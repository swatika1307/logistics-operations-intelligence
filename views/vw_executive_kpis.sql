CREATE VIEW vw_executive_kpis AS
SELECT
    year,
    month,
    month_name,

    total_orders,
    total_delays,
    delay_percentage,
    on_time_percentage,

    avg_delivery_time_hours,
    avg_customer_satisfaction,

    mom_order_growth_percentage,
    mom_delay_change_percentage,

    total_delays * 25 AS delay_cost

FROM vw_monthly_kpis_with_mom;

DESCRIBE vw_executive_kpis;

SELECT * FROM vw_executive_kpis;