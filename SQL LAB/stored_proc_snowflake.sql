drop database"STORED_PROCEDURE";

CREATE DATABASE snowflake_stored_procedure;

USE snowflake_stored_procedure;

CREATE OR REPLACE PROCEDURE myprocedure()
  RETURNS VARCHAR
  LANGUAGE SQL
  AS
  $$
   
    DECLARE
      radius_of_circle FLOAT;
      area_of_circle FLOAT;
    BEGIN
      radius_of_circle := 3;
      area_of_circle := pi() * radius_of_circle * radius_of_circle;
      RETURN area_of_circle;
    END;
  $$
  ;
  
CALL   myprocedure();

CREATE OR REPLACE PROCEDURE myprocedure_param(radius number(8,3))
  RETURNS VARCHAR
  LANGUAGE SQL
  AS
  $$
   
    DECLARE
      message VARCHAR;
      radius_of_circle FLOAT;
      area_of_circle FLOAT;
    BEGIN
      radius_of_circle := radius ;
      area_of_circle := 3.14 * radius_of_circle * radius_of_circle;
      message := 'Area of circle with ' || radius || ' is ' || area_of_circle;
      RETURN message;
    END;
  $$
  ;
  
CALL  myprocedure_param(3.4);


SHOW PROCEDURES; 

DROP PROCEDURE AVG_BAL_JOBROLE();


