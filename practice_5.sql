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
SELECT 
t1.title, t1.length, t3.name
FROM film as t1
inner join film_category as t2
on t1.film_id = t2.film_id 
inner join category as t3
on t2.category_id = t3.category_id
where t3.name in ('Drama', 'Sports')
ORDER BY LENGTH DESC
-- Câu hỏi 4: Đưa ra cái nhìn tổng quan về số lượng phim (tilte) trong mỗi danh mục (category).
SELECT 
count(t1.film_id), t3.name
FROM film as t1
inner join film_category as t2
on t1.film_id = t2.film_id 
inner join category as t3
on t2.category_id = t3.category_id
GROUP BY t3.name
ORDER BY count(t1.film_id) DESC
-- Câu hỏi 5: /* Đưa ra cái nhìn tổng quan về họ và tên của các diễn viên cũng như số lượng phim họ tham gia. */
SELECT concat(t1.first_name,' ',t1.last_name) AS full_name, 
count(t2.film_id)
FROM actor as t1
LEFT JOIN film_actor as t2
ON t1.actor_id = t2.actor_id
group by concat(t1.first_name,' ',t1.last_name)
ORDER BY count(t2.film_id) DESC
-- Câu hỏi 6:
select t1.customer_id, t2.address
FROM public.customer AS t1
RIGHT JOIN address AS t2
ON t1.address_id = t2.address_id
WHERE t1.customer_id IS NULL
-- Câu hỏi 7:
/* Danh sách các thành phố và doanh thu tương ừng trên từng thành phố */
SELECT 
public.city.city,
SUM(public.payment.AMOUNT)
FROM public.payment 
JOIN public.customer
ON public.payment.customer_id = public.customer.customer_id
JOIN public.address
ON public.address.address_id = public.customer.address_id
JOIN public.city
ON public.address.city_id = public.city.city_id
GROUP BY public.city.city
ORDER BY SUM(public.payment.AMOUNT) DESC
-- Câu hỏi 8:
SELECT 
concat(city, ', ', country),
SUM(public.payment.AMOUNT)
FROM public.payment 
JOIN public.customer
ON public.payment.customer_id = public.customer.customer_id
JOIN public.address
ON public.address.address_id = public.customer.address_id
JOIN public.city
ON public.address.city_id = public.city.city_id
JOIN public.country
ON public.country.country_id = public.city.country_id
GROUP BY concat(city, ', ', country)
ORDER BY SUM(public.payment.AMOUNT) ASC
