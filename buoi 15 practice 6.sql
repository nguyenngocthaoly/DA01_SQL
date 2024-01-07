---ex1
WITH job_count_cte 
  AS (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description)
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count_cte
WHERE job_count > 1;
---ex2
WITH ranked_spending_cte 
  AS (
  SELECT 
    category, 
    product, 
    SUM(spend) AS total_spend,
    RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC) AS ranking 
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product)
SELECT 
  category, 
  product, 
  total_spend 
FROM ranked_spending_cte 
---ex3
WITH call_records 
  AS (
SELECT
  policy_holder_id,
  COUNT(case_id) AS call_count
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) >= 3)
SELECT COUNT(policy_holder_id) AS member_count
FROM call_records;
---ex4
SELECT page_id FROM pages
EXCEPT SELECT page_id
FROM page_likes;
---ex5
SELECT 
  EXTRACT(MONTH FROM curr_month.event_date) AS mth, 
  COUNT(DISTINCT curr_month.user_id) AS monthly_active_users 
FROM user_actions AS curr_month
WHERE EXISTS 
(SELECT last_month.user_id 
  FROM user_actions AS last_month
  WHERE last_month.user_id = curr_month.user_id
    AND EXTRACT(MONTH FROM last_month.event_date) =
    EXTRACT(MONTH FROM curr_month.event_date - interval '1 month'))
  AND EXTRACT(MONTH FROM curr_month.event_date) = 7
  AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date);
---ex6
SELECT DATE_FORMAT(trans_date, '%Y-%m') 
AS month,
       country,
       COUNT(id) AS trans_count,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country;
---ex7
SELECT product_id, year AS first_year, quantity, price
FROM sales
WHERE (product_id, year) IN 
     (SELECT product_id, MIN(year)
      FROM sales GROUP BY product_id);
---ex8
SELECT  customer_id 
FROM Customer GROUP BY customer_id
HAVING COUNT(distinct product_key) = (SELECT COUNT(product_key) 
FROM Product);
---ex9
SELECT e.employee_id
FROM Employees e
WHERE e.salary < 30000
AND NOT EXISTS (
    SELECT 1
    FROM Employees m
    WHERE m.employee_id = e.manager_id)
AND e.manager_id IS NOT NULL
ORDER BY e.employee_id;
---ex10
WITH job_count_cte AS (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description)
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count_cte
WHERE job_count > 1;
----ex11
WITH cnt AS (
    SELECT user_id, COUNT(movie_id) AS count
    FROM MovieRating
    GROUP BY user_id
),
avg1 AS (
    SELECT movie_id, AVG(rating) AS AVG
    FROM MovieRating
    WHERE EXTRACT(YEAR_MONTH FROM created_at) = 202002
    GROUP BY movie_id)

(SELECT name AS results
FROM Users
JOIN cnt ON Users.user_id = cnt.user_id
WHERE cnt.count = (SELECT MAX(count) FROM cnt)
ORDER BY name
LIMIT 1)

UNION ALL

(SELECT title AS results
FROM Movies
JOIN avg1 ON Movies.movie_id = avg1.movie_id
WHERE avg1.AVG = (SELECT MAX(AVG) FROM avg1)
ORDER BY title
LIMIT 1);
---ex12
WITH
     RequesAccepted AS (
        SELECT requester_id, accepter_id FROM RequestAccepted
        UNION
        SELECT accepter_id, requester_id FROM RequestAccepted)
SELECT requester_id AS id, COUNT(accepter_id) AS num
FROM RequesAccepted
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
