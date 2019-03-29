USE [Casino]
GO
/****** Object:  Table [dbo].[utbl_Gender]    Script Date: 29/03/2019 10:21:25 ******/
DROP TABLE [dbo].[utbl_Gender]
GO
/****** Object:  Table [dbo].[utbl_Gender]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Gender](
	[GenderId] [tinyint] IDENTITY(1,1) NOT NULL,
	[Gender] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
