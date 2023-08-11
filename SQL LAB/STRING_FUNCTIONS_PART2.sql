USE DATABASE DEMO_DATABASE;

CREATE OR REPLACE TABLE AGENTS
   (	
     AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY, 
	 AGENT_NAME CHAR(40) , 
	 WORKING_AREA CHAR(35), 
	 COMMISSION NUMBER(10,2) DEFAULT 0.05, 
	 PHONE_NO CHAR(15), 
	 COUNTRY VARCHAR2(25) 
	 );

INSERT INTO AGENTS VALUES ('A007', 'Ramasundar', 'Bangalore',0.15,'077-25814763', '');
INSERT INTO AGENTS(AGENT_CODE,AGENT_NAME,WORKING_AREA) 
VALUES ('A110', 'Anand', 'Germany');


INSERT INTO AGENTS VALUES ('A003', 'Alex ', 'London', '0.13', '075-12458969', '');
INSERT INTO AGENTS VALUES ('A008', 'Alford', 'New York', '0.12', '044-25874365', '');
INSERT INTO AGENTS VALUES ('A011', 'Ravi Kumar', 'Bangalore', '0.15', '077-45625874', '');
INSERT INTO AGENTS VALUES ('A010', 'Santakumar', 'Chennai', '0.14', '007-22388644', '');
INSERT INTO AGENTS VALUES ('A012', 'Lucida', 'San Jose', '0.12', '044-52981425', '');
INSERT INTO AGENTS VALUES ('A005', 'Anderson', 'Brisban', '0.13', '045-21447739', '');
INSERT INTO AGENTS VALUES ('A001', 'Subbarao', 'Bangalore', '0.14', '077-12346674', '');
INSERT INTO AGENTS VALUES ('A002', 'Mukesh', 'Mumbai', '0.11', '029-12358964', '');
INSERT INTO AGENTS VALUES ('A006', 'McDen', 'London', '0.15', '078-22255588', '');
INSERT INTO AGENTS VALUES ('A004', 'Ivan', 'Torento', '0.15', '008-22544166', '');
INSERT INTO AGENTS VALUES ('A009', 'Benjamin', 'Hampshair', '0.11', '008-22536178', '');

SELECT * FROM AGENTS;

--SET THE COUNTRY TO 'IN' WHEREEVER COUNTRY IS NULL OR BLANK IS NULL
UPDATE AGENTS 
SET COUNTRY = 'IN' WHERE COUNTRY IN (NULL,'');

SELECT * FROM AJ_CONSUMER

/* The SUBSTRING () function returns the position of a string or binary value from the complete string, 
starting with the character specified by substring_start_index. If any input is null, null is returned */

--Example 1: Get the substring from a specific string in Snowflake
select substring('ANAND KUMAR JHA', 1, 9) AS PARTIAL_NAME;
select substring('ANAND KUMAR JHA', 0, 9) AS PARTIAL_NAME;
select substring('ANAND KUMAR JHA', 4, 7);

--TO RETURNS THE LENGTH OF THE STRING INCLUDING SPACE
SELECT LEN('      ANAND KUMAR JHA          ') AS MY_NAME_LENGTH;

select substring('Anand Kumar Jha', 3,3) As Sbstring;

-- AKASH
-- sir if I want only A from anand and K FROM KUMAR SO IN THIS CASE WHAT SHOULD I DO

select substr('Anand Kumar Jha',1,1)||substr('Anand Kumar Jha',7,1) as initial;

select concat(substring('ANAND KUMAR JHA',1,1),substring('ANAND KUMAR JHA',7,1),substring('ANAND KUMAR JHA',13,1)) AS partial_name;

select concat('Anand',' India',' Great');
select 'anand' || ' kumar' || ' jha' as full_name;

select AGENT_CODE || ' ' || AGENT_NAME as AGENT_DETAILS 
FROM AGENTS;

select PHONE_NO || ' ' || COUNTRY as DETAILS 
FROM AGENTS;


select substr('Raja Ram',0,3);
select substr('Raja Ram',3);

select substring('ANAND KUMAR JHA',-7,6); -- START FROM INDEX -7 AND GIVE NEXT 3 CHARACTERS FROM THAT INDEX
select substring('ANAND KUMAR JHA',-7,-4); -- NO OUTPUT
select substring('ANAND KUMAR JHA',NULL); 
---sajkdsdjfsfbffbkjtqjUK

--Example 2: Get the substring from a specific string by using table data
select AGENT_CODE,AGENT_NAME,substring(AGENT_CODE,-3,3) AS AGENT_INITIALS from agents;
select AGENT_CODE,AGENT_NAME,substring(AGENT_CODE,2,5) AS AGENT_INITIALS from agents;

select substring('ruhee k qureshi',1,1), substring('ruhee k qureshi',7,1) ,substring('ruhee k qureshi',9,1) as initial;

SELECT * FROM AGENTS;

SELECT * FROM "DEMO_DATABASE"."PUBLIC"."AJ_CONSUMER_COMPLAINTS";

--TAKE THIS AS A HINT
CREATE OR REPLACE VIEW AJ_CONSUMER_COMPLAINTS_VIEW AS
SELECT *,CONCAT(ZIP_CODE,PRODUCT_NAME) AS PROD_CODE_DETAILS
FROM "DEMO_DATABASE"."PUBLIC"."AJ_CONSUMER_COMPLAINTS"
WHERE COL_NAME IS NOT NULL;

DESCRIBE VIEW AJ_CONSUMER_COMPLAINTS_VIEW;

SELECT * FROM AJ_CONSUMER_COMPLAINTS_VIEW;

create or replace VIEW CUSTOM_CONSUMER_COMPLAINTS_VIEW AS 
SELECT *, CONCAT(STATE_NAME,'-',ZIP_CODE) AS STATE_ZIP_DETAILS
FROM AJ_CONSUMER_COMPLAINTS
WHERE SUB_ISSUE IS NOT NULL AND CONSUMER_COMPLAINT_NARRATIVE IS NOT NULL
AND SUB_PRODUCT IS NOT NULL
AND COMPANY_PUBLIC_RESPONSE IS NOT NULL;

SELECT * FROM CUSTOM_CONSUMER_COMPLAINTS_VIEW;



/* To get a specific substring from an expression or string. 
You can also use the substring function if you want to get the substrings in reverse order from the strings. */

-- If you use the substrings in reverse order, use the starting index as a negative value.
select AGENT_CODE,AGENT_NAME,substring(AGENT_NAME,-3,3) AS NAME_BACKWARDS from agents;

/*
Snowflake CAST is a data-type conversion command. 
Snowflake CAST works similar to the TO_ datatype conversion functions. 
If a particular data type conversion is not possible,
it raises an error. Let’s understand the Snowflake CAST in detail via the syntax and a few examples.
*/

select cast('1.6845' as decimal(4,3));
select '1.6845'::decimal(2,1);

select cast('10-Sep-2021' as timestamp);

-- When the provided precision is insufficient 
-- to hold the input value, the Snowflake CAST command raises an error as follows:
select cast('123.12' as number(4,2));
--Here, precision is set as 4 but the input value has a total of 5 digits, thereby raising the error.
select cast('123.12' as number(4,1));

--TRY_CAST( <source_string_expr> AS <target_data_type> )
select try_cast('05-Mar-2016' as timestamp);

--The Snowflake TRY_CAST command returns NULL as the input value 
--has more characters than the provided precision in the target data type.
select try_cast('ANAND' as char(4));

---select cast ('27-09-2012' as timestamp) why is it not taking

select TRY_cast('23-09-1990' as timestamp);
select TRY_cast('1990-09-23' as timestamp);


--trim function
select trim('❄-❄ABC-❄-', '❄-') as trimmed_string;
select trim('❄-❄ABC-❄-', '❄') as trimmed_string;
select trim('❄-❄ABC-❄-', '-') as trimmed_string;
SELECT TRIM('********T E S T I N G 1 2 3 4********','*') AS TRIMMED_SPACE;
SELECT TRIM('********T E S T I*N*G 1 2 3 4********','*') AS TRIMMED_SPACE;

--ltrim
select ltrim('#000000123', '0#');
select ltrim('#0000AISHWARYA', '0#');
select ltrim('      ANAND JHA', '');

--RTRIM
select rtrim('$125.00', '0.');
select rtrim('ANAND JHA*****', '*');

--To remove the white spaces or the blank spaces from the string TRIM function can be used. 
--It can remove the whitespaces from the start and end both.
select TRIM('  Snwoflake Space Remove  ', ' ');

--To remove the first character from the string you can pass the string in the RTRIM function.
select LTRIM('Snowflake Remove  ', 'S'); --EXCEL U WILL FIND LEFT
--To remove the last character from the string you can pass the string in the RTRIM function.
select RTRIM('Snwoflake Remove  ', 'e'); --IN EXCEL U WILL FIND RIGHT

select BTRIM('  Snwoflake Space Remove  ', ' '); -- THERE IS NOTHING CALLED BTGRIM

--LENGTH FUNCTION
SELECT LEN(trim('  Snowflake Space Remove  ')) as length_EXCUDING_SPACE_string;
SELECT LENGTH(trim('  Snowflake Space Remove  ')) as length_string;

--concat
select * from agents;

SELECT CONCAT('KA', '-', 'India') as state_country;

SELECT *,concat('*',AGENT_CODE, '-', AGENT_NAME,'*') AS agent_details from agents;

--Snowflake CONCAT_WS Function
/* The concat_ws function concatenates two or more strings, or concatenates two or more binary values 
and adds separator between those strings.
The CONCAT_WS operator requires at least two arguments, and uses the first argument to separate all following arguments

Following is the concat_ws function syntax
CONCAT_WS( <separator> , <expression1> [ , <expressionN> ... ] ) */

SELECT CONCAT_WS('-', 'KA','India') as state_country;

/*
Snowflake Concat Operator (||)
The concatenation operator concatenates two strings on either side of the || symbol and returns the concatenated string. 
The || operator provides alternative syntax for CONCAT and requires at least two arguments.

For example,
*/
select 'Nested' || ' CONCAT' || ' example!' as Concat_operator;


--Handling NULL Values in CONCAT function and the Concatenation operator
--For both the CONCAT function and the concatenation operator,
--if one or both strings are null, the result of the concatenation is null.
--For example,

select concat('Bangalore, ', NULL) as null_example;
select 'Bangalore, '|| NULL as null_example;

--how to handle it?
select concat('Bangalore ', NVL(NULL,'')) as null_example;
select 'Bangalore'|| NVL(NULL, '') as null_example;

-- REVERSE IN STRING
select reverse('India is My Country');

-- SPLIT
select split('127.0.0.1', '.');
SELECT SPLIT('ANAND-KUMAR-JHA',' ');
SELECT SPLIT('ANAND-KUMAR-JHA','-');
select split('|a||', '|');

create or replace table aj_persons
(
   NAME CHAR(10),
   CHILDREN VARCHAR(30)
);

INSERT INTO AJ_PERSONS
VALUES('Mark','Marky,Mark Jr,Maria'),('John','Johnny,Jane');

select * from AJ_persons;

SELECT SPLIT(CHILDREN,',') FROM AJ_persons;

select name, anand.value::string as childname
from AJ_persons,
     lateral flatten(input=>split(children, ',')) anand;






select  split_part('11.22.33', '.', 1) as first_part , 
        split_part('11.22.33', '.', 2) as sec_part;

select split_part('aaa--bbb-BBB--ccc', '--',1);
select split_part('aaa--bbb-BBB--ccc', '--',2);
select split_part('aaa--bbb-BBB--ccc', '--',3);
select split_part('aaa--bbb-BBB--ccc', '--',4);

SELECT split(AGENT_DETAILS, '-')
FROM (
SELECT *,concat(AGENT_CODE, '-', AGENT_NAME) AS agent_details 
  from agents );
  

SELECT lower('India Is My Country') as lwr_strng;
SELECT UPPER('India Is My Country') as upr_strng;


select UPPER(CONCAT(substring('ruhee k qureshi',1,1), 
                    substring('ruhee k qureshi',7,1) ,
                    substring('ruhee k qureshi',9,1))) as initial;

SELECT INITCAP('india is my country') as init_cap_sent;
/*
delimiters specified as an empty string (i.e. '') instructs INITCAP to ignore all delimiters, 
including whitespace characters, in the input expression (i.e. the input expression is treated as a single, continuous word). 
The resulting output is a string with the 
first character capitalized (if the first character is a letter) and all other letters in lowercase.
*/
select initcap('this is the new Frame+work');
select initcap('this is the new Framework','');
select initcap('iqamqinterestedqinqthisqtopic','q');
select initcap('lion☂fRog potato⨊cLoUD', '⨊☂');





--REPLACE COMMAND
-- REPLACE( <subject> , <pattern> [ , <replacement> ] )

select REPLACE( '   ANAND KUMAR JHA   ' ,' ','*');
select REPLACE( '   ANAND KUMAR JHA   ' ,' '); -- 

SELECT REPLACE('   T  E S T I N G 1 2 3 4   ',' ');

select replace('abcd', 'bc') as replaced_nothing_just_remove;

create or replace table replace_example
(subject varchar(10), 
 pattern varchar(10), 
 replacement varchar(10));
 
insert into replace_example 
values('snowman', 'snow', 'fire'), 
('sad face', 'sad', 'happy');

select * from replace_example;

select subject, pattern, replacement, 
       replace(subject, pattern, replacement) as new 
       from replace_example;

select * from AJ_CONSUMER_COMPLAINTS WHERE STARTSWITH(PRODUCT_NAME,'Bank');
select * from AJ_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME LIKE '%Bank';
select * from AJ_CONSUMER_COMPLAINTS where contains(PRODUCT_NAME, 'Bank');
select * from AJ_CONSUMER_COMPLAINTS where endswith(PRODUCT_NAME , 'Loan');


select right('ABCDEFG', 2);

select LEFT('ABCDEFG', 4);

SELECT RIGHT('ASJHKVASFJFSACNKLSAHFL2378475723595469HERLLOUS',2) AS COUNTRY_CODE;

SELECT LOWER(CONCAT(AGENT_NAME, ' ', country)) AS NAME_COUNTRY,
       INITCAP(NAME_COUNTRY) AS_INITCAP_EX,
       UPPER(RIGHT(NAME_COUNTRY,2)) AS RIGHT_Country
FROM AGENTS;

select nvl(null, 'bard') as col1, 
       nvl(null, 0) as col2;

select column1, column2, column3, 
coalesce(column1, column2, column3) as extracted_values
from 
(values
  ('anand', 'kumar'   ,   null  ),
  (null, null, 'singh' )
) v;

SELECT COALESCE(1,'ANAND','KUMAR') AS NAME;

SELECT COALESCE('VIJAY', 1,'ANAND','KUMAR') AS NAME;

SELECT * FROM AGENTS;

SELECT COALESCE(AGENT_CODE, CAST(COMMISSION AS VARCHAR)) AS NEW_DATA FROM AGENTS;



















