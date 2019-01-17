USE eDate
GO

SELECT
	MIM.MemberId,
	MIM.MemberName,
	MS.Id AS SessionId,
	MS.LoginDateTime
FROM FemaleItalianMembers AS MIM
	INNER JOIN Operation.MemberSessions AS MS
		ON MIM.MemberId = MS.MemberId
WHERE (MS.LoginDateTime > DATEADD(YY, - 1, GETDATE()))
GO