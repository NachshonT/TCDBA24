-- שאלה 6
--========
-- A.
-- לא נכון
SELECT *
FROM Employees
WHERE SALARY > (SELECT MIN(SALARY) FROM Employees GROUP BY Department_ID)

-- B.
-- לא נכון
SELECT *
FROM Employees
WHERE SALARY > (SELECT AVG(SALARY) FROM Employees GROUP BY Department_ID)

-- C.
-- נכון
SELECT DISTINCT Department_ID  
FROM Employees
WHERE SALARY> ANY (SELECT AVG(SALARY) FROM Employees GROUP BY Department_ID)

-- D.
-- נכון
SELECT Department_ID
FROM Employees 
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM Employees GROUP BY Department_ID) 

-- E.
-- נכון
SELECT FirstName
FROM Employees
WHERE SALARY > ANY (SELECT MAX(SALARY) FROM Employees GROUP BY Department_ID)

-- F.
-- לא נכון
SELECT Department_ID  
FROM Employees 
WHERE SALARY > ALL(SELECT AVG(SALARY) FROM Employees GROUP BY AVG(SALARY))


USE
	tempdb;
GO

-- שאלה 6א
-- =======
CREATE TABLE
	dbo.LearnInsert
(
	LineID	INT		IDENTITY(1,1)	NOT NULL ,
	Name	NVARCHAR(50)	NOT NULL,
	AnotherName NVARCHAR(50) NOT NULL 
);
GO

-- שאלה 6ב
-- =======
-- 1.
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('יוסי', 'יונה1')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('יוני', 'יונה2')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('דורי', 'יונה3')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('מוני', 'יונה4')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('מוטי', 'יונה5')
GO

-- 2.
INSERT INTO LearnInsert (Name, AnotherName) SELECT TOP 5 sysTables.name, sysTables.object_id FROM AdventureWorks2012.sys.tables AS sysTables
GO

-- 3.
SELECT * INTO LearnInsert2
FROM LearnInsert
GO

-- 4.
DELETE TOP (1)
FROM LearnInsert2
GO

-- 5.
DELETE FROM LearnInsert2
WHERE Name = 'מוטי'
GO

-- 6.
DELETE FROM LearnInsert2
GO

-- 7.
INSERT INTO LearnInsert2 (Name, AnotherName)
SELECT Name, AnotherName FROM LearnInsert
GO

-- 8.
DELETE FROM LearnInsert
GO

INSERT INTO LearnInsert (Name, AnotherName) VALUES ('יוסי', 'יונה1')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('יוני', 'יונה2')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('דורי', 'יונה3')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('מוני', 'יונה4')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('מוטי', 'יונה5')
GO

SELECT 'The highest LineID in LearnInsert table is : ' + CAST(MAX(LineID) AS NVARCHAR) AS MaxLineID FROM LearnInsert

-- 9.
TRUNCATE TABLE LearnInsert
GO

INSERT INTO LearnInsert (Name, AnotherName) VALUES ('יוסי', 'יונה1')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('יוני', 'יונה2')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('דורי', 'יונה3')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('מוני', 'יונה4')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('מוטי', 'יונה5')
GO

SELECT 'The highest LineID in LearnInsert table is : ' + CAST(MAX(LineID) AS NVARCHAR) AS MaxLineID FROM LearnInsert

