USE DATABASE DEMODATABASE;


CREATE OR REPLACE TABLE Meals
(MealName VARCHAR(100));

CREATE OR REPLACE TABLE Drinks
(DrinkName VARCHAR(100));

INSERT INTO Drinks
VALUES('Orange Juice'), ('Tea'), ('Cofee'),('Beer');

INSERT INTO Meals
VALUES('Omlet'), ('Fried Egg'), ('Sausage');

SELECT * FROM Meals;
SELECT * FROM Drinks;

--FOLLOW THIS APPROACH
SELECT *,MEALNAME || DRINKNAME AS BREAK_COMBO FROM Meals 
CROSS JOIN Drinks
ORDER BY MealName;


SELECT *,MEALNAME || DRINKNAME AS BREAK_COMBO 
FROM Meals,Drinks
ORDER BY MealName;

SELECT *,CONCAT_WS('-',MealName,DrinkName) AS MenuList
FROM Meals CROSS JOIN Drinks;

