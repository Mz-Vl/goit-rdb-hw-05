SELECT
	od.*,
    (SELECT customer_id
    FROM orders as o
    WHERE o.id = od.order_id) AS customer_id
FROM order_details od;


SELECT *
FROM order_details
WHERE order_id IN (
	SELECT id
    FROM orders
    WHERE shipper_id = 3
);


SELECT order_id, AVG(quantity) AS avg_quantity
FROM (
    SELECT order_id, quantity
    FROM order_details
    WHERE quantity > 10
) AS filtered_order_details
GROUP BY order_id;


WITH temp AS (
    SELECT order_id, quantity
    FROM order_details
    WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;









DROP FUNCTION IF EXISTS divide_quantity;
DELIMITER //
CREATE FUNCTION divide_quantity(num1 FLOAT, num2 FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
	RETURN num1 / num2;
END //
DELIMITER ;

SELECT
	id,
    quantity,
    divide_quantity(quantity, 2) as divided_quantity
FROM order_details;
