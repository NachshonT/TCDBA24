USE [eDate]
GO

/****** Object:  Index [PK_C_Members_Id]    Script Date: 28/12/2018 14:34:31 ******/
ALTER TABLE [Operation].[MemberSessions] DROP CONSTRAINT [fk_MemberSessions_MemberId_Members_Id]
GO

ALTER TABLE [Operation].[Invitations] DROP CONSTRAINT [fk_Invitations_ReceivingMemberId_Members_Id]
GO

ALTER TABLE [Operation].[Members] DROP CONSTRAINT [PK_C_Members_Id]
GO

/****** Object:  Index [PK_C_Members_Id]    Script Date: 28/12/2018 14:34:31 ******/
ALTER TABLE [Operation].[Members] ADD  CONSTRAINT [PK_C_Members_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO

ALTER TABLE [Operation].[MemberSessions]  WITH CHECK ADD  CONSTRAINT [fk_MemberSessions_MemberId_Members_Id] FOREIGN KEY([MemberId])
REFERENCES [Operation].[Members] ([Id])
GO

ALTER TABLE [Operation].[MemberSessions] CHECK CONSTRAINT [fk_MemberSessions_MemberId_Members_Id]
GO

ALTER TABLE [Operation].[Invitations]  WITH CHECK ADD  CONSTRAINT [fk_Invitations_ReceivingMemberId_Members_Id] FOREIGN KEY([ReceivingMemberId])
REFERENCES [Operation].[Members] ([Id])
GO

ALTER TABLE [Operation].[Invitations] CHECK CONSTRAINT [fk_Invitations_ReceivingMemberId_Members_Id]
GO

