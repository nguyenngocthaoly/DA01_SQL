---ex1
SELECT Country.Continent, FLOOR(AVG(City.Population))
FROM Country, City 
WHERE Country.Code = City.CountryCode 
GROUP BY Country.Continent;
---ex2
SELECT 
  ROUND(COUNT(texts.email_id)::DECIMAL/COUNT(DISTINCT emails.email_id),2) 
  AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';
---ex3
SELECT age.age_bucket, 
  ROUND(100.0 * SUM(activities.time_spent) 
  FILTER (WHERE activities.activity_type = 'send')/SUM(activities.time_spent),2) 
  AS send_perc, 
  ROUND(100.0 * SUM(activities.time_spent) 
  FILTER (WHERE activities.activity_type = 'open')/SUM(activities.time_spent),2)
  AS open_perc
FROM activities
INNER JOIN age_breakdown AS age ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket;
---ex4
SELECT 
  customers.customer_id, 
  COUNT(DISTINCT products.product_category) AS unique_count
FROM customer_contracts AS customers
LEFT JOIN products ON customers.product_id = products.product_id
GROUP BY customers.customer_id;
---ex5
SELECT a.reports_to AS employee_id,
       b.name,
       COUNT(a.reports_to) AS reports_count,
       ROUND(avg(a.age),0) AS average_age
FROM employees a
JOIN employees b ON a.reports_to=b.employee_id
GROUP BY a.reports_to
ORDER BY a.reports_to;
---ex6
SELECT a.product_name, sum(unit) AS unit
FROM Products a
LEFT JOIN Orders b ON  a.product_id = b.product_id
WHERE b.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY a.product_id
HAVING SUM(unit) >= 100;
---ex7
SELECT page_id FROM pages
EXCEPT SELECT page_id FROM page_likes;

