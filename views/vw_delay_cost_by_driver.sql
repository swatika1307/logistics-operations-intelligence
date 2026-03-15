CREATE VIEW vw_delay_cost_by_driver AS
SELECT
	d.driver_id,
    d.driver_name,
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
JOIN drivers d
	ON o.driver_id = d.driver_id
    
GROUP BY
	d.driver_id,
    d.driver_name
    
ORDER BY delay_cost DESC;

DESCRIBE vw_delay_cost_by_driver;

SELECT * FROM vw_delay_cost_by_driver;