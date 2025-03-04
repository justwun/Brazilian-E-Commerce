SHOW INDEXES FROM orders;
SHOW INDEXES FROM sellers;

SELECT * FROM orders WHERE customer_id = '3ce436f183e68e07877b285a838db11a';

SELECT order_id, customer_id FROM orders WHERE customer_id = '3ce436f183e68e07877b285a838db11a';

ANALYZE TABLE orders, customers;

SELECT o.*, c.customer_city  
FROM orders o  
JOIN customers c ON o.customer_id = c.customer_id  
WHERE o.customer_id = '3ce436f183e68e07877b285a838db11a';

EXPLAIN SELECT * FROM orders WHERE customer_id = '3ce436f183e68e07877b285a838db11a';

CREATE INDEX idx_order_date ON orders(order_purchase_timestamp);

SELECT * FROM orders WHERE order_purchase_timestamp BETWEEN '2017-08-15' AND '2018-01-01';

OPTIMIZE TABLE orders;


