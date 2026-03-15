CREATE TABLE dim_date(
	date_id INT PRIMARY KEY,
    full_date DATE UNIQUE,
    year INT,
    month INT,
    month_name VARCHAR(20),
    quarter VARCHAR(10),
    day_of_week INT,
    day_name VARCHAR(20),
    is_weekend BOOLEAN
);

DESCRIBE dim_date;

SET @@cte_max_recursion_depth = 5000; 

INSERT INTO dim_date(
	date_id,
    full_date,
    year,
    month,
    month_name,
    quarter,
    day_of_week,
    day_name,
    is_weekend
)
WITH RECURSIVE date_series AS(
	SELECT DATE('2023-01-01') AS dt
    UNION ALL
    SELECT DATE_ADD(dt, INTERVAL 1 DAY)
    FROM date_series
    WHERE dt < '2025-12-31'
) 
SELECT
	CAST(DATE_FORMAT(dt, '%Y%m%d') AS UNSIGNED),
    dt,
    YEAR(dt),
    MONTH(dt),
    MONTHNAME(dt),
    CONCAT('Q',QUARTER(dt)),
    DAYOFWEEK(dt),
    DAYNAME(dt),
    CASE
		WHEN DAYOFWEEK(dt) IN (1,7) THEN 1
        ELSE 0
	END
FROM date_series;

SELECT * FROM dim_date;

SELECT COUNT(*) FROM dim_date;

SELECT 
	MIN(full_date) AS minimum_date, 
    MAX(full_date) AS maximum_date
FROM dim_date;