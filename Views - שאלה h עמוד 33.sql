USE [eDate]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[SomeInvitations]
AS
SELECT  Id AS InvitationID,
		RequestingSessionId,
		ReceivingMemberId,
		CreationDateTime,
		StatusId
FROM    Operation.Invitations
WHERE  (StatusId = 3)

GO


