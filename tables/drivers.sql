CREATE TABLE drivers_staging(
	driver_id INT,
    driver_name VARCHAR(100),
    employment_type VARCHAR(50),
    hire_date VARCHAR(20),
    experience_years INT,
    performance_rating INT
);

DESCRIBE drivers_staging;

SELECT * FROM drivers_staging;

SELECT COUNT(*) FROM drivers_staging;

CREATE TABLE drivers(
	driver_id INT PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    employment_type VARCHAR(50),
    hire_date DATE,
    experience_years INT,
    performance_rating INT
);

DESCRIBE drivers;

INSERT INTO drivers(
	driver_id,
    driver_name,
    employment_type,
    hire_date,
    experience_years,
    performance_rating
)
SELECT
	driver_id,
    driver_name,
    employment_type,
    STR_TO_DATE(hire_date, '%d-%m-%Y'),
    experience_years,
    performance_rating
FROM drivers_staging;

SELECT * FROM drivers;

SELECT COUNT(*) FROM drivers;