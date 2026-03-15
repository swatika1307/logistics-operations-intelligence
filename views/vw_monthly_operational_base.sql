CREATE VIEW vw_monthly_operational_base AS
SELECT 
	d.year,
    d.month,
    d.month_name,
    
    COUNT(o.order_id) AS total_orders,
    
    SUM(
		CASE 
			WHEN o.delay_reason <> '' THEN 1
			ELSE 0
		END
        ) AS total_delays,
        
	SUM(
		CASE
			WHEN o.delay_reason = '' THEN 1
            ELSE 0
		END
        ) AS on_time_orders,
        
	ROUND(AVG(o.delivery_time_hours),2) AS avg_delivery_time_hours,
    ROUND(AVG(o.hub_processing_time_hours),2) AS avg_hub_processing_time_hours,
    ROUND(AVG(o.customer_satisfaction),2) AS avg_customer_satisfaction
    
FROM orders o
JOIN dim_date d
	ON o.order_date = d.full_date
GROUP BY
	d.year,
    d.month,
    d.month_name
ORDER BY
	d.year,
    d.month;

DESCRIBE vw_monthly_operational_base;

SELECT * FROM vw_monthly_operational_base;	