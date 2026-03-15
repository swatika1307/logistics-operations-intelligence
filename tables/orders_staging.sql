CREATE TABLE orders_staging(
	order_id INT,
    actual_delivery_date VARCHAR(20),
    delay_reason VARCHAR(100),
    driver_id INT,
    driver_name VARCHAR(100),
    hub_name VARCHAR(100),
    is_delayed VARCHAR(10),
    is_on_time VARCHAR(10),
    order_date VARCHAR(20),
    order_status VARCHAR(50),
    vehicle_name VARCHAR(20),
    vehicle_type VARCHAR(50),
    customer_satisfaction INT,
    delivery_time_hours VARCHAR(20),
    hub_processing_time_hours VARCHAR(20)
);

DESCRIBE orders_staging;

SELECT * FROM orders_staging;

SELECT COUNT(*) FROM orders_staging;

SELECT COUNT(*)
FROM orders_staging
WHERE actual_delivery_date = "";

SELECT COUNT(*)
FROM orders_staging
WHERE delivery_time_hours = "";

SELECT COUNT(*) 
FROM orders_staging
WHERE order_status = 'Cancelled';

SELECT order_status, COUNT(*) 
FROM orders_staging
GROUP BY order_status;

SELECT COUNT(*) 
FROM orders_staging
WHERE order_status = 'Cancelled'
AND actual_delivery_date = ""
AND delivery_time_hours = "";