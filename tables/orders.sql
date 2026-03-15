CREATE TABLE orders(
	order_id INT PRIMARY KEY,
    order_date DATE,
    actual_delivery_date DATE NULL,
    driver_id INT,
    hub_id INT,
    vehicle_id INT,
    order_status VARCHAR(20) NOT NULL,
    delay_reason VARCHAR(100),
    customer_satisfaction INT,
    delivery_time_hours DECIMAL(6,2) NULL,
    hub_processing_time_hours DECIMAL(6,2),
    
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (hub_id) REFERENCES hubs(hub_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

DESCRIBE orders;

SELECT 
	os.order_id,
    STR_TO_DATE(os.order_date,'%d-%m-%Y') AS order_date,
    CASE
		WHEN os.actual_delivery_date = "" THEN NULL
        ELSE STR_TO_DATE(os.actual_delivery_date,'%d-%m-%Y')
	END AS actual_delivery_date,
    os.driver_id,
    h.hub_id,
    v.vehicle_id,
    os.order_status,
    os.delay_reason,
    os.customer_satisfaction,
    CASE
		WHEN os.delivery_time_hours = "" THEN NULL
        ELSE CAST(os.delivery_time_hours AS DECIMAL(6,2))
	END AS delivery_time_hours,
    CASE
		WHEN os.hub_processing_time_hours = "" THEN NULL
        ELSE CAST(os.hub_processing_time_hours AS DECIMAL(6,2))
	END AS hub_processing_time_hours
FROM orders_staging os
JOIN hubs h
ON os.hub_name = h.hub_name
JOIN vehicles v
ON os.vehicle_name = v.vehicle_code
LIMIT 50;

INSERT INTO orders(
	order_id,
    order_date,
    actual_delivery_date,
    driver_id,
    hub_id,
    vehicle_id,
    order_status,
    delay_reason,
    customer_satisfaction,
    delivery_time_hours,
    hub_processing_time_hours
)
SELECT 
	os.order_id,
    STR_TO_DATE(os.order_date,'%d-%m-%Y'),
    CASE
		WHEN os.actual_delivery_date = "" THEN NULL
        ELSE STR_TO_DATE(os.actual_delivery_date,'%d-%m-%Y')
	END,
    os.driver_id,
    h.hub_id,
    v.vehicle_id,
    os.order_status,
    os.delay_reason,
    os.customer_satisfaction,
    CASE
		WHEN os.delivery_time_hours = "" THEN NULL
        ELSE CAST(os.delivery_time_hours AS DECIMAL(6,2))
	END,
    CASE
		WHEN os.hub_processing_time_hours = "" THEN NULL
        ELSE CAST(os.hub_processing_time_hours AS DECIMAL(6,2))
	END
FROM orders_staging os
JOIN hubs h
ON os.hub_name = h.hub_name
JOIN vehicles v
ON os.vehicle_name = v.vehicle_code;

SELECT * FROM orders; 

SELECT COUNT(*) FROM orders;

SELECT order_status, COUNT(*)
FROM orders
GROUP BY order_status;