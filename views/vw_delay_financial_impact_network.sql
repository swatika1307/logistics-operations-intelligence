CREATE VIEW vw_delay_financial_impact_network AS
SELECT
	COUNT(order_id) as total_orders,
    SUM( 
		CASE 
			WHEN delay_reason <> '' THEN 1
            ELSE 0
		END
		) AS total_delays,
	ROUND(
		SUM( 
		CASE 
			WHEN delay_reason <> '' THEN 1
            ELSE 0
		END) / COUNT(order_id) * 100, 
	2) AS delay_percentage,
    SUM( 
		CASE
			WHEN delay_reason <> '' THEN 25
            ELSE 0
		END
        ) AS total_delay_cost

FROM orders;

DESCRIBE vw_delay_financial_impact_network;

SELECT * FROM vw_delay_financial_impact_network;