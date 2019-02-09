USE AdventureWorks2012
GO

DECLARE @ProductName SYSNAME, @ListPrice MONEY

DECLARE curProducts CURSOR READ_ONLY FORWARD_ONLY
FOR
	SELECT [name] AS ProductName, ListPrice
	FROM Production.Product
	ORDER BY ListPrice DESC

OPEN curProducts

FETCH NEXT
FROM curProducts
INTO @ProductName, @ListPrice

WHILE (@@FETCH_STATUS = 0)
	BEGIN
		PRINT 'Product Name : ' + @ProductName + ' ListPrice : ' + CAST(@ListPrice AS nvarchar)
		
		FETCH NEXT
		FROM curProducts
		INTO @ProductName, @ListPrice
	END 

CLOSE curProducts
DEALLOCATE curProducts

