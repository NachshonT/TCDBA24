USE [Casino]
GO
/****** Object:  Table [dbo].[utbl_LoginHistory]    Script Date: 29/03/2019 10:21:25 ******/
DROP TABLE [dbo].[utbl_LoginHistory]
GO
/****** Object:  Table [dbo].[utbl_LoginHistory]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_LoginHistory](
	[PlayerId] [int] NOT NULL,
	[LoginFrom] [datetime] NOT NULL,
	[LoginTo] [datetime] NOT NULL,
	[LoginSuccessYN] [bit] NOT NULL,
 CONSTRAINT [PK_utbl_LoginHistory] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
