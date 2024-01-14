--ex1:
SELECT DISTINCT city FROM STATION
where ID%2 = 0
--ex2:
select 
(count(city) - count(Distinct city)) as the_different
from station
--ex4:
SELECT 
round(
cast(
sum(item_count * order_occurrences) / sum(order_occurrences) 
AS DECIMAL),1) as mean
FROM items_per_order;
--ex5:
SELECT Candidate_id FROM candidates
WHERE SKILL IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY CANDIDATE_ID
having count(skill) = 3
ORDER BY CANDIDATE_ID
--ex6:
SELECT user_id, 
date(MAX(post_date)) - date(Min(post_date))
as days_between 
FROM posts
where post_date >= '2021-01-01' AND post_date <= '2021-12-31'
group by user_id
having COUNT(POST_ID) >= 2
--ex7:
SELECT 
card_name,
max(issued_amount) - min(issued_amount) as numbers_different
FROM monthly_cards_issued
Group BY card_name
order by max(issued_amount) - min(issued_amount) DESC
--ex8:
SELECT 
MANUFACTURER,
COUNT(DRUG) AS DRUG_COUNT,
ABS(SUM(COGS - TOTAL_SALES)) AS TOTAL_LOSS
FROM pharmacy_sales
WHERE TOTAL_SALES < COGS
GROUP BY MANUFACTURER
ORDER BY TOTAL_LOSS DESC
--ex9:
SELECT * FROM CINEMA
WHERE ID%2 = 1 AND description <> 'boring' 
order by rating desc
--ex10:
select teacher_id, 
count(distinct subject_id) as cnt
from teacher
group by teacher_id 
order by teacher_id
--ex11:
select user_id,
count(follower_id) as followers_count
from Followers
group by user_id
order by user_id
--ex12:
select
class
from Courses
group by class
having count(student) >= 5
