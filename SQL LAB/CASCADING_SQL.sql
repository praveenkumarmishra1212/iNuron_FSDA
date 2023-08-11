DROP DATABASE IF EXISTS CASCADING;

CREATE DATABASE CASCADING;
USE CASCADING;	

drop table Employee;
drop table Payment;

CREATE TABLE Employee 
(
emp_id int(10) NOT NULL,
name varchar(40) NOT NULL,
birthdate date NOT NULL,
gender varchar(10) NOT NULL,
hire_date date NOT NULL,
PRIMARY KEY (emp_id)
);

INSERT INTO Employee (emp_id, name, birthdate, gender, hire_date) 
VALUES
(101, 'Bryan', '1988-08-12', 'M', '2015-08-26'),
(102, 'Joseph', '1978-05-12', 'M', '2014-10-21'),
(103, 'Mike', '1984-10-13', 'M', '2017-10-28'),
(104, 'Daren', '1979-04-11', 'M', '2006-11-01'),
(105, 'Marie', '1990-02-11', 'F', '2018-10-12');

SELECT * FROM Employee;

CREATE TABLE Payment 
(
payment_id int(10) PRIMARY KEY NOT NULL,
emp_id int(10) NOT NULL,
amount float NOT NULL,
payment_date date NOT NULL,
FOREIGN KEY (emp_id) REFERENCES Employee (emp_id) ON DELETE CASCADE ON UPDATE CASCADE
-- ask this before implementing
);


INSERT INTO Payment (payment_id, emp_id, amount, payment_date) 
VALUES
(301, 101, 1200, '2015-09-15'),
(302, 101, 1200, '2015-09-30'),
(303, 101, 1500, '2015-10-15'),
(304, 101, 1500, '2015-10-30'),
(305, 102, 1800, '2015-09-15'),
(306, 102, 1800, '2015-09-30');

SELECT * FROM Payment;

-- master_table
DROP TABLE AJ_MASTERTABLE_CASCADE;
CREATE TABLE IF NOT EXISTS AJ_MASTERTABLE_CASCADE AS 
SELECT E.emp_id,E.name,E.birthdate, E.gender, E.hire_date, P.payment_id,  P.payment_date, P.amount
FROM Employee AS E
LEFT OUTER JOIN Payment AS P ON E.emp_id = P.emp_id;

SELECT * FROM AJ_MASTERTABLE_CASCADE;

-- DELETING RECORDING FROM PARENT TABLE 
DELETE FROM Employee WHERE emp_id = 102;

select * from Employee;
select * from Payment;

UPDATE Employee SET emp_id = 109 WHERE emp_id = 101;

DELETE FROM Payment WHERE emp_id = 101;

USE CASCADING;
USE information_schema;

SELECT table_name FROM referential_constraints
WHERE constraint_schema = 'CASCADING'
AND referenced_table_name = 'Employee'
AND delete_rule = 'CASCADE';

ALTER TABLE Payment ADD CONSTRAINT `payment_fk`
FOREIGN KEY(emp_id) REFERENCES Employee (emp_id) ON UPDATE CASCADE;

describe table Payment;


