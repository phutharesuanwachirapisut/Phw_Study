SET @ROW := 0;                              -- สร้างค่าใหม่ขึ้นมา
SELECT REPEAT("* ",@ROW := @ROW + 1)        -- REAPEAT(ตัวที่จะแสดงซ้ำ, เงื่อนไขใดๆ) -> คล้าย loop in python
FROM INFORMATION_SCHEMA.TABLES              -- แสดงตารางทั้งหมด
WHERE @ROW < 20;