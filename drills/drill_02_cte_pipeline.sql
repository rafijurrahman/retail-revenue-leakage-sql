-- ==============================================================================
-- DRILL 02: Multi-Step CTE Pipeline & Customer Cohort Analysis
-- Target: Day 2 Unassisted SQL Muscle Memory Sprint
-- ==============================================================================
--
-- BUSINESS QUESTION:
-- Identify "High-Value Loyal Customers" who have placed at least 2 delivered orders
-- and calculate their Average Order Value (AOV) and Total Spend.
--
-- REQUIREMENTS:
-- 1. Use a Common Table Expression (WITH customer_orders AS ...) to first aggregate
--    delivered orders per customer (calculating total_spend and order_count).
-- 2. In the main query, join back to the customers table to get customer_name and city.
-- 3. Filter for customers with order_count >= 2.
-- 4. Calculate AOV as (total_spend / order_count) rounded to 2 decimal places.
-- 5. Order by total_spend DESC.
--
-- WRITE YOUR QUERY BELOW:
-- ------------------------------------------------------------------------------



