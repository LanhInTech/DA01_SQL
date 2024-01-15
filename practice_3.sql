--ex1:
select NAME
from STUDENTS
where marks > 75
ORDER BY right(name, 3), ID
--ex2:
SELECT  
USER_ID,
concat(upper(left(name,1)), LOWER(SUBSTRING(NAME FROM 2 FOR LENGTH(NAME) - 1))) 
as name
FROM USERS
ORDER BY USER_ID
--ex3:
SELECT 
manufacturer,
concat('$', round(sum(total_sales)/1000000, 0), ' millions')
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) DESC, manufacturer
--ex4:
SELECT
EXTRACT(MONTH FROM SUBMIT_DATE),
product_ID,
ROUND(AVG(STARS), 2) AS AVG_STARS
FROM reviews
group by product_ID, EXTRACT(MONTH FROM SUBMIT_DATE)
ORDER BY EXTRACT(MONTH FROM SUBMIT_DATE), PRODUCT_ID;
--ex5:
SELECT
SENDER_ID,
COUNT(MESSAGE_ID) AS MESSAGE_COUNT
FROM messages
WHERE EXTRACT(MONTH FROM SENT_DATE) = 8 
AND EXTRACT(YEAR FROM SENT_DATE) = 2022
GROUP BY SENDER_ID
ORDER BY MESSAGE_COUNT DESC
LIMIT 2;
--ex6:
SELECT 
TWEET_ID
FROM TWEETS
WHERE LENGTH(CONTENT) > 15
--ex7:
SELECT 
ACTIVITY_DATE AS day,
COUNT(distinct user_id) as active_users
FROM ACTIVITY
WHERE activity_date BETWEEN '2019-06-27' AND '2019-07-27'
AND SESSION_ID >= 1
GROUP BY ACTIVITY_DATE;
--ex8:
select count(id), joining_date
from employees
where extract(month from joining_date) between '01' and '07'
and extract (year from joining_date) = '2022'
group by joining_date;
--ex9:
select 
first_name,
position('a' in first_name)
from worker;
--ex10:
select
title,
substring(title from length(winery)+2 for 4) as vintage_year 
from winemag_p2
where country = 'Macedonia';
