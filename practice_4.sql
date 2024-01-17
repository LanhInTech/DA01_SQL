--ex1: 
SELECT
count(
CASE
  WHEN device_type = 'laptop' THEN view_time
END) AS laptop_views,
count(
CASE
  WHEN device_type = 'tablet' 
    or device_type = 'phone' 
  THEN view_time
END) AS mobile_views
FROM viewership
--ex2:
SELECT 
x,
y, 
z,
CASE
WHEN (x + y <= z OR x + z <= y OR y + z <= x) THEN 'No'
else 'Yes'
END AS TRIANGLE
FROM TRIANGLE 
--ex3: 
  SELECT
ROUND(
count(
CASE
  WHEN call_category = 'n/a' or call_category IS NULL
  THEN 1 ELSE 0
END)
/COUNT(call_category) * 100, 1) 
AS call_percentage
FROM callers
--ex4: 
SELECT 
NAME 
FROM CUSTOMER
WHERE REFEREE_ID <> 2 or REFEREE_ID IS NULL
--ex5:
select
SURVIVED,
SUM(CASE
WHEN PCLASS = 1 THEN 1 ELSE 0
END) AS FIRST_CLASS,
SUM(CASE
WHEN PCLASS = 2 THEN 1 ELSE 0
END) AS SECOND_CLASS,
SUM(CASE
WHEN PCLASS = 3 THEN 1 ELSE 0
END) AS THIRD_CLASS
from titanic
GROUP BY SURVIVED
