USE [Casino]
GO
ALTER TABLE [dbo].[utbl_Deposits] DROP CONSTRAINT [CK_utbl_Deposit_MaxAmount]
GO
ALTER TABLE [dbo].[utbl_Deposits] DROP CONSTRAINT [CK_utbl_Deposit_ExpiryDate]
GO
ALTER TABLE [dbo].[utbl_Deposits] DROP CONSTRAINT [FK_utbl_Deposits_utbl_Bankroll]
GO
ALTER TABLE [dbo].[utbl_Deposits] DROP CONSTRAINT [DF_utbl_Deposit_DepositedOn]
GO
/****** Object:  Table [dbo].[utbl_Deposits]    Script Date: 29/03/2019 10:21:25 ******/
DROP TABLE [dbo].[utbl_Deposits]
GO
/****** Object:  Table [dbo].[utbl_Deposits]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Deposits](
	[TransactionId] [int] NOT NULL,
	[CCNumber] [char](17) NOT NULL,
	[ExpiryDate] [date] NOT NULL,
	[FirstName] [nchar](10) NOT NULL,
	[LastName] [nchar](10) NOT NULL,
	[DepositedOn] [datetime] NOT NULL,
	[DepositAmount] [money] NOT NULL,
 CONSTRAINT [PK_utbl_Deposit] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[utbl_Deposits] ADD  CONSTRAINT [DF_utbl_Deposit_DepositedOn]  DEFAULT (getdate()) FOR [DepositedOn]
GO
ALTER TABLE [dbo].[utbl_Deposits]  WITH NOCHECK ADD  CONSTRAINT [FK_utbl_Deposits_utbl_Bankroll] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[utbl_Bankroll] ([TransactionId])
GO
ALTER TABLE [dbo].[utbl_Deposits] NOCHECK CONSTRAINT [FK_utbl_Deposits_utbl_Bankroll]
GO
ALTER TABLE [dbo].[utbl_Deposits]  WITH CHECK ADD  CONSTRAINT [CK_utbl_Deposit_ExpiryDate] CHECK  (([ExpiryDate]>=getdate()))
GO
ALTER TABLE [dbo].[utbl_Deposits] CHECK CONSTRAINT [CK_utbl_Deposit_ExpiryDate]
GO
ALTER TABLE [dbo].[utbl_Deposits]  WITH CHECK ADD  CONSTRAINT [CK_utbl_Deposit_MaxAmount] CHECK  (([DepositAmount]=(1000)))
GO
ALTER TABLE [dbo].[utbl_Deposits] CHECK CONSTRAINT [CK_utbl_Deposit_MaxAmount]
GO
