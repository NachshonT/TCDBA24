USE [Casino]
GO
/****** Object:  Table [dbo].[utbl_CashOut]    Script Date: 02/04/2019 15:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_CashOut](
	[PlayerId] [int] NOT NULL,
	[BillingAddress] [nchar](50) NOT NULL,
	[PostalCode] [int] NOT NULL,
	[City] [nchar](10) NOT NULL,
	[Country] [nchar](10) NOT NULL,
	[CashoutAmount] [money] NOT NULL,
	[CashoutDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
