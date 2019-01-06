SELECT *
FROM Operation.MemberSessions AS MS
WHERE MemberId = 1234 AND
	YEAR(LoginDateTime) = 2010