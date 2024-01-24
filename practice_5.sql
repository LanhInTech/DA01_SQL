--ex1: 
SELECT Table_2.continent, floor(AVG(Table_1.population)) 
FROM city AS Table_1
INNER JOIN country AS Table_2
ON Table_1.countrycode = Table_2.code
GROUP BY Table_2.continent
order by floor(AVG(Table_1.population))
--ex2:
SELECT ROUND(CAST(COUNT(Table_2.email_id) AS DECIMAL)
/COUNT(DISTINCT Table_1.email_id), 2)
AS confirm_rate 
FROM emails as Table_1
LEFT JOIN texts AS Table_2
ON Table_1.email_id = Table_2.email_id
AND Table_2.signup_action = 'Confirmed'
--ex3:
SELECT 
age_breakdown.age_bucket,
round((SUM(CASE 
WHEN activities.activity_type = 'send' 
THEN activities.time_spent
ELSE 0 END)/SUM(activities.time_spent))*100.0, 2) AS send_PERC,
round((SUM(CASE 
WHEN activities.activity_type = 'open' 
THEN activities.time_spent
ELSE 0 END)/SUM(activities.time_spent))*100.0, 2) AS open_PERC
FROM activities
INNER JOIN age_breakdown 
ON activities.user_id = age_breakdown.user_id
WHERE activities.activity_type IN ('send', 'open')
GROUP BY age_breakdown.age_bucket
--ex4:
SELECT
customer_contracts.customer_iD
FROM customer_contracts
LEFT JOIN products 
ON customer_contracts.product_id = products.product_id
group by customer_contracts.customer_iD
HAVING COUNT(distinct products.product_category) >=3
ORDER BY customer_contracts.customer_iD
--ex5:
SELECT
emp.employee_id,
emp.name,
count(mng.reports_to) AS reports_count,
round(AVG(mng.age),0) AS average_age
FROM employees AS emp
LEFT JOIN employees AS mng
ON emp.employee_id = mng.reports_to
GROUP BY emp.employee_id,
emp.name
HAVING count(mng.reports_to) >=1
ORDER BY emp.employee_id
--ex6:
SELECT 
Products.product_name,
SUM(orders.unit) AS unit
FROM Products
LEFT JOIN Orders
ON Products.product_id =  Orders.product_id
WHERE EXTRACT(year FROM order_date) = '2020' 
and EXTRACT(month FROM order_date) = '02'
GROUP BY Products.product_name
HAVING SUM(orders.unit) >= 100
--ex7:
SELECT
pages.page_id
FROM pages
LEFT JOIN page_likes
ON pages.page_id = page_likes.page_id
GROUP BY pages.page_id
HAVING count(user_id) = 0
-- MID TERM TEST:
-- Câu hỏi 1:
SELECT 
DISTINCT replacement_cost
FROM film
ORDER BY replacement_cost ASC
-- Câu hỏi 2:
SELECT 
	CASE
		WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'LOW'
		WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'MEDIUM'
		WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'HIGH'
	END AS CATEGORY,
	COUNT(replacement_cost)
FROM film
GROUP BY CASE
		WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'LOW'
		WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'MEDIUM'
		WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'HIGH'
	END
-- Câu hỏi 3:

-- Câu hỏi 4:

-- Câu hỏi 5:

-- Câu hỏi 6:

-- Câu hỏi 7:

-- Câu hỏi 8:
