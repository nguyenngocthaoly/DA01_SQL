---ex1
SELECT
 SUM(CASE
  WHEN DEVICE_TYPE = 'tablet' OR DEVICE_TYPE = 'phone' 
  THEN MOBILE_VIEWS ELSE 0 
  END AS category),
 SUM(CASE
  WHEN DEVICE_TYPE = 'laptop'
  THEN LAPTOP_VIEWS ELSE 0
  END AS category)
  FROM viewership;
---ex2
SELECT 
If(x+y>z AND x+z>y AND y+z>x, 'YES','NO') AS TRIANGLE
FROM TRIANGLE;
---ex3
SELECT 
  ROUND(100.0*COUNT(case_id)/(SELECT COUNT(*) FROM callers),1)
  AS call_percentage
FROM callers
WHERE call_category IS NULL 
  OR call_category = 'n/a';
---ex4
select name from customer
where not referee_id =2 or referee_id is null;
---ex5
SELECT
    survived,
    sum(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
    sum(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
    sum(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM titanic
GROUP BY survived
