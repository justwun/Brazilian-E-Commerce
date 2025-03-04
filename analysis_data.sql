-- Select the total number of orders per month
SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month, COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- Select the top 5 customers with the highest number of orders
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 5;

-- Select the top 10 best-selling products
SELECT product_id, COUNT(*) AS total_sold
FROM order_items
GROUP BY product_id
ORDER BY total_sold DESC
LIMIT 10;

-- Select the total payment value for each payment type
SELECT payment_type, SUM(payment_value) AS total_payment
FROM order_payments
GROUP BY payment_type;

