CREATE TABLE vehicles_staging(
	purchase_date VARCHAR(20),
    vehicle_id INT,
    vehicle_model VARCHAR(100),
    vehicle_status VARCHAR(50),
    breakdown_count INT,
    maintenance_count INT,
    vehicle_code VARCHAR(20)
);

DESCRIBE vehicles_staging;

SELECT * FROM vehicles_staging;

SELECT COUNT(*) FROM vehicles_staging;

CREATE TABLE vehicles(
    vehicle_id INT PRIMARY KEY,
    vehicle_model VARCHAR(100),
    vehicle_status VARCHAR(50),
    breakdown_count INT,
    maintenance_count INT,
    vehicle_code VARCHAR(20) UNIQUE,
    purchase_date DATE
);

DESCRIBE vehicles;

INSERT INTO vehicles(
	vehicle_id,
    vehicle_model,
    vehicle_status,
    breakdown_count,
    maintenance_count,
    vehicle_code,
    purchase_date
)
SELECT
	vehicle_id,
    vehicle_model,
    vehicle_status,
    breakdown_count,
    maintenance_count,
    vehicle_code,
    STR_TO_DATE(purchase_date, '%d-%m-%Y')
FROM vehicles_staging;

SELECT * FROM vehicles;

SELECT COUNT(*) FROM vehicles;