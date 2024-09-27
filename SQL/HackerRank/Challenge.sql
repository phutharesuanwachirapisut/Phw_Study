SELECT H.HACKER_ID, H.NAME, COUNT(C.CHALLENGE_ID)
FROM HACKERS AS H
INNER JOIN CHALLENGES AS C
ON H.HACKER_ID = C.HACKER_ID
GROUP BY H.HACKER_ID, H.NAME
HAVING  -- เงื่อนไขในการ GROUP BY 
        -- จากโจทย์ เงื่อนไข คือ ไม่แสดงข้อมูลที่ มี hacker_id > 1 คน ที่สร้าง challenge จำนวนเท่ากัน
        -- และ จำนวน challenge ที่สร้าง นั้นน้อยกว่า maximum ของ challenge ที่สร้าง
        -- เพื่อให้ข้อมูลเขียนได้ง่ายขึ้น ดังนั้น จึงใช้การ reverse ทางตรรกศาสตร์

    -- เงื่อนไขแรก คือ การที่ข้อมูลต้องมีค่าเท่ากับ ค่าสูงสุด
    COUNT(C.CHALLENGE_ID) = (
        SELECT MAX(CNT) -- เป็นการเลือก ค่าสูงสุด ของจำนวน challenges ทั้งหมด ที่ hacker_id แต่ละคนสร้างขึ้น
        FROM ( -- subquery นี้ อธิบายได้ว่า เป็นการแสดงข้อมูล จำนวน challenges ทั้งหมด ที่ hacker_id แต่ละคนสร้างขึ้น
            SELECT COUNT(*) AS CNT 
             FROM CHALLENGES
             GROUP BY HACKER_ID
             ) AS TEMP1
)
    -- เงื่อนไขที่ 2 คือ การที่ข้อมูลต้องปรากฎเพียง 1 ครั้ง
    OR COUNT(C.CHALLENGE_ID) IN ( -- เป็นเงื่อนไขที่จะนำแต่ละตัวบน column COUNT(C.CHALLENGE_ID) มาพิจารณาว่า เกิดตัวซ้ำหรือไม่จากใน subqery
        SELECT CNT -- เป็นแสดงข้อมูลของ จำนวน challenges ทั้งหมด ที่ hacker_id แต่ละคนสร้างขึ้น
        FROM ( -- subquery นี้ อธิบายได้ว่า เป็นการแสดงข้อมูล จำนวน challenges ทั้งหมด ที่ hacker_id แต่ละคนสร้างขึ้น
            SELECT COUNT(*) AS CNT
             FROM CHALLENGES
             GROUP BY HACKER_ID
        ) AS T
        GROUP BY CNT
        HAVING COUNT(CNT) = 1 -- เงื่อนไขที่ว่า หากมีตัวซ้ำเกิดขึ้น จะไม่แสดง จะแสดงแค่ตัวที่ไม่ซ้ำ หรือก็คือ ถูกนับได้แค่ 1 เท่านั้น
    )
        
        
ORDER BY COUNT(C.CHALLENGE_ID) DESC, H.HACKER_ID;