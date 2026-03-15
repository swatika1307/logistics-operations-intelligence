CREATE VIEW vw_monthly_kpis_with_mom AS
SELECT
	year,
    month,
    month_name,
    total_orders,
    total_delays,
    on_time_orders,
    delay_percentage,
    on_time_percentage,
    avg_delivery_time_hours,
	avg_hub_processing_time_hours,
	avg_customer_satisfaction,
    
    LAG(total_orders) OVER(ORDER BY year, month) AS prev_month_orders,
    
-- Why You Can’t Use the Alias Immediately
-- You wrote:
-- LAG(total_orders) OVER (ORDER BY year, month) AS prev_month_orders
-- Then you want to do:
-- (total_orders - prev_month_orders) / prev_month_orders
-- But SQL won’t allow that in the same SELECT.
-- Why?
-- Because of SQL’s logical execution order.
-- The key part: All SELECT expressions are evaluated at the same time.
-- So when SQL sees:
-- SELECT
--    LAG(total_orders) OVER (...) AS prev_month_orders,
--    (total_orders - prev_month_orders) / prev_month_orders
-- At that moment:
-- prev_month_orders does not exist yet
-- It is being created in the same step
-- So SQL cannot reference it.
	
    ROUND((total_orders - LAG(total_orders) OVER(ORDER BY year, month)) / LAG(total_orders) OVER(ORDER BY year, month) * 100, 2) AS mom_order_growth_percentage,
    
    LAG(delay_percentage) OVER(ORDER BY year, month) as prev_month_delay_percentage,
    
    ROUND(delay_percentage - LAG(delay_percentage) OVER(ORDER BY year, month), 2) AS mom_delay_change_percentage

FROM vw_monthly_kpis;

DESCRIBE vw_monthly_kpis_with_mom;
    
SELECT * FROM vw_monthly_kpis_with_mom;