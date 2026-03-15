CREATE VIEW vw_vehicle_risk_classification AS
SELECT
    vehicle_id,
    vehicle_model,
    vehicle_status,
    vehicle_code,
    purchase_date,
    vehicle_age_years,
    breakdown_count,
    maintenance_count,
    breakdown_rate,
    total_deliveries,
    total_delays,
    delay_percentage,
    avg_delivery_time_hours,
    vehicle_risk_score,

    CASE
		WHEN vehicle_risk_score IS NULL THEN 'No Data'
		WHEN vehicle_risk_score < 25 THEN 'Low Risk'
		WHEN vehicle_risk_score < 40 THEN 'Moderate Risk'
		ELSE 'High Risk'
	END AS vehicle_risk_category,

    DENSE_RANK() OVER (
        ORDER BY vehicle_risk_score DESC
    ) AS vehicle_risk_rank

FROM vw_vehicle_performance_intelligence;

DESCRIBE vw_vehicle_risk_classification;

SELECT * FROM vw_vehicle_risk_classification;