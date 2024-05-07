-- 1) Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER)
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN ordernumber TYPE numeric USING ordernumber::numeric;
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN quantityordered TYPE numeric USING quantityordered::numeric;
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN priceeach TYPE decimal USING priceeach::decimal;
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderlinenumber TYPE numeric USING orderlinenumber::numeric;
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN sales TYPE decimal USING sales::decimal;
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderdate TYPE date USING orderdate::date;
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN msrp TYPE numeric USING msrp::numeric;

SELECT * FROM public.sales_dataset_rfm_prj;

-- 2) Check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
SELECT * FROM public.sales_dataset_rfm_prj
WHERE ORDERNUMBER IS NULL
  OR QUANTITYORDERED IS NULL 
  OR PRICEEACH IS NULL 
  OR ORDERLINENUMBER IS NULL 
  OR SALES IS NULL 
  OR ORDERDATE IS NULL;

-- 3) Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME. 
Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường.
SELECT * FROM public.sales_dataset_rfm_prj;

ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN contactlastname text;
UPDATE public.sales_dataset_rfm_prj SET contactlastname = 
SUBSTRING(contactfullname FROM 1 FOR (POSITION('-' IN contactfullname) - 1));
UPDATE public.sales_dataset_rfm_prj SET contactlastname = LOWER(contactlastname);
UPDATE public.sales_dataset_rfm_prj SET contactlastname = INITCAP(contactlastname)

ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN CONTACTFIRSTNAME text;
UPDATE public.sales_dataset_rfm_prj SET CONTACTFIRSTNAME = 
SUBSTRING(contactfullname FROM (POSITION('-' IN contactfullname) + 1));
UPDATE public.sales_dataset_rfm_prj SET contactfirstname = LOWER(contactfirstname);
UPDATE public.sales_dataset_rfm_prj SET contactfirstname = INITCAP(contactfirstname);

--4) Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 
ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN QTR_ID numeric; 
ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN MONTH_ID numeric;
ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN YEAR_ID numeric;

UPDATE public.sales_dataset_rfm_prj SET month_id = EXTRACT(month FROM orderdate);
UPDATE public.sales_dataset_rfm_prj SET qtr_id = EXTRACT(QUARTER FROM orderdate);
UPDATE public.sales_dataset_rfm_prj SET year_id = EXTRACT(year FROM orderdate);

--5) Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách)
WITH twt_count as(
SELECT 
*, (q1 - 1.5*IQR) min_value, (q3 + 1.5*IQR) max_value
FROM
(
SELECT PERCENTILE_CONT(0.25)
WITHIN GROUP (ORDER BY quantityordered) q1, 
PERCENTILE_CONT(0.75)
WITHIN GROUP (ORDER BY quantityordered) q3,
(PERCENTILE_CONT(0.75)
WITHIN GROUP (ORDER BY quantityordered) 
- 
PERCENTILE_CONT(0.25)
WITHIN GROUP (ORDER BY quantityordered)) IQR
FROM public.sales_dataset_rfm_prj) AS a_table)

SELECT * FROM public.sales_dataset_rfm_prj
WHERE quantityordered < (SELECT min_value FROM twt_count) 
OR quantityordered > (SELECT max_value FROM twt_count)




