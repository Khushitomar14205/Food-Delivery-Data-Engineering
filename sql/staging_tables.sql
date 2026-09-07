-- ============================================================
-- FOOD DELIVERY DATA ENGINEERING PROJECT
-- Staging Layer
-- Database: food_delivery_dw
-- ============================================================

CREATE DATABASE IF NOT EXISTS food_delivery_dw;

USE food_delivery_dw;


-- ============================================================
-- 1. STAGING CUSTOMERS
-- ============================================================

DROP TABLE IF EXISTS stg_customers;

CREATE TABLE stg_customers (
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    age INT,
    gender VARCHAR(20),
    city VARCHAR(100),
    signup_date DATE
);


-- ============================================================
-- 2. STAGING RESTAURANTS
-- ============================================================

DROP TABLE IF EXISTS stg_restaurants;

CREATE TABLE stg_restaurants (
    restaurant_id VARCHAR(20),
    restaurant_name VARCHAR(100),
    city VARCHAR(100),
    cuisine VARCHAR(50),
    rating DECIMAL(3,1),
    avg_preparation_time INT
);


-- ============================================================
-- 3. STAGING DELIVERY PARTNERS
-- ============================================================

DROP TABLE IF EXISTS stg_delivery_partners;

CREATE TABLE stg_delivery_partners (
    delivery_partner_id VARCHAR(20),
    partner_name VARCHAR(100),
    vehicle_type VARCHAR(30),
    city VARCHAR(100),
    joining_date DATE,
    rating DECIMAL(3,1)
);


-- ============================================================
-- 4. STAGING ORDERS
-- ============================================================

DROP TABLE IF EXISTS stg_orders;

CREATE TABLE stg_orders (
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    restaurant_id VARCHAR(20),
    delivery_partner_id VARCHAR(20),
    order_date DATE,
    order_time TIME,
    order_amount DECIMAL(10,2),
    discount DECIMAL(10,2),
    delivery_fee DECIMAL(10,2),
    status VARCHAR(20),
    estimated_delivery_time INT,
    actual_delivery_time INT,
    final_amount DECIMAL(10,2),
    delivery_delay INT,
    is_delayed BOOLEAN,
    order_year INT,
    order_month INT,
    order_day INT,
    order_hour INT
);


-- ============================================================
-- 5. STAGING PAYMENTS
-- ============================================================

DROP TABLE IF EXISTS stg_payments;

CREATE TABLE stg_payments (
    payment_id VARCHAR(20),
    order_id VARCHAR(20),
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    transaction_amount DECIMAL(10,2)
);


-- ============================================================
-- VERIFY STAGING TABLES
-- ============================================================

SHOW TABLES;
