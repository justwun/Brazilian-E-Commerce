SET SQL_SAFE_UPDATES = 0;

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM order_items  
WHERE seller_id IN (SELECT seller_id FROM sellers WHERE seller_zip_code_prefix NOT IN (SELECT geolocation_zip_code_prefix FROM geolocation));

DELETE FROM sellers  
WHERE seller_zip_code_prefix NOT IN (SELECT geolocation_zip_code_prefix FROM geolocation);

SET FOREIGN_KEY_CHECKS = 1;

SET SQL_SAFE_UPDATES = 1;
-- delete the unmatch foreign key
SET SQL_SAFE_UPDATES = 0;

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM customers 
WHERE customer_zip_code_prefix NOT IN (SELECT geolocation_zip_code_prefix FROM geolocation);

SET FOREIGN_KEY_CHECKS = 1;

SET SQL_SAFE_UPDATES = 1;



SET SQL_SAFE_UPDATES = 0;

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM orders
WHERE customer_id NOT IN (SELECT customer_id FROM customers);

SET FOREIGN_KEY_CHECKS = 1;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM orders WHERE customer_id IS NULL;






