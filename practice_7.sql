    --EX1: 

SELECT 
EXTRACT(YEAR FROM transaction_date) AS year,
product_id,
spend AS curr_year_spend,
LAG(spend) OVER(PARTITION BY product_id) AS prev_year_spend,
ROUND(
100*
(spend - LAG(spend) OVER(PARTITION BY product_id))
/(LAG(spend) OVER(PARTITION BY product_id)), 2) AS yoy_rate 
FROM user_transactions 
  
    --EX2: 
  
WITH cte_first AS(
SELECT card_name,
FIRST_VALUE(issue_year) OVER(PARTITION BY card_name) AS first_year_isue,
FIRST_VALUE(issue_month)OVER(PARTITION BY card_name) AS first_month_isue
FROM MONTHLY_CARDS_ISSUED
GROUP BY card_name,
issue_year,
issue_month),
cte_sum AS (SELECT issue_month, card_name, SUM(issued_amount) AS sum_amount FROM MONTHLY_CARDS_ISSUED GROUP BY issue_month, card_name)

SELECT 
DISTINCT
MONTHLY_CARDS_ISSUED.card_name,
cte_sum.sum_amount AS issued_amount
FROM MONTHLY_CARDS_ISSUED
JOIN cte_first
ON cte_first.card_name = MONTHLY_CARDS_ISSUED.card_name
JOIN cte_sum
ON cte_sum.card_name = cte_first.card_name
WHERE cte_sum.issue_month = cte_first.first_month_isue
ORDER BY cte_sum.sum_amount DESC

    --EX3: 
  
WITH cte_rank AS(
SELECT *, 
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rank
FROM transactions)

SELECT DISTINCT cte_rank.user_id, 
cte_rank.spend, 
cte_rank.transaction_date
FROM transactions
JOIN cte_rank
ON cte_rank.user_id = transactions.user_id
WHERE cte_rank.rank = 3

    --EX4:
  
WITH cte_count AS (SELECT transaction_date, user_id, COUNT(product_id) AS purchase_count
FROM user_transactions
GROUP BY transaction_date, user_id),
cte_first_value AS (
SELECT DISTINCT user_id, FIRST_VALUE(transaction_date) OVER(PARTITION BY user_id ORDER BY transaction_date DESC) 
AS first_transaction_date FROM user_transactions
)

SELECT DISTINCT cte_first_value.first_transaction_date,
A.user_id,
cte_count.purchase_count
FROM user_transactions AS A
JOIN cte_first_value
ON A.user_id = cte_first_value.user_id
JOIN cte_count
ON A.user_id = cte_count.user_id
WHERE cte_count.transaction_date = cte_first_value.first_transaction_date
ORDER BY cte_first_value.first_transaction_date

--EX5:

WITH cte_lag AS
(SELECT *,
LAG(tweet_count) OVER(PARTITION BY user_id ORDER BY tweet_date) AS lag_1,
LAG(tweet_count, 2) OVER(PARTITION BY user_id ORDER BY tweet_date) AS lag_2
FROM tweets)

SELECT cte_lag.user_id, cte_lag.tweet_date,
CASE 
WHEN lag_1 IS NULL AND lag_2 IS NULL
THEN 1.00*cte_lag.tweet_count
WHEN lag_1 IS NOT NULL AND lag_2 IS NULL
THEN ROUND(CAST((cte_lag.tweet_count + lag_1) AS DECIMAL)/2, 2)
ELSE ROUND(CAST((cte_lag.tweet_count + lag_1 + lag_2) AS DECIMAL)/3, 2)
END  rolling_avg_3d
FROM cte_lag   
    
--EX6:
    
WITH cte_lead AS (SELECT *,
EXTRACT(HOUR FROM transaction_timestamp) * 24 + EXTRACT(MINUTE FROM transaction_timestamp) AS minute_total,
LEAD(EXTRACT(HOUR FROM transaction_timestamp) * 24 + EXTRACT(MINUTE FROM transaction_timestamp)) 
OVER(PARTITION BY merchant_id, credit_card_id),
LEAD(EXTRACT(HOUR FROM transaction_timestamp) * 24 + EXTRACT(MINUTE FROM transaction_timestamp)) 
OVER(PARTITION BY merchant_id, credit_card_id) - 
EXTRACT(HOUR FROM transaction_timestamp) * 24 + EXTRACT(MINUTE FROM transaction_timestamp) AS difference_time
FROM transactions)

SELECT
COUNT(transaction_id) AS payment_count
FROM cte_lead
WHERE difference_time <=10
    
--EX7:
  
  -- CÁCH 1:
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
  -- CÁCH 2

--EX8: 
  
WITH cte_count_top10 AS(
SELECT A.artist_name AS artist_name,
COUNT(B.song_id) AS count_songs
FROM artists AS A  
JOIN songs AS B  
ON A.artist_id = B.artist_id
JOIN global_song_rank AS C 
ON B.song_id = C.song_id
WHERE C.rank <=10
GROUP BY A.artist_name
ORDER BY count_songs),

cte_dense_rank AS(
SELECT cte_count_top10.artist_name,
DENSE_RANK() OVER(ORDER BY cte_count_top10.count_songs DESC) AS rank_artist
FROM artists
JOIN cte_count_top10
ON cte_count_top10.artist_name = artists.artist_name)

SELECT artists.artist_name, cte_dense_rank.rank_artist AS artist_rank
FROM artists
JOIN cte_dense_rank
ON cte_dense_rank.artist_name = artists.artist_name
WHERE cte_dense_rank.rank_artist <= 5
ORDER BY cte_dense_rank.rank_artist, artist_name







