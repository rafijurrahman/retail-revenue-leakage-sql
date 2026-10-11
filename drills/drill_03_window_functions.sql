-- ==============================================================================
-- DRILL 03: Window Functions (DENSE_RANK & Running Totals)
-- Target: Day 2 Unassisted SQL Muscle Memory Sprint
-- ==============================================================================
--
-- BUSINESS QUESTION:
-- For each product category, rank the top 2 highest-selling products based on
-- total quantity sold across delivered orders.
--
-- REQUIREMENTS:
-- 1. Join products, order_items, and orders tables.
-- 2. Filter for order_status = 'Delivered'.
-- 3. Calculate total_quantity_sold for each product.
-- 4. Use DENSE_RANK() OVER (PARTITION BY category ORDER BY total_quantity_sold DESC)
--    to rank products within each category.
-- 5. Wrap inside a CTE or Subquery to only return ranks <= 2.
--
-- WRITE YOUR QUERY BELOW:
-- ------------------------------------------------------------------------------



