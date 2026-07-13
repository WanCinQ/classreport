-- 1. Add new subjects and setup relations
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('computer', '电脑', 'Computer', 'Sains Komputer', '💻');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('pe', '体育', 'Physical Education', 'Pendidikan Jasmani', '🏃');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('science_1', '科学 1', 'Science 1', 'Sains 1', '🧪');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('science_2', '科学 2', 'Science 2', 'Sains 2', '🧬');

INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('computer', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('pe', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('science_1', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('science_2', '2026_J2Ai');

INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (10, 'computer_t', '电脑老师', 'Computer Teacher', 'Guru Komputer', 'B/rLJ8WfdDxs5BccfkUX0A==:COCXgliCpR9zf9TLZKfPoHB/6LJObxJPhe8+JfyqEdg=', 'teacher');
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (11, 'pe_t', '体育老师', 'PE Teacher', 'Guru PJPK', 'B/rLJ8WfdDxs5BccfkUX0A==:COCXgliCpR9zf9TLZKfPoHB/6LJObxJPhe8+JfyqEdg=', 'teacher');

INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (6, 'science_1');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (6, 'science_2');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (10, 'computer');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (11, 'pe');

-- 2. Insert/Update comments for Computer (computer)
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (1, 'computer', '2026', '学业表现有所进步，并能主动协助老师处理事务。若能保持专注与细心，表现将更加出色。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (2, 'computer', '2026', '课堂上仍需培养更积极的学习态度。把心思放在成长上，收获自然会越来越多。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (3, 'computer', '2026', '愿意参与班级服务工作。若能在言语与行为上多一分自律，将更受师长与同学欣赏。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (4, 'computer', '2026', '上课专心，愿意参与课堂互动，学习态度良好。持续保持这份认真，进步自然会累积。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (5, 'computer', '2026', '学习表现稳定，课堂参与情况良好。珍惜每一次学习机会，必能让自己的长处更加突出。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (6, 'computer', '2026', '能够完成课堂任务。若能以更积极和尊重的态度与人相处，将更能展现个人魅力。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (7, 'computer', '2026', '课堂表现尚可，偶尔会参与互动。若能减少与同学闲谈，把专注力放在学习上，将有更好的表现。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (8, 'computer', '2026', '学习态度认真，课堂参与积极，并能主动回应老师提问。持续保持自律与上进心，未来可期。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (9, 'computer', '2026', '与同桌互动融洽。若能在课堂上更专注于学习，并勇于完整表达自己的想法，将有助于提升学习成效。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (10, 'computer', '2026', '学习仍有进步空间，应加强课堂自律与专注，良好的学习态度和礼仪修养，是成长最稳固的基础。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (12, 'computer', '2026', '学习仍有进步空间。若能主动投入课堂学习，培养独立思考与自律精神，表现将更上一层楼。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (13, 'computer', '2026', '近来比较自律，说话频率降低了一点。若能在言语中多一分尊重与体谅，将更能展现良好的个人修养。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (14, 'computer', '2026', '课堂表现尚可。若能主动承担责任，积极参与课堂活动，必能发挥更大的潜力。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (16, 'computer', '2026', '与同学相处融洽。若能更积极参与课堂互动，勇于表达自己的想法，学习表现将更加出色。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (18, 'computer', '2026', '乐于协助老师，做事认真负责，课堂表现良好。若能进一步提升学习效率，相信会有增优异的表现。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (19, 'computer', '2026', '课堂表现尚可，需更加积极。保持谦逊的学习态度，广结善缘，才能让自己的长处发挥得更加长远。', 1);

-- 3. Insert/Update comments for Science 1 (science_1)
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (1, 'science_1', '2026', '上课走神，专注力低。学习化学知识能力较弱。会负责任，帮助维持班级卫生。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (2, 'science_1', '2026', '上课不专心，玩闹，打瞌睡。但被老师罚站是会乖乖认罚。说话比较粗鲁。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (3, 'science_1', '2026', '上课走神，学习不积极，会与同学讲悄悄话。但整体算安静。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (4, 'science_1', '2026', '专注力不长，但偶有参与课堂回答。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (5, 'science_1', '2026', '老师要求抄笔记则会抄。偶尔会回答老师提问。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (6, 'science_1', '2026', '在课堂上很难保持安静，常与紫涵聊天或做与学习任务无关的事情。但也会积极回应老师提问。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (7, 'science_1', '2026', '上课尚算认真，对于老师的提问会认真积极回答，对课堂加分表现正面态度。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (8, 'science_1', '2026', '上课表现尚可。会积极抢答，对于加分的活动表现积极。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (9, 'science_1', '2026', '上课不专心，学习极弱。上课时会与同学私下讲话。但整体算安静，不会造成干扰。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (10, 'science_1', '2026', '难专心，上课时会讲话，做其他功课，老师提问基本答不上来。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (12, 'science_1', '2026', '需要老师时刻监督，不然就会放飞自己，写作业时需要时时监督，不然就不写，静不下来，好玩。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (13, 'science_1', '2026', '偶会走神，大多数保持安静（换位后），如果与男同学在一起则会跟着一起讲话。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (14, 'science_1', '2026', '课堂上相当积极回应提问，老师一停下讲课，就会四处走动和同学讲话，造成干扰。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (16, 'science_1', '2026', '几乎都不在状况，可能受视力不佳影响，抄东西特别慢。很容易受邻桌影响而不上课。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (18, 'science_1', '2026', '容易打瞌睡，上课会发呆，写字特别慢。但对老师要求抄的东西认真对待。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (19, 'science_1', '2026', '虽然上课途中，如果老师讲课时间较长，就会失去专注力而打瞌睡，但有听课时对回答问题很积极。', 1);

-- 4. Insert/Update comments for Science 2 (science_2)
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (1, 'science_2', '2026', '上课偶有分神，但功课都会准时完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (2, 'science_2', '2026', '上课态度积极，积极回答问题，功课也会定时完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (3, 'science_2', '2026', '在班上态度尚好，偶尔会分心，但功课会完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (4, 'science_2', '2026', '上课态度积极，积极回答问题，功课也会定时完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (5, 'science_2', '2026', '经常缺席，在班上态度尚好，功课有些也会缺交', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (6, 'science_2', '2026', '上课态度积极，积极回答问题，功课也会定时完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (7, 'science_2', '2026', '上课态度积极，积极回答问题，功课也会定时完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (8, 'science_2', '2026', '上课态度积极，积极回答问题，功课也会定时完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (9, 'science_2', '2026', '在班上态度尚好，偶尔会分心，但功课会完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (10, 'science_2', '2026', '在班上态度尚好，会回答问题，但功课会完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (12, 'science_2', '2026', '在班上态度尚好，会回答问题，但功课不完整。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (13, 'science_2', '2026', '在班上态度尚好，偶尔会分心，但功课会完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (14, 'science_2', '2026', '上课态度积极，积极回答问题，功课也会定时完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (16, 'science_2', '2026', '在班上态度尚好，偶尔会分心，关系自然会越来越好', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (18, 'science_2', '2026', '在班上态度尚好，偶尔会分心，但功课会完成得很工整', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (19, 'science_2', '2026', '上课态度积极，积极回答问题，功课也会定时完成', 1);

-- 5. Insert/Update comments for History (history)
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (1, 'history', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (2, 'history', '2026', '没有学习的动力！必须要有目标，才有前进动力！', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (3, 'history', '2026', '上课很多话', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (4, 'history', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (5, 'history', '2026', '经常缺课', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (6, 'history', '2026', '思维敏捷，学习能力强。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (7, 'history', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (8, 'history', '2026', '学习有时太生硬死板，必须活学活用', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (9, 'history', '2026', '经常跟芷涵说话', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (10, 'history', '2026', '上课很多话讲，要被老师骂才收敛。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (12, 'history', '2026', '无心向学，上课分心，功课常拖欠。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (13, 'history', '2026', '最近明显失去学习的动力，成绩明显退步。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (14, 'history', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (16, 'history', '2026', '无心向学，专注力非常差', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (18, 'history', '2026', '会主动帮老师，有求知欲，热爱学习。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (19, 'history', '2026', '专注力不好。', 1);

-- 6. Insert/Update comments for Geography (geography)
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (1, 'geography', '2026', '在班上有认真听课，有时候会做自己的事而分心', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (2, 'geography', '2026', '会帮忙老师，常不礼貌的对待同学，上课有时会分心', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (3, 'geography', '2026', '是位有天赋的孩子，今年上课一直不专心，一直与同桌聊天', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (4, 'geography', '2026', '上课专心，成绩方面需努力', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (5, 'geography', '2026', '在班上很常与别人玩闹，有把该做的事情完成', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (6, 'geography', '2026', '课堂表现不错，有时对老师无礼，在班上会唱歌打扰上课', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (7, 'geography', '2026', '上课专心，常参与课堂问答，有时会常聊天', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (8, 'geography', '2026', '上课专心，成绩方面不错，在班上算是模范生', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (9, 'geography', '2026', '常与同桌聊天，成绩方面需要改善', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (10, 'geography', '2026', '常参与课堂活动，有时会玩闹', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (12, 'geography', '2026', '近期上课有专心，希望可以保持，之前常常上课不专心', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (13, 'geography', '2026', '是位有天赋的孩子，爱讲话，很难专心上课', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (14, 'geography', '2026', '上课专心，成绩方面需加油', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (16, 'geography', '2026', '上课专心，偶尔会与同桌玩闹', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (18, 'geography', '2026', '上课专心，字体很美，成绩方面需加油', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (19, 'geography', '2026', '上课专心，近期成绩表现不错', 1);

-- 7. Insert/Update comments for Chinese (chinese)
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (1, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (2, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (3, 'chinese', '2026', '上课时若能专心，减少与同桌聊天的频率，会有更出色的表现。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (4, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (5, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (6, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (7, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (8, 'chinese', '2026', '有用心听课，态度认真', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (9, 'chinese', '2026', '上课时若能专心，减少与同桌聊天的频率，会有更出色的表现。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (10, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (12, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (13, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (14, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (16, 'chinese', '2026', '-', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (18, 'chinese', '2026', '写作业的速度需要加快。', 1);
INSERT OR REPLACE INTO reports (student_id, subject_code, academic_year_id, feedback, is_complete) VALUES (19, 'chinese', '2026', '整体表现需要再调整，功课缺交状况较严重。', 1);
