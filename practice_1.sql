--ex1:
SELECT NAME FROM CITY
WHERE POPULATION > 120000
AND COUNTRYCODE = 'USA';
--ex2:
SELECT * FROM CITY
WHERE COUNTRYCODE = 'JPN';
--ex3:
SELECT CITY, STATE FROM STATION;
--ex4:
SELECT CITY FROM STATION
WHERE CITY LIKE 'A%' 
OR CITY LIKE 'E%' 
OR CITY LIKE 'I%'
OR CITY LIKE 'O%'
OR CITY LIKE 'U%';
--ex5:
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE '%a' 
OR CITY LIKE '%e' 
OR CITY LIKE '%i'
OR CITY LIKE '%o'
OR CITY LIKE '%u';
--ex6:
SELECT distinct CITY FROM STATION
WHERE not (CITY LIKE 'A%' 
OR CITY LIKE 'E%' 
OR CITY LIKE 'I%'
OR CITY LIKE 'O%'
OR CITY LIKE 'U%');
--ex7:
select name from employee
order by name asc
--ex8:
select name from employee
where (salary > 2000 and months <10)
order by employee_id asc
--ex9:
select product_id from Products
where low_fats = 'Y' and recyclable = 'Y'
--ex10:
--ex11:
--ex12:
--ex13:
--ex14:
--ex15:
