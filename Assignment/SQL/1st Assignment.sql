USE DEMODATABASE;

CREATE or replace TABLE sales_data_final_1
(
order_id STRING,
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(100),
customer_name VARCHAR(100),
segment VARCHAR(100),
state VARCHAR(100),
country VARCHAR(100),
market VARCHAR(100),
region VARCHAR(100),
product_id VARCHAR(100),
category VARCHAR(100),
sub_category VARCHAR(100),
product_name VARCHAR(200),
sales VARCHAR(50),
quantity VARCHAR(100),
discount STRING,
profit VARCHAR(50),
shipping_cost VARCHAR(50),
order_priority VARCHAR(100),
year STRING
);

SELECT * FROM sales_data_final_1

DROP TABLE sales_data_final_1

CREATE TABLE sales_data_final_1_copy AS
SELECT * FROM sales_data_final_1;


SELECT * FROM sales_data_final_1_copy;



---- 1.  SET PRIMARY KEY.


ALTER TABLE sales_data_final_1_copy
ADD PRIMARY KEY (order_id);

select * from sales_data_final_1_copy;


---2. CHECK THE ORDER DATE AND SHIP DATE TYPE AND THINK IN WHICH DATA TYPE YOU HAVE TO CHANGE.

---Already updated in Excel before loading the file.



---3. EXTACT THE LAST NUMBER AFTER THE - AND CREATE OTHER COLUMN AND UPDATE IT.



ALTER TABLE sales_data_final_1_copy
ADD COLUMN order_extract number (10);

update sales_data_final_1_copy
set  order_extract=split_part(order_id,'-',1);

select * from sales_data_final_1_copy;


---- 4.  FLAG ,IF DISCOUNT IS GREATER THEN 0 THEN  YES ELSE FALSE AND PUT IT IN NEW COLUMN FRO EVERY ORDER ID.



SELECT *,
CASE
       WHEN TRY_CAST (discount AS DECIMAL) > 0 THEN 'yes'
       ELSE 'FALSE'
       END AS FRO
    FROM sales_data_final_1_copy;

SELECT DISTINCT ORDER_ID FROM sales_data_final_1_copy;



---5.  FIND OUT THE FINAL PROFIT AND PUT IT IN COLUMN FOR EVERY ORDER ID.

---Already done in the table.



-- 6.  FIND OUT HOW MUCH DAYS TAKEN FOR EACH ORDER TO PROCESS FOR THE SHIPMENT FOR EVERY ORDER ID.



ALTER TABLE sales_data_final_1_copy
ADD COLUMN PROCESS_DAYS number (10);

UPDATE sales_data_final_1_copy
SET  PROCESS_DAYS = DATEDIFF('DAY',order_date,ship_date);

select * from sales_data_final_1_copy;



----7 . FLAG THE PROCESS DAY AS BY RATING IF IT TAKES LESS OR EQUAL 3  DAYS MAKE 5,LESS OR EQUAL THAN 6 DAYS BUT MORE THAN 3 MAKE 4,LESS THAN 10 BUT MORE THAN 6 MAKE 3,MORE THAN 10 MAKE IT 2 FOR EVERY ORDER ID.


SELECT *,
CASE
        WHEN PROCESS_DAYS BETWEEN 0 AND 3 THEN '5'
        WHEN PROCESS_DAYS BETWEEN 4 AND 6 THEN '4'
        WHEN PROCESS_DAYS BETWEEN 7 AND 10 THEN '3'
        ELSE '2'
        END AS RATTING
  FROM sales_data_final_1_copy;

select * from sales_data_final_1_copy;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
        

