# 📊 Retail Intelligence: Revenue Leakage, Churn & Regional Fulfillment Audit
**Production SQL Investigation on a 4-Table Relational Database**  
*Author:* **Md. Rafijur Rahman** | [Live Portfolio](https://rafijur-analytics.netlify.app) • [LinkedIn](https://www.linkedin.com/in/mdrafijur) • [Email](mailto:rafizurrahman3@gmail.com)

---

## 📌 Executive Summary

An e-commerce retail enterprise recorded strong top-line gross merchandise value (**৳1,937,050**) across 70 orders and 10 regional city hubs. However, executive cash flow audits revealed significant margin erosion post-booking. 

This repository contains the complete forensic SQL investigation conducted on a 4-table relational database model (`retail_analytics.db`). Using multi-stage Common Table Expressions (CTEs), analytical window functions (`DENSE_RANK`), and anti-join existence checks, this project diagnoses:
1. **৳ 449,050 in trapped/lost revenue** from cancelled and returned orders.
2. **20.0% dormant first-touch churn** (5 out of 25 registered customers never completed an order).
3. **The "Mymensingh Paradox"** — Tier-2 regional hubs generated Average Order Values (AOV) up to **2.3x higher than metropolitan Dhaka**.

---

## 🎯 Key Forensic Findings

| Metric | Measured Value | Business Consequence |
|---|---|---|
| **Total GMV Analyzed** | **৳ 1,937,050** | 70 orders across 10 regional distribution hubs |
| **Delivered Revenue** | **৳ 1,186,800** | 43 fulfilled orders (61.3% of total volume) |
| **Trapped Margin** | **৳ 449,050 (23.2%)** | ৳87.4K lost to cancellations + ৳361.6K trapped in returns |
| **Dormant User Churn** | **20.0% (5 / 25)** | Registered accounts with zero lifetime orders |
| **Top Revenue Category** | **Electronics (৳ 1.16M)** | Accounts for 60.0% of total revenue & highest return exposure |
| **Highest AOV City** | **Mymensingh (৳ 47,650)** | Non-metro hub outperforming Dhaka AOV (৳ 20,833) by 228% |

---

## 🗄️ Relational Data Schema (3NF)

```text
[customers] (customer_id PK)
     │
     └──< (customer_id FK) [orders] (order_id PK)
                                │
                                └──< (order_id FK) [order_items] >── (product_id FK) [products]
```

### Table Dictionary:
* **`customers`** (25 records): `customer_id` (PK), `customer_name`, `city`, `signup_date`
* **`orders`** (70 records): `order_id` (PK), `customer_id` (FK), `order_date`, `total_amount`, `order_status` *(Delivered, Cancelled, Returned, Pending)*
* **`order_items`** (139 records): `order_item_id` (PK), `order_id` (FK), `product_id` (FK), `quantity`, `unit_price`
* **`products`** (10 records): `product_id` (PK), `product_name`, `category`, `unit_price`

---

## 💻 Core SQL Architectures

### 1. Anti-Join: Detecting Zero-Order Customer Churn
```sql
-- Identifies registered users who dropped out before making their first transaction
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    c.signup_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```
*Business Takeaway:* 5 users abandoned after account creation. Marketing spend on these acquisitions produced 0 ROI.

---

### 2. Multi-Stage CTE: Customer Lifetime Spend & Value Tiering
```sql
WITH CustomerTotals AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.city,
        COUNT(o.order_id) AS total_orders,
        COALESCE(SUM(o.total_amount), 0) AS lifetime_spend
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id 
        AND o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name, c.city
),
TierSegmented AS (
    SELECT 
        *,
        CASE 
            WHEN lifetime_spend >= 100000 THEN 'Platinum'
            WHEN lifetime_spend >= 50000  THEN 'Gold'
            WHEN lifetime_spend > 0       THEN 'Silver'
            ELSE 'Dormant'
        END AS customer_tier
    FROM CustomerTotals
)
SELECT 
    customer_tier, 
    COUNT(*) AS customer_count, 
    SUM(lifetime_spend) AS tier_revenue
FROM TierSegmented
GROUP BY customer_tier
ORDER BY tier_revenue DESC;
```

---

### 3. Window Function: Category Top-Sellers via `DENSE_RANK`
```sql
WITH CategoryRanked AS (
    SELECT 
        p.category,
        p.product_name,
        SUM(oi.quantity) AS total_units_sold,
        SUM(oi.quantity * oi.unit_price) AS total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY p.category 
            ORDER BY SUM(oi.quantity) DESC
        ) AS rank_in_category
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status != 'Cancelled'
    GROUP BY p.category, p.product_name
)
SELECT * FROM CategoryRanked
WHERE rank_in_category <= 2;
```

---

## ⚡ How to Run & Reproduce Locally

No external database server installation is needed. A pre-compiled SQLite database is included in this repository:

### Option A: Using the Built-in Python Query Runner
```bash
# Run any custom query directly
python run_query.py "SELECT order_status, COUNT(*), SUM(total_amount) FROM orders GROUP BY order_status;"

# Run interactive SQL terminal
python run_query.py
```

### Option B: Using DB Browser for SQLite / DBeaver / VS Code
* Open `retail_analytics.db` in [DB Browser for SQLite](https://sqlitebrowser.org/) or DBeaver.
* Open files in the `/drills/` directory and execute!

---

## 📈 Strategic Business Recommendations

1. **Automated 72-Hour Nudge Campaign:** Deploy event-driven onboarding discounts for the 5 dormant accounts to recover an estimated ৳60K+ in initial orders.
2. **Electronics Pre-Dispatch Quality Control:** Electronics represents 60% of GMV (৳1.16M) and the majority of the ৳361K in returns. Stricter pre-dispatch verification could reduce return rates by 35%, preserving approx ৳126K in logistics costs.
3. **Reallocate Ad Spend to High-AOV Hubs:** Shift digital marketing allocation from low-AOV Dhaka (৳20.8K) toward high-ticket regional buyers in Mymensingh (৳47.6K), Gazipur (৳37.5K), and Rangpur (৳33.4K).

---

## 📄 License
This project is open-source under the MIT License.
