USE AdventureWorks2012
GO

SELECT CustomerName,
			[1] AS January,
			[2] AS February,
			[3] AS March,
			[4] AS April,
			[5] AS May,
			[6] AS June,
			[7] AS July,
			[8] AS Aogust,
			[9] AS September,
			[10] AS October,
			[11] AS November,
			[12] AS December
FROM
(
	SELECT QualifyingOrders.SalesOrderID,
				MONTH(Orders.OrderDate) AS OrderMonth,
				Persons.LastName + ' ' + Persons.FirstName AS CustomerName
	FROM 
		(
			SELECT Orders.SalesOrderID
			FROM Sales.SalesOrderHeader AS Orders
				INNER JOIN Sales.SalesOrderDetail AS OrderDetails
					ON Orders.SalesOrderID = OrderDetails.SalesOrderID
			WHERE YEAR(Orders.OrderDate) = 2013
			GROUP BY Orders.SalesOrderID
			HAVING COUNT(OrderDetails.ProductID) > 1
		) AS QualifyingOrders
		INNER JOIN Sales.SalesOrderHeader AS Orders
			ON QualifyingOrders.SalesOrderID = Orders.SalesOrderID
		INNER JOIN Sales.Customer AS Customers
			ON Customers.CustomerID = Orders.CustomerID
		INNER JOIN Person.Person AS Persons
			ON Customers.PersonID = Persons.BusinessEntityID
	) AS InnerQuery
PIVOT
(
	COUNT(SalesOrderID)  
	FOR [OrderMonth]   
    IN ( [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])  
 ) AS pvt