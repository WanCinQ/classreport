export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const path = url.pathname;
    const cors = corsHeaders(request, env);

    // Handle CORS preflight
    if (request.method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: cors });
    }

    try {
      // 1. PUBLIC ROUTES (No Login Required)

      // Login Route
      if (path === '/api/auth/login' && request.method === 'POST') {
        return handleLogin(request, env, cors);
      }

      // Parent View Route (Rate Limited)
      if (path.startsWith('/api/parent/report/')) {
        return handleParentReport(request, env, path, cors);
      }

      // 2. AUTHENTICATED ROUTES
      const user = await authenticate(request, env);
      if (!user) {
        return json({ error: '未登录 / Unauthorized' }, 401, cors);
      }

      // Get Current User Profile
      if (path === '/api/auth/me' && request.method === 'GET') {
        return json({ teacher: user }, 200, cors);
      }

      // Logout Route
      if (path === '/api/auth/logout' && request.method === 'POST') {
        await env.DB.prepare('DELETE FROM sessions WHERE token = ?').bind(request.headers.get('Authorization').replace('Bearer ', '')).run();
        return json({ success: true }, 200, cors);
      }

      // Change Password Route
      if (path === '/api/auth/change-password' && request.method === 'POST') {
        return handleChangePassword(request, env, user, cors);
      }

      // Teacher Subject & Student List
      if (path === '/api/reports/my-subjects' && request.method === 'GET') {
        return handleMyReports(user, env, cors);
      }

      // Save Student Comment
      // Matches PUT /api/reports/:studentId/:subjectCode
      const saveReportMatch = path.match(/^\/api\/reports\/(\d+)\/([a-zA-Z0-9_-]+)$/);
      if (saveReportMatch && request.method === 'PUT') {
        const studentId = parseInt(saveReportMatch[1]);
        const subjectCode = saveReportMatch[2];
        return handleSaveReport(request, env, user, studentId, subjectCode, cors);
      }

      // Mark All Complete for Subject
      const completeSubjectMatch = path.match(/^\/api\/reports\/mark-complete\/([a-zA-Z0-9_-]+)$/);
      if (completeSubjectMatch && request.method === 'POST') {
        const subjectCode = completeSubjectMatch[1];
        return handleMarkSubjectComplete(env, user, subjectCode, cors);
      }

      // 3. FORM TEACHER EXCLUSIVE ROUTES
      if (user.role !== 'form_teacher') {
        return json({ error: '仅班主任可访问 / Form Teacher only' }, 403, cors);
      }

      // Form Teacher Matrix Summary
      if (path === '/api/form-teacher/summary' && request.method === 'GET') {
        return handleFTClassSummary(env, cors);
      }

      // Generate Parent View Links
      if (path === '/api/form-teacher/generate-links' && request.method === 'GET') {
        return handleFTGenerateLinks(env, cors);
      }

      // Reset Another Teacher's Password
      if (path === '/api/form-teacher/reset-password' && request.method === 'POST') {
        return handleFTResetPassword(request, env, user, cors);
      }

      // Update Student Status (Active / Left)
      if (path === '/api/form-teacher/change-student-status' && request.method === 'POST') {
        return handleFTChangeStudentStatus(request, env, user, cors);
      }

      // Visitor & Completion Analytics Dashboard
      if (path === '/api/form-teacher/analytics' && request.method === 'GET') {
        return handleFTAnalytics(env, cors);
      }

      // Batch Import Comments from Word file parsing
      if (path === '/api/form-teacher/import-comments' && request.method === 'POST') {
        return handleFTImportComments(request, env, user, cors);
      }

      return json({ error: 'Endpoint not found' }, 404, cors);
    } catch (e) {
      return json({ error: e.message }, 500, cors);
    }
  }
};

// --- CORS HELPER ---
function corsHeaders(request, env) {
  const origin = request.headers.get('Origin') || '';
  const allowed = [
    env.CORS_ORIGIN || 'http://localhost:8000',
    'https://chewyenhan.github.io', // Fallback whitelist
  ];
  const allowOrigin = allowed.includes(origin) ? origin : allowed[0];
  return {
    'Access-Control-Allow-Origin': allowOrigin,
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    'Access-Control-Max-Age': '86400',
  };
}

// --- JSON RESPONSE HELPER ---
function json(body, status = 200, headers = {}) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json', ...headers },
  });
}

// --- PASSWORD SECURITY (PBKDF2) ---
async function verifyPassword(password, stored) {
  const [saltB64, hashB64] = stored.split(':');
  const salt = Uint8Array.from(atob(saltB64), c => c.charCodeAt(0));
  const key = await crypto.subtle.importKey('raw', new TextEncoder().encode(password), 'PBKDF2', false, ['deriveBits']);
  const derived = new Uint8Array(await crypto.subtle.deriveBits(
    { name: 'PBKDF2', salt, iterations: 100000, hash: 'SHA-256' }, key, 256
  ));
  let derivedB64 = btoa(String.fromCharCode(...derived));
  return derivedB64 === hashB64;
}

async function hashPassword(password) {
  const salt = crypto.getRandomValues(new Uint8Array(16));
  const key = await crypto.subtle.importKey('raw', new TextEncoder().encode(password), 'PBKDF2', false, ['deriveBits']);
  const derived = new Uint8Array(await crypto.subtle.deriveBits(
    { name: 'PBKDF2', salt, iterations: 100000, hash: 'SHA-256' }, key, 256
  ));
  return btoa(String.fromCharCode(...salt)) + ':' + btoa(String.fromCharCode(...derived));
}

// --- AUTHENTICATION MIDDLEWARE ---
async function authenticate(request, env) {
  const auth = request.headers.get('Authorization') || '';
  const token = auth.replace('Bearer ', '');
  if (!token) return null;

  const session = await env.DB.prepare(
    `SELECT s.token, t.id as teacher_id, t.username, t.display_name, t.display_name_en, t.display_name_ms, t.role 
     FROM sessions s 
     JOIN teachers t ON s.teacher_id = t.id 
     WHERE s.token = ? AND s.expires_at > datetime('now', 'localtime')`
  ).bind(token).first();

  if (!session) return null;

  // Sliding session renewal (extend duration by configured value)
  const durationDays = parseInt(env.SESSION_DURATION_DAYS || '7');
  await env.DB.prepare(
    `UPDATE sessions SET expires_at = datetime('now', '+${durationDays} days', 'localtime') WHERE token = ?`
  ).bind(token).run();

  return session;
}

// --- ROUTE HANDLERS ---

// POST /api/auth/login
async function handleLogin(request, env, cors) {
  const { username, password } = await request.json().catch(() => ({}));
  if (!username || !password) {
    return json({ error: '请输入用户名和密码 / Username and password required' }, 400, cors);
  }

  const teacher = await env.DB.prepare('SELECT * FROM teachers WHERE username = ?').bind(username).first();
  if (!teacher) {
    return json({ error: '用户名或密码错误 / Invalid username or password' }, 401, cors);
  }

  const isValid = await verifyPassword(password, teacher.password);
  if (!isValid) {
    return json({ error: '用户名或密码错误 / Invalid username or password' }, 401, cors);
  }

  const token = crypto.randomUUID();
  const durationDays = parseInt(env.SESSION_DURATION_DAYS || '7');
  await env.DB.prepare(
    `INSERT INTO sessions (token, teacher_id, expires_at) VALUES (?, ?, datetime('now', '+${durationDays} days', 'localtime'))`
  ).bind(token, teacher.id).run();

  return json({
    token,
    teacher: {
      username: teacher.username,
      display_name: teacher.display_name,
      display_name_en: teacher.display_name_en,
      display_name_ms: teacher.display_name_ms,
      role: teacher.role,
    }
  }, 200, cors);
}

// POST /api/auth/change-password
async function handleChangePassword(request, env, user, cors) {
  const { old_password, new_password } = await request.json().catch(() => ({}));
  if (!old_password || !new_password) {
    return json({ error: '参数不完整 / Missing parameters' }, 400, cors);
  }

  const teacher = await env.DB.prepare('SELECT password FROM teachers WHERE id = ?').bind(user.teacher_id).first();
  const isValid = await verifyPassword(old_password, teacher.password);
  if (!isValid) {
    return json({ error: '原密码错误 / Current password incorrect' }, 400, cors);
  }

  const hashedPassword = await hashPassword(new_password);
  await env.DB.prepare('UPDATE teachers SET password = ? WHERE id = ?').bind(hashedPassword, user.teacher_id).run();
  
  await env.DB.prepare(
    "INSERT INTO audit_log (actor, action, details) VALUES (?, 'change_password', 'Teacher changed own password')"
  ).bind(user.username).run();

  return json({ success: true }, 200, cors);
}

// GET /api/reports/my-subjects
async function handleMyReports(user, env, cors) {
  let subjects;
  
  // If the user has a form teacher role and is mapped to all subjects '*'
  const isFTWithAll = user.role === 'form_teacher';
  
  if (isFTWithAll) {
    subjects = await env.DB.prepare('SELECT * FROM subjects').all();
  } else {
    subjects = await env.DB.prepare(
      `SELECT s.* FROM subjects s 
       JOIN teacher_subjects ts ON s.code = ts.subject_code 
       WHERE ts.teacher_id = ?`
    ).bind(user.teacher_id).all();
  }

  // Populate student list for each subject
  // Teachers should only see "active" students in the classes mapped to their subjects.
  for (const subj of subjects.results) {
    const students = await env.DB.prepare(
      `SELECT st.id, st.student_number, st.name, st.name_en, st.gender, st.is_boarding, st.parent_phone, st.student_phone, st.address, st.siblings, st.photo_url, st.status,
              r.feedback, r.is_complete, r.last_updated
       FROM students st
       JOIN student_class_relations scr ON st.id = scr.student_id
       JOIN subject_groups sg ON scr.group_id = sg.group_id
       LEFT JOIN reports r ON r.student_id = st.id AND r.subject_code = ? AND r.academic_year_id = (SELECT id FROM academic_years WHERE is_current = 1)
       WHERE sg.subject_code = ? AND st.status = 'active'
       ORDER BY st.student_number`
    ).bind(subj.code, subj.code).all();
    
    subj.students = students.results;
  }

  return json({ subjects: subjects.results }, 200, cors);
}

// PUT /api/reports/:studentId/:subjectCode
async function handleSaveReport(request, env, user, studentId, subjectCode, cors) {
  const { feedback, is_complete } = await request.json().catch(() => ({}));
  const isCompleteVal = is_complete ? 1 : 0;

  // Verify that the teacher has permission to edit this subject
  if (user.role !== 'form_teacher') {
    const permission = await env.DB.prepare(
      'SELECT 1 FROM teacher_subjects WHERE teacher_id = ? AND subject_code = ?'
    ).bind(user.teacher_id, subjectCode).first();
    if (!permission) {
      return json({ error: '您无权编辑此科目评语 / Unauthorized for this subject' }, 403, cors);
    }
  }

  const currentYear = await env.DB.prepare('SELECT id FROM academic_years WHERE is_current = 1').first();
  if (!currentYear) {
    return json({ error: '当前未设置活动学年 / Current academic year not set' }, 500, cors);
  }

  // Upsert comment
  await env.DB.prepare(
    `INSERT INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete, last_updated)
     VALUES (?, ?, ?, ?, ?, datetime('now', 'localtime'))
     ON CONFLICT(student_id, subject_code, academic_year_id) 
     DO UPDATE SET feedback = excluded.feedback, is_complete = excluded.is_complete, last_updated = excluded.last_updated`
  ).bind(studentId, subjectCode, currentYear.id, feedback || '', isCompleteVal).run();

  // Audit log
  await env.DB.prepare(
    `INSERT INTO audit_log (actor, action, target, details) 
     VALUES (?, 'save_report', ?, ?)`
  ).bind(user.username, `student:${studentId},subj:${subjectCode}`, `feedback_len:${(feedback || '').length},complete:${isCompleteVal}`).run();

  return json({ success: true }, 200, cors);
}

// POST /api/reports/mark-complete/:subjectCode
async function handleMarkSubjectComplete(env, user, subjectCode, cors) {
  // Check permission
  if (user.role !== 'form_teacher') {
    const permission = await env.DB.prepare(
      'SELECT 1 FROM teacher_subjects WHERE teacher_id = ? AND subject_code = ?'
    ).bind(user.teacher_id, subjectCode).first();
    if (!permission) {
      return json({ error: '您无权操作此科目 / Unauthorized for this subject' }, 403, cors);
    }
  }

  const currentYear = await env.DB.prepare('SELECT id FROM academic_years WHERE is_current = 1').first();
  
  // Find all active students for this subject
  const students = await env.DB.prepare(
    `SELECT st.id 
     FROM students st 
     JOIN student_class_relations scr ON st.id = scr.student_id
     JOIN subject_groups sg ON scr.group_id = sg.group_id
     WHERE sg.subject_code = ? AND st.status = 'active'`
  ).bind(subjectCode).all();

  // Bulk complete (using transaction or loop - D1 supports batch queries)
  const statements = students.results.map(st => {
    return env.DB.prepare(
      `INSERT INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete, last_updated)
       VALUES (?, ?, ?, '', 1, datetime('now', 'localtime'))
       ON CONFLICT(student_id, subject_code, academic_year_id) 
       DO UPDATE SET is_complete = 1, last_updated = datetime('now', 'localtime')`
    ).bind(st.id, subjectCode, currentYear.id);
  });

  if (statements.length > 0) {
    await env.DB.batch(statements);
  }

  await env.DB.prepare(
    "INSERT INTO audit_log (actor, action, target, details) VALUES (?, 'complete_subject', ?, 'Marked all active students as complete')"
  ).bind(user.username, subjectCode).run();

  return json({ success: true, count: statements.length }, 200, cors);
}

// GET /api/form-teacher/summary
async function handleFTClassSummary(env, cors) {
  const currentYear = await env.DB.prepare('SELECT id FROM academic_years WHERE is_current = 1').first();
  
  // Get active class/groups for this year (primary class)
  const classGroup = await env.DB.prepare(
    'SELECT * FROM student_groups WHERE academic_year_id = ? LIMIT 1'
  ).bind(currentYear.id).first();

  if (!classGroup) {
    return json({ students: [], subjects: [], reports: [] }, 200, cors);
  }

  // Get ALL students in this class (including both active and left) so FT can see/toggle them
  const students = await env.DB.prepare(
    `SELECT st.id, st.student_number, st.name, st.name_en, st.gender, st.is_boarding, st.parent_phone, st.student_phone, st.address, st.siblings, st.photo_url, st.status, st.parent_code
     FROM students st
     JOIN student_class_relations scr ON st.id = scr.student_id
     WHERE scr.group_id = ?
     ORDER BY st.status ASC, st.student_number ASC`
  ).bind(classGroup.id).all();

  // Get subjects mapped to this class
  const subjects = await env.DB.prepare(
    `SELECT s.* FROM subjects s 
     JOIN subject_groups sg ON s.code = sg.subject_code 
     WHERE sg.group_id = ?`
  ).bind(classGroup.id).all();

  // Get all reports for students in this class for the current year
  const reports = await env.DB.prepare(
    `SELECT r.student_id, r.subject_code, r.feedback, r.is_complete, r.last_updated
     FROM reports r
     JOIN student_class_relations scr ON r.student_id = scr.student_id
     WHERE scr.group_id = ? AND r.academic_year_id = ?`
  ).bind(classGroup.id, currentYear.id).all();

  return json({
    className: classGroup.name,
    classNameEn: classGroup.name_en,
    classNameMs: classGroup.name_ms,
    students: students.results,
    subjects: subjects.results,
    reports: reports.results
  }, 200, cors);
}

// GET /api/form-teacher/generate-links
async function handleFTGenerateLinks(env, cors) {
  const currentYear = await env.DB.prepare('SELECT id FROM academic_years WHERE is_current = 1').first();
  const classGroup = await env.DB.prepare('SELECT id FROM student_groups WHERE academic_year_id = ? LIMIT 1').bind(currentYear.id).first();

  if (!classGroup) {
    return json({ links: [] }, 200, cors);
  }

  // Generate parent links for active students
  const students = await env.DB.prepare(
    `SELECT st.student_number, st.name, st.name_en, st.parent_code, st.status
     FROM students st
     JOIN student_class_relations scr ON st.id = scr.student_id
     WHERE scr.group_id = ? AND st.status = 'active'
     ORDER BY st.student_number`
  ).bind(classGroup.id).all();

  const baseUrl = env.PARENT_BASE_URL || 'https://chewyenhan.github.io/reports/parent.html';
  const links = students.results.map(st => ({
    student_number: st.student_number,
    name: st.name,
    name_en: st.name_en,
    code: st.parent_code,
    url: `${baseUrl}?code=${st.parent_code}`
  }));

  return json({ links }, 200, cors);
}

// POST /api/form-teacher/reset-password
async function handleFTResetPassword(request, env, user, cors) {
  const { username, new_password } = await request.json().catch(() => ({}));
  if (!username || !new_password) {
    return json({ error: '参数不完整 / Missing parameters' }, 400, cors);
  }

  const hashedPassword = await hashPassword(new_password);
  const result = await env.DB.prepare('UPDATE teachers SET password = ? WHERE username = ?').bind(hashedPassword, username).run();
  
  if (result.meta.changes === 0) {
    return json({ error: '未找到该教师用户 / Teacher not found' }, 404, cors);
  }

  await env.DB.prepare(
    "INSERT INTO audit_log (actor, action, target, details) VALUES (?, 'reset_password', ?, 'Form teacher reset password')"
  ).bind(user.username, username).run();

  return json({ success: true }, 200, cors);
}

// POST /api/form-teacher/change-student-status
async function handleFTChangeStudentStatus(request, env, user, cors) {
  const { student_number, status } = await request.json().catch(() => ({}));
  if (!student_number || !status) {
    return json({ error: '参数不完整 / Missing parameters' }, 400, cors);
  }

  // Validate status
  const allowed = ['active', 'left'];
  if (!allowed.includes(status)) {
    return json({ error: '不支持的状态值 / Invalid status value' }, 400, cors);
  }

  const result = await env.DB.prepare('UPDATE students SET status = ? WHERE student_number = ?').bind(status, student_number).run();
  if (result.meta.changes === 0) {
    return json({ error: '未找到该学生 / Student not found' }, 404, cors);
  }

  await env.DB.prepare(
    "INSERT INTO audit_log (actor, action, target, details) VALUES (?, 'change_student_status', ?, ?)"
  ).bind(user.username, student_number, `Updated status to: ${status}`).run();

  return json({ success: true }, 200, cors);
}

// GET /api/parent/report/:code
async function handleParentReport(request, env, path, cors) {
  const code = path.replace('/api/parent/report/', '');
  if (!code || code.length !== 8) {
    return json({ error: '无效的安全码 / Invalid code' }, 400, cors);
  }

  // Get Client IP for Rate Limiting
  const ip = request.headers.get('CF-Connecting-IP') || request.headers.get('x-real-ip') || 'unknown';
  const userAgent = request.headers.get('user-agent') || 'unknown';

  // Rate Limiting Check: Max 5 hits per minute per IP
  const rateCheck = await env.DB.prepare(
    `SELECT COUNT(*) as count 
     FROM audit_log 
     WHERE actor = ? AND action = 'parent_view' AND created_at > datetime('now', '-1 minute', 'localtime')`
  ).bind(ip).first();

  if (rateCheck && rateCheck.count >= 5) {
    return json({
      error: '请求过于频繁，请稍候再试。 / Too many requests. Please try again in a minute.',
      rate_limited: true
    }, 429, cors);
  }

  // Log the view attempt to audit log
  await env.DB.prepare(
    "INSERT INTO audit_log (actor, action, target, details) VALUES (?, 'parent_view', ?, ?)"
  ).bind(ip, code, userAgent).run();

  // Find Student (Only allow view if the student is currently active)
  const student = await env.DB.prepare(
    `SELECT st.id, st.student_number, st.name, st.name_en, st.gender, st.is_boarding, st.parent_phone, st.student_phone, st.address, st.siblings, st.photo_url, st.status,
            sg.name as class_name, sg.name_en as class_name_en, sg.name_ms as class_name_ms
     FROM students st
     JOIN student_class_relations scr ON st.id = scr.student_id
     JOIN student_groups sg ON scr.group_id = sg.group_id
     WHERE st.parent_code = ? AND st.status = 'active'`
  ).bind(code).first();

  if (!student) {
    return json({ error: '报告未找到或链接已失效 / Report not found or link expired' }, 404, cors);
  }

  // Fetch all COMPLETED comments for the student in current year
  const currentYear = await env.DB.prepare('SELECT id FROM academic_years WHERE is_current = 1').first();
  const reports = await env.DB.prepare(
    `SELECT r.subject_code, s.display_name, s.display_name_en, s.display_name_ms, s.emoji, r.feedback 
     FROM reports r 
     JOIN subjects s ON r.subject_code = s.code 
     WHERE r.student_id = ? AND r.academic_year_id = ? AND r.is_complete = 1`
  ).bind(student.id, currentYear.id).all();

  return json({
    schoolName: env.SCHOOL_NAME || '华联中学 (Hua Lian High School)',
    student: {
      student_number: student.student_number,
      name: student.name,
      name_en: student.name_en,
      gender: student.gender,
      is_boarding: student.is_boarding === 1,
      parent_phone: student.parent_phone,
      student_phone: student.student_phone,
      address: student.address,
      siblings: student.siblings,
      photo_url: student.photo_url,
      class_name: student.class_name,
      class_name_en: student.class_name_en,
      class_name_ms: student.class_name_ms
    },
    reports: reports.results
  }, 200, cors);
}

// GET /api/form-teacher/analytics
async function handleFTAnalytics(env, cors) {
  const currentYear = await env.DB.prepare('SELECT id FROM academic_years WHERE is_current = 1').first();

  // 1. Total parent views (all time)
  const totalViews = await env.DB.prepare(
    "SELECT COUNT(*) as count FROM audit_log WHERE action = 'parent_view'"
  ).first();

  // 2. Views in last 7 days (daily breakdown)
  const dailyViews = await env.DB.prepare(
    `SELECT date(created_at) as day, COUNT(*) as count 
     FROM audit_log 
     WHERE action = 'parent_view' AND created_at > datetime('now', '-7 days', 'localtime')
     GROUP BY day
     ORDER BY day ASC`
  ).all();

  // 3. Per-student access counts (top accessed)
  const perStudentViews = await env.DB.prepare(
    `SELECT al.target as code, st.name, st.name_en, st.student_number, COUNT(*) as count
     FROM audit_log al
     JOIN students st ON st.parent_code = al.target
     WHERE al.action = 'parent_view'
     GROUP BY al.target
     ORDER BY count DESC
     LIMIT 20`
  ).all();

  // 4. Rate-limited hits count
  const rateLimitHits = await env.DB.prepare(
    "SELECT COUNT(*) as count FROM audit_log WHERE action = 'parent_view' AND details LIKE 'rate_limited%'"
  ).first();

  // 5. Subject completion stats for current year
  let subjectStats = { results: [] };
  if (currentYear) {
    subjectStats = await env.DB.prepare(
      `SELECT s.display_name, s.display_name_en, s.emoji, s.code,
              COUNT(DISTINCT st.id) as total_students,
              SUM(CASE WHEN r.is_complete = 1 THEN 1 ELSE 0 END) as completed,
              SUM(CASE WHEN r.feedback IS NOT NULL AND r.feedback != '' AND r.is_complete = 0 THEN 1 ELSE 0 END) as in_progress
       FROM subjects s
       JOIN subject_groups sg ON s.code = sg.subject_code
       JOIN student_class_relations scr ON sg.group_id = scr.group_id
       JOIN students st ON scr.student_id = st.id AND st.status = 'active'
       LEFT JOIN reports r ON r.student_id = st.id AND r.subject_code = s.code AND r.academic_year_id = ?
       GROUP BY s.code
       ORDER BY s.code`
    ).bind(currentYear.id).all();
  }

  // 6. Total active students
  const activeStudentCount = await env.DB.prepare(
    "SELECT COUNT(*) as count FROM students WHERE status = 'active'"
  ).first();

  return json({
    total_views: totalViews?.count || 0,
    daily_views: dailyViews.results,
    per_student_views: perStudentViews.results,
    rate_limit_hits: rateLimitHits?.count || 0,
    subject_stats: subjectStats.results,
    active_student_count: activeStudentCount?.count || 0
  }, 200, cors);
}

// POST /api/form-teacher/import-comments
async function handleFTImportComments(request, env, user, cors) {
  // Payload: { subject_code: string, comments: [{student_id: int, feedback: string, is_complete: bool}] }
  const body = await request.json().catch(() => ({}));
  const { subject_code, comments } = body;

  if (!subject_code || !comments || !Array.isArray(comments) || comments.length === 0) {
    return json({ error: '参数不完整 / Missing parameters' }, 400, cors);
  }

  const currentYear = await env.DB.prepare('SELECT id FROM academic_years WHERE is_current = 1').first();
  if (!currentYear) {
    return json({ error: '未设置当前学年 / Current year not set' }, 500, cors);
  }

  let successCount = 0;
  let failCount = 0;

  // D1 supports batch queries – process in batches of 20 to avoid timeout
  const batchSize = 20;
  for (let i = 0; i < comments.length; i += batchSize) {
    const chunk = comments.slice(i, i + batchSize);
    const statements = chunk.map(c => {
      const isCompleteVal = c.is_complete ? 1 : 0;
      return env.DB.prepare(
        `INSERT INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete, last_updated)
         VALUES (?, ?, ?, ?, ?, datetime('now', 'localtime'))
         ON CONFLICT(student_id, subject_code, academic_year_id)
         DO UPDATE SET feedback = excluded.feedback, is_complete = excluded.is_complete, last_updated = excluded.last_updated`
      ).bind(c.student_id, subject_code, currentYear.id, c.feedback || '', isCompleteVal);
    });

    try {
      await env.DB.batch(statements);
      successCount += chunk.length;
    } catch (err) {
      failCount += chunk.length;
    }
  }

  await env.DB.prepare(
    "INSERT INTO audit_log (actor, action, target, details) VALUES (?, 'import_comments', ?, ?)"
  ).bind(user.username, subject_code, `Imported ${successCount} comments via Word import`).run();

  return json({ success: true, imported: successCount, failed: failCount }, 200, cors);
}

