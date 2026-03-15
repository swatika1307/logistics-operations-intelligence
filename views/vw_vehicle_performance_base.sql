CREATE VIEW vw_vehicle_performance_base AS
SELECT
	v.vehicle_id,
    v.vehicle_model,
    v.vehicle_status,
    v.breakdown_count,
    v.maintenance_count,
    v.vehicle_code,
    v.purchase_date,
    
    COUNT(o.order_id) as total_deliveries,
    
    SUM( 
		CASE
			WHEN o.delay_reason <> '' THEN 1
            ELSE 0
		END) AS total_delays,
        
	ROUND(
        SUM(
            CASE 
                WHEN o.delay_reason <> '' THEN 1
                ELSE 0
            END
        ) / COUNT(o.order_id) * 100,
        2
    ) AS delay_percentage,
	
     ROUND(
        AVG(o.delivery_time_hours),
        2
    ) AS avg_delivery_time_hours

FROM vehicles v
LEFT JOIN orders o 
	ON v.vehicle_id = o.vehicle_id
    
GROUP BY
	v.vehicle_id,
    v.vehicle_model,
    v.vehicle_status,
    v.breakdown_count,
    v.maintenance_count,
    v.vehicle_code,
    v.purchase_date;

DESCRIBE vw_vehicle_performance_base;

SELECT * FROM vw_vehicle_performance_base;