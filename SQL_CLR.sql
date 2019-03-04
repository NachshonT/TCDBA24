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

 --SP with input parameters 
CREATE PROCEDURE P_CLR_Insert (@FirstName AS  NVARCHAR(100), @LastName AS NVARCHAR(100))
AS
EXTERNAL NAME [SQL_CLR].CLR_DML.CLR_Insert
GO

EXECUTE P_CLR_Insert @FirstName = 'יעקב', @LastName = 'יעקבי'
GO

EXECUTE P_CLR_Insert @FirstName = 'יצחק', @LastName = 'יצחקי'
GO

DROP PROCEDURE P_CLR_Insert
GO

-- Show data currently in T_Test
SELECT * FROM T_Test
GO

-- Update row with ID = 3
CREATE PROCEDURE P_CLR_Update (@ID AS INT, @FirstName AS NVARCHAR(100), @LastName AS NVARCHAR(100))
AS
EXTERNAL NAME [SQL_CLR].CLR_DML.CLR_Update
GO

EXECUTE P_CLR_Update @ID = 3, @FirstName = 'דויד', @LastName = 'דוידי'
GO

DROP PROCEDURE P_CLR_Update
GO

-- Show data currently in T_Test
SELECT * FROM T_Test
GO

-- Delete row with ID = 4
CREATE PROCEDURE P_CLR_Delete (@ID AS INT)
AS
EXTERNAL NAME [SQL_CLR].CLR_DML.CLR_Delete
GO

EXECUTE P_CLR_Delete @ID = 2
GO

DROP PROCEDURE P_CLR_Delete
GO

-- Show data currently in T_Test
SELECT * FROM T_Test
GO

DROP TABLE T_Test
GO
