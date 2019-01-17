USE [eDate]
GO

INSERT INTO [dbo].[SomeInvitations]
(
	[InvitationID],
	[RequestingSessionId],
	[ReceivingMemberId],
	[CreationDateTime],
	[StatusId],
	[MemberId]
)
VALUES
(
	784083,
	13937,
	DATEADD(WW, -1, GETDATE()),
	3,
	13937
)
GO

/*
Got this error message :

Msg 4405, Level 16, State 1, Line 2
View or function 'dbo.SomeInvitations' is not updatable because the modification affects multiple base tables.

*/