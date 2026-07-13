-- Auto-generated Seed Data
PRAGMA foreign_keys = ON;

-- Academic Year Data
INSERT OR IGNORE INTO academic_years (id, display_name, is_current) VALUES ('2026', '2026å­¦å¹´', 1);

-- Classes Data
INSERT OR IGNORE INTO student_groups (id, academic_year_id, name, name_en, name_ms) VALUES ('2026_J2Ai', '2026', 'åˆäºŒçˆ±ç­', 'Junior 2 Ai', 'Junior 2 Ai');

-- Subjects Data
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('chinese', 'åŽè¯­', 'Chinese', 'Bahasa Cina', 'ðŸ®');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('english', 'è‹±è¯­', 'English', 'Bahasa Inggeris', 'ðŸ”¤');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('malay', 'å›½è¯­', 'Malay', 'Bahasa Melayu', 'ðŸ‡²ðŸ‡¾');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('math', 'æ•°å­¦', 'Mathematics', 'Matematik', 'ðŸ“');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('science', 'ç§‘å­¦', 'Science', 'Sains', 'ðŸ§ª');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('history', 'åŽ†å²', 'History', 'Sejarah', 'ðŸ“œ');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('geography', 'åœ°ç†', 'Geography', 'Geografi', 'ðŸ—ºï¸');
INSERT OR IGNORE INTO subjects (code, display_name, display_name_en, display_name_ms, emoji) VALUES ('art', 'ç¾Žæœ¯', 'Art', 'Pendidikan Seni', 'ðŸŽ¨');

-- Subject-Group Map Data
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('chinese', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('english', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('malay', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('math', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('science', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('history', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('geography', '2026_J2Ai');
INSERT OR IGNORE INTO subject_groups (subject_code, group_id) VALUES ('art', '2026_J2Ai');

-- Teachers and Subject Map Data
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (1, 'form_teacher', 'ç­ä¸»ä»»', 'Form Teacher', 'Guru Kelas', 'B/rLJ8WfdDxs5BccfkUX0A==:COCXgliCpR9zf9TLZKfPoHB/6LJObxJPhe8+JfyqEdg=', 'form_teacher');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (1, '*');
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (2, 'chinese_t', 'åŽè¯­è€å¸ˆ', 'Chinese Teacher', 'Guru Bahasa Cina', 't3bx1/yF//hdFKydrOkiNg==:jgfG4p2XRDU3Wmz/Ur6Y63iSEcUL/wjBJL1ZaA7is1k=', 'teacher');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (2, 'chinese');
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (3, 'english_t', 'è‹±è¯­è€å¸ˆ', 'English Teacher', 'Guru Bahasa Inggeris', 'TPK3YFc4GqiAjKUOjXLmzA==:80SKHMHpoP14amE375R5I1vXINl8R9zphaZ2jfvgdpw=', 'teacher');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (3, 'english');
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (4, 'malay_t', 'å›½è¯­è€å¸ˆ', 'Malay Teacher', 'Guru Bahasa Melayu', 'EJzn44wELA+OONxyx//RoA==:8rtGInZhYC5yWiIWmdU1Fc9CAacE87frIoQe/t48oaI=', 'teacher');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (4, 'malay');
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (5, 'math_t', 'æ•°å­¦è€å¸ˆ', 'Math Teacher', 'Guru Matematik', 'Dc8CnFUGgGvMTKgFt029aw==:Y7CStUmuNfwtcjlsa8aSu0Rp76W5L5e/wwNlfFDxu/o=', 'teacher');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (5, 'math');
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (6, 'science_t', 'ç§‘å­¦è€å¸ˆ', 'Science Teacher', 'Guru Sains', 'ZuyCxEVof+SnyJUQ3Bhclg==:s1OakEjIKy2DTjXIBhvVJu95tpgy2zFIdigfVJ+mAsY=', 'teacher');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (6, 'science');
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (7, 'history_t', 'åŽ†å²è€å¸ˆ', 'History Teacher', 'Guru Sejarah', 'iw2NDAiMAZtJ3VHxvAtnaw==:PvRXRmEE4uTZwEpNRGSiEenNELhIUXQUQex6MB4NC5Y=', 'teacher');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (7, 'history');
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (8, 'geography_t', 'åœ°ç†è€å¸ˆ', 'Geography Teacher', 'Guru Geografi', 'SGe5SFdk6vBkNtj8Xoz35w==:qNpcAb12tdVrxUmVeS9QKDm7Bhh3vyFJCBjFvIDI6io=', 'teacher');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (8, 'geography');
INSERT OR IGNORE INTO teachers (id, username, display_name, display_name_en, display_name_ms, password, role) VALUES (9, 'art_t', 'ç¾Žæœ¯è€å¸ˆ', 'Art Teacher', 'Guru Seni', 'i2izvWdWXkB6rcNggq6QJA==:zFhQZI/1E2ImuNj7SPBVXIsug9QjHyZq9hChI0ySVOE=', 'teacher');
INSERT OR IGNORE INTO teacher_subjects (teacher_id, subject_code) VALUES (9, 'art');

-- Students and Class Map Data
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (1, '25091', 'å´æ·‘å©·', 'GOH SHU TING', 'F', 1, '012-5853134', '010-665 9685', '18,LORONG SEMARAK 2/7 TAMAN SEMARAK 2,34000 TAIPING PERAK', '', 'photos/25091.jpg', 'active', 'A293WK8X');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (1, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (2, '25060', 'å´ç´«æ¶µ', 'GOH ZI HAN', 'F', 0, '016-4462763', '012-328 2763', '13,JALAN MEDAN TAIPING 7,MEDAN TAIPING,34000 TAIPING PERAK.', '', 'photos/25060.jpg', 'active', 'WG9U7J6W');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (2, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (3, '25151', 'å´èŠ·æ¶µ', 'GOH ZI HAN', 'F', 1, '012-429 2504', '011-1669 8357', 'NO5,LORONG VILA INDAH 2,TAMAN VILA INDAH,14300 NIBONG TEBAL,PULAU PINANG.', '', 'photos/25151.jpg', 'active', 'TV6CAFRX');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (3, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (4, '25094', 'è®¸å¯æ˜•', 'KHOR KE XIN', 'F', 0, '016-5210729', '011-2686 6638', '28,TAMAN JANA SETIA,TAMAN JANA SETIA ,34600 KAMUNTING PERAK.', '', 'photos/25094.jpg', 'active', 'DPYLT3MF');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (4, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (5, '25095', 'è®¸èŠ¯ç‘¶', 'KHOR XIN YAO', 'F', 0, '017-6715480', '012-682 5480', '807,JALAN WALKE POKOK ASSAM,34000 TAIPING PERAK.', '', 'photos/25095.jpg', 'active', 'CARZ7G9B');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (5, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (6, '25098', 'å½­æºå¦¤', 'PEH KHAI YI', 'F', 0, '017-7368186', '011-20810156', '4,LORONG PULAI ,TAMAN SIMPANG MAKMUR 2,34700 PERAK.', '', 'photos/25098.jpg', 'active', '9ZRY7XKQ');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (6, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (7, '25147', 'é™ˆæ²›å€ª', 'TAN PENNY', 'F', 1, '018-4061353', '011-1084 2181', 'NO 116E,JALAN BESAR,09810 SELAMA,KEDAH.', 'é™ˆæ²›æ…ˆ (é«˜ä¸‰ä» S3K)', 'photos/25147.jpg', 'active', 'XA4UL75G');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (7, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (8, '25069', 'éƒ‘åæ¶µ', 'TEH MING HAN', 'F', 0, '012-5203750', '011-26111101', '10,LORONG BERSATU 4, TAMAN SIMPANG BERSATU,34700 SIMPANG PERAK.', '', 'photos/25069.jpg', 'active', 'YQ7R5GXN');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (8, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (9, '25102', 'èƒ¡å˜‰ç€…', 'WOO JIA YING', 'F', 0, '019-5515618', '017-636 1886', 'PT2163,TAMAN PERMAI 2,34100 SELAMA PERAK.', '', 'photos/25102.jpg', 'active', 'ZMPHTPXG');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (9, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (10, '25074', 'å·«å½¦æ™–', 'BOO YAN FEY', 'M', 0, '016-8318951', '016-968 8812', '2,LORONG SP/3,TAMAN SURIA PERMAI,34000 TAIPING PERAK.', '', 'photos/25074.jpg', 'active', 'QVK9F9H3');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (10, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (11, '24063', 'æ›¾æ¢“æ±¶', 'CHANG ZI WEN', 'M', 0, '016-5266969', '', '7,JALAN MAKMUR 2/2,TAMAN PANGKALAN MAKMUR 2, 34000 TAIPING PERAK.', 'æ›¾æ¢“å¥ (å·²ç¦»æ ¡)', 'photos/24063.jpg', 'left', 'AVG59H2A');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (11, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (12, '25109', 'æ–¹æ¥·æ¼©', 'HONG KHAI XUAN', 'M', 0, '012-2986801', '011-15106801', '2,JALAN MUHIBBAH 7,TAMAN MUHIBBAH,KUALA GULA,34350 KUALA KURAU,PERAK.', '', 'photos/25109.jpg', 'active', '2QRXUWLP');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (12, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (13, '25086', 'é™ˆæ¯…', 'KAYDEN TAN AIK', 'M', 0, '012-5585750', '012-310 6928', '284,JALAN PAKCIK AHMAD TAMAN BERSATU KAMPUNG BOYAN 34000 TAIPING PERAK.', 'é™ˆé›ªéŠ˜ (é«˜ä¸€ä» S1K)', 'photos/25086.jpg', 'active', '4K7ZLP9X');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (13, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (14, '25081', 'æž—æ¥·å¥', 'LIM KAI JIAN', 'M', 1, '012-4949790', '010-808 1574', '6,LORONG SINTAR 7,TAMAN SINTAR,14300 NIBONG TEBAL.', '', 'photos/25081.jpg', 'active', '2WJTDLTE');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (14, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (15, '26095', 'æž—é“ å‹¤', 'LIM KAI QIN', 'M', 1, '016-4422 722', '011-3328 3362', 'C2,BIDOR STATION,35500 BIDOR,PERAK.', '', 'photos/26095.jpg', 'left', 'RDJ29Q3U');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (15, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (16, '25169', 'é»„ä¿Šè¾¾', 'OON JUN DA', 'M', 0, '016-5050 009', '011-5751 7858', 'NO 21,PT 5030,LORONG 5,TAMAN ANJUNG SEMARAK,34000 TAIPING PERAK.', '', 'photos/25169.jpg', 'active', 'ZT2AQBNW');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (16, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (17, '25003', 'æ½˜çŽŸæ–Œ', 'PHUAH WEN BIN', 'M', 0, '011-5328 2263', '', '202,JALAN CHUAH TEIK SENG,TAMAN SENING KAMPUNG BOYAN', '', 'photos/25003.jpg', 'left', 'KF9AMWGL');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (17, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (18, '25087', 'æˆ´ä»²è¨“', 'TEH ZHONG XUN', 'M', 0, '016-4483378', '016-546 2020', '27,LORONG RIA 3,TAMAN RIA,34700 SIMPANG ,PERAK.', '', 'photos/25087.jpg', 'active', 'LAVFMD5S');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (18, '2026_J2Ai');
INSERT OR IGNORE INTO students (id, student_number, name, name_en, gender, is_boarding, parent_phone, student_phone, address, siblings, photo_url, status, parent_code) VALUES (19, '25119', 'å°¤å®‡ç¿”', 'YEU YEE SIANG', 'M', 1, '014-3095815', '011-8842260', '84,LORONG 4,AULONG LAMA,34000 TAIPING PERAK.', '', 'photos/25119.jpg', 'active', '3TF7TDU4');
INSERT OR IGNORE INTO student_class_relations (student_id, group_id) VALUES (19, '2026_J2Ai');

