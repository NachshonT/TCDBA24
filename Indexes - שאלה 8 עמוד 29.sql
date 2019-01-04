USE [eDate]

GO

SET ANSI_PADDING ON


GO

CREATE NONCLUSTERED INDEX [IX_Members_LastName#FirstName] ON [Operation].[Members]
(
	[LastName] ASC,
	[FirstName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

GO


SELECT I.*
FROM Operation.Invitations AS I
	INNER JOIN Operation.Members AS M
		On I.ReceivingMemberId = M.Id
WHERE M.LastName = 'Simon' AND
	M.FirstName = 'Paul'