-- ==============================================================================
-- DRILL 01: Multi-Table JOIN, Aggregation & Post-Filter (HAVING)
-- Target: Day 2 Unassisted SQL Muscle Memory Sprint
-- ==============================================================================
--
-- BUSINESS QUESTION:
-- The management wants to see the top 5 cities by total delivered sales in 2024.
--
-- REQUIREMENTS:
-- 1. Display City Name (city), Total Revenue (total_revenue), and Completed Orders count (completed_orders).
-- 2. Filter for orders placed in the year 2024 (between '2024-01-01' and '2024-12-31').
-- 3. Only count orders where order_status = 'Delivered'.
-- 4. Only include cities where total_revenue is greater than 10,000 (using HAVING).
-- 5. Sort from highest revenue to lowest (DESC), returning top 5 cities.
--
-- WRITE YOUR QUERY BELOW:
-- ------------------------------------------------------------------------------


select c.city, 
       sum(o.order_total) as total_revenue, 
       count(o.order_id) as completed_orders
from orders o
join customers c on o.customer_id = c.customer_id
where o.order_status = 'Delivered'
  and o.order_date between '2024-01-01' and '2024-12-31'
group by c.city
having sum(o.order_total) > 10000
order by total_revenue desc
limit 5;
