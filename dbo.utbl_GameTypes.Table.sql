USE [Casino]
GO
/****** Object:  Table [dbo].[utbl_GameTypes]    Script Date: 29/03/2019 11:29:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_GameTypes](
	[GameTypeID] [tinyint] NOT NULL,
	[GameTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_utbl_GameTypes] PRIMARY KEY CLUSTERED 
(
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
