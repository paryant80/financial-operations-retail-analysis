-- Financial Operations & Retail Transaction Analysis
-- Dataset: UCI Online Retail
-- Purpose: operational reporting, revenue analysis and data-quality checks

CREATE DATABASE IF NOT EXISTS financial_operations;
USE financial_operations;

CREATE TABLE IF NOT EXISTS retail_transactions (
    invoice_no VARCHAR(20),
    stock_code VARCHAR(20),
    description VARCHAR(255),
    quantity INT,
    invoice_date DATETIME,
    unit_price DECIMAL(12,4),
    customer_id INT NULL,
    country VARCHAR(100),
    revenue DECIMAL(14,2),
    transaction_status VARCHAR(20),
    data_quality_flag VARCHAR(50)
);

-- After importing the cleaned CSV into retail_transactions:

-- 1. Overall transaction volume
SELECT COUNT(*) AS total_transaction_lines
FROM retail_transactions;

-- 2. Completed vs cancelled lines
SELECT transaction_status,
       COUNT(*) AS transaction_lines,
       ROUND(SUM(revenue),2) AS revenue
FROM retail_transactions
GROUP BY transaction_status
ORDER BY transaction_lines DESC;

-- 3. Net revenue
SELECT ROUND(SUM(revenue),2) AS net_revenue
FROM retail_transactions;

-- 4. Cancellation rate
SELECT ROUND(
    100.0 * SUM(transaction_status = 'Cancelled') / COUNT(*), 2
) AS cancellation_rate_pct
FROM retail_transactions;

-- 5. Revenue by country
SELECT country,
       ROUND(SUM(revenue),2) AS revenue
FROM retail_transactions
GROUP BY country
ORDER BY revenue DESC;

-- 6. Top 10 products by revenue
SELECT description,
       ROUND(SUM(revenue),2) AS revenue
FROM retail_transactions
WHERE transaction_status = 'Completed'
GROUP BY description
ORDER BY revenue DESC
LIMIT 10;

-- 7. Monthly revenue trend
SELECT DATE_FORMAT(invoice_date,'%Y-%m') AS month,
       ROUND(SUM(revenue),2) AS revenue
FROM retail_transactions
WHERE transaction_status = 'Completed'
GROUP BY DATE_FORMAT(invoice_date,'%Y-%m')
ORDER BY month;

-- 8. Data-quality monitoring
SELECT
    SUM(quantity < 0) AS negative_quantity_lines,
    SUM(customer_id IS NULL) AS missing_customer_ids,
    SUM(transaction_status = 'Cancelled') AS cancelled_lines
FROM retail_transactions;

-- 9. Revenue by customer (useful for operations/customer review)
SELECT customer_id,
       ROUND(SUM(revenue),2) AS revenue
FROM retail_transactions
WHERE customer_id IS NOT NULL
  AND transaction_status = 'Completed'
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;

-- 10. Country-level cancellation impact
SELECT country,
       ROUND(SUM(CASE WHEN transaction_status='Cancelled' THEN revenue ELSE 0 END),2) AS cancelled_value
FROM retail_transactions
GROUP BY country
ORDER BY cancelled_value ASC
LIMIT 10;
