
USE Connect_wave_db;

-- Lets create a copy of our raw table so we can keep our original file

SELECT *
INTO customers_2
FROM customer_table

-- We can run pre-audit cleaning so as to see the issues we have in each columns of the dataset

SELECT *
FROM customers_2


SELECT 
	COUNT(*) AS Total_rows,
	SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Missing_gender,
	SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Missing_age,
	SUM(CASE WHEN Contract_Type IS NULL THEN 1 ELSE 0 END) AS Missing_Contract_type,
	SUM(CASE WHEN Age < 0 OR Age > 120 THEN 1 ELSE 0 END) AS invalid_age,
	SUM(CASE WHEN Gender IN ('M' , 'F') THEN 1 ELSE 0 END) AS bad_gender,
	COUNT(DISTINCT State) AS states
FROM customers_2

-- So from the audit
-- Total rows = 40,000
-- missing_gender = 8,067
-- missing_age = 424
-- missing contract type = 10,111
-- invalid age = 813
-- bad gender = 16,056
-- states = 7

-- Lets remove extra any extra spaces in entry (trim)
-- We do this for all columns
SELECT *
FROM customers_2

UPDATE customers_2
SET 
	Customer_ID = LTRIM(RTRIM(Customer_ID)),
	Gender = LTRIM(RTRIM(Gender)),
	Age = LTRIM(RTRIM(Age)),
	State = LTRIM(RTRIM(State)),
	Churn_Status = LTRIM(RTRIM(Churn_Status))

-- Fix bad Gender values entry

SELECT DISTINCT Gender
FROM customers_2

UPDATE customers_2
SET Gender = CASE 
				WHEN Gender = 'M' THEN 'Male'
				WHEN Gender = 'F' THEN 'Female'
				ELSE Gender
			END
WHERE Gender IN ('M', 'F')


-- Fixing NULL Gender entry types
-- Lets try a new method by using the mode of both entries (using the entry that appeared more)

BEGIN

	DECLARE @GenderMode NVARCHAR(50);

	SELECT TOP 1 @GenderMode = Gender
	FROM customers_2
	WHERE Gender IS NOT NULL
	GROUP BY Gender
	ORDER BY COUNT(*) DESC

	UPDATE customers_2
	SET Gender = @GenderMode
	WHERE Gender IS NULL; 

END

SELECT DISTINCT Gender
FROM customers_2
-- Now we have sucessfully fixed the NULL enteries in the Gender column

-- Lets now fix the Age column
-- Lets look for outlier Age enteries

SELECT *
FROM customers_2
WHERE Age < 0 OR Age > 120;

-- We have 813 cases of outlier Ages
-- We can set the outlier ages to NULL since there is no other column we can use to get their real Age 

UPDATE customers_2
SET Age = NULL
WHERE Age < 0 OR Age > 120

-- Now lets try using the median subquery so we can fill up the NULL enteries

UPDATE customers_2
SET    Age = (
           SELECT DISTINCT
                  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Age)
                  OVER ()
           FROM   customers_2
           WHERE  Age IS NOT NULL
       )
WHERE  Age IS NULL;

-- lets see if the fix worked

SELECT *
FROM customers_2

-- Lets fix  the state column
-- Standardize the column names

SELECT COUNT(*)
FROM customers_2
WHERE State = 'Abuja' AND Churn_Status = '1'

-- We can see the fix we have from running the previous code
-- lagos and LAGOS to be Lagos
-- Also FCT to be Abuja

UPDATE customers_2
SET State = CASE 
				WHEN LOWER(State) = 'lagos' THEN 'Lagos'
				WHEN State = 'FCT' THEN 'Abuja'
			END
WHERE LOWER(State) = 'lagos'
	OR State = 'FCT';

SELECT *
FROM customers_2

-- Lets fix contract type
-- Set the NULL enteries using the mode of the contract type column

UPDATE customers_2
SET    Contract_Type = (
           SELECT TOP 1 Contract_Type
           FROM   customers_2
           WHERE  Contract_Type IS NOT NULL
           GROUP  BY Contract_Type
           ORDER  BY COUNT(*) DESC
       )
WHERE  Contract_Type IS NULL;


BEGIN

	DECLARE @Contract_TypeMode NVARCHAR(50);

	SELECT TOP 1 @Contract_TypeMode = Contract_Type
	FROM customers_2
	WHERE Contract_Type IS NOT NULL
	GROUP BY Contract_Type
	ORDER BY COUNT(*) DESC

	UPDATE customers_2
	SET Contract_Type = @Contract_TypeMode
	WHERE Gender IS NULL; 

END

-- Lets fix duplicates customer_id

-- lets identity duplicates

SELECT Customer_ID, 
COUNT(*) AS amount
FROM customers_2
GROUP BY Customer_ID
HAVING COUNT (*) > 1;

-- Lets delete the duplicates but keep one of the records

WITH CTE_Duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Customer_ID
               ORDER BY     (SELECT NULL)   -- no natural key to prefer, so i can  keep any one row
           ) AS RowNum
    FROM   customers_2
)
DELETE FROM CTE_Duplicates
WHERE  RowNum > 1;


-- Now after finishing up cleaning the data, we can run post audit check

SELECT
    COUNT(*)                                               AS Total_Rows,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END)       AS Missing_Gender,
    SUM(CASE WHEN Age    IS NULL THEN 1 ELSE 0 END)       AS Missing_Age,
    SUM(CASE WHEN Contract_Type IS NULL THEN 1 ELSE 0 END) AS Missing_Contract_Type,
    SUM(CASE WHEN Age < 0 OR Age > 120 THEN 1 ELSE 0 END) AS Invalid_Age,
    SUM(CASE WHEN Gender IN ('M','F') THEN 1 ELSE 0 END)  AS NonStandard_Gender,
    COUNT(DISTINCT State)                                  AS states_count,
    COUNT(*) - COUNT(DISTINCT Customer_ID)                 AS Duplicate_CustomerIDs
FROM customers_2;

-- No more NULL or unusual entry

SELECT TOP 20 *
FROM   customers_2
ORDER  BY Customer_ID;


-- i can also perform Gender, State, and Contract type distribution to see the percentages of each data entries for the columns
-- will look good 

-- Gender distribution
SELECT Gender, COUNT(*) AS Count,
       CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS Percentage
FROM   customers_2
GROUP  BY Gender
ORDER  BY Count DESC;

-- State distribution
SELECT State, COUNT(*) AS Count,
       CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS Pct
FROM   customers_2
GROUP  BY State
ORDER  BY Count DESC;

-- Contract Type distribution
SELECT Contract_Type, COUNT(*) AS Count,
       CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS Pct
FROM   customers_2
GROUP  BY Contract_Type
ORDER  BY Count DESC;

-- Age summary stattics
-- Perform different measures of standard tendency
SELECT
    MIN(Age)  AS Min_Age,
    MAX(Age)  AS Max_Age,
    AVG(Age)  AS Avg_Age,
    STDEV(Age) AS StdDev_Age
FROM customers_2;