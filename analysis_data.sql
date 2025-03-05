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

-- Select monthly sales and growth rate compared to the previous month
SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders,
    LAG(COUNT(*)) OVER (ORDER BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')) AS previous_month_orders,
    ROUND(
        (COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m'))) 
        / LAG(COUNT(*)) OVER (ORDER BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')) * 100, 2
    ) AS growth_rate
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- Select sales dues to each products
SELECT 
    p.product_category_name,
    SUM(oi.price) AS total_revenue,
    COUNT(oi.product_id) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Select the canceled orders percentage
SELECT order_status, COUNT(*) AS total_orders, 
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS percentage
FROM orders
GROUP BY order_status
ORDER BY percentage DESC;

-- Select the average time for delivery
SELECT 
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 2) AS avg_delivery_days,
    ROUND(AVG(DATEDIFF(order_estimated_delivery_date, order_delivered_customer_date)), 2) AS avg_delay_days
FROM orders
WHERE order_status = 'delivered';

