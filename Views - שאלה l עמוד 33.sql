USE [eDate]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[SomeInvitations]
WITH  VIEW_METADATA
AS
SELECT  I.Id AS InvitationID,
		I.RequestingSessionId,
		I.CreationDateTime,
		I.StatusId,
		I.ReceivingMemberId,
		MS.MemberId
FROM Operation.Invitations AS I
	INNER JOIN Operation.MemberSessions AS MS
		ON I.RequestingSessionId = MS.Id
WHERE  (I.StatusId = 3)
WITH CHECK OPTION

GO


