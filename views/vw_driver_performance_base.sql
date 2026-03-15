CREATE VIEW vw_driver_performance_base AS
SELECT
	d.driver_id,
    d.driver_name,
    d.employment_type,
    d.hire_date,
    d.experience_years,
    d.performance_rating,
    
    COUNT(o.order_id) AS total_deliveries,
    SUM(
		CASE
			WHEN o.delay_reason <> '' THEN 1
            ELSE 0
		END) AS total_delays,
	ROUND(SUM(
		CASE
			WHEN o.delay_reason <> '' THEN 1
            ELSE 0
		END) / COUNT(o.order_id) * 100, 2) AS delay_percentage,
	ROUND(AVG(o.delivery_time_hours), 2) AS avg_delivery_time_hours,
    ROUND(AVG(o.customer_satisfaction), 2) AS avg_customer_satisfaction

FROM orders o
JOIN drivers d
	ON 	o.driver_id = d.driver_id
    
GROUP BY
	d.driver_id,
    d.driver_name,
    d.employment_type,
    d.hire_date,
    d.experience_years,
    d.performance_rating;
    
DESCRIBE vw_driver_performance_base;

SELECT * FROM vw_driver_performance_base;