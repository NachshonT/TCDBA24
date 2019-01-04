--First Insert
INSERT INTO Operation.Members 
(
	FirstName,
	LastName,
	Username,
	Password,
	CountryId,
	EmailAddress,
	GenderId,
	BirthDate,
	RegistrationDateTime)
VALUES
(
	'Nachshon',
	'Tamir',
	'NachshonT',
	'8888',
	1,
	'Nachshon.tamir@gmail.com',
	1,
	CAST ('6-27-1967' AS DateTime),
	GETDATE()
)
GO

--Second Insert
INSERT INTO Operation.Members 
(
	FirstName,
	LastName,
	Username,
	Password,
	CountryId,
	EmailAddress,
	GenderId,
	BirthDate,
	RegistrationDateTime)
VALUES
(
	'Nachshon',
	'Tamir',
	'NachshonT',
	'8888',
	1,
	'Nachshon.tamir@gmail.com',
	1,
	CAST ('6-27-1967' AS DateTime),
	GETDATE()
)
GO