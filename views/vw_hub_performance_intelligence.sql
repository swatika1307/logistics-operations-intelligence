CREATE VIEW vw_hub_performance_intelligence AS
SELECT
	hub_id,
    hub_name,
    hub_capacity,
    total_orders,
    total_delays,
    delay_percentage,
	avg_hub_processing_time_hours,
    hub_utilization_percentage,
    
    CASE
		WHEN hub_utilization_percentage < 2.5 THEN 'Underutilized'
        WHEN hub_utilization_percentage BETWEEN 2.5 AND 3.5 THEN 'Optimized'
        ELSE 'High load'
	END AS hub_stress_level,
    
    DENSE_RANK() OVER(ORDER BY delay_percentage DESC, total_delays DESC) AS delay_risk_rank

FROM vw_hub_performance_base
ORDER BY hub_id;

DESCRIBE vw_hub_performance_intelligence;

SELECT * FROM vw_hub_performance_intelligence;

DROP VIEW vw_hub_performance_intelligence;