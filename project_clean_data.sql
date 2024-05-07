-- 1) Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER)
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN ordernumber TYPE numeric USING ordernumber::numeric
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN quantityordered TYPE numeric USING quantityordered::numeric
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN priceeach TYPE decimal USING priceeach::decimal
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN orderlinenumber TYPE numeric USING orderlinenumber::numeric
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN sales TYPE decimal USING sales::decimal
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN msrp TYPE numeric USING msrp::numeric
SELECT * FROM public.sales_dataset_rfm_prj

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

ALTER TABLE public.sales_dataset_rfm_prj
ADD COLUMN contactlastname text

