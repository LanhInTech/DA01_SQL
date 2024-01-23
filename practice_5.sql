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

--ex5:

--ex6:

--ex7:

