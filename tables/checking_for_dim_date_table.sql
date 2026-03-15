SELECT
	MIN(order_date) AS minimum_order_date,
    MAX(order_date) AS maximum_order_date,
    MIN(actual_delivery_date) AS minimumn_actual_delivery_date,
    MAX(actual_delivery_date) AS maximum_actual_delivery_date
FROM orders;