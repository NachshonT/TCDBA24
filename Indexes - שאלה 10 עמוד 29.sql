SELECT LastName, FirstName
FROM Operation.Members
WHERE LastName LIKE 'B%'
ORDER BY FirstName, BirthDate
GO

SELECT LastName, FirstName
FROM Operation.Members
WHERE LastName LIKE 'B%'
ORDER BY LastName, FirstName
GO