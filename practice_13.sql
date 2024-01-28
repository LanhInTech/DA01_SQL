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

/* EX3: */
  
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
