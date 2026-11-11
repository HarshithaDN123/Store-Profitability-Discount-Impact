-- =====================================================================
-- STORE PROFITABILITY & DISCOUNT IMPACT CAPSTONE - SQL ANALYSIS
-- =====================================================================

-- 1. Overall Sales, Profit, and Profit Margin by Category
SELECT 
    p.category,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit,
    ROUND(SUM(o.profit) / SUM(o.sales) * 100, 2) AS profit_margin_pct
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_profit DESC;

-- 2. Sub-Category Performance (Identifying Loss Drivers like Tables & Bookcases)
SELECT 
    p.sub_category,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit,
    ROUND(AVG(o.discount) * 100, 2) AS avg_discount_pct
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.sub_category
ORDER BY total_profit ASC;

-- 3. Discount Impact Analysis (Proving profit drops heavily above 20% discount)
SELECT 
    CASE 
        WHEN o.discount = 0 THEN '0% (No Discount)'
        WHEN o.discount <= 0.20 THEN '1% - 20% Discount'
        ELSE 'Above 20% Discount'
    END AS discount_tier,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o
GROUP BY discount_tier
ORDER BY total_profit DESC;

-- 4. Regional Profitability Breakdown
SELECT 
    r.region_name,
    ROUND(SUM(o.sales), 2) AS total_sales,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o
JOIN regions r ON o.region_id = r.region_id
GROUP BY r.region_name
ORDER BY total_profit DESC;