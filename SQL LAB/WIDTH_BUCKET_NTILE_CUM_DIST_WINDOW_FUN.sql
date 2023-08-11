USE DATABASE DEMODATABASE;

DROP TABLE TOP_SCORERS;
--another way to insert data
CREATE OR REPLACE TABLE TOP_SCORERS AS
SELECT
  'James Harden' AS player,
  2335 AS points,
  2020 AS season
UNION ALL
(SELECT
  'Damian Lillard' AS player,
  1978 AS points,
  2020 AS season)
UNION ALL
(SELECT
  'Devin Booker' AS player,
  1863 AS points,
  2020 AS season)
UNION ALL
(SELECT
  'James Harden' AS player,
  2818 AS points,
  2019 AS season)
UNION ALL
(SELECT
  'Paul George' AS player,
  1978 AS points,
  2019 AS season)
UNION ALL
(SELECT
  'Kemba Walker' AS player,
  2102 AS points,
  2019 AS season)
UNION ALL
(SELECT
  'Damian Lillard' AS player,
  2067 AS points,
  2019 AS season)
UNION ALL

( SELECT 
 'Richard Bartner' AS player,
  2067 AS points,
  2019 AS season)
UNION ALL
(SELECT
  'Devin Booker' AS player,
  1700 AS points,
  2019 AS season)
UNION ALL
(SELECT
  'Paul George' AS player,
  1033 AS points,
  2020 AS season)
UNION ALL
(SELECT
  'Kemba Walker' AS player,
  1145 AS points,
  2020 AS season)
 UNION ALL
(SELECT
  'Adam Gilchrist' AS player,
  1145 AS points,
  2020 AS season);
  
 SELECT * FROM TOP_SCORERS;
  
 DESCRIBE TABLE TOP_SCORERS;
 
 
 ---YEAR-OVER-YEAR CHANGE
 SELECT DISTINCT
  player,
  FIRST_VALUE(POINTS) OVER (PARTITION BY PLAYER ORDER BY SEASON ) AS first_season,
  LAST_VALUE(POINTS) OVER (PARTITION BY PLAYER ORDER BY SEASON ) AS last_season,
  ((last_season - first_season) / first_season) * 100 AS PER_CHANGE
  --(100 * ((LAST_VALUE(points) OVER (PARTITION BY player ORDER BY season ASC) - FIRST_VALUE(points) OVER (PARTITION BY player ORDER BY season ASC)) / FIRST_VALUE(points) OVER (PARTITION BY player ORDER BY season ASC))) AS per_change  
FROM
  TOP_SCORERS
ORDER BY 1;

SELECT DISTINCT
  player,
  FIRST_VALUE(POINTS) OVER (PARTITION BY PLAYER ORDER BY SEASON ) AS first_season,
  LAST_VALUE(POINTS) OVER (PARTITION BY PLAYER ORDER BY SEASON ) AS last_season
FROM TOP_SCORERS
ORDER BY 1;

--We used FIRST_VALUE and LAST_VALUE to find the scores for each player in the 
--earliest and most recent seasons of data. 

-- Then we computed the percent difference using:

-- 100 * ((new value - old value) / old value) per_difference

--- How to get top 3 results for each group?
SELECT
  *
FROM
  (
    SELECT
      season,
      DENSE_RANK() OVER (PARTITION BY season ORDER BY points DESC) AS points_rank,
      player,
      points
    FROM
      TOP_SCORERS
  ) 
WHERE
  (points_rank <= 3);

-- In this example, we used RANK to rank each player by points over each season. 
-- Then we used a subquery to then return only the top 3 ranked players for each season.

-- How to find a running total?
select
  season,
  player,
  points,
  --SUM( <expr1> ) OVER ( [ PARTITION BY <expr2> ] [ ORDER BY <expr3> [ ASC | DESC ] [ <window_frame> ] ] )
  SUM(top_scorers.points) OVER (PARTITION BY player ORDER BY season ASC) AS running_total_points
FROM
  TOP_SCORERS
ORDER BY PLAYER ASC, SEASON ASC;

--To find the running total simply use SUM with an OVER clause where you specify your groupings (PARTITION BY), 
-- and the order in which to add them (ORDER BY).

SELECT * FROM TOP_SCORERS;

--NTILE
SELECT player, season,points,
  NTILE(2) OVER (PARTITION BY player ORDER BY season ASC)  AS NTILE_3
FROM TOP_SCORERS
ORDER BY player, NTILE_3;


-- percent rank
SELECT player, season,points,
  PERCENT_RANK() OVER (PARTITION BY player ORDER BY points ASC) AS percent_rank
FROM TOP_SCORERS
ORDER BY player, percent_rank;

---width bucket
CREATE TABLE home_sales (
    sale_date DATE,
    price NUMBER(11, 2)
    );
INSERT INTO home_sales (sale_date, price) VALUES 
    ('2013-08-01'::DATE, 290000.00),
    ('2014-02-01'::DATE, 320000.00),
    ('2015-04-01'::DATE, 399999.99),
    ('2016-04-01'::DATE, 400000.00),
    ('2017-04-01'::DATE, 470000.00),
    ('2018-04-01'::DATE, 510000.00);

describe table home_sales;
select * from home_sales;

SELECT 
    sale_date, price,
    CASE 
       WHEN price between 200000 and 300000 THEN '20K-30K'
       WHEN price between 300000 and 400000 THEN '30K-40K'
       WHEN price between 400000 and 500000 THEN '40K-50K'
       WHEN price between 500000 and 600000 THEN '50K-60K'
       ELSE 'PRICE OUTSIDE RANGE'
     END AS PRICE_BUCKET,  
    WIDTH_BUCKET(price, 200000, 600000, 4) AS "SALES GROUP"
  FROM home_sales
  ORDER BY sale_date;


  
