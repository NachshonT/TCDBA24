USE [Casino]
GO
/****** Object:  Index [UQ_Countries_CountryName]    Script Date: 29/03/2019 10:21:25 ******/
DROP INDEX [UQ_Countries_CountryName] ON [dbo].[utbl_Countries]
GO
/****** Object:  Table [dbo].[utbl_Countries]    Script Date: 29/03/2019 10:21:25 ******/
DROP TABLE [dbo].[utbl_Countries]
GO
/****** Object:  Table [dbo].[utbl_Countries]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Countries](
	[CountryId] [smallint] IDENTITY(1,1) NOT NULL,
	[CountryName] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Countries_CountryID] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_Countries_CountryName]    Script Date: 29/03/2019 10:21:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Countries_CountryName] ON [dbo].[utbl_Countries]
(
	[CountryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
