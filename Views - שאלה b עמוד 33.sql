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
