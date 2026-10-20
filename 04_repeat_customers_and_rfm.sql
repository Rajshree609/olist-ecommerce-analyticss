-- Part A: repeat customer rate
WITH cust AS (
  SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) AS order_count
  FROM `river-woodland-511108-q8.olist_raw.orders` AS o
  JOIN `river-woodland-511108-q8.olist_raw.customers` AS c ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)
SELECT
  COUNT(*) AS total_customers,
  COUNTIF(order_count > 1) AS repeat_customers,
  ROUND(COUNTIF(order_count > 1) / COUNT(*) * 100, 2) AS repeat_rate_pct
FROM cust;

-- Part B: RFM table (Recency, Frequency, Monetary) per customer
WITH base AS (
  SELECT
    c.customer_unique_id,
    o.order_id,
    DATE(o.order_purchase_timestamp) AS order_date,
    SUM(oi.price) AS order_value
  FROM `river-woodland-511108-q8.olist_raw.orders` AS o
  JOIN `river-woodland-511108-q8.olist_raw.customers` AS c ON o.customer_id = c.customer_id
  JOIN `river-woodland-511108-q8.olist_raw.order_items` AS oi ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id, o.order_id, order_date
),
ref AS (SELECT MAX(order_date) AS max_date FROM base)
SELECT
  b.customer_unique_id,
  DATE_DIFF(r.max_date, MAX(b.order_date), DAY) AS recency_days,
  COUNT(DISTINCT b.order_id) AS frequency,
  ROUND(SUM(b.order_value), 2) AS monetary
FROM base AS b
CROSS JOIN ref AS r
GROUP BY b.customer_unique_id, r.max_date
ORDER BY monetary DESC
LIMIT 20;
