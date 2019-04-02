USE [Casino]
GO
/****** Object:  Table [dbo].[utbl_GameManagers]    Script Date: 02/04/2019 15:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_GameManagers](
	[GameManagerId] [int] NOT NULL,
	[GameManagerName] [nchar](10) NOT NULL,
 CONSTRAINT [PK_utbl_GameManagers] PRIMARY KEY CLUSTERED 
(
	[GameManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
