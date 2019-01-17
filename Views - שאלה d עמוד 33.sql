USE [eDate]
GO

INSERT INTO [dbo].[SomeInvitations]
           ([RequestingSessionId]
           ,[ReceivingMemberId]
           ,[CreationDateTime]
           ,[StatusId]
           ,[ResponseDateTime])
     VALUES
           (784083
           ,13937
           ,DATEADD(WW, -1, GETDATE())
           ,3
		   ,GETDATE())
GO
/*
Got this error message :

Msg 207, Level 16, State 1, Line 7
Invalid column name 'ResponseDateTime'.

*/