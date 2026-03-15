CREATE VIEW vw_vehicle_performance_intelligence AS
SELECT
	vehicle_id,
	vehicle_model,
	vehicle_status,
	breakdown_count,
	maintenance_count,
	vehicle_code, 
	purchase_date,
	total_deliveries,
	total_delays,
	delay_percentage,
	avg_delivery_time_hours,
    
    TIMESTAMPDIFF(YEAR, purchase_date, CURDATE()) AS vehicle_age_years,
    ROUND(breakdown_count / TIMESTAMPDIFF(YEAR, purchase_date, CURDATE() + 1), 2) AS breakdown_rate,
    ROUND(
		(
			(TIMESTAMPDIFF(YEAR, purchase_date, CURDATE()) / 10) * 0.30 +
			(breakdown_count / 30 ) * 0.40 +
			(maintenance_count / 10) * 0.20 +
			(delay_percentage / 100) * 0.10
		) * 100,
        2) AS vehicle_risk_score
        
FROM vw_vehicle_performance_base;
        
DESCRIBE vw_vehicle_performance_intelligence;

SELECT * FROM vw_vehicle_performance_intelligence;