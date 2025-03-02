SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM sellers;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM geolocation;
SELECT COUNT(*) FROM order_reviews;
SELECT COUNT(*) FROM products;

SELECT COUNT(*) FROM orders 
WHERE customer_id NOT IN (SELECT customer_id FROM customers);

SELECT * FROM orders WHERE order_purchase_timestamp IS NULL;
SELECT * FROM products WHERE product_id IS NULL;

SELECT order_id, COUNT(*) 
FROM orders 
GROUP BY order_id 
HAVING COUNT(*) > 1;

CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_seller_id ON sellers(seller_id);
