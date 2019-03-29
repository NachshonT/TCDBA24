USE [Casino]
GO
ALTER TABLE [dbo].[utbl_PasswordHistory] DROP CONSTRAINT [CK_PasswordHistory_EffectiveFrom_LT_EffectiveTo]
GO
ALTER TABLE [dbo].[utbl_PasswordHistory] DROP CONSTRAINT [FK_PasswordHistory_Players]
GO
/****** Object:  Index [IX_PasswordHistory]    Script Date: 29/03/2019 10:21:25 ******/
DROP INDEX [IX_PasswordHistory] ON [dbo].[utbl_PasswordHistory]
GO
/****** Object:  Table [dbo].[utbl_PasswordHistory]    Script Date: 29/03/2019 10:21:25 ******/
DROP TABLE [dbo].[utbl_PasswordHistory]
GO
/****** Object:  Table [dbo].[utbl_PasswordHistory]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_PasswordHistory](
	[PlayerId] [int] NOT NULL,
	[Password] [nchar](10) NOT NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[EffectiveTo] [datetime] NULL,
 CONSTRAINT [PK_PasswordHistory] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC,
	[EffectiveFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_PasswordHistory]    Script Date: 29/03/2019 10:21:26 ******/
CREATE NONCLUSTERED INDEX [IX_PasswordHistory] ON [dbo].[utbl_PasswordHistory]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[utbl_PasswordHistory]  WITH CHECK ADD  CONSTRAINT [FK_PasswordHistory_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[utbl_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[utbl_PasswordHistory] CHECK CONSTRAINT [FK_PasswordHistory_Players]
GO
ALTER TABLE [dbo].[utbl_PasswordHistory]  WITH CHECK ADD  CONSTRAINT [CK_PasswordHistory_EffectiveFrom_LT_EffectiveTo] CHECK  (([EffectiveFrom]>[EffectiveTo]))
GO
ALTER TABLE [dbo].[utbl_PasswordHistory] CHECK CONSTRAINT [CK_PasswordHistory_EffectiveFrom_LT_EffectiveTo]
GO
