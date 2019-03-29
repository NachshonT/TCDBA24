USE [Casino]
GO
/****** Object:  Table [dbo].[utbl_SlotMachineGames]    Script Date: 29/03/2019 11:29:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_SlotMachineGames](
	[GameNo] [int] NOT NULL,
	[Wheel1] [int] NOT NULL,
	[Wheel2] [int] NOT NULL,
	[Wheel3] [int] NOT NULL,
	[IsWin] [bit] NOT NULL
) ON [PRIMARY]

GO
