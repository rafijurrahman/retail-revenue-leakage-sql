-- ==============================================================================
-- SQL FUNDAMENTALS SPRINT: JOIN, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT
-- Database: E:\SQL_Practice_Hub\retail_analytics.db
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- DRILL A: 3-Table Join & Product Category Performance
-- ------------------------------------------------------------------------------
-- BUSINESS QUESTION:
-- Which product categories generated the most revenue from successfully delivered orders?
--
-- REQUIREMENTS:
-- 1. Show Category Name (category), Total Sales (total_sales), and Total Quantity Sold (items_sold).
-- 2. Join products, order_items, and orders.
-- 3. Filter for order_status = 'Delivered'.
-- 4. Group by category.
-- 5. Order by total_sales DESC.
--
-- Write Query Below:



-- ------------------------------------------------------------------------------
-- DRILL B: Customer Loyalty & Volume Filtering (HAVING)
-- ------------------------------------------------------------------------------
-- BUSINESS QUESTION:
-- Find loyal customers who have placed at least 3 successfully delivered orders.
--
-- REQUIREMENTS:
-- 1. Show Customer Name (customer_name), City (city), Total Orders (total_orders), and Total Amount Spent (total_spent).
-- 2. Join customers and orders.
-- 3. Filter for order_status = 'Delivered'.
-- 4. Group by customer_id (and customer_name, city).
-- 5. Only include customers where total_orders >= 3 (using HAVING).
-- 6. Order by total_spent DESC.
--
-- Write Query Below:



-- ------------------------------------------------------------------------------
-- DRILL C: City-Level Average Order Value (AOV) in 2024
-- ------------------------------------------------------------------------------
-- BUSINESS QUESTION:
-- What is the Average Order Value (AOV) per delivered order across cities in 2024,
-- for cities with at least 3 delivered orders?
--
-- REQUIREMENTS:
-- 1. Show City Name (city), Average Order Value (avg_order_value rounded to 2 decimals), and Total Orders (total_orders).
-- 2. Join customers and orders.
-- 3. Filter for order_status = 'Delivered' and order_date in 2024 (>= '2024-01-01').
-- 4. Group by city.
-- 5. Only include cities where total_orders >= 3 (using HAVING).
-- 6. Order by avg_order_value DESC.
--
-- Write Query Below:



-- ------------------------------------------------------------------------------
-- DRILL D: Top 3 Best-Selling Products by Units Sold
-- ------------------------------------------------------------------------------
-- BUSINESS QUESTION:
-- Find the top 3 best-selling individual products based on total units sold.
--
-- REQUIREMENTS:
-- 1. Show Product Name (product_name), Category (category), and Total Units Sold (total_units_sold).
-- 2. Join products, order_items, and orders.
-- 3. Filter for order_status = 'Delivered'.
-- 4. Group by product_id (and product_name, category).
-- 5. Order by total_units_sold DESC.
-- 6. Limit to top 3 products.
--
-- Write Query Below:



-- ------------------------------------------------------------------------------
-- DRILL E: Revenue Loss Analysis by City (Cancelled Orders)
-- ------------------------------------------------------------------------------
-- BUSINESS QUESTION:
-- Which cities are suffering the most from cancelled orders, and how much revenue was lost?
--
-- REQUIREMENTS:
-- 1. Show City Name (city), Cancelled Orders Count (cancelled_orders_count), and Total Lost Revenue (cancelled_amount_lost).
-- 2. Join customers and orders.
-- 3. Filter for order_status = 'Cancelled'.
-- 4. Group by city.
-- 5. Order by cancelled_orders_count DESC.
--
-- Write Query Below:

