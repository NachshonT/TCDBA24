SELECT *
FROM Operation.MemberSessions AS MS
	INNER JOIN Operation.Members AS M
		ON Ms.MemberId = M.Id
WHERE M.GenderId = 2 AND
	m.BirthDate <= DATEADD(yy, -25, GETDATE()) AND 
	m.BirthDate > DATEADD(yy, -26, GETDATE())
ORDER BY MS.MemberId, Ms.LoginDateTime