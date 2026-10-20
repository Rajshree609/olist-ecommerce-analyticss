-- Category ranking with share of total and cumulative % (Pareto)
WITH cat AS (
  SELECT
    t.string_field_1 AS category,
    ROUND(SUM(oi.price), 2) AS revenue
  FROM `river-woodland-511108-q8.olist_raw.order_items` AS oi
  JOIN `river-woodland-511108-q8.olist_raw.products` AS p ON oi.product_id = p.product_id
  JOIN `river-woodland-511108-q8.olist_raw.category_translation` AS t ON p.product_category_name = t.string_field_0
  GROUP BY category
)
SELECT
  RANK() OVER (ORDER BY revenue DESC) AS rnk,
  category,
  revenue,
  ROUND(revenue / SUM(revenue) OVER () * 100, 1) AS pct_of_total,
  ROUND(SUM(revenue) OVER (ORDER BY revenue DESC) / SUM(revenue) OVER () * 100, 1) AS cumulative_pct
FROM cat
ORDER BY rnk
LIMIT 15;
