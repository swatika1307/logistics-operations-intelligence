CREATE VIEW vw_driver_performance_intelligence AS
SELECT
	driver_id,
    driver_name,
    employment_type,
    hire_date,
    experience_years,
    performance_rating,
    total_deliveries,
    total_delays,
    delay_percentage,
    
    100 - delay_percentage AS on_time_percentage,
    
    avg_delivery_time_hours,
    avg_customer_satisfaction,
    
    ROUND(
		(
			((100 - delay_percentage) / 100) * 0.5 + 
            (avg_customer_satisfaction / 5) * 0.3 + 
            (performance_rating / 5) * 0.2
		) * 100, 
        2) AS reliability_score,
        
	DENSE_RANK() OVER(
		ORDER BY (
					((100 - delay_percentage) / 100) * 0.5 + 
					(avg_customer_satisfaction / 5) * 0.3 + 
					(performance_rating / 5) * 0.2
				) DESC
	) AS driver_reliability_rank
    
FROM vw_driver_performance_base;

DESCRIBE vw_driver_performance_intelligence;

SELECT * FROM vw_driver_performance_intelligence;