USE Northwind
GO

MERGE INTO dbo.Employees AS TARGET  
USING [AdventureWorks2012].[HumanResources].[Employee] AS SOURCE
ON (TARGET.EmployeeID = SOURCE.EmployeeID)
WHEN MATCHED THEN UPDATE TARGET SET LastName = SOURCE.LastName
WHEN NOT MATCHED BY TARGET
    THEN INSERT INTO TARGET (EmployeeID, FirstName, LastName, PhoneNumber, Address)
		VALUES (EmployeeID, FirstName, LastName, PhoneNumber, Address)
			VALUES(Inserted.EmployeeID, SOURCE.FirstName, SOURCE.LastName, SOURCE.PhoneNumber, SOURCE.Address)

OUTPUT $action, Inserted.ProductID, Inserted.Quantity, 
    Inserted.ModifiedDate, Deleted.ProductID,  
    Deleted.Quantity, Deleted.ModifiedDate;  
