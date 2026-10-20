-- Top product categories by revenue
SELECT
  t.string_field_1 AS category,
  ROUND(SUM(oi.price), 2) AS revenue,
  COUNT(DISTINCT oi.order_id) AS orders
FROM `river-woodland-511108-q8.olist_raw.order_items` AS oi
JOIN `river-woodland-511108-q8.olist_raw.products` AS p ON oi.product_id = p.product_id
JOIN `river-woodland-511108-q8.olist_raw.category_translation` AS t ON p.product_category_name = t.string_field_0
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;
