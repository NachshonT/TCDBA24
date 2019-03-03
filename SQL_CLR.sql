-- First, we need to enable CLR in the server level
sp_configure 'clr enabled' ,1
RECONFIGURE
GO
-- Add the dll into Database -> Programmability -> Assemblies

-- Create a SQL-CLR stored procedure
CREATE PROCEDURE P_PrintMessage
AS
EXTERNAL NAME [SQL_CLR].SQLMessage.PrintMessage
GO

EXECUTE P_PrintMessage
GO

DROP PROCEDURE P_PrintMessage
GO

CREATE TABLE T_Test
(
	ID INT NOT NULL IDENTITY(1,1),
	FirstName varchar(100),
	LastName varchar(100)
 )

-- Insert a row into the T_Test table using plain T-SQL
INSERT INTO T_Test (FirstName , LastName) VALUES('אברהם' , 'אברהמי')
GO

-- Show data currently in T_Test
SELECT * FROM T_Test
GO

-- Create a SQL-CLR stored procedure that insert a row into the T_Test table for 'יצחק' 'יצחקי'
CREATE PROCEDURE P_InsertNew
AS
EXTERNAL NAME [SQL_CLR].InsertTest.InsertNew
GO

EXECUTE P_InsertNew
GO

DROP PROCEDURE P_InsertNew
GO

-- Show data currently in T_Test
SELECT * FROM T_Test
GO

 --SP with input parameters 
CREATE PROCEDURE P_ParamInsert (@FirstName AS  NVARCHAR(100), @LastName AS NVARCHAR(100))
AS
EXTERNAL NAME [SQL_CLR].InsertTest.ParamInsert
GO

EXECUTE P_ParamInsert @FirstName = 'יעקב', @LastName = 'יעקבי'
GO

EXECUTE P_ParamInsert @FirstName = 'יוסף', @LastName = 'יוספי'
GO

DROP PROCEDURE P_ParamInsert
GO

-- Show data currently in T_Test
SELECT * FROM T_Test
GO

DROP TABLE T_Test
GO
