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
--ex6:
--ex7:
--ex8:
--ex9:
--ex10:
