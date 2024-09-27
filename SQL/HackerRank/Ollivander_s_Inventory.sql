SELECT W.ID, WP.AGE, W.COINS_NEEDED, W.POWER
FROM WANDS AS W
INNER JOIN WANDS_PROPERTY AS WP 
    ON W.CODE = WP.CODE
WHERE WP.IS_EVIL = 0 
AND W.COINS_NEEDED = (
    SELECT MIN(COINS_NEEDED)
    FROM WANDS AS W1
    INNER JOIN WANDS_PROPERTY AS WP1
    ON W1.CODE = WP1.CODE
    WHERE W1.POWER = W.POWER 
    AND WP1.AGE = WP.AGE
    ) 
-- อธิบายได้ว่า เป็นการเปรียบเทียบ database W และ W1(มาจากการ Duplicate W) ผ่านการ join โดยเปรียบเทียบเงื่อนไขคือ power เท่ากัน and age เท่ากันเช่นกัน
-- ด้วยความที่ว่า W = W1 and WP = WP1 ดังนั้นเงื่อนไขจริงเป็นจริงทุกประการ 
-- เมื่อเงื่อนไขเป็นจริงทั้งหมด(หรือหลายประการ) จึงเลือกค่าที่ต่ำที่สุด(ตาม MIN(COINS_NEEDED)) จากทั้งหมด และตัวที่นำมาเปรียบ(ให้พิจารณาเเหมือน for loop ให้พิจารณาว่าใส่ข้อมูลเปรียบทีละตัวใน field coins_needed)
-- จะได้ แถวที่มีค่าของ W.COINS_NEEDED เท่ากับค่าที่น้อยที่สุดที่สามารถหาได้จาก subquery หรือเงื่อนไขย่อย
ORDER BY W.POWER DESC, WP.AGE DESC;
