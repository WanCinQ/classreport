-- 学年表
CREATE TABLE IF NOT EXISTS academic_years (
  id TEXT PRIMARY KEY,          -- '2026', '2027' 等
  display_name TEXT NOT NULL,   -- '2026学年'
  is_current INTEGER DEFAULT 0  -- 是否为当前活动学年 (1/0)
);

-- 分组/班级表
CREATE TABLE IF NOT EXISTS student_groups (
  id TEXT PRIMARY KEY,          -- '2026_J2Ai'
  academic_year_id TEXT NOT NULL REFERENCES academic_years(id),
  name TEXT NOT NULL,           -- '初二爱班'
  name_en TEXT,                 -- 'Junior 2 Ai'
  name_ms TEXT                  -- 'Junior 2 Ai'
);

-- 学生主表（包含个人详细资料）
CREATE TABLE IF NOT EXISTS students (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  student_number TEXT NOT NULL UNIQUE, -- 学号
  name TEXT NOT NULL,                  -- 中文名，如 '吴淑婷'
  name_en TEXT NOT NULL,               -- 英文名，如 'GOH SHU TING'
  gender TEXT NOT NULL,                -- 'M' (男) / 'F' (女)
  is_boarding INTEGER DEFAULT 0,       -- 住宿：1 (住宿) / 0 (通勤)
  parent_phone TEXT,                   -- 家长联系电话
  student_phone TEXT,                  -- 学生手机号码
  address TEXT,                        -- 家庭地址
  siblings TEXT,                       -- 在校兄弟姐妹或亲戚信息
  photo_url TEXT,                      -- 照片路径，如 'photos/25091.jpg'
  status TEXT NOT NULL DEFAULT 'active', -- 状态：'active' (在籍) / 'left' (离校/停学/转校)
  parent_code TEXT NOT NULL UNIQUE     -- 8位随机家长查看码，排除易混淆字符
);

-- 学生-班级学年关联表
CREATE TABLE IF NOT EXISTS student_class_relations (
  student_id INTEGER NOT NULL REFERENCES students(id),
  group_id TEXT NOT NULL REFERENCES student_groups(id),
  PRIMARY KEY (student_id, group_id)
);

-- 科目表
CREATE TABLE IF NOT EXISTS subjects (
  code TEXT PRIMARY KEY,               -- 'chinese', 'math' 等
  display_name TEXT NOT NULL,          -- 中文：'华语'
  display_name_en TEXT,                -- 英文：'Chinese'
  display_name_ms TEXT,                -- 马来文：'Bahasa Cina'
  emoji TEXT                           -- 科目对应最合适的图标/Emoji
);

-- 科目-班级关联表（控制哪些班级上哪些科目）
CREATE TABLE IF NOT EXISTS subject_groups (
  subject_code TEXT NOT NULL REFERENCES subjects(code),
  group_id TEXT NOT NULL REFERENCES student_groups(id),
  PRIMARY KEY (subject_code, group_id)
);

-- 教师表
CREATE TABLE IF NOT EXISTS teachers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL UNIQUE,       -- 'form_teacher', 'chinese_t'
  display_name TEXT NOT NULL,          -- '班主任'
  display_name_en TEXT,                -- 'Form Teacher'
  display_name_ms TEXT,                -- 'Guru Kelas'
  password TEXT NOT NULL,              -- PBKDF2 哈希值
  role TEXT NOT NULL DEFAULT 'teacher' -- 角色：'form_teacher' (班主任) / 'teacher' (任课老师)
);

-- 教师-科目关联表（一个教师可教多科，班主任关联 '*'）
CREATE TABLE IF NOT EXISTS teacher_subjects (
  teacher_id INTEGER NOT NULL REFERENCES teachers(id),
  subject_code TEXT NOT NULL,          -- 科目代码，'*' 表示所有科目
  PRIMARY KEY (teacher_id, subject_code)
);

-- 评语表
CREATE TABLE IF NOT EXISTS reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  student_id INTEGER NOT NULL REFERENCES students(id),
  subject_code TEXT NOT NULL REFERENCES subjects(code),
  academic_year_id TEXT NOT NULL REFERENCES academic_years(id),
  feedback TEXT DEFAULT '',
  is_complete INTEGER DEFAULT 0,
  last_updated TEXT DEFAULT (datetime('now', 'localtime')),
  UNIQUE(student_id, subject_code, academic_year_id)
);

-- 会话表（Session）
CREATE TABLE IF NOT EXISTS sessions (
  token TEXT PRIMARY KEY,
  teacher_id INTEGER NOT NULL REFERENCES teachers(id),
  created_at TEXT NOT NULL DEFAULT (datetime('now', 'localtime')),
  expires_at TEXT NOT NULL
);

-- 审计日志表
CREATE TABLE IF NOT EXISTS audit_log (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  actor TEXT NOT NULL,
  action TEXT NOT NULL,
  target TEXT,
  details TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now', 'localtime'))
);

-- 创建索引以优化性能
CREATE INDEX IF NOT EXISTS idx_reports_lookup ON reports(student_id, subject_code, academic_year_id);
CREATE INDEX IF NOT EXISTS idx_students_parent_code ON students(parent_code);
CREATE INDEX IF NOT EXISTS idx_sessions_expires ON sessions(expires_at);
CREATE INDEX IF NOT EXISTS idx_student_relations ON student_class_relations(group_id);
