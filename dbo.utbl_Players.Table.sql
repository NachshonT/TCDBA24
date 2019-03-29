USE [Casino]
GO
ALTER TABLE [dbo].[utbl_Players] DROP CONSTRAINT [FK_utbl_Players_utbl_LoginHistory]
GO
ALTER TABLE [dbo].[utbl_Players] DROP CONSTRAINT [FK_Players_Gender]
GO
ALTER TABLE [dbo].[utbl_Players] DROP CONSTRAINT [FK_Players_Countries]
GO
/****** Object:  Index [UQ_utbl_Players_PlayerName]    Script Date: 29/03/2019 10:21:25 ******/
DROP INDEX [UQ_utbl_Players_PlayerName] ON [dbo].[utbl_Players]
GO
/****** Object:  Index [IX_PlayersCountryId]    Script Date: 29/03/2019 10:21:25 ******/
DROP INDEX [IX_PlayersCountryId] ON [dbo].[utbl_Players]
GO
/****** Object:  Table [dbo].[utbl_Players]    Script Date: 29/03/2019 10:21:25 ******/
DROP TABLE [dbo].[utbl_Players]
GO
/****** Object:  Table [dbo].[utbl_Players]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Players](
	[PlayerId] [int] NOT NULL,
	[PlayerName] [nchar](10) NOT NULL,
	[Password] [nchar](10) NOT NULL,
	[FirstName] [nchar](20) NOT NULL,
	[LastName] [nchar](20) NOT NULL,
	[Address] [nchar](100) NULL,
	[CountryId] [smallint] NOT NULL,
	[Email] [nchar](100) NOT NULL,
	[GenderId] [tinyint] NULL,
	[Birthdate] [date] NOT NULL,
	[IsBlocked]  AS ([dbo].[udf_IsBlocked]([PlayerId])),
	[Balance]  AS ([dbo].[udf_getBalance]([PlayerId])),
 CONSTRAINT [PK_Players] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_PlayersCountryId]    Script Date: 29/03/2019 10:21:26 ******/
CREATE NONCLUSTERED INDEX [IX_PlayersCountryId] ON [dbo].[utbl_Players]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_utbl_Players_PlayerName]    Script Date: 29/03/2019 10:21:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_utbl_Players_PlayerName] ON [dbo].[utbl_Players]
(
	[PlayerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[utbl_Players]  WITH CHECK ADD  CONSTRAINT [FK_Players_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[utbl_Countries] ([CountryId])
GO
ALTER TABLE [dbo].[utbl_Players] CHECK CONSTRAINT [FK_Players_Countries]
GO
ALTER TABLE [dbo].[utbl_Players]  WITH CHECK ADD  CONSTRAINT [FK_Players_Gender] FOREIGN KEY([GenderId])
REFERENCES [dbo].[utbl_Gender] ([GenderId])
GO
ALTER TABLE [dbo].[utbl_Players] CHECK CONSTRAINT [FK_Players_Gender]
GO
ALTER TABLE [dbo].[utbl_Players]  WITH CHECK ADD  CONSTRAINT [FK_utbl_Players_utbl_LoginHistory] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[utbl_LoginHistory] ([PlayerId])
GO
ALTER TABLE [dbo].[utbl_Players] CHECK CONSTRAINT [FK_utbl_Players_utbl_LoginHistory]
GO
