// ============================================================
// data.js — Local Data Manager + Offline Fallback
// 当 Cloudflare Workers 后端不可用时，使用 localStorage 作为后备
// 班导也可以通过此模块直接管理多年级数据
// ============================================================

const LocalData = {
  // 从 class-config.json 加载本地配置
  _config: null,

  async loadConfig() {
    if (this._config) return this._config;
    try {
      const res = await fetch('../class-config.json');
      if (!res.ok) throw new Error('Config not found');
      this._config = await res.json();
      return this._config;
    } catch (e) {
      console.warn('Cannot load class-config.json, using empty config');
      this._config = { schoolName: '', subjects: [], teachers: [], students: [] };
      return this._config;
    }
  },

  // 获取当前学年的活跃学生
  getActiveStudents(year) {
    const cfg = this._config;
    if (!cfg) return [];
    const y = year || cfg.currentAcademicYear || '2026';
    return (cfg.students || []).filter(s =>
      s.academicYear === y && s.status === 'active'
    );
  },

  // 获取所有学生（包括离校）
  getAllStudents(year) {
    const cfg = this._config;
    if (!cfg) return [];
    const y = year || cfg.currentAcademicYear || '2026';
    return (cfg.students || []).filter(s => s.academicYear === y);
  },

  // 获取科目列表
  getSubjects() {
    const cfg = this._config;
    if (!cfg) return [];
    return cfg.subjects || [];
  },

  // 获取教师列表
  getTeachers() {
    const cfg = this._config;
    if (!cfg) return [];
    return cfg.teachers || [];
  },

  // 根据学号查找学生
  findStudent(studentId) {
    const cfg = this._config;
    if (!cfg) return null;
    return (cfg.students || []).find(s => s.studentId === studentId) || null;
  },

  // 根据姓名搜索（中英文模糊匹配）
  searchStudents(query) {
    const cfg = this._config;
    if (!cfg) return [];
    const q = query.toLowerCase().trim();
    if (!q) return this.getActiveStudents();
    return (cfg.students || []).filter(s =>
      s.status === 'active' && (
        s.nameZh.toLowerCase().includes(q) ||
        s.nameEn.toLowerCase().includes(q) ||
        s.studentId.includes(q) ||
        (s.fatherPhone || '').includes(q) ||
        (s.motherPhone || '').includes(q)
      )
    );
  },

  // ========== localStorage 评语后备存储 ==========

  // Key format: report_{academicYear}_{studentId}_{subjectCode}
  _reportKey(year, studentId, subjectCode) {
    return `report_${year}_${studentId}_${subjectCode}`;
  },

  // 保存评语到 localStorage
  saveReportLocal(year, studentId, subjectCode, feedback, isComplete) {
    const key = this._reportKey(year, studentId, subjectCode);
    const data = {
      studentId,
      subjectCode,
      feedback,
      isComplete: isComplete ? 1 : 0,
      updatedAt: new Date().toISOString()
    };
    localStorage.setItem(key, JSON.stringify(data));
    return data;
  },

  // 从 localStorage 读取评语
  getReportLocal(year, studentId, subjectCode) {
    const key = this._reportKey(year, studentId, subjectCode);
    const raw = localStorage.getItem(key);
    return raw ? JSON.parse(raw) : null;
  },

  // 获取某学生某年的所有科目评语
  getStudentReportsLocal(year, studentId) {
    const results = {};
    const prefix = `report_${year}_${studentId}_`;
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key && key.startsWith(prefix)) {
        const raw = localStorage.getItem(key);
        if (raw) {
          const data = JSON.parse(raw);
          results[data.subjectCode] = data;
        }
      }
    }
    return results;
  },

  // 获取某年所有评语（用于构建矩阵）
  getAllReportsLocal(year) {
    const results = [];
    const prefix = `report_${year}_`;
    for (let i = 0; i < localStorage.length; i++) {
      const key = localStorage.key(i);
      if (key && key.startsWith(prefix)) {
        const raw = localStorage.getItem(key);
        if (raw) {
          results.push(JSON.parse(raw));
        }
      }
    }
    return results;
  },

  // 删除评语
  deleteReportLocal(year, studentId, subjectCode) {
    const key = this._reportKey(year, studentId, subjectCode);
    localStorage.removeItem(key);
  },

  // 批量导出某年所有评语为 JSON
  exportAllReportsLocal(year) {
    return this.getAllReportsLocal(year);
  },

  // 获取某年某科目的进度
  getSubjectProgressLocal(year, subjectCode) {
    const activeStudents = this.getActiveStudents(year);
    const total = activeStudents.length;
    let completed = 0;
    activeStudents.forEach(s => {
      const report = this.getReportLocal(year, s.studentId, subjectCode);
      if (report && report.isComplete === 1) completed++;
    });
    return { total, completed, percentage: total > 0 ? Math.round((completed / total) * 100) : 0 };
  },

  // ========== 多年级辅助 ==========

  // 获取所有可用的学年
  getAvailableYears() {
    const cfg = this._config;
    if (!cfg || !cfg.academicYears) return ['2026'];
    return Object.keys(cfg.academicYears).sort();
  },

  // 获取指定学年的班级
  getClassesForYear(year) {
    const cfg = this._config;
    if (!cfg || !cfg.academicYears) return {};
    const yearData = cfg.academicYears[year];
    return yearData ? yearData.classes : {};
  }
};

// 导出到全局
window.LocalData = LocalData;
