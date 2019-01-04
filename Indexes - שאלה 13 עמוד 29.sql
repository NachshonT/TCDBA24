SELECT *
FROM Operation.Members AS M
WHERE BirthDate <= DATEADD(YY, -50, GETDATE()) AND
	StreetAddress IS NULL