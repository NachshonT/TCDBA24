USE AdventureWorks2012
GO

SELECT ProductID, [Name], ListPrice
INTO #T_Products_Temp
FROM Production.Product

DECLARE @ProductID INT, @ListPrice MONEY

DECLARE curProducts CURSOR READ_ONLY FORWARD_ONLY
FOR
	SELECT ProductID, ListPrice
	FROM Production.Product

OPEN curProducts

FETCH NEXT
FROM curProducts
INTO @ProductID, @ListPrice

WHILE (@@FETCH_STATUS = 0)
	BEGIN
		UPDATE #T_Products_Temp
		SET ListPrice = @ListPrice * 1.1
		WHERE ProductID = @ProductID
		
		FETCH NEXT
		FROM curProducts
		INTO @ProductID, @ListPrice
	END 

CLOSE curProducts
DEALLOCATE curProducts

SELECT *
FROM #T_Products_Temp

DROP TABLE #T_Products_Temp
