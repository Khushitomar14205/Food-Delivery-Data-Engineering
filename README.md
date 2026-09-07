# 🍔 Food Delivery Data Engineering & Analytics

An end-to-end **Data Engineering and Business Analytics project** built using Python, MySQL, SQL, and Power BI.

The project simulates a food delivery platform and demonstrates how raw operational data can be transformed into a cleaned, validated, structured **data warehouse** and finally converted into actionable business insights through an interactive Power BI dashboard.

---

## 📌 Project Overview

Food delivery platforms generate large amounts of data from customers, restaurants, orders, delivery partners, and payments.

The objective of this project is to build a complete data pipeline that:

- Extracts raw data from multiple CSV files
- Identifies and handles data quality issues
- Performs data cleaning and transformation using Python
- Loads cleaned data into a MySQL staging layer
- Builds a Star Schema-based data warehouse
- Performs analytical SQL queries
- Connects the warehouse to Power BI
- Creates interactive dashboards
- Generates business insights and recommendations

The project follows an end-to-end workflow:

**Raw Data → Python ETL → MySQL Staging → Data Warehouse → SQL Analytics → Power BI Dashboard**

---

## 🎯 Project Objectives

The main objectives of the project are:

1. Build an end-to-end ETL pipeline.
2. Clean and validate raw operational data.
3. Handle missing values, duplicates, invalid values, and referential integrity issues.
4. Design a structured data warehouse using a Star Schema.
5. Implement dimension and fact tables.
6. Perform business analysis using SQL.
7. Develop an interactive Power BI dashboard.
8. Identify important business and operational trends.
9. Provide actionable recommendations based on the analysis.

---

## 🏗️ Project Architecture


                    RAW DATA
                       │
                       ▼
              ┌─────────────────┐
              │   CSV Files     │
              │                 │
              │ Customers       │
              │ Restaurants     │
              │ Orders          │
              │ Payments        │
              │ Delivery        │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │     Python      │
              │      ETL        │
              │                 │
              │ Extract         │
              │ Clean           │
              │ Transform       │
              │ Validate        │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ MySQL Staging   │
              │     Layer       │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │  Data Warehouse │
              │                 │
              │  Star Schema    │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │   SQL Analytics │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │    Power BI     │
              │    Dashboard    │
              └────────┬────────┘
                       │
                       ▼
              BUSINESS INSIGHTS

---

## 📊 Dataset

The project contains five datasets representing different components of a food delivery platform:

- **Customers** – Customer demographics, location, and signup information
- **Restaurants** – Restaurant details, cuisine, location, and ratings
- **Delivery Partners** – Delivery partner details, vehicle type, location, and ratings
- **Orders** – Order details, pricing, status, and delivery information
- **Payments** – Payment methods, payment status, and transaction details

### 📦 Dataset Size

| Dataset | Raw Records | Cleaned Records | Key Information |
|---|---:|---:|---|
| Customers | 5,000 | 5,000 | Customer demographics, city and signup details |
| Restaurants | 200 | 200 | Restaurant, cuisine, location and rating details |
| Delivery Partners | 500 | 500 | Partner, vehicle type, city and rating details |
| Orders | 20,050 | 19,981 | Order, pricing, status and delivery information |
| Payments | 20,000 | 19,981 | Payment method, status and transaction details |
| **Total** | **45,750** | **45,662** | **Combined records across all datasets** |

### 🧪 Data Quality Issues

The synthetic dataset was intentionally created with realistic data quality issues to demonstrate the ETL and data validation process.

The issues included:

- Missing values
- Duplicate records
- Invalid numerical values
- Negative order amounts
- Invalid foreign-key references
- Inconsistent data relationships

These issues were identified and handled during the **Python ETL and data cleaning process**.

> **Note:** The dataset is synthetic and was created for educational and portfolio purposes. Therefore, the resulting numerical metrics should be treated as illustrative rather than real-world industry benchmarks.

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| **Python** | Data extraction, cleaning, transformation, validation, and ETL pipeline development |
| **Pandas** | Data manipulation, preprocessing, missing-value handling, duplicate detection, and feature creation |
| **NumPy** | Numerical operations and synthetic data generation |
| **MySQL** | Staging database and data warehouse implementation |
| **SQL** | Table creation, data loading, joins, transformations, and business analysis |
| **SQLAlchemy** | Python–MySQL connectivity and bulk data loading |
| **PyMySQL** | MySQL database driver for Python |
| **Power BI** | Interactive dashboards and business performance visualization |
| **DAX** | KPI calculations and analytical measures in Power BI |
| **Git & GitHub** | Version control, project documentation, and source-code management |

---

## 🔄 ETL Pipeline

The project follows a structured **Extract, Transform, Load (ETL)** pipeline to convert raw food delivery data into a reliable analytical dataset.

```
Raw CSV Files
      │
      ▼
┌───────────────┐
│    EXTRACT    │
│               │
│ Read CSV data │
│ using Pandas  │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   TRANSFORM   │
│               │
│ Clean data    │
│ Handle nulls  │
│ Remove dupes  │
│ Validate data │
│ Create fields │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│     LOAD      │
│               │
│ MySQL Staging │
│     Layer     │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│ DATA WAREHOUSE│
│               │
│   Star Schema │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│   ANALYTICS   │
│               │
│ SQL + Power BI│
└───────────────┘

```

1️⃣ Extract

Raw CSV files are loaded into Python using Pandas.

The following datasets are extracted:
-customers.csv
-restaurants.csv
-delivery_partners.csv
-orders.csv
-payments.csv

The extraction layer keeps the raw data separate from the cleaned and transformed data.

2️⃣ Transform

The extracted data is processed using Python and Pandas.

The transformation stage includes:

-Handling missing values

-Removing duplicate records

-Validating numerical values

-Removing invalid records

-Checking referential integrity

-Standardizing data types

-Converting date and time columns

-Creating derived business fields

-Order-level transformations

The following fields were created:

-final_amount

-delivery_delay

-is_delayed

-order_year

-order_month

-order_day

-order_hour

The final order amount is calculated as:

-> Final Amount = Order Amount - Discount + Delivery Fee

Delivery delay is calculated as:

-> Delivery Delay = Actual Delivery Time - Estimated Delivery Time

An order is classified as delayed when:

-> Delivery Delay > 0

3️⃣ Load

After transformation and validation, the cleaned datasets are loaded into MySQL staging tables.

The staging layer contains:

-stg_customers

-stg_restaurants

-stg_delivery_partners

-stg_orders

-stg_payments

The staging layer acts as an intermediate layer between the source data and the analytical data warehouse.

4️⃣ Data Warehouse

The validated staging data is transformed into a Star Schema-based data warehouse.

The warehouse consists of:

One central fact table: fact_orders
Five dimension tables:

-dim_customer

-dim_restaurant

-dim_delivery

-dim_payment

-dim_date

This structure makes the data easier to query and analyze for business reporting.

5️⃣ Analytics

The data warehouse is used for:

-SQL-based business analysis

-KPI calculation

-Revenue analysis

-Customer analysis 

-Restaurant performance analysis

-Delivery performance analysis

-Time-based analysis

The warehouse is then connected to Power BI to create interactive dashboards and visual reports.

---

## 🔍 ETL Validation

Data validation was performed at different stages of the pipeline.

Key checks included:

-Missing-value checks

-Duplicate detection

-Negative-value detection

-Data-type validation

-Referential integrity checks

-Record-count validation

The final cleaned datasets were saved separately before loading them into MySQL.

---

## 🧹 Data Cleaning & Transformation

The raw datasets were inspected and cleaned using **Python and Pandas** before being loaded into the MySQL staging layer.

The cleaning process focused on data quality, consistency, validity, and referential integrity.

### 👤 Customer Data

The customer dataset was checked for:

- Missing values
- Duplicate customer IDs
- Invalid records

#### Cleaning performed:

- Missing `city` values were replaced with `"Unknown"`
- Duplicate records based on `customer_id` were removed
- Data types were validated

---

### 🍽️ Restaurant Data

The restaurant dataset was checked for:

- Duplicate restaurant IDs
- Invalid rating values
- Missing or inconsistent data

#### Cleaning performed:

- Duplicate restaurant records were removed
- Restaurant ratings were restricted to the valid **0–5 range**
- Data types were standardized

---

### 🛵 Delivery Partner Data

The delivery partner dataset was checked for:

- Duplicate delivery partner IDs
- Invalid rating values
- Data consistency

#### Cleaning performed:

- Duplicate delivery partner records were removed
- Ratings were restricted to the valid **0–5 range**
- Data types were standardized

---

### 🧾 Order Data

The orders dataset contained several intentionally introduced data quality issues.

#### Issues identified:

- Exact duplicate rows
- Missing discount values
- Negative order amounts
- Invalid relationships with other datasets

#### Cleaning performed:

- Exact duplicate rows were removed
- Missing `discount` values were replaced with `0`
- Orders with negative `order_amount` values were removed
- Order IDs were validated for uniqueness
- Date and time fields were converted into appropriate formats

#### Derived columns

Several business-related columns were created:

| Derived Column | Description |
|---|---|
| `final_amount` | Final amount after discount and delivery fee |
| `delivery_delay` | Difference between actual and estimated delivery time |
| `is_delayed` | Indicates whether an order was delivered late |
| `order_year` | Year extracted from order date |
| `order_month` | Month extracted from order date |
| `order_day` | Day extracted from order date |
| `order_hour` | Hour extracted from order time |

The final order amount was calculated as:

->Final Amount = Order Amount - Discount + Delivery Fee

---

## 💳 Payment Data

The payment dataset was checked for:

-Duplicate payment IDs
-Invalid order references
-Data consistency
-Cleaning performed:
-Duplicate payment records were removed
-Payment records were validated against the cleaned orders dataset
-Payments referencing orders that no longer existed were removed
-Data types were standardized

---

🔗 Referential Integrity

Referential integrity checks were performed to ensure that relationships between datasets remained valid.

The following relationships were validated:
```text
Orders
  │
  ├── Customer ID ─────────► Customers
  │
  ├── Restaurant ID ───────► Restaurants
  │
  └── Delivery Partner ID ─► Delivery Partners

Payments
  │
  └── Order ID ────────────► Orders
```
This prevented orphan records from being loaded into the data warehouse.

---

## 🗄️ Data Warehouse Design

A **MySQL-based data warehouse** was designed to organize the cleaned food delivery data for efficient analytical querying and reporting.

The warehouse follows a **Star Schema** design, with a central fact table connected to multiple dimension tables.

### ⭐ Star Schema

```text
                         dim_customer
                              │
                              │
                              ▼
dim_restaurant ───────► fact_orders ◄─────── dim_delivery
                              │
                              │
                    ┌─────────┴─────────┐
                    ▼                   ▼
              dim_payment           dim_date

```
The Star Schema separates transactional measures from descriptive information, making the data easier to query and analyze.

---

### ⭐ Fact Table

The central fact table in the data warehouse is `fact_orders`.

It stores order-level transactional data and connects the different dimension tables through foreign keys.

| Column | Type / Role | Description |
|---|---|---|
| `order_key` | Primary Key | Unique warehouse identifier for each order record |
| `order_id` | Business Key | Original order identifier from the source data |
| `customer_key` | Foreign Key | References `dim_customer` |
| `restaurant_key` | Foreign Key | References `dim_restaurant` |
| `delivery_key` | Foreign Key | References `dim_delivery` |
| `payment_key` | Foreign Key | References `dim_payment` |
| `date_key` | Foreign Key | References `dim_date` |
| `order_time` | Attribute | Time at which the order was placed |
| `order_amount` | Measure | Original order amount |
| `discount` | Measure | Discount applied to the order |
| `delivery_fee` | Measure | Delivery fee charged |
| `final_amount` | Measure | Final order amount after discount and delivery fee |
| `estimated_delivery_time` | Attribute | Estimated delivery time |
| `actual_delivery_time` | Attribute | Actual delivery time |
| `delivery_delay` | Measure | Difference between actual and estimated delivery time |
| `is_delayed` | Flag | Indicates whether the delivery was delayed |
| `order_status` | Attribute | Order status such as Delivered, Cancelled, or Pending |

The fact table acts as the central point of the Star Schema and allows business metrics to be analyzed across different dimensions.

---

### 📚 Dimension Tables

The data warehouse contains five dimension tables that store descriptive information used to analyze the order transactions from different business perspectives.

| Dimension Table | Primary Key | Key Attributes | Purpose |
|---|---|---|---|
| `dim_customer` | `customer_key` | Customer ID, Name, Age, Gender, City, Signup Date | Stores customer information for customer-level analysis |
| `dim_restaurant` | `restaurant_key` | Restaurant ID, Name, City, Cuisine, Rating, Preparation Time | Stores restaurant information for restaurant and cuisine analysis |
| `dim_delivery` | `delivery_key` | Delivery Partner ID, Name, Vehicle Type, City, Joining Date, Rating | Stores delivery partner information for operational analysis |
| `dim_payment` | `payment_key` | Payment ID, Order ID, Payment Method, Payment Status, Transaction Amount | Stores payment information for payment and transaction analysis |
| `dim_date` | `date_key` | Full Date, Year, Quarter, Month, Month Name, Day, Day Name, Week | Supports time-based analysis and reporting |

### ⭐ Fact Table

| Fact Table | Primary Key | Foreign Keys | Key Measures | Purpose |
|---|---|---|---|---|
| `fact_orders` | `order_key` | Customer, Restaurant, Delivery, Payment, Date Keys | Order Amount, Discount, Delivery Fee, Final Amount, Delivery Delay | Stores order-level transactional data for business analysis |

---

### 🔑 Surrogate Keys

Surrogate keys were used in the dimension tables to provide unique warehouse-specific identifiers.

Instead of directly using the source system IDs as primary keys, each dimension table has its own surrogate key.

| Dimension Table | Surrogate Key | Source / Business Key |
|---|---|---|
| `dim_customer` | `customer_key` | `customer_id` |
| `dim_restaurant` | `restaurant_key` | `restaurant_id` |
| `dim_delivery` | `delivery_key` | `delivery_partner_id` |
| `dim_payment` | `payment_key` | `payment_id` |
| `dim_date` | `date_key` | `full_date` |

### Why Surrogate Keys Were Used

Surrogate keys provide a warehouse-specific identifier for each dimension record and make relationships between fact and dimension tables easier to manage.

For example:

```text
Source System
     │
     │ customer_id = C1025
     ▼
┌─────────────────────────┐
│     dim_customer        │
│                         │
│ customer_key = 1025     │
│ customer_id  = C1025    │
└────────────┬────────────┘
             │
             │ customer_key
             ▼
┌─────────────────────────┐
│      fact_orders        │
│                         │
│ customer_key = 1025     │
│ order_id = O5001        │
└─────────────────────────┘

---
### 🔗 Warehouse Structure

```text
                    dim_customer
                         │
                         │
                         ▼
dim_restaurant ───► fact_orders ◄─── dim_delivery
                         │
                         │
                ┌────────┴────────┐
                ▼                 ▼
          dim_payment         dim_date
```
---

## 🔗 Table Relationships

The following one-to-many relationships were created:
```text
dim_customer
     1
     │
     │
     *
fact_orders

dim_restaurant
     1
     │
     │
     *
fact_orders

dim_delivery
     1
     │
     │
     *
fact_orders

dim_payment
     1
     │
     │
     *
fact_orders

dim_date
     1
     │
     │
     *
fact_orders
```
This structure allows business users to analyze orders from multiple perspectives such as:

-Customer
-Restaurant
-Delivery partner
-Payment method
-Date
-City
-Cuisine

---

## 📈 Analytical SQL & Business Analysis

After building the data warehouse, SQL was used to perform analytical queries and extract meaningful business insights from the food delivery data.

The analysis was performed using the fact and dimension tables in the warehouse.

### 🔍 Key Business Analyses

The following areas were analyzed:

#### 1. Overall Business Performance

Calculated key business metrics such as:

- Total orders
- Delivered orders
- Total revenue
- Average Order Value (AOV)
- Cancelled orders
- Cancellation rate

---

#### 2. Order Status Analysis

Analyzed the distribution of:

- Delivered orders
- Cancelled orders
- Pending orders

This helps understand overall order completion and cancellation patterns.

---

#### 3. Revenue by City

Revenue was analyzed across different cities to identify:

- High-performing markets
- Low-performing markets
- Geographic revenue concentration

---

#### 4. Top Restaurants by Revenue

The top-performing restaurants were identified based on total revenue generated from delivered orders.

This helps identify restaurants that contribute significantly to overall business revenue.

---

#### 5. Revenue by Cuisine

Revenue was analyzed across different cuisine categories such as:

- North Indian
- South Indian
- Chinese
- Italian
- Fast Food
- Biryani
- Mughlai
- Desserts
- Cafe
- Healthy

This helps identify high-performing cuisine categories.

---

#### 6. Payment Method Analysis

Order and revenue performance were analyzed across different payment methods:

- UPI
- Credit Card
- Debit Card
- Cash
- Wallet

This helps understand customer payment preferences and transaction performance.

---

#### 7. Delivery Performance Analysis

Delivery operations were analyzed using:

- Total deliveries
- Delayed deliveries
- Delay rate
- Average delivery delay

This helps identify potential operational bottlenecks.

---

#### 8. Vehicle Performance

Delivery performance was compared across different vehicle types:

- Bike
- Scooter
- Bicycle

This helps evaluate whether delivery efficiency varies based on vehicle type.

---

#### 9. Monthly Revenue Trend

Revenue was analyzed over time to identify:

- Monthly revenue trends
- Growth or decline patterns
- Seasonal or time-based variations

The `dim_date` table was used for time-based analysis.

---

#### 10. Customer Spending Analysis

Customers were ranked based on their total spending.

This helps identify:

- High-value customers
- Major revenue contributors
- Customer spending patterns

---

#### 11. Customer City Analysis

Orders were analyzed by customer city to understand:

- Order concentration
- High-demand locations
- Geographic customer distribution

---

#### 12. Restaurant Rating vs Revenue

Restaurant ratings were compared with revenue to investigate whether highly rated restaurants necessarily generate higher revenue.

This provides insight into the relationship between customer ratings and business performance.

---

#### 13. Delivery Partner Performance

Delivery partners were analyzed based on:

- Total deliveries
- Average delivery delay
- Delayed deliveries
- Delivery performance

This helps identify partners with potential operational performance issues.

---

## 📊 Power BI Dashboard

The cleaned and structured data warehouse was connected to **Power BI** to create an interactive business analytics dashboard.

The dashboard was designed using a Star Schema and includes multiple dimensions such as customers, restaurants, delivery partners, payments, and dates.

### 🔗 Power BI Data Model

The following warehouse tables were imported into Power BI:

- `fact_orders`
- `dim_customer`
- `dim_restaurant`
- `dim_delivery`
- `dim_payment`
- `dim_date`

The relationships were created using surrogate keys between the dimension and fact tables.

```text
dim_customer     ─┐
dim_restaurant   ─┤
dim_delivery     ─┤
dim_payment      ─┼──► fact_orders
dim_date         ─┘
```

### 📄 Page 1 — Business Overview

**Focus:** Overall sales and business performance

This page provides an executive-level overview of the food delivery platform.

#### 📌 KPIs

- **Total Revenue**
- **Delivered Orders**
- **Average Order Value (AOV)**
- **Delay Rate**

#### 📊 Visualizations

- **Monthly Revenue Trend** – Shows how revenue changes over time.
- **Revenue by City** – Identifies cities contributing the highest revenue.
- **Revenue by Cuisine** – Compares revenue generated by different cuisine categories.
- **Order Status Distribution** – Shows the proportion of delivered, cancelled, and pending orders.

#### 🎯 Insights

This page helps understand the overall health of the business and identify high-performing markets and cuisine categories.

---

### 📄 Page 2 — Customer & Restaurant Analysis

**Focus:** Customer behavior and restaurant performance

This page analyzes customer spending patterns and restaurant performance.

#### 📌 KPIs

- **Total Customers**
- **Average Customer Spend**
- **Average Restaurant Rating**
- **Repeat Customers**

#### 📊 Visualizations

- **Top 10 Customers by Revenue** – Identifies the highest-value customers.
- **Top 10 Restaurants by Revenue** – Identifies restaurants generating the highest revenue.
- **Orders by Customer City** – Shows order distribution across customer locations.
- **Restaurant Rating vs Revenue** – Examines whether restaurant ratings are associated with higher revenue.

#### 🎯 Insights

This page helps identify valuable customers, high-performing restaurants, customer demand by location, and the relationship between restaurant ratings and revenue.

---

### 📄 Page 3 — Delivery & Operations Analysis

**Focus:** Delivery efficiency and operational performance

This page focuses on delivery operations and helps identify potential bottlenecks.

#### 📌 KPIs

- **Total Deliveries**
- **Delayed Deliveries**
- **Average Delivery Delay**
- **Delay Rate**

#### 📊 Visualizations

- **Average Delivery Delay by Vehicle Type** – Compares delivery delays across bikes, scooters, and bicycles.
- **Delivery Delay Rate by City** – Identifies cities with higher delivery delay rates.
- **Delivery Delay Trend** – Tracks average delivery delays over time.
- **Top 10 Delivery Partners by Average Delay** – Identifies delivery partners with higher average delays.

#### 🎯 Insights

This page helps identify operational problem areas and provides visibility into delivery performance by city, vehicle type, and delivery partner.

---

### 📄 Page 4 — Business Insights & Recommendations

**Focus:** Converting analysis into actionable business decisions

The final page summarizes the major findings from the dashboard and translates them into business recommendations.

#### 📌 KPIs

- **Total Revenue**
- **Delivered Orders**
- **Average Order Value**
- **Delay Rate**

#### 📊 Visualizations

- **Revenue Contribution by City** – Shows how different cities contribute to total revenue.
- **Revenue Contribution by Cuisine** – Shows the contribution of different cuisine categories to overall revenue.

#### 💡 Key Business Insights

**1. Revenue Concentration**

Revenue is concentrated across a subset of cities and cuisine categories, indicating areas with stronger business performance.

**2. Customer Retention**

Repeat customers represent an important opportunity for improving customer retention and increasing customer lifetime value.

**3. Restaurant Performance**

Restaurant ratings do not necessarily translate directly into higher revenue, suggesting that other factors such as order volume, location, cuisine, and customer demand may also influence revenue.

**4. Delivery Operations**

Delivery delays are a significant operational metric and can be further investigated by city, vehicle type, and delivery partner.

#### 💼 Business Recommendations

**1. Improve Delivery Efficiency**

Investigate high-delay cities, vehicle types, and delivery partners to identify and address operational bottlenecks.

**2. Increase Customer Retention**

Use customer spending and repeat-order behavior to identify high-value customers and develop targeted retention strategies.

**3. Optimize Restaurant Partnerships**

Focus on high-performing restaurants while evaluating restaurant performance using revenue, order volume, ratings, and customer demand.

**4. Focus Marketing Efforts**

Prioritize high-performing cities and cuisine categories when planning marketing campaigns and promotional activities.

---

### 🎛️ Interactive Dashboard Features

The dashboard includes interactive filters that allow users to explore the data dynamically.

Available filters include:

- **Order Date**
- **City**
- **Cuisine**
- **Payment Method**

Selecting a filter dynamically updates the relevant KPIs and visualizations across the dashboard.

---

### 📌 Dashboard Summary

The four dashboard pages provide a complete view of the food delivery business:

| Dashboard Page | Primary Focus |
|---|---|
| **Business Overview** | Revenue, orders, cities, cuisines, and order status |
| **Customer & Restaurant Analysis** | Customer spending, repeat customers, and restaurant performance |
| **Delivery & Operations Analysis** | Delivery delays, vehicles, cities, and delivery partners |
| **Business Insights & Recommendations** | Key findings and actionable business recommendations |

Together, these pages transform the warehouse data into an interactive business intelligence solution for monitoring performance and supporting data-driven decision-making.

---

---

## 🎯 Project Outcome

This project demonstrates an end-to-end data engineering and analytics workflow, starting from raw operational data and ending with business-ready insights.

Through this project, the following concepts were implemented:

- Data extraction and transformation using Python
- Data quality checks and validation
- ETL pipeline development
- MySQL staging and data warehousing
- Star Schema design
- Fact and dimension tables
- Surrogate key implementation
- SQL-based business analysis
- Power BI dashboard development
- DAX-based KPI calculations
- Business insights and recommendations

The final solution provides a structured and scalable approach for transforming raw food delivery data into meaningful information for business decision-making.

---

## 🚀 Future Improvements

The project can be further enhanced by implementing:

- Incremental data loading instead of full data loads
- Automated data quality reports
- Scheduled ETL execution
- Cloud-based data warehouse deployment
- Advanced customer segmentation
- Demand forecasting
- Delivery time prediction
- Real-time data pipelines
- Automated Power BI dataset refresh
- Advanced analytics and machine learning models

---

## 📁 Project Structure

```text
food-delivery-data-engineering/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── etl/
│   ├── extract.py
│   ├── transform.py
│   ├── load.py
│   └── pipeline.py
│
├── sql/
│   ├── staging_tables.sql
│   ├── warehouse_tables.sql
│   └── analytical_queries.sql
│
├── powerbi/
│   └── Food_Delivery_Analytics.pbix
│
├── reports/
│
├── README.md
├── requirements.txt
└── .gitignore
```

👩‍💻 Author

Khushi Tomar

B.Tech Computer Science Engineering
Specialization: Artificial Intelligence & Machine Learning

Skills Demonstrated

Python • SQL • MySQL • Data Engineering • Data Warehousing • Power BI • DAX • Data Analytics

