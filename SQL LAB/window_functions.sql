CREATE OR REPLACE TABLE EMPLOYEE
(
   EMPID INTEGER NOT NULL PRIMARY KEY,
   EMP_NAME VARCHAR2(20),
   JOB_ROLE STRING,
   SALARY NUMBER(10,2)
);

INSERT INTO EMPLOYEE
VALUES('101','ANAND JHA','Analyst',50000);

INSERT INTO EMPLOYEE
VALUES('114','AAMIR','Analyst',50000);

INSERT INTO EMPLOYEE
VALUES('114','SAMEER','Analyst',50000);

INSERT INTO EMPLOYEE
VALUES(102,'ALex', 'Data Engineer',60000);

INSERT INTO EMPLOYEE
VALUES(102,'MICHAEL', 'Data Engineer',60000);

INSERT INTO EMPLOYEE
VALUES(103,'Ravi', 'Data Scientist',48000);

INSERT INTO EMPLOYEE
VALUES(103,'KOUSHALYA', 'Data Scientist',48000);

INSERT INTO EMPLOYEE
VALUES(104,'Peter', 'Analyst',98000);

INSERT INTO EMPLOYEE
VALUES(104,'SAM', 'Analyst',45000);

INSERT INTO EMPLOYEE
VALUES(105,'Pulkit', 'Data Scientist',72000);

INSERT INTO EMPLOYEE
VALUES(106,'Robert','Analyst',100000);

INSERT INTO EMPLOYEE
VALUES(107,'Rishabh','Data Engineer',67000);

INSERT INTO EMPLOYEE
VALUES(108,'Subhash','Manager',148000);

INSERT INTO EMPLOYEE
VALUES(109,'Michaeal','Manager',213000);

INSERT INTO EMPLOYEE
VALUES(110,'Dhruv','Data Scientist',89000);

INSERT INTO EMPLOYEE
VALUES(111,'Amit Sharma','Analyst',72000);

select * from employee;

--ROW_NUMBER
select *, 
min(salary) over(partition by JOB_ROLE) as MIN_SAL,
max(salary) over(partition by JOB_ROLE) as MAX_SAL ,
SUM(SALARY) OVER(PARTITION BY JOB_ROLE) AS TOT_SALARY_JOB_WISE,
SUM(SALARY) OVER() AS TOT_SALARY,
ROW_NUMBER() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY DESC) AS SAL_ROW_WITH_PARTITION,
ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS SAL_ROW_WITHOUT_PARTITION,
RANK() OVER(PARTITION BY JOB_ROLE ORDER BY  SALARY DESC) AS SAL_RANK_USING_RANK,
DENSE_RANK() OVER(PARTITION BY JOB_ROLE ORDER BY  SALARY DESC) AS SAL_RANK_USING_DENSE_RANK
FROM employee;

select *,ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS SAL_ROW
FROM employee; -- 1,2,3,4,5,6,7,8..

--RANK()
SELECT * FROM (
select *,RANK() OVER(PARTITION BY JOB_ROLE ORDER BY  SALARY DESC) AS SAL_RANK
FROM employee) AS A 
WHERE A.SAL_RANK <= 5; 

--DENSE_RANK()
select *,DENSE_RANK() OVER(PARTITION BY JOB_ROLE ORDER BY  SALARY DESC) AS SAL_ROW
FROM employee; 

--- display total salary based on job profile
SELECT JOB_ROLE,SUM(SALARY) FROM EMPLOYEE 
GROUP BY JOB_ROLE;

-- display total salary along with all the records ()every row value 
SELECT * , SUM(SALARY) OVER() AS TOT_SALARY
FROM EMPLOYEE;

--display total salary along with all the records DEPARTMENT WISE FOR every row value 
SELECT * , SUM(SALARY) OVER() AS TOT_SALARY
SELECT * , SUM(SALARY) OVER(PARTITION BY JOB_ROLE) AS TOT_SALARY
FROM EMPLOYEE;

-- display the total salary per job category for all the rows 
SELECT *,MAX(SALARY) OVER(PARTITION BY JOB_ROLE) AS MAX_JOB_SAL
FROM EMPLOYEE;

select *,max(salary) over(partition by JOB_ROLE) as MAX_SAL , 
min(salary) over(partition by JOB_ROLE) as MIN_SAL,
SUM(salary) over(partition by JOB_ROLE) as TOT_SAL
from Employee;



--ARRANGING ROWS WITHIN EACH PARTITION BASED ON SALARY IN DESC ORDDER
select *,max(salary) over(partition by JOB_ROLE ORDER BY SALARY DESC) as MAX_SAL , 
min(salary) over(partition by JOB_ROLE ORDER BY SALARY DESC) as MIN_SAL,
SUM(salary) over(partition by JOB_ROLE ORDER BY SALARY DESC) as TOT_SAL
from Employee;

-- ROW_NUMBER() It assigns a unique sequential number to each row of the table ...
SELECT * FROM 
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY DESC) AS PART_ROW_NUM 
FROM EMPLOYEE 
)
WHERE PART_ROW_NUM <=2;

/* The RANK() window function, as the name suggests, ranks the rows within their partition based on the given condition.
   In the case of ROW_NUMBER(), we have a sequential number. 
   On the other hand, in the case of RANK(), we have the same rank for rows with the same value.
But there is a problem here. Although rows with the same value are assigned the same rank, 
the subsequent rank skips the missing rank. 
This wouldn’t give us the desired results if we had to return “top N distinct” values from a table. 
Therefore we have a different function to resolve this issue. */

SELECT *,ROW_NUMBER() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY DESC) AS ROW_NUM ,
RANK() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY DESC) AS RANK_ROW
FROM EMPLOYEE;

/* The DENSE_RANK() function is similar to the RANK() except for one difference, it doesn’t skip any ranks when ranking rows
Here, all the ranks are distinct and sequentially increasing within each partition. 
As compared to the RANK() function, it has not skipped any rank within a partition. */

SELECT * FROM 
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY) AS ROW_NUM ,
RANK() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY) AS RANK_ROW,
DENSE_RANK() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY) AS DENSE_RANK_ROW 
FROM EMPLOYEE  
)
WHERE DENSE_RANK_ROW <=2;


CREATE OR REPLACE TABLE DAILY_SALES
(Product_ID INT,
 Sale_Date DATE,
 Daily_Sales FLOAT);

INSERT INTO DAILY_SALES 
values
(1000,'2000-09-28',48850.40),
(1000,'2000-09-29',54500.22),
(1000,'2000-09-30',36000.07),
(1000,'2000-10-01',40200.43),
(2000,'2000-09-28',41888.88),
(2000,'2000-09-29',48000.00),
(2000,'2000-09-30',49850.03),
(2000,'2000-10-01',54850.29),
(3000,'2000-09-28',61301.77),
(3000,'2000-09-29',34509.13),
(3000,'2000-09-30',43868.86),
(3000,'2000-10-01',28000.00);

select * from daily_sales;

describe table daily_sales;

--SELECT PROD,DATE,SALES, SALE_CHANGE_NEXT_DAY,SALE_CHANGE_SEC_DAY,SALE_CHANGE_THIRD_DAY 
--FROM 
--(
select PRODUCT_ID as PROD , SALE_DATE AS DATE , DAILY_SALES AS SALES,
LEAD(DAILY_SALES,1) IGNORE NULLS OVER(PARTITION BY PRODUCT_ID ORDER BY SALE_DATE) AS NEXT_DAY_SALE,
LEAD(DAILY_SALES,2) IGNORE NULLS OVER(PARTITION BY PRODUCT_ID ORDER BY SALE_DATE) AS SECOND_DAY_SALE,
LEAD(DAILY_SALES,3) IGNORE NULLS OVER(PARTITION BY PRODUCT_ID ORDER BY SALE_DATE) AS THIRD_DAY_SALE,
ROUND((LEAD(DAILY_SALES,1) IGNORE NULLS OVER(PARTITION BY PRODUCT_ID ORDER BY SALE_DATE) - SALES)/SALES * 100,2) AS SALE_CHANGE_NEXT_DAY,
ROUND((SECOND_DAY_SALE - NEXT_DAY_SALE)/NEXT_DAY_SALE * 100,2)AS SALE_CHANGE_SEC_DAY,
ROUND((THIRD_DAY_SALE - SECOND_DAY_SALE)/SECOND_DAY_SALE * 100,2) AS SALE_CHANGE_THIRD_DAY
FROM daily_sales
QUALIFY THIRD_DAY_SALE IS NOT NULL;

--);

select PRODUCT_ID as PROD , SALE_DATE AS DATE , DAILY_SALES AS TODAY_SALES,
LAG(DAILY_SALES,1) IGNORE NULLS OVER(PARTITION BY PRODUCT_ID ORDER BY SALE_DATE) AS PREV_DAY_SALE,
LAG(DAILY_SALES,2) IGNORE NULLS OVER(PARTITION BY PRODUCT_ID ORDER BY SALE_DATE) AS PREV_TO_PREV_DAY_SALE,
LAG(DAILY_SALES,3) IGNORE NULLS OVER(PARTITION BY PRODUCT_ID ORDER BY SALE_DATE) AS BEFORE_TWO_DAYS_SALE,
ROUND((PREV_DAY_SALE- TODAY_SALES)/TODAY_SALES * 100,2) AS SALE_CHANGE_PREV_DAY,
ROUND((PREV_TO_PREV_DAY_SALE - PREV_DAY_SALE)/PREV_DAY_SALE * 100,2)AS SALE_CHANGE_PREV_TO_PREV_DAY,
ROUND((BEFORE_TWO_DAYS_SALE - PREV_TO_PREV_DAY_SALE)/PREV_TO_PREV_DAY_SALE * 100,2) AS SALE_CHANGE_BEFORE_TWO_DAYS
FROM daily_sales
QUALIFY BEFORE_TWO_DAYS_SALE IS NOT NULL AND PREV_DAY_SALE IS NOT NULL;
--LEAD(DAILY_SALES,-1) = LAG(DAILY_SALES,1)


CREATE OR REPLACE TABLE sales(emp_id INTEGER, year INTEGER, revenue DECIMAL(10,2));
INSERT INTO sales VALUES (0, 2010, 1000), (0, 2011, 1500), (0, 2012, 500), (0, 2013, 750);
INSERT INTO sales VALUES (1, 2010, 10000), (1, 2011, 12500), (1, 2012, 15000), (1, 2013, 20000);
INSERT INTO sales VALUES (2, 2012, 500), (2, 2013, 800);

SELECT * FROM SALES;

SELECT emp_id, year, revenue, 
LEAD(revenue) IGNORE NULLS OVER (PARTITION BY emp_id ORDER BY year) AS REVENUE_NEXT,
(REVENUE_NEXT - revenue) AS diff_to_next 
FROM sales 
ORDER BY emp_id, year;

CREATE OR REPLACE TABLE TEST_NULLS (c1 NUMBER, c2 NUMBER);
INSERT INTO TEST_NULLS VALUES (1,5),(2,4),(3,NULL),(4,2),(5,NULL),(6,NULL),(7,6);

SELECT * FROM TEST_NULLS;
SELECT c1, c2, 
LEAD(c2) IGNORE NULLS OVER (ORDER BY c1) AS LEAD_C2_WITHOUT_NULLS
FROM TEST_NULLS;


--FIRST VALEU 
SELECT
        column1,
        column2,
        FIRST_VALUE(column2) OVER (PARTITION BY column1 ORDER BY column2 NULLS LAST) AS column2_first,
        FIRST_VALUE(column2) IGNORE NULLS OVER (PARTITION BY column1 ORDER BY column2 NULLS LAST) AS column2_first_IGNORE_NULLS,
        
        LAST_VALUE(column2) OVER (PARTITION BY column1 ORDER BY column2 NULLS LAST) AS column2_last,
        LAST_VALUE(column2) IGNORE NULLS OVER (PARTITION BY column1 ORDER BY column2 NULLS LAST) AS column2_LAST_IGNORE_NULLS
        
    FROM VALUES
       (1, 10), (1, 11), (1, null), (1, 12),
       (2, 20), (2, 21), (2, 22)
    ORDER BY column1, column2;


SELECT 
customer_id, 
plan_id, 
LAG(plan_id, 1) OVER(
PARTITION BY customer_id 
ORDER BY plan_id) as next_plan
FROM subscriptions
;

CREATE OR REPLACE TABLE example_cumulative (p INT, o INT, i INT);

INSERT INTO example_cumulative VALUES
    (  0, 1, 10), (0, 2, 20), (0, 3, 30),
    (100, 1, 10),(100, 2, 30),(100, 2, 5),(100, 3, 11),(100, 3, 120),
    (200, 1, 10000),(200, 1, 200),(200, 1, 808080),(200, 2, 33333),(200, 3, null), (200, 3, 4),
    (300, 1, null), (300, 1, null);

--Run a query that uses a cumulative window frame and show the output. 
--Return a cumulative count, sum, min, and max, for rows in the specified window for the table:

SELECT
    p, o, i,
    COUNT(i) OVER (PARTITION BY p ORDER BY o ) count_i_Rows_Pre,
    SUM(i)   OVER (PARTITION BY p ORDER BY o ) sum_i_Rows_Pre,
    AVG(i)   OVER (PARTITION BY p ORDER BY o ) avg_i_Rows_Pre,
    MIN(i)   OVER (PARTITION BY p ORDER BY o ) min_i_Rows_Pre,
    MAX(i)   OVER (PARTITION BY p ORDER BY o ) max_i_Rows_Pre
  FROM example_cumulative
  ORDER BY p,o;

SELECT
    p, o, i,
    COUNT(i) OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) count_i_Rows_Pre,
    SUM(i)   OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sum_i_Rows_Pre,
    AVG(i)   OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) avg_i_Rows_Pre,
    MIN(i)   OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) min_i_Rows_Pre,
    MAX(i)   OVER (PARTITION BY p ORDER BY o ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) max_i_Rows_Pre
  FROM example_cumulative
  ORDER BY p,o;











