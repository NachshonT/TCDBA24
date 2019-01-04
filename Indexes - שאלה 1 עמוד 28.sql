USE [eDate]

/*
After executing this for the first time :
ALTER TABLE [Operation].[MemberSessions] DROP CONSTRAINT [pk_MemberSessions_c_Id]

Got this Error message :
Msg 3725, Level 16, State 0, Line 2
The constraint 'pk_MemberSessions_c_Id' is being referenced by table 'Invitations', foreign key constraint 'fk_Invitations_RequestingSessionId_MemberSessions_Id'.
Msg 3727, Level 16, State 0, Line 2
Could not drop constraint. See previous errors.

So did this first :
*/
ALTER TABLE [Operation].[Invitations] DROP CONSTRAINT [fk_Invitations_RequestingSessionId_MemberSessions_Id]
GO

/****** Object:  Index [pk_MemberSessions_c_Id]    Script Date: 26/12/2018 21:52:39 ******/
ALTER TABLE [Operation].[MemberSessions] DROP CONSTRAINT [pk_MemberSessions_c_Id]
GO

/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE CLUSTERED INDEX IXC_MemberSessions_MemberID_LoginDateTime ON Operation.MemberSessions
	(
	MemberId,
	LoginDateTime
	) WITH( PAD_INDEX = OFF, FILLFACTOR = 80, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE Operation.MemberSessions SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

ALTER TABLE [Operation].[MemberSessions] ADD CONSTRAINT [pk_MemberSessions_c_Id] PRIMARY KEY NONCLUSTERED (Id ASC) ON [PRIMARY]
GO

ALTER TABLE [Operation].[Invitations] ADD CONSTRAINT [fk_Invitations_RequestingSessionId_MemberSessions_Id] FOREIGN KEY (RequestingSessionId) REFERENCES Operation.MemberSessions (Id)
GO
