create DATABASE olist_db;
USE olist_db;

CREATE TABLE customers (
	customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(50),
    customer__state VARCHAR(2)
    );
 
 
    
CREATE TABLE orders (
	order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approve_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    );

CREATE TABLE order_items (
	order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY(order_id,order_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    );
    
CREATE TABLE products (
	product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(50),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
    );

ALTER TABLE order_items 
ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id);


CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(50),
    seller_state CHAR(2)
);

ALTER TABLE order_items
ADD CONSTRAINT fk_seller FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);

CREATE TABLE order_reviews(
	review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    review_score INT CHECK (review_score BETWEEN 1 AND 5),
    review_comment_title VARCHAR(50),
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME,
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
    );

CREATE TABLE order_payments (
	order_id VARCHAR(50),
    payment_sequential INT CHECK (payment_sequential BETWEEN 1 AND 5),
    payment_type VARCHAR(20),
    payment_installments INT,
    payment_value DECIMAL(10,2),
	PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    );

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10,8),
    geolocation_lng DECIMAL(11,8),
    geolocation_city VARCHAR(50),
    geolocation_state CHAR(2),
    PRIMARY KEY (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng)
);

ALTER TABLE sellers 
ADD CONSTRAINT fk_seller_geolocation 
FOREIGN KEY (seller_zip_code_prefix) REFERENCES geolocation(geolocation_zip_code_prefix);

ALTER TABLE customers 
ADD CONSTRAINT fk_customer_geolocation 
FOREIGN KEY (customer_zip_code_prefix) REFERENCES geolocation(geolocation_zip_code_prefix);





































    

    
    
    

