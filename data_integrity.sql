USE olist_db;

-- Check Primary Key
SELECT order_id, COUNT(*) 
FROM orders 
GROUP BY order_id 
HAVING COUNT(*) > 1;

SELECT customer_id, COUNT(*) 
FROM customers 
GROUP BY customer_id 
HAVING COUNT(*) > 1;

SELECT seller_id, COUNT(*) 
FROM sellers 
GROUP BY seller_id 
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) 
FROM products 
GROUP BY product_id 
HAVING COUNT(*) > 1;

-- Check FOREIGN KEY
SELECT order_items.seller_id 
FROM order_items
LEFT JOIN sellers ON order_items.seller_id = sellers.seller_id
WHERE sellers.seller_id IS NULL;

SELECT orders.customer_id 
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id
WHERE customers.customer_id IS NULL;

SELECT sellers.seller_zip_code_prefix 
FROM sellers
LEFT JOIN geolocation ON sellers.seller_zip_code_prefix = geolocation.geolocation_zip_code_prefix
WHERE geolocation.geolocation_zip_code_prefix IS NULL;

SELECT customers.customer_zip_code_prefix 
FROM customers
LEFT JOIN geolocation ON customers.customer_zip_code_prefix = geolocation.geolocation_zip_code_prefix
WHERE geolocation.geolocation_zip_code_prefix IS NULL;

-- CHECK NULL VALUE
SELECT * FROM orders WHERE order_status IS NULL OR order_purchase_timestamp IS NULL;
SELECT * FROM customers WHERE customer_unique_id IS NULL;
SELECT * FROM sellers WHERE seller_zip_code_prefix IS NULL;
SELECT * FROM order_items WHERE product_id IS NULL OR price IS NULL;
SELECT * FROM products WHERE product_category_name IS NULL;

-- Check DUPLICATE VALUES
SELECT order_id, customer_id, COUNT(*) 
FROM orders 
GROUP BY order_id, customer_id 
HAVING COUNT(*) > 1;

-- CHECK INVALID ORDER DATE
SELECT * FROM orders 
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- CHECK NEGATIVE VALUES
SELECT * FROM order_items 
WHERE price < 0 OR freight_value < 0;

-- CHECK EMPTY SLOT
SELECT 'orders' AS table_name, 'order_status' AS column_name 
FROM orders WHERE order_status IS NOT NULL
UNION ALL
SELECT 'customers', 'customer_unique_id' FROM customers WHERE customer_unique_id IS NOT NULL
UNION ALL
SELECT 'products', 'product_category_name' FROM products WHERE product_category_name IS NOT NULL;

