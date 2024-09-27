SELECT H.HACKER_ID, H.NAME, SUM(MAX_SCORE.SCORE) AS TS -- SUM(FIELD) บวกข้อมูลทั้งหมดใน FIELD ที่ตรงตามเงื่อนไข
FROM HACKERS AS H
INNER JOIN (                                        -- เป็นการประยุกต์ใช้ subquery กับ inner join โดยใช้ subquery ดึงข้อมูลเพื่อสร้างเป็นตารางชั่วคราวไว้ในชื่อ MAX_SCORE

    SELECT HACKER_ID, MAX(SCORE) AS SCORE           -- เลือก HACKER_ID, MAX(SCORE) 
    FROM SUBMISSIONS                                -- จาก SUBMISSIONS
    GROUP BY CHALLENGE_ID, HACKER_ID) MAX_SCORE     -- โดย รวมกลุ่มจากการเลือกเฉพาะ CHALLENGE_ID ที่มีค่า score สูงสุดใน HACKER_ID 

ON H.HACKER_ID = MAX_SCORE.HACKER_ID
GROUP BY H.HACKER_ID, H.NAME
HAVING TS > 0
ORDER BY TS DESC, H.HACKER_ID ASC;