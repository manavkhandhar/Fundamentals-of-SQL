
-- creating table for our database to analyze the data using SQL queries

CREATE TABLE EmployeeDemographics 
(EmployeeID int,
FirstName varchar(50), 
LastName varchar(50),
Age int,
Gender varchar(50)
)

-- creating a second table named EmployeeSalary

CREATE TABLE EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int,
)

-- inserting values in our first table

INSERT INTO EmployeeDemographics VALUES 
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

-- inserting values into our second table

Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

-- using TOP, DISTINCT, COUNT, MIN, MAX, AVG, =, <>, >, <, IN  functions 

SELECT TOP 5 *
FROM EmployeeDemographics

SELECT DISTINCT (EmployeeID)
FROM EmployeeDemographics

SELECT COUNT(LastName) AS LastNameCount
FROM EmployeeDemographics

SELECT * FROM EmployeeSalary

SELECT MAX(Salary)
FROM EmployeeSalary

SELECT EmployeeID, MIN(Salary)
FROM EmployeeSalary
GROUP BY Salary

SELECT AVG(Salary)
FROM EmployeeSalary

SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim'

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 AND Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%'

SELECT *
FROM EmployeeDemographics
Where FirstName is NOT NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael')

SELECT Gender, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY Gender ASC

SELECT *
From EmployeeDemographics
ORDER BY Age DESC

-- adding more entries into the tables, introducing NULL Values

Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

INSERT INTO EmployeeSalary VALUES
('1010', NULL, 47000),
(NULL,'Salesman', 43000)


-- Creating a new table for warehouse employee information

Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

-- inserting values in the warehouse employee table

Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

-- advancing to JOINS, first selecting all columns and initiating INNER JOIN for both EmployeeID columns which is a common link for both the tables

Select * 
from EmployeeDemographics
INNER JOIN EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- Specifying the exact columns we need from the tables and pulling the Salary column from EmployeeSalary table

Select EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
from EmployeeDemographics
INNER JOIN EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	
-- running RIGHT OUTER JOIN to fetch data from the EmployeeSalary table

Select EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
from SQLTutorial.dbo.EmployeeDemographics
RIGHT OUTER JOIN SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- running LEFT OUTER JOIN to fetch data from the left table - EmployeeDemogrpahics

Select EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary
from SQLTutorial.dbo.EmployeeDemographics
LEFT OUTER JOIN SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- finding highest paid employee except for the manager Michael Scott using Inner Join

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics
Inner Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

-- finding average salary of Salesmen

SELECT JobTitle, AVG(Salary) as AvgSalary
FROM EmployeeDemographics
Inner Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle



-- joining both tables using OUTER JOIN to find if we can use UNION to have all the information in a single query

SELECT *
FROM EmployeeDemographics
FULL OUTER JOIN WareHouseEmployeeDemographics
ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID

-- using UNION to join these tables and appending info from second table to EmployeeDemographics Table

SELECT *
FROM EmployeeDemographics
UNION
SELECT *
FROM WareHouseEmployeeDemographics
ORDER BY EmployeeID 

-- applying CASE WHEN statements

SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby' 
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

-- calculating salary raise based on job titles using CASE WHEN

SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
	ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- applying HAVING clause

SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 40000
ORDER BY AVG(Salary)

-- updating and deleting data in a table

UPDATE EmployeeDemographics
SET EmployeeId = 1012, Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' and LastName = 'Flax'


-- delete data from a table

DELETE FROM EmployeeDemographics
WHERE EmployeeID = 1005

-- showcasing Aliasing

Select FirstName + ' ' + LastName AS FullName
from EmployeeDemographics 

-- making the query short & cleaner using Alias

SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Salary
FROM EmployeeDemographics AS Demo
LEFT JOIN EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN WareHouseEmployeeDemographics AS Ware
ON Demo.EmployeeID = Ware.EmployeeID

-- showcasing PARTITION BY function

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'


-- demonstrating CTEs in SQL

WITH CTE_Employee AS 
(SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary
FROM CTE_Employee

-- demonstrating Temp Tables in SQL

CREATE TABLE #temp_Employee (
EmployeeId int,
JobTitle varchar(100),
Salary int)

-- inserting values in the temp table created

INSERT INTO #temp_Employee VALUES (
'1001', 'HR', 45000)

SELECT * FROM #temp_Employee -- to re-check run query results

INSERT INTO #temp_Employee
Select * 
from EmployeeSalary

-- creating 2nd temp table 

DROP TABLE IF EXISTS #temp_employee2
CREATE TABLE #temp_employee2
(JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

-- inserting values to the temp_employee2 table

INSERT INTO #temp_employee2
SELECT JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

SELECT * FROM #temp_employee2 -- re-checking queried result

-- demonstrating STRING FUNCTIONS in SQL

CREATE TABLE EmployeeErrors (			-- creating a table with errors in data to show string function uses
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors  -- to re-check inserted data into the table

-- Using TRIM, LTRIM, RTRIM functions

SELECT EmployeeID, TRIM(EmployeeID) as ID_Trim
FROM EmployeeErrors 

SELECT EmployeeID, LTRIM(EmployeeID) as ID_LTrim
FROM EmployeeErrors 

SELECT EmployeeID, RTRIM(EmployeeID) as ID_RTrim
FROM EmployeeErrors 

-- Using Replace functions to correct errors in the table

SELECT FirstName, LastName, 
REPLACE(
						REPLACE(
				FirstName, 'TOby', 'Toby'
							),
							'Jimbo', 'Jim'
							) AS FirstName_corrected,
REPLACE(
	REPLACE(
		REPLACE(
			LastName, ' - Fired',''
		),
				'Halbert','Halpert'
			),
				'Beasely','Beasly'
				) AS LastName_corrected
FROM EmployeeErrors

-- using SubStrings

SELECT SUBSTRING(FirstName,1,3)
FROM EmployeeErrors

-- matching first names from two tables using SubStrings aka Fuzzy Match and correcting FirstName using REPLACE function

SELECT SUBSTRING(err.FirstName,1,3) as Sub1, SUBSTRING(dem.FirstName,1,3) as sub2, 
REPLACE(
	REPLACE(
err.FirstName,'TOby','Toby'), 
	'Jimbo', 'Jim') as corrected_FirstName
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)


-- using UPPER & LOWER functions which makes all characters capitalised & lower respectively.

SELECT FirstName, LOWER(FirstName) as lowerchar
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName) as capital_char
FROM EmployeeErrors

-- creating and running Stored Procedures in SQL

CREATE PROCEDURE temp_employee
AS 
CREATE TABLE #Temp_employee1
(JobTitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #Temp_employee1
SELECT JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

SELECT *
FROM #Temp_employee1

EXEC temp_employee @JobTitle = 'Salesman'  -- executing stored procedures

-- demonstrating subqueries in SQL

SELECT EmployeeID, Salary, (Select AVG(Salary) FROM EmployeeSalary) as allavg
FROM EmployeeSalary

-- type 2 of subquery (PARTITION BY)

SELECT EmployeeID, JobTitle, Salary, 
Salary + (Salary * 0.1) as updated_salary, 
	avg(Salary +(Salary * 0.1)) 
		over (PARTITION BY JobTitle) as allavg
FROM EmployeeSalary

-- type 3 (FROM)

SELECT a.EmployeeID, allavg
FROM (Select EmployeeID, Salary, AVG(Salary) over () as allavg
from EmployeeSalary) a

-- type 4 (WHERE)

SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
	Select EmployeeID 
	FROM EmployeeDemographics
	WHERE Age > 30)


--*END








