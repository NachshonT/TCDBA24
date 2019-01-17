USE [eDate]
GO

INSERT INTO [dbo].[SomeInvitations]
(
	[RequestingSessionId],
	[ReceivingMemberId],
	[CreationDateTime],
	[StatusId]
)
VALUES
(
	784083,
	13937,
	DATEADD(WW, -1, GETDATE()),
	2 --!!!
)
GO

/*
Got this error message :

Msg 550, Level 16, State 1, Line 2
The attempted insert or update failed because the target view either specifies WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.
The statement has been terminated.

*/