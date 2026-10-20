-- Monthly revenue and month-over-month growth (CTE + LAG window function)
WITH monthly AS (
  SELECT
    FORMAT_DATE('%Y-%m', DATE(o.order_purchase_timestamp)) AS month,
    ROUND(SUM(oi.price), 2) AS revenue
  FROM `river-woodland-511108-q8.olist_raw.orders` AS o
  JOIN `river-woodland-511108-q8.olist_raw.order_items` AS oi ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered'
    AND o.order_purchase_timestamp >= '2017-01-01'
  GROUP BY month
)
SELECT
  month,
  revenue,
  LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
  ROUND((revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month) * 100, 1) AS mom_growth_pct
FROM monthly
ORDER BY month;
