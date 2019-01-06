SELECT
	MemberId = Members.Id,
	MemberFirstName = Members.FirstName,
	MemberLastName = Members.LastName,
	LoginDateTime = MemberSessions.LoginDateTime,
	SessionEndDateTime = MemberSessions.EndDateTime
FROM Operation.Members AS Members
	INNER JOIN Operation.MemberSessions AS MemberSessions
		ON Members.Id = MemberSessions.MemberId
WHERE Members.CountryId = 4 AND
		YEAR(MemberSessions.LoginDateTime ) = 2010 AND
		MONTH(MemberSessions.LoginDateTime) = 6
ORDER BY
MemberId ASC, LoginDateTime ASC


