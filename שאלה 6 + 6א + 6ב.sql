-- ���� 6
--========
-- A.
-- �� ����
SELECT *
FROM Employees
WHERE SALARY > (SELECT MIN(SALARY) FROM Employees GROUP BY Department_ID)

-- B.
-- �� ����
SELECT *
FROM Employees
WHERE SALARY > (SELECT AVG(SALARY) FROM Employees GROUP BY Department_ID)

-- C.
-- ����
SELECT DISTINCT Department_ID  
FROM Employees
WHERE SALARY> ANY (SELECT AVG(SALARY) FROM Employees GROUP BY Department_ID)

-- D.
-- ����
SELECT Department_ID
FROM Employees 
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM Employees GROUP BY Department_ID) 

-- E.
-- ����
SELECT FirstName
FROM Employees
WHERE SALARY > ANY (SELECT MAX(SALARY) FROM Employees GROUP BY Department_ID)

-- F.
-- �� ����
SELECT Department_ID  
FROM Employees 
WHERE SALARY > ALL(SELECT AVG(SALARY) FROM Employees GROUP BY AVG(SALARY))


USE
	tempdb;
GO

-- ���� 6�
-- =======
CREATE TABLE
	dbo.LearnInsert
(
	LineID	INT		IDENTITY(1,1)	NOT NULL ,
	Name	NVARCHAR(50)	NOT NULL,
	AnotherName NVARCHAR(50) NOT NULL 
);
GO

-- ���� 6�
-- =======
-- 1.
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����1')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����2')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����3')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����4')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����5')
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
WHERE Name = '����'
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

INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����1')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����2')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����3')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����4')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����5')
GO

SELECT 'The highest LineID in LearnInsert table is : ' + CAST(MAX(LineID) AS NVARCHAR) AS MaxLineID FROM LearnInsert

-- 9.
TRUNCATE TABLE LearnInsert
GO

INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����1')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����2')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����3')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����4')
INSERT INTO LearnInsert (Name, AnotherName) VALUES ('����', '����5')
GO

SELECT 'The highest LineID in LearnInsert table is : ' + CAST(MAX(LineID) AS NVARCHAR) AS MaxLineID FROM LearnInsert

