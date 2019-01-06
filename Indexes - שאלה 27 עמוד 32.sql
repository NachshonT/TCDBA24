USE [Northwind]
GO

/****** Object:  Table [dbo].[T_PKsOnTables]    Script Date: 31/12/2018 22:52:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE #T_PKsOnTables
(
	[TableName] [nchar](100) NULL,
	[PrimaryKeyName] [nchar](100) NULL
) ON [PRIMARY]

GO

DECLARE curTables CURSOR READ_ONLY FORWARD_ONLY
FOR 
	SELECT sysTables.[name] AS TableName,
		sysKeyConstraints.[name] AS PrimaryKeyName
	FROM sys.tables AS sysTables
		INNER JOIN sys.key_constraints AS sysKeyConstraints
			ON sysTables.object_id = sysKeyConstraints.parent_object_id
	WHERE sysKeyConstraints.[type] = 'PK'

DECLARE
	@TableName sysname,
	@PrimaryKeyName sysname

OPEN curTables

FETCH NEXT FROM curTables
	INTO @TableName, @PrimaryKeyName

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO #T_PKsOnTables (TableName, PrimaryKeyName)
	VALUES (CAST(@TableName AS NCHAR(100)), CAST(@PrimaryKeyName AS NCHAR(100)))

	FETCH NEXT FROM curTables
		INTO @TableName, @PrimaryKeyName
END

CLOSE curTables
DEALLOCATE curTables

SELECT *
FROM #T_PKsOnTables