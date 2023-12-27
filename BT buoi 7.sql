---ex1
SELECT Name FROM STUDENTS
WHERE Marks>75
ORDER BY RIGHT(Name,3), ID;
---ex2
SELECT user_id,
CONCAT (UPPER (LEFT(name,1)),LOWER(RIGHT(name, LENGTH(name)-1))) AS name
FROM users
ORDER BY user_id;
---ex3
SELECT manufacturer,
'$'||ROUND(SUM(total_sales)/1000000,0)||''|| 'million' AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales), DESC, manufacturer;
---ex4
SELECT 
EXTRACT(month FROM submit_date) AS mth,
product_id, 
ROUND(AVG(stars),2) AS avg_stars
FROM reviews
GROUP BY mth, product_id
ORDER BY mth, product_id;
---ex5
SELECT 
sender_id,
COUNT(message_id) AS message_count
FROM messages
WHERE EXTRACT(month FROM sent_date)=8
AND EXTRACT(year FROM sent_date)=2022
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;
---ex6
SELECT tweet_id FROM Tweets
WHERE LENGTH(content)>15;
---ex8
select 
COUNT(employee_id) AS number_emloyee
from employees
WHERE EXTRACT( month FROM joining_date ) BETWEEN 1 and 7 
AND EXTRACT(year FROM joining_date)=2022;
---ex9
select 
POSITION('a' in first_name) AS position
from worker
WHERE first_name='Amitah';
---ex10
select 
SUBSTRING(title,length(winery)+2,4)
from winemag_p2
WHERE country= 'Macedonia';

