-- Late vs on-time delivery and average review score
SELECT
  CASE
    WHEN DATE_DIFF(DATE(o.order_delivered_customer_date), DATE(o.order_estimated_delivery_date), DAY) <= 0 THEN 'On time'
    ELSE 'Late'
  END AS delivery_status,
  COUNT(*) AS orders,
  ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM `river-woodland-511108-q8.olist_raw.orders` AS o
JOIN `river-woodland-511108-q8.olist_raw.reviews` AS r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;
