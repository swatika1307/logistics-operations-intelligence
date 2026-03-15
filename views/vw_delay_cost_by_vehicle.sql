CREATE VIEW vw_delay_cost_by_vehicle AS
SELECT
	v.vehicle_model,
	COUNT(o.order_id) AS total_deliveries,
    SUM(
		CASE
			WHEN o.delay_reason <> '' THEN 1
            ELSE 0
		END
	) AS total_delays,
    SUM(
		CASE
			WHEN o.delay_reason <> '' THEN 25
            ELSE 0
		END
	) AS delay_cost

FROM orders o
JOIN vehicles v
	ON o.vehicle_id = v.vehicle_id
    
GROUP BY
	v.vehicle_model
    
ORDER BY delay_cost DESC;

DESCRIBE vw_delay_cost_by_vehicle;

SELECT * FROM vw_delay_cost_by_vehicle;