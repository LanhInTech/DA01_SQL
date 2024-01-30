/*ex1: 
--output: duplicate_companies
--input: count(company_id), title, description, job_id 
--condition: Count(job_id) GROUP BY company_id >=2 */

WITH companies_duplicate AS(
SELECT COMPANY_ID, COUNT(job_id)
FROM Job_listings
GROUP BY company_id
HAVING COUNT(job_id) >=2)
  
SELECT COUNT(company_id) 
FROM companies_duplicate AS duplicate_companies

/* EX2: output: category, product, and total_spend: SUM(spend).
--input:  category, product, spend, EXTRACT(year FROM transaction_date)
--condition: SUM(spend) GROUP BY product, LIMIT 4, EXTRACT(year FROM transaction_date) = '2022'*/

WITH top_product AS
(SELECT product, SUM(spend) AS total_spend
FROM product_spend
WHERE EXTRACT(year FROM transaction_date) = '2022' 
GROUP BY product
ORDER BY total_spend DESC
LIMIT 4)

SELECT A.category, top_product.product, top_product.total_spend 
FROM product_spend AS A
JOIN top_product
ON A.PRODUCT = top_product.PRODUCT
GROUP BY A.category, top_product.product, top_product.total_spend 
ORDER BY category, TOTAL_SPEND DESC
  
/* EX3: --output: member_count
--input:  COUNT(case_id) GROUP BY policy_holder_id, COUNT(policy_holder_id)
--condition: COUNT(case_id) GROUP BY policy_holder_id >=3 */

WITH call_case AS(
SELECT policy_holder_id, COUNT(case_id) 
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id)>=3)
SELECT COUNT(policy_holder_id) AS member_count
FROM call_case
  
/* EX4: */
  
WITH page_count AS(
SELECT page_id, COUNT(user_id) AS count_likes 
FROM page_likes
GROUP BY page_id
ORDER BY page_id ASC) 
SELECT pages.page_id
FROM pages 
LEFT JOIN page_count 
  ON pages.page_id = page_count.page_id
WHERE count_likes IS NULL

/* EX5: */
SELECT '7' AS month, 
COUNT(DISTINCT user_7.user_id) AS monthly_active_users
FROM
(SELECT EXTRACT(MONTH FROM event_date) AS event_date, user_id
FROM user_actions
WHERE EXTRACT(MONTH FROM event_date) = '07'
AND EXTRACT(YEAR FROM event_date) = '2022') AS user_7
JOIN  
(SELECT EXTRACT(MONTH FROM event_date) AS event_date, user_id
FROM user_actions
WHERE EXTRACT(MONTH FROM event_date) = '06'
AND EXTRACT(YEAR FROM event_date) = '2022') AS user_6
ON user_7.user_id = user_6.user_id
  
/* EX6: */
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month,
country,
COUNT(*) as  trans_count,
SUM(CASE 
WHEN state ='approved' 
THEN 1 ELSE 0 
END) as approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE 
WHEN state ='approved'
THEN amount 
ELSE 0 END) AS approved_total_amount
FROM 
Transactions
GROUP BY
DATE_FORMAT(trans_date, '%Y-%m'), country
/* EX7: */
WITH cte_min_year AS 
(SELECT product_id, MIN(year) AS first_year_cte
FROM Sales
GROUP BY product_id)
SELECT A.product_id, A.year AS first_year, A.quantity, A.price
FROM Sales AS A
JOIN cte_min_year
ON A.product_id = cte_min_year.product_id
WHERE A.YEAR = cte_min_year.first_year_cte
/* EX8: */
SELECT customer_id FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = 
(SELECT COUNT(product_key) FROM Product)
/* EX9: */
SELECT 
employee_id FROM Employees
WHERE NOT manager_id IN
(SELECT 
emp.manager_id 
FROM Employees AS emp
JOIN Employees AS mng
ON emp.manager_id = mng.employee_id)
AND salary < 30000
ORDER BY employee_id ASC
/* EX10: */
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_listings
WHERE company_id IN (
SELECT company_id
FROM Job_listings
GROUP BY company_id, title, description
HAVING COUNT(job_id) >= 2)
/* EX11: */
  
# Write your MySQL query statement below
(SELECT 
Users.name AS results
FROM (SELECT 
user_id,
COUNT(MovieRating.RATING) AS count_rating
FROM MovieRating
GROUP BY user_id 
ORDER BY COUNT(MovieRating.RATING)) AS count_rate
JOIN Users
ON count_rate.user_id = Users.user_id
ORDER BY count_rate.count_rating DESC, Users.name ASC
LIMIT 1)
UNION ALL
(SELECT 
Movies.title AS results
FROM (SELECT 
movie_id,
AVG(MovieRating.RATING) AS avg_rating
FROM MovieRating
WHERE EXTRACT(MONTH FROM created_at) = '02' 
AND EXTRACT(YEAR FROM created_at) = '2020'
GROUP BY movie_id 
ORDER BY AVG(MovieRating.RATING)) AS avg_rate
JOIN Movies
ON Movies.movie_id = avg_rate.movie_id
ORDER BY avg_rate.avg_rating DESC, results ASC
LIMIT 1)

/* EX12: */
SELECT
distinct requester_id AS id,
COUNT(requester_id) AS num
FROM
((SELECT 
requester_id
FROM RequestAccepted AS A)
UNION ALL 
(SELECT 
accepter_id
FROM RequestAccepted AS B)) AS union_table
GROUP BY requester_id
ORDER BY num DESC
LIMIT 1

