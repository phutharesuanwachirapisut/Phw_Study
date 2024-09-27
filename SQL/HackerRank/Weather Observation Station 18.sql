SELECT ROUND(F.G, 4)
FROM (
    SELECT (ABS(C - A) +ABS(D - B)) AS G
    FROM (
        SELECT MIN(LAT_N) AS A, MIN(LONG_W) AS B, MAX(LAT_N) AS C, MAX(LONG_W) AS D
        FROM STATION
    ) AS V
) AS F;
-- Manhattan Distance