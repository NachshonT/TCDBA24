USE [eDate]
GO

/****** Object:  View [dbo].[SomeInvitations]    Script Date: 03/01/2019 15:30:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[SomeInvitations]
AS
SELECT  Id AS InvitationID, RequestingSessionId, CreationDateTime, StatusId, ReceivingMemberId
FROM     Operation.Invitations
WHERE  (StatusId = 3)
WITH CHECK OPTION

GO


