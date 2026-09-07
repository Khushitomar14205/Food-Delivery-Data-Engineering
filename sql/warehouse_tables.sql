-- ============================================================
-- FOOD DELIVERY DATA ENGINEERING PROJECT
-- Data Warehouse Layer
-- Star Schema
-- ============================================================

USE food_delivery_dw;


-- ============================================================
-- DROP EXISTING WAREHOUSE TABLES
-- Drop fact table first because it contains foreign keys.
-- ============================================================

DROP TABLE IF EXISTS fact_orders;

DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_restaurant;
DROP TABLE IF EXISTS dim_delivery;
DROP TABLE IF EXISTS dim_payment;
DROP TABLE IF EXISTS dim_date;


-- ============================================================
-- 1. CUSTOMER DIMENSION
-- ============================================================

CREATE TABLE dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(20) UNIQUE,
    customer_name VARCHAR(100),
    age INT,
    gender VARCHAR(20),
    city VARCHAR(100),
    signup_date DATE
);


-- ============================================================
-- 2. RESTAURANT DIMENSION
-- ============================================================

CREATE TABLE dim_restaurant (
    restaurant_key INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id VARCHAR(20) UNIQUE,
    restaurant_name VARCHAR(100),
    city VARCHAR(100),
    cuisine VARCHAR(50),
    rating DECIMAL(3,1),
    avg_preparation_time INT
);


-- ============================================================
-- 3. DELIVERY PARTNER DIMENSION
-- ============================================================

CREATE TABLE dim_delivery (
    delivery_key INT AUTO_INCREMENT PRIMARY KEY,
    delivery_partner_id VARCHAR(20) UNIQUE,
    partner_name VARCHAR(100),
    vehicle_type VARCHAR(30),
    city VARCHAR(100),
    joining_date DATE,
    rating DECIMAL(3,1)
);


-- ============================================================
-- 4. PAYMENT DIMENSION
-- ============================================================

CREATE TABLE dim_payment (
    payment_key INT AUTO_INCREMENT PRIMARY KEY,
    payment_id VARCHAR(20) UNIQUE,
    order_id VARCHAR(20),
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    transaction_amount DECIMAL(10,2)
);


-- ============================================================
-- 5. DATE DIMENSION
-- ============================================================

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE UNIQUE,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    day_name VARCHAR(20),
    week INT
);


-- ============================================================
-- POPULATE CUSTOMER DIMENSION
-- ============================================================

INSERT INTO dim_customer (
    customer_id,
    customer_name,
    age,
    gender,
    city,
    signup_date
)
SELECT
    customer_id,
    customer_name,
    age,
    gender,
    city,
    signup_date
FROM stg_customers;


-- ============================================================
-- POPULATE RESTAURANT DIMENSION
-- ============================================================

INSERT INTO dim_restaurant (
    restaurant_id,
    restaurant_name,
    city,
    cuisine,
    rating,
    avg_preparation_time
)
SELECT
    restaurant_id,
    restaurant_name,
    city,
    cuisine,
    rating,
    avg_preparation_time
FROM stg_restaurants;


-- ============================================================
-- POPULATE DELIVERY DIMENSION
-- ============================================================

INSERT INTO dim_delivery (
    delivery_partner_id,
    partner_name,
    vehicle_type,
    city,
    joining_date,
    rating
)
SELECT
    delivery_partner_id,
    partner_name,
    vehicle_type,
    city,
    joining_date,
    rating
FROM stg_delivery_partners;


-- ============================================================
-- POPULATE PAYMENT DIMENSION
-- ============================================================

INSERT INTO dim_payment (
    payment_id,
    order_id,
    payment_method,
    payment_status,
    transaction_amount
)
SELECT
    payment_id,
    order_id,
    payment_method,
    payment_status,
    transaction_amount
FROM stg_payments;


-- ============================================================
-- POPULATE DATE DIMENSION
-- ============================================================

INSERT INTO dim_date (
    date_key,
    full_date,
    year,
    quarter,
    month,
    month_name,
    day,
    day_name,
    week
)
SELECT DISTINCT
    DATE_FORMAT(order_date, '%Y%m%d') + 0 AS date_key,
    order_date,
    YEAR(order_date),
    QUARTER(order_date),
    MONTH(order_date),
    MONTHNAME(order_date),
    DAY(order_date),
    DAYNAME(order_date),
    WEEK(order_date)
FROM stg_orders;


-- ============================================================
-- FACT TABLE
-- ============================================================

CREATE TABLE fact_orders (
    order_key INT AUTO_INCREMENT PRIMARY KEY,

    order_id VARCHAR(20) UNIQUE,

    customer_key INT,
    restaurant_key INT,
    delivery_key INT,
    payment_key INT,
    date_key INT,

    order_time TIME,

    order_amount DECIMAL(10,2),
    discount DECIMAL(10,2),
    delivery_fee DECIMAL(10,2),
    final_amount DECIMAL(10,2),

    estimated_delivery_time INT,
    actual_delivery_time INT,
    delivery_delay INT,

    is_delayed BOOLEAN,

    order_status VARCHAR(20),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (restaurant_key)
        REFERENCES dim_restaurant(restaurant_key),

    FOREIGN KEY (delivery_key)
        REFERENCES dim_delivery(delivery_key),

    FOREIGN KEY (payment_key)
        REFERENCES dim_payment(payment_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);


-- ============================================================
-- LOAD FACT TABLE
-- ============================================================

INSERT INTO fact_orders (
    order_id,
    customer_key,
    restaurant_key,
    delivery_key,
    payment_key,
    date_key,
    order_time,
    order_amount,
    discount,
    delivery_fee,
    final_amount,
    estimated_delivery_time,
    actual_delivery_time,
    delivery_delay,
    is_delayed,
    order_status
)
SELECT
    o.order_id,

    c.customer_key,

    r.restaurant_key,

    d.delivery_key,

    p.payment_key,

    dt.date_key,

    o.order_time,

    o.order_amount,

    o.discount,

    o.delivery_fee,

    o.final_amount,

    o.estimated_delivery_time,

    o.actual_delivery_time,

    o.delivery_delay,

    o.is_delayed,

    o.status

FROM stg_orders o

JOIN dim_customer c
    ON o.customer_id = c.customer_id

JOIN dim_restaurant r
    ON o.restaurant_id = r.restaurant_id

JOIN dim_delivery d
    ON o.delivery_partner_id = d.delivery_partner_id

JOIN dim_payment p
    ON o.order_id = p.order_id

JOIN dim_date dt
    ON o.order_date = dt.full_date;


-- ============================================================
-- VERIFY WAREHOUSE
-- ============================================================

SELECT 'dim_customer' AS table_name,
       COUNT(*) AS row_count
FROM dim_customer

UNION ALL

SELECT 'dim_restaurant',
       COUNT(*)
FROM dim_restaurant

UNION ALL

SELECT 'dim_delivery',
       COUNT(*)
FROM dim_delivery

UNION ALL

SELECT 'dim_payment',
       COUNT(*)
FROM dim_payment

UNION ALL

SELECT 'dim_date',
       COUNT(*)
FROM dim_date

UNION ALL

SELECT 'fact_orders',
       COUNT(*)
FROM fact_orders;
