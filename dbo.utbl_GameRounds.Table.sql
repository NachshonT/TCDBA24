USE [Casino]
GO
/****** Object:  Table [dbo].[utbl_GameRounds]    Script Date: 29/03/2019 11:29:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_GameRounds](
	[GameRoundID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [int] NOT NULL,
	[GameTypeID] [tinyint] NOT NULL,
	[BetAmount] [money] NOT NULL,
	[BetMadeOn] [datetime] NOT NULL,
	[IsWin] [bit] NOT NULL,
 CONSTRAINT [PK_utbl_GameRounds] PRIMARY KEY CLUSTERED 
(
	[GameRoundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[utbl_GameRounds] ADD  CONSTRAINT [DF_utbl_GameRounds_BetMadeOn]  DEFAULT (getdate()) FOR [BetMadeOn]
GO
