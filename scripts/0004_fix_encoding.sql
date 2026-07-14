-- Fix encoding: Update all corrupted Chinese fields in D1
-- This was caused by PowerShell reading class-config.json with wrong encoding

-- Fix academic year display name
UPDATE academic_years SET display_name = '2026学年' WHERE id = '2026';

-- Fix class/group name
UPDATE student_groups SET name = '初二爱班' WHERE id = '2026_J2Ai';

-- Fix subject display names
UPDATE subjects SET display_name = '华语' WHERE code = 'chinese';
UPDATE subjects SET display_name = '英语' WHERE code = 'english';
UPDATE subjects SET display_name = '国语' WHERE code = 'malay';
UPDATE subjects SET display_name = '数学' WHERE code = 'math';
UPDATE subjects SET display_name = '科学 1' WHERE code = 'science_1';
UPDATE subjects SET display_name = '科学 2' WHERE code = 'science_2';
UPDATE subjects SET display_name = '历史' WHERE code = 'history';
UPDATE subjects SET display_name = '地理' WHERE code = 'geography';
UPDATE subjects SET display_name = '美术' WHERE code = 'art';
UPDATE subjects SET display_name = '电脑' WHERE code = 'computer';
UPDATE subjects SET display_name = '体育' WHERE code = 'pe';

-- Fix teacher display names
UPDATE teachers SET display_name = '班主任' WHERE username = 'form_teacher';
UPDATE teachers SET display_name = '华语老师' WHERE username = 'chinese_t';
UPDATE teachers SET display_name = '英语老师' WHERE username = 'english_t';
UPDATE teachers SET display_name = '国语老师' WHERE username = 'malay_t';
UPDATE teachers SET display_name = '数学老师' WHERE username = 'math_t';
UPDATE teachers SET display_name = '科学老师' WHERE username = 'science_t';
UPDATE teachers SET display_name = '历史老师' WHERE username = 'history_t';
UPDATE teachers SET display_name = '地理老师' WHERE username = 'geography_t';
UPDATE teachers SET display_name = '美术老师' WHERE username = 'art_t';
UPDATE teachers SET display_name = '电脑老师' WHERE username = 'computer_t';
UPDATE teachers SET display_name = '体育老师' WHERE username = 'pe_t';

-- Fix student names and siblings
UPDATE students SET name = '吴淑婷', address = '18,LORONG SEMARAK 2/7 TAMAN SEMARAK 2,34000 TAIPING PERAK', siblings = '' WHERE id = 1;
UPDATE students SET name = '吴紫涵', address = '13,JALAN MEDAN TAIPING 7,MEDAN TAIPING,34000 TAIPING PERAK.', siblings = '' WHERE id = 2;
UPDATE students SET name = '吴芷涵', address = 'NO5,LORONG VILA INDAH 2,TAMAN VILA INDAH,14300 NIBONG TEBAL,PULAU PINANG.', siblings = '' WHERE id = 3;
UPDATE students SET name = '许可昕', address = '28,TAMAN JANA SETIA,TAMAN JANA SETIA ,34600 KAMUNTING PERAK.', siblings = '' WHERE id = 4;
UPDATE students SET name = '许芯瑶', address = '807,JALAN WALKE POKOK ASSAM,34000 TAIPING PERAK.', siblings = '' WHERE id = 5;
UPDATE students SET name = '彭恺妤', address = '4,LORONG PULAI ,TAMAN SIMPANG MAKMUR 2,34700 PERAK.', siblings = '' WHERE id = 6;
UPDATE students SET name = '陈沛倪', address = 'NO 116E,JALAN BESAR,09810 SELAMA,KEDAH.', siblings = '陈沛慈 (高三仁 S3K)' WHERE id = 7;
UPDATE students SET name = '郑名涵', address = '10,LORONG BERSATU 4, TAMAN SIMPANG BERSATU,34700 SIMPANG PERAK.', siblings = '' WHERE id = 8;
UPDATE students SET name = '胡嘉瀅', address = 'PT2163,TAMAN PERMAI 2,34100 SELAMA PERAK.', siblings = '' WHERE id = 9;
UPDATE students SET name = '巫彦晖', address = '2,LORONG SP/3,TAMAN SURIA PERMAI,34000 TAIPING PERAK.', siblings = '' WHERE id = 10;
UPDATE students SET name = '曾梓汶', address = '7,JALAN MAKMUR 2/2,TAMAN PANGKALAN MAKMUR 2, 34000 TAIPING PERAK.', siblings = '曾梓奕 (已离校)' WHERE id = 11;
UPDATE students SET name = '方楷漩', address = '2,JALAN MUHIBBAH 7,TAMAN MUHIBBAH,KUALA GULA,34350 KUALA KURAU,PERAK.', siblings = '' WHERE id = 12;
UPDATE students SET name = '陈毅',   address = '284,JALAN PAKCIK AHMAD TAMAN BERSATU KAMPUNG BOYAN 34000 TAIPING PERAK.', siblings = '陈雪铭 (高一仁 S1K)' WHERE id = 13;
UPDATE students SET name = '林楷健', address = '6,LORONG SINTAR 7,TAMAN SINTAR,14300 NIBONG TEBAL.', siblings = '' WHERE id = 14;
UPDATE students SET name = '林铠勤', address = 'C2,BIDOR STATION,35500 BIDOR,PERAK.', siblings = '' WHERE id = 15;
UPDATE students SET name = '黄俊达', address = 'NO 21,PT 5030,LORONG 5,TAMAN ANJUNG SEMARAK,34000 TAIPING PERAK.', siblings = '' WHERE id = 16;
UPDATE students SET name = '潘玟斌', address = '202,JALAN CHUAH TEIK SENG,TAMAN SENING KAMPUNG BOYAN', siblings = '' WHERE id = 17;
UPDATE students SET name = '戴仲訓', address = '27,LORONG RIA 3,TAMAN RIA,34700 SIMPANG ,PERAK.', siblings = '' WHERE id = 18;
UPDATE students SET name = '尤宇翔', address = '84,LORONG 4,AULONG LAMA,34000 TAIPING PERAK.', siblings = '' WHERE id = 19;
