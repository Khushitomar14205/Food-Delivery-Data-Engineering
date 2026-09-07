-- ============================================================
-- FOOD DELIVERY DATA ENGINEERING PROJECT
-- Analytical SQL Queries
-- ============================================================

USE food_delivery_dw;


-- ============================================================
-- 1. OVERALL BUSINESS PERFORMANCE
-- ============================================================

SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(final_amount), 2) AS total_revenue,
    ROUND(AVG(final_amount), 2) AS average_order_value
FROM fact_orders
WHERE order_status = 'Delivered';


-- ============================================================
-- 2. ORDER STATUS DISTRIBUTION
-- ============================================================

SELECT
    order_status,
    COUNT(*) AS order_count,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM fact_orders),
        2
    ) AS percentage

FROM fact_orders

GROUP BY order_status

ORDER BY order_count DESC;


-- ============================================================
-- 3. REVENUE BY CITY
-- ============================================================

SELECT
    r.city,

    COUNT(*) AS total_orders,

    ROUND(
        SUM(f.final_amount),
        2
    ) AS revenue

FROM fact_orders f

JOIN dim_restaurant r
    ON f.restaurant_key = r.restaurant_key

WHERE f.order_status = 'Delivered'

GROUP BY r.city

ORDER BY revenue DESC;


-- ============================================================
-- 4. TOP 10 RESTAURANTS BY REVENUE
-- ============================================================

SELECT
    r.restaurant_name,

    r.cuisine,

    COUNT(*) AS total_orders,

    ROUND(
        SUM(f.final_amount),
        2
    ) AS revenue

FROM fact_orders f

JOIN dim_restaurant r
    ON f.restaurant_key = r.restaurant_key

WHERE f.order_status = 'Delivered'

GROUP BY
    r.restaurant_name,
    r.cuisine

ORDER BY revenue DESC

LIMIT 10;


-- ============================================================
-- 5. REVENUE BY CUISINE
-- ============================================================

SELECT
    r.cuisine,

    COUNT(*) AS total_orders,

    ROUND(
        SUM(f.final_amount),
        2
    ) AS revenue

FROM fact_orders f

JOIN dim_restaurant r
    ON f.restaurant_key = r.restaurant_key

WHERE f.order_status = 'Delivered'

GROUP BY r.cuisine

ORDER BY revenue DESC;


-- ============================================================
-- 6. PAYMENT METHOD PERFORMANCE
-- ============================================================

SELECT
    p.payment_method,

    COUNT(*) AS transactions,

    ROUND(
        SUM(f.final_amount),
        2
    ) AS revenue

FROM fact_orders f

JOIN dim_payment p
    ON f.payment_key = p.payment_key

WHERE f.order_status = 'Delivered'

GROUP BY p.payment_method

ORDER BY revenue DESC;


-- ============================================================
-- 7. DELIVERY PERFORMANCE
-- ============================================================

SELECT

    COUNT(*) AS total_deliveries,

    SUM(
        CASE
            WHEN is_delayed = 1 THEN 1
            ELSE 0
        END
    ) AS delayed_deliveries,

    ROUND(
        SUM(
            CASE
                WHEN is_delayed = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS delay_percentage,

    ROUND(
        AVG(delivery_delay),
        2
    ) AS average_delivery_delay

FROM fact_orders

WHERE order_status = 'Delivered';


-- ============================================================
-- 8. VEHICLE TYPE PERFORMANCE
-- ============================================================

SELECT
    d.vehicle_type,

    COUNT(*) AS deliveries,

    ROUND(
        AVG(f.delivery_delay),
        2
    ) AS average_delay,

    ROUND(
        SUM(
            CASE
                WHEN f.is_delayed = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS delay_percentage

FROM fact_orders f

JOIN dim_delivery d
    ON f.delivery_key = d.delivery_key

WHERE f.order_status = 'Delivered'

GROUP BY d.vehicle_type

ORDER BY delay_percentage;


-- ============================================================
-- 9. MONTHLY REVENUE TREND
-- ============================================================

SELECT

    dt.year,

    dt.month,

    dt.month_name,

    COUNT(*) AS orders,

    ROUND(
        SUM(f.final_amount),
        2
    ) AS revenue

FROM fact_orders f

JOIN dim_date dt
    ON f.date_key = dt.date_key

WHERE f.order_status = 'Delivered'

GROUP BY
    dt.year,
    dt.month,
    dt.month_name

ORDER BY
    dt.year,
    dt.month;


-- ============================================================
-- 10. TOP 10 CUSTOMERS BY SPENDING
-- ============================================================

SELECT

    c.customer_id,

    c.customer_name,

    COUNT(f.order_id) AS total_orders,

    ROUND(
        SUM(f.final_amount),
        2
    ) AS total_spent

FROM fact_orders f

JOIN dim_customer c
    ON f.customer_key = c.customer_key

WHERE f.order_status = 'Delivered'

GROUP BY
    c.customer_id,
    c.customer_name

ORDER BY total_spent DESC

LIMIT 10;


-- ============================================================
-- 11. CUSTOMER CITY PERFORMANCE
-- ============================================================

SELECT

    c.city,

    COUNT(DISTINCT c.customer_id) AS customers,

    COUNT(f.order_id) AS orders,

    ROUND(
        SUM(f.final_amount),
        2
    ) AS revenue

FROM dim_customer c

LEFT JOIN fact_orders f
    ON c.customer_key = f.customer_key
    AND f.order_status = 'Delivered'

GROUP BY c.city

ORDER BY revenue DESC;


-- ============================================================
-- 12. RESTAURANT RATING VS REVENUE
-- ============================================================

SELECT

    r.restaurant_name,

    r.rating,

    r.cuisine,

    COUNT(f.order_id) AS orders,

    ROUND(
        SUM(f.final_amount),
        2
    ) AS revenue

FROM fact_orders f

JOIN dim_restaurant r
    ON f.restaurant_key = r.restaurant_key

WHERE f.order_status = 'Delivered'

GROUP BY
    r.restaurant_name,
    r.rating,
    r.cuisine

ORDER BY revenue DESC;


-- ============================================================
-- 13. DELIVERY PARTNER PERFORMANCE
-- ============================================================

SELECT

    d.partner_name,

    d.vehicle_type,

    d.city,

    COUNT(f.order_id) AS deliveries,

    ROUND(
        AVG(f.delivery_delay),
        2
    ) AS average_delay

FROM fact_orders f

JOIN dim_delivery d
    ON f.delivery_key = d.delivery_key

WHERE f.order_status = 'Delivered'

GROUP BY
    d.partner_name,
    d.vehicle_type,
    d.city

ORDER BY average_delay DESC

LIMIT 10;
