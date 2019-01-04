CREATE NONCLUSTERED INDEX [IX_MembersSessions_LoginDateTime] ON [Operation].[MemberSessions]
(
	[LoginDateTime] ASC
)
INCLUDE ([MemberId], [EndDateTime]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Members_CountryId] ON [Operation].[Members]
(
	[CountryId]
)
INCLUDE ([Id], [FirstName], [LastName])
GO

SELECT
	M.Id AS MemberId,
	M.FirstName AS MemberFirstName,
	M.LastName AS MemberLastName,
	MS.LoginDateTime AS LoginDateTime,
	MS.EndDateTime AS SessionEndDateTime
FROM Operation.Members AS M
	INNER JOIN Operation.MemberSessions AS MS
		ON M.Id = MS.MemberId
WHERE M.CountryId = 4 AND
		--MS.LoginDateTime BETWEEN '06-01-2010' AND '07-01-2010'
		YEAR(MS.LoginDateTime ) = 2010 AND
		MONTH(MS.LoginDateTime) = 6
ORDER BY
MemberId ASC, LoginDateTime ASC




