USE olist_db;
SET GLOBAL local_infile = 1;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(order_id, customer_id, order_status, 
 order_purchase_timestamp, @order_approve_at, 
 @order_delivered_carrier_date, @order_delivered_customer_date, order_estimated_delivery_date)
SET 
	order_approve_at = CASE
		WHEN @order_approve_at = '' THEN NULL 
        ELSE @order_approve_at
	END,
    order_delivered_carrier_date = CASE 
        WHEN @order_delivered_carrier_date = '' THEN NULL 
        ELSE @order_delivered_carrier_date 
    END,
    order_delivered_customer_date = CASE 
        WHEN @order_delivered_customer_date = '' THEN NULL 
        ELSE @order_delivered_customer_date 
    END;
    
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(product_id,	product_category_name,	@product_name_lenght,	@product_description_lenght,	
@product_photos_qty, @product_weight_g,	@product_length_cm,	@product_height_cm,	@product_width_cm)
SET 
	product_name_lenght = CASE
    WHEN @product_name_lenght = '' THEN NULL
    ELSE @product_name_lenght
    END,
    product_description_lenght = CASE
    WHEN @product_description_lenght = '' THEN NULL 
    ELSE @product_description_lenght
    END,
    product_photos_qty = CASE
    WHEN @product_photos_qty = '' THEN NULL
    ELSE @product_photos_qty
    END,
    product_weight_g = CASE
    WHEN @product_weight_g ='' THEN NULL
    ELSE @product_weight_g 
    END,
    product_length_cm = CASE
    WHEN @product_length_cm = '' THEN NULL 
    ELSE @product_length_cm 
    END,
    product_height_cm = CASE
    WHEN @product_height_cm ='' THEN NULL 
    ELSE @product_height_cm 
    END,
	product_width_cm = CASE
    WHEN @product_width_cm = '' THEN NULL 
    ELSE @product_width_cm 
    END;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_cleaned.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

SELECT count(*) FROM order_payments;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_geolocation_dataset.csv'
IGNORE INTO TABLE geolocation
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

select count(*) from geolocation;

SELECT DISTINCT seller_zip_code_prefix 
FROM sellers 
WHERE seller_zip_code_prefix NOT IN (SELECT geolocation_zip_code_prefix FROM geolocation);

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

