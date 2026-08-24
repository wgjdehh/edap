-- Walmart Project Queries - MySQL

SELECT * FROM walmart;



-- Count total records
SELECT COUNT(*) FROM walmart;

-- Count payment methods and number of transactions by payment method
SELECT 
    payment_method,
    COUNT(*) AS no_payments
FROM walmart
GROUP BY payment_method;

-- Count distinct branches
SELECT COUNT(DISTINCT branch) FROM walmart;

-- Find the minimum quantity sold
SELECT MIN(quantity) FROM walmart;

-- Business Problem Q: Find different payment methods, number of transactions, and quantity sold by payment method
SELECT 
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

-- Project Question : Identify the highest-rated category in each branch
-- Display the branch, category, and avg rating
SELECT branch, category, avg_rating
FROM (
    SELECT 
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
    FROM walmart
    GROUP BY branch, category
) AS ranked
WHERE rank = 1;



-- Q: Calculate the total quantity of items sold per payment method
SELECT 
    payment_method,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

-- Q: Determine the average, minimum, and maximum rating of categories for each city
SELECT 
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY city, category;

-- Q: Calculate the total profit for each category
SELECT 
    category,
    SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;

-- Q: Determine the most common payment method for each branch
WITH cte AS (
    SELECT 
        branch,
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
    FROM walmart
    GROUP BY branch, payment_method
)
SELECT branch, payment_method AS preferred_payment_method
FROM cte
WHERE rank = 1;

-- Q: Total revenue by category
SELECT
    category,
    SUM(unit_price * quantity) AS total_revenue
FROM walmart
GROUP BY category
ORDER BY total_revenue DESC;



-- Q: Total revenue by branch
SELECT
    branch,
    SUM(unit_price * quantity) AS total_revenue
FROM walmart
GROUP BY branch
ORDER BY total_revenue DESC;

-- Q: Sum of profit margin by branch
SELECT
    branch,
    SUM(unit_price * quantity * profit_margin) AS total_profit_margin
FROM walmart
GROUP BY branch
ORDER BY total_profit_margin DESC;

-- Q: Year-on-Year revenue growth % by branch
WITH yearly_revenue AS (
    SELECT
        branch,
        YEAR(STR_TO_DATE(date, '%d/%m/%y')) AS sales_year,
        SUM(unit_price * quantity) AS total_revenue
    FROM walmart
    GROUP BY branch, YEAR(STR_TO_DATE(date, '%d/%m/%y'))
),
yoy AS (
    SELECT
        branch,
        sales_year,
        total_revenue,
        LAG(total_revenue) OVER (PARTITION BY branch ORDER BY sales_year) AS prev_year_revenue
    FROM yearly_revenue
)
SELECT
    branch,
    sales_year,
    total_revenue,
    prev_year_revenue,
    ROUND(
        (total_revenue - prev_year_revenue) / prev_year_revenue * 100, 2
    ) AS yoy_growth_pct
FROM yoy
ORDER BY branch, sales_year

