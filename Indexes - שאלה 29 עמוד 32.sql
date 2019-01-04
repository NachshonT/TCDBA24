SELECT City,
		StateProvinceID
		--StateProvince.Name AS Province
FROM Person.[Address]
--	INNER JOIN Person.StateProvince
--		ON Address.StateProvinceID = StateProvince.StateProvinceID
WHERE PostalCode = '84407'