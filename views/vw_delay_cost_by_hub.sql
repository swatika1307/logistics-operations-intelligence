CREATE VIEW vw_delay_cost_by_hub AS
SELECT
	h.hub_id,
    h.hub_name,
	COUNT(o.order_id) AS total_order,
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
JOIN hubs h
	ON o.hub_id = h.hub_id
    
GROUP BY
	h.hub_id,
    h.hub_name
    
ORDER BY delay_cost DESC;

DESCRIBE vw_delay_cost_by_hub;

SELECT * FROM vw_delay_cost_by_hub;