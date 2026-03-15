CREATE VIEW vw_monthly_kpis AS
SELECT
	year,
    month,
    month_name,
    total_orders,
    total_delays,
    on_time_orders,
    
    ROUND((total_delays / total_orders) * 100, 2) AS delay_percentage,
    ROUND((on_time_orders / total_orders) * 100, 2) AS on_time_percentage,
    
    avg_delivery_time_hours,
    avg_hub_processing_time_hours,
    avg_customer_satisfaction
    
FROM vw_monthly_operational_base;

DESCRIBE vw_monthly_kpis;

SELECT * FROM vw_monthly_kpis;