Use company_db;
-- 1. Select all data
SELECT * 
FROM data;

-- 2. Total revenue by gender
SELECT gender, 
       SUM(purchase_amount) AS revenue
FROM data
GROUP BY gender;

-- 3. Customers with discount applied and purchase above average
SELECT id, purchase_amount
FROM data
WHERE discount_applied = 'Yes' 
  AND purchase_amount >= (SELECT AVG(purchase_amount) FROM data);

-- 4. Top 5 items by average review rating
SELECT item_purchased, 
       AVG(review_rating) AS avg_rating
FROM data
GROUP BY item_purchased
ORDER BY AVG(review_rating) DESC
LIMIT 5;

-- 5. Average purchase amount by shipping type
SELECT shipping_type,
       AVG(purchase_amount) AS avg_purchase
FROM data
WHERE shipping_type IN ('standard','express','overnight')
GROUP BY shipping_type;

-- 6. Customer subscription stats: total, avg spend, total revenue
SELECT subscription,
       COUNT(id) AS customer_total,
       AVG(purchase_amount) AS avg_spend,
       SUM(purchase_amount) AS total_revenue
FROM data
GROUP BY subscription
ORDER BY avg_spend, total_revenue DESC;

-- 7. Top 5 items with highest percentage of discount applied
SELECT item_purchased,
       (100 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) AS discount_percentage
FROM data
GROUP BY item_purchased
ORDER BY discount_percentage DESC
LIMIT 5;

-- 8. Customer segmentation based on previous purchases
WITH customer_type AS (
    SELECT id,
           CASE
               WHEN previous_purchases = 1 THEN 'New'
               WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
               ELSE 'Loyal'
           END AS customer_segment
    FROM data
)
SELECT customer_segment,
       COUNT(*) AS no_of_customers
FROM customer_type
GROUP BY customer_segment;

-- 9. Top 3 items per category by number of orders
SELECT category,
       item_purchased,
       total_orders
FROM (
    SELECT category,
           item_purchased,
           COUNT(*) AS total_orders,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(*) DESC) AS rn
    FROM data
    GROUP BY category, item_purchased
) t
WHERE rn <= 3;

-- 10. Total customers by subscription and previous purchases (up to 5 previous purchases)
WITH data_type AS (
    SELECT subscription, previous_purchases,
           COUNT(id) AS total_customer
    FROM data
    GROUP BY subscription, previous_purchases
)
SELECT *
FROM data_type
WHERE previous_purchases <= 5;

-- 11. Customers with more than 5 previous purchases, by subscription
SELECT subscription,
       COUNT(id) AS total_customer
FROM data
WHERE previous_purchases > 5
GROUP BY subscription;

-- 12. Total revenue by age
SELECT age,
       SUM(purchase_amount) AS total_revenue
FROM data
GROUP BY age
ORDER BY total_revenue DESC;
