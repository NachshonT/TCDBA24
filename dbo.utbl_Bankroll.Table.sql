USE [Casino]
GO
ALTER TABLE [dbo].[utbl_Bankroll] DROP CONSTRAINT [FK_utbl_Bankroll_utbl_TransactionType]
GO
ALTER TABLE [dbo].[utbl_Bankroll] DROP CONSTRAINT [FK_utbl_Bankroll_utbl_Players]
GO
ALTER TABLE [dbo].[utbl_Bankroll] DROP CONSTRAINT [DF_utbl_Bankroll_CommitedOn]
GO
/****** Object:  Index [UQ_utbl_Bankroll_PlayerId_TransactionId]    Script Date: 29/03/2019 10:21:25 ******/
DROP INDEX [UQ_utbl_Bankroll_PlayerId_TransactionId] ON [dbo].[utbl_Bankroll]
GO
/****** Object:  Index [IX_utbl_Bankroll_TransactionTypeId]    Script Date: 29/03/2019 10:21:25 ******/
DROP INDEX [IX_utbl_Bankroll_TransactionTypeId] ON [dbo].[utbl_Bankroll]
GO
/****** Object:  Index [IX_utbl_Bankroll_PlayerId]    Script Date: 29/03/2019 10:21:25 ******/
DROP INDEX [IX_utbl_Bankroll_PlayerId] ON [dbo].[utbl_Bankroll]
GO
/****** Object:  Table [dbo].[utbl_Bankroll]    Script Date: 29/03/2019 10:21:25 ******/
DROP TABLE [dbo].[utbl_Bankroll]
GO
/****** Object:  Table [dbo].[utbl_Bankroll]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Bankroll](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[PlayerId] [int] NOT NULL,
	[TransactionTypeId] [tinyint] NOT NULL,
	[CommitedOn] [datetime] NOT NULL,
	[Amount] [money] NOT NULL,
 CONSTRAINT [PK_utbl_Bankroll_TransactionId] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_utbl_Bankroll_PlayerId]    Script Date: 29/03/2019 10:21:26 ******/
CREATE NONCLUSTERED INDEX [IX_utbl_Bankroll_PlayerId] ON [dbo].[utbl_Bankroll]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_utbl_Bankroll_TransactionTypeId]    Script Date: 29/03/2019 10:21:26 ******/
CREATE NONCLUSTERED INDEX [IX_utbl_Bankroll_TransactionTypeId] ON [dbo].[utbl_Bankroll]
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_utbl_Bankroll_PlayerId_TransactionId]    Script Date: 29/03/2019 10:21:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_utbl_Bankroll_PlayerId_TransactionId] ON [dbo].[utbl_Bankroll]
(
	[PlayerId] ASC,
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[utbl_Bankroll] ADD  CONSTRAINT [DF_utbl_Bankroll_CommitedOn]  DEFAULT (getdate()) FOR [CommitedOn]
GO
ALTER TABLE [dbo].[utbl_Bankroll]  WITH CHECK ADD  CONSTRAINT [FK_utbl_Bankroll_utbl_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[utbl_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[utbl_Bankroll] CHECK CONSTRAINT [FK_utbl_Bankroll_utbl_Players]
GO
ALTER TABLE [dbo].[utbl_Bankroll]  WITH CHECK ADD  CONSTRAINT [FK_utbl_Bankroll_utbl_TransactionType] FOREIGN KEY([TransactionTypeId])
REFERENCES [dbo].[utbl_TransactionType] ([TransactionTypeId])
GO
ALTER TABLE [dbo].[utbl_Bankroll] CHECK CONSTRAINT [FK_utbl_Bankroll_utbl_TransactionType]
GO
