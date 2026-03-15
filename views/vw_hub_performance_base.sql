CREATE VIEW vw_hub_performance_base AS
SELECT
	h.hub_id AS hub_id,
    h.hub_name AS hub_name,
    h.hub_capacity AS hub_capacity,
	COUNT(o.order_id) AS total_orders,
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
	ROUND(AVG(o.hub_processing_time_hours), 2) AS avg_hub_processing_time_hours,
    ROUND((COUNT(o.order_id) / COUNT(DISTINCT o.order_date))/ h.hub_capacity * 100, 2) AS hub_utilization_percentage
FROM orders o
JOIN hubs h 
	ON o.hub_id = h.hub_id

GROUP BY 
	h.hub_id,
    h.hub_name,
    h.hub_capacity;
    
DESCRIBE vw_hub_performance_base;

SELECT * FROM vw_hub_performance_base;

DROP VIEW vw_hub_performance_base;