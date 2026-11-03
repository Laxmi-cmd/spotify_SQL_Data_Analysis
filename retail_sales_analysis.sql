
-- ==========================================
-- RETAIL SALES ANALYSIS PROJECT
-- SQL Portfolio Project
-- ==========================================

-- STEP 1: Create the table
CREATE TABLE sales (
    order_id TEXT,
    customer_name TEXT,
    product TEXT,
    category TEXT,
    region TEXT,
    sales REAL,
    quantity INTEGER,
    profit REAL
);

-- STEP 2: Insert sample data
INSERT INTO sales VALUES
('O001', 'Amit', 'Laptop', 'Technology', 'West', 50000, 2, 8000),
('O002', 'Priya', 'Chair', 'Furniture', 'East', 5000, 3, 1000),
('O003', 'Rahul', 'Paper', 'Office Supplies', 'South', 1000, 5, 200),
('O004', 'Sneha', 'Phone', 'Technology', 'West', 25000, 1, 4000),
('O005', 'Neha', 'Table', 'Furniture', 'North', 12000, 2, -1000),
('O006', 'Amit', 'Monitor', 'Technology', 'West', 15000, 2, 2500),
('O007', 'Priya', 'Desk', 'Furniture', 'East', 8000, 1, 500),
('O008', 'Rahul', 'Printer', 'Technology', 'South', 18000, 1, 3000),
('O009', 'Sneha', 'Pen', 'Office Supplies', 'West', 500, 10, 100),
('O010', 'Neha', 'Sofa', 'Furniture', 'North', 30000, 1, -2000);


-- STEP 3: Overall business performance
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales;


-- STEP 4: Sales by category
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY category
ORDER BY total_sales DESC;


-- STEP 5: Customer analysis
SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM sales
GROUP BY customer_name
ORDER BY total_sales DESC;


-- STEP 6: Profit by region
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales
GROUP BY region
ORDER BY total_profit DESC;


-- STEP 7: Top 5 products by sales
SELECT
    product,
    SUM(sales) AS total_sales
FROM sales
GROUP BY product
ORDER BY total_sales DESC
LIMIT 5;


-- STEP 8: Loss-making products
SELECT
    product,
    SUM(profit) AS total_profit
FROM sales
GROUP BY product
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;


-- STEP 9: Rank products by sales
WITH product_sales AS (
    SELECT
        product,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY product
)
SELECT
    product,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM product_sales;


-- STEP 10: Average Order Value (AOV)
SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT
        order_id,
        SUM(sales) AS order_total
    FROM sales
    GROUP BY order_id
);


-- STEP 11: Most profitable category
SELECT
    category,
    SUM(profit) AS total_profit
FROM sales
GROUP BY category
ORDER BY total_profit DESC;
