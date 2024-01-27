-- CORELLATED SUBQUERIES IN SELECT
-- Mã khách hàng, tên khách hàng, mã thanh toán, số tiền lớn nhất của từng khách hàng

SELECT 
  a.customer_id,
  a.first_name || a.lastname,
  b.payment_id,
-- Đưa ra giá trị lớn nhất của tất cả các đơn hàng theo cùng 1 customer_id
  (SELECT MAX(amount) FROM payment WHERE customer_id = a.customer_id GROUP BY customer_id)
FROM customer AS a
JOIN payment AS b
ON a.customer_id = b.customer_id
GROUP BY 
a.customer_id,
a.first_name || a.lastname,
b.payment_id
ORDER BY customer_id
  
-- Challenge: Tổng tiền và tổng số hóa đơn cho 1 khách hàng
  
SELECT 
a.payment_id,
a.staff_id,
a.rental_id,
a.amount,
(SELECT SUM(amount) FROM payment AS b
 WHERE b.customer_id = a.customer_id
 GROUP BY customer_id) AS count_payment,
payment_date,
(SELECT COUNT(payment_id) FROM payment AS b
 WHERE b.customer_id = a.customer_id
 GROUP BY customer_id) AS count_payment
FROM payment AS a

-- Challenge: 
SELECT 
a.film_id,
a.title,
a.rating,
(SELECT MAX(replacement_cost) FROM film AS b
 WHERE b.rating = a.rating
 GROUP BY a.rating) AS replacement_cost_max,
 (SELECT AVG(replacement_cost) FROM film AS b
 WHERE b.rating = a.rating
 GROUP BY a.rating) AS avg_replacement_cost
FROM film AS a
ORDER BY rating


