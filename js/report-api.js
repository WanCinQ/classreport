const ReportAPI = {
  // 1. Auth APIs
  async login(username, password, remember = false) {
    const res = await fetch(WORKER_URL + '/api/auth/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username, password })
    });
    
    const data = await res.json().catch(() => ({}));
    if (!res.ok) {
      throw new Error(data.error || '登录失败 / Login failed');
    }
    
    setToken(data.token, remember);
    setUser(data.teacher, remember);
    return data;
  },

  async logout() {
    try {
      await fetchWithAuth('/api/auth/logout', { method: 'POST' });
    } catch (e) {
      console.warn('Logout request failed', e);
    } finally {
      clearToken();
      clearUser();
      window.location.href = 'teacher-login.html';
    }
  },

  async changePassword(oldPassword, newPassword) {
    return fetchWithAuth('/api/auth/change-password', {
      method: 'POST',
      body: JSON.stringify({ old_password: oldPassword, new_password: newPassword })
    });
  },

  // 2. Teacher Report Recording APIs
  async getMyReports() {
    return fetchWithAuth('/api/reports/my-subjects', { method: 'GET' });
  },

  async saveReport(studentId, subjectCode, feedback, isComplete) {
    return fetchWithAuth(`/api/reports/${studentId}/${subjectCode}`, {
      method: 'PUT',
      body: JSON.stringify({ feedback, is_complete: isComplete ? 1 : 0 })
    });
  },

  async markSubjectComplete(subjectCode) {
    return fetchWithAuth(`/api/reports/mark-complete/${subjectCode}`, {
      method: 'POST'
    });
  },

  // 3. Form Teacher Dashboard APIs
  async getFTClassSummary() {
    return fetchWithAuth('/api/form-teacher/summary', { method: 'GET' });
  },

  async getFTGenerateLinks() {
    return fetchWithAuth('/api/form-teacher/generate-links', { method: 'GET' });
  },

  async resetFTTeacherPassword(username, newPassword) {
    return fetchWithAuth('/api/form-teacher/reset-password', {
      method: 'POST',
      body: JSON.stringify({ username, new_password: newPassword })
    });
  },

  async changeFTStudentStatus(studentNumber, status) {
    return fetchWithAuth('/api/form-teacher/change-student-status', {
      method: 'POST',
      body: JSON.stringify({ student_number: studentNumber, status: status })
    });
  },

  // NEW: Analytics dashboard
  async getFTAnalytics() {
    return fetchWithAuth('/api/form-teacher/analytics', { method: 'GET' });
  },

  // NEW: Batch import from Word parsing
  async importComments(subjectCode, comments) {
    return fetchWithAuth('/api/form-teacher/import-comments', {
      method: 'POST',
      body: JSON.stringify({ subject_code: subjectCode, comments })
    });
  },

  // 4. Parent View API (No Auth)
  async getParentReport(code) {
    const res = await fetch(WORKER_URL + `/api/parent/report/${code}`);
    const data = await res.json().catch(() => ({}));
    if (!res.ok) {
      throw {
        message: data.error || '获取报告失败 / Failed to retrieve report',
        rate_limited: data.rate_limited || false,
        status: res.status
      };
    }
    return data;
  }
};
