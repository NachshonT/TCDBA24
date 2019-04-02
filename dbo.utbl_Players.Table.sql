USE [Casino]
GO
/****** Object:  Table [dbo].[utbl_Players]    Script Date: 02/04/2019 15:53:44 ******/
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
	[FeedBack] [nchar](2000) NULL,
 CONSTRAINT [PK_Players] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

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
