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
select name from Customer
where referee_id <> 2 OR referee_id IS NULL
--ex11:
SELECT NAME, POPULATION, AREA
FROM WORLD
WHERE AREA = 3000000 OR  population >= 25000000
--ex12:
SELECT DISTINCT AUTHOR_ID AS id FROM Views
WHERE viewer_id >=1 AND VIEWER_ID = AUTHOR_ID
ORDER BY AUTHOR_ID ASC
--ex13:
SELECT part, assembly_step FROM parts_assembly
where finish_date is NULL;
--ex14:
SELECT * FROM lyft_drivers
WHERE yearly_salary <= 30000 OR yearly_salary >= 70000;
--ex15:
select advertising_channel from uber_advertising
WHERE money_spent > 100000 AND year = 2019;
