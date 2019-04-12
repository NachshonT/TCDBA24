USE [Casino]
GO
/****** Object:  Table [dbo].[T_ConfigParams]    Script Date: 12/04/2019 13:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_ConfigParams](
	[Key] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_T_ConfigParams] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Secondary1]
) ON [Secondary1]

GO
/****** Object:  Table [dbo].[T_Countries]    Script Date: 12/04/2019 13:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Countries](
	[CountryId] [smallint] IDENTITY(1,1) NOT NULL,
	[CountryName] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Countries_CountryID] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Secondary1]
) ON [Secondary1]

GO
/****** Object:  Table [dbo].[T_GameTypes]    Script Date: 12/04/2019 13:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_GameTypes](
	[GameTypeID] [tinyint] NOT NULL,
	[GameTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_utbl_GameTypes] PRIMARY KEY CLUSTERED 
(
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Secondary1]
) ON [Secondary1]

GO
/****** Object:  Table [dbo].[T_Genders]    Script Date: 12/04/2019 13:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Genders](
	[GenderId] [tinyint] NOT NULL,
	[Gender] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Secondary1]
) ON [Secondary1]

GO
/****** Object:  Table [dbo].[T_TransactionTypes]    Script Date: 12/04/2019 13:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_TransactionTypes](
	[TransactionTypeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[TransactionTypeName] [nchar](10) NOT NULL,
 CONSTRAINT [PK_TransactionType] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Secondary1]
) ON [Secondary1]

GO
INSERT [dbo].[T_ConfigParams] ([Key], [Value]) VALUES (N'FailedLoginsToBlock', N'5')
INSERT [dbo].[T_ConfigParams] ([Key], [Value]) VALUES (N'RegistrationBonus', N'10')
INSERT [dbo].[T_ConfigParams] ([Key], [Value]) VALUES (N'WinRatio', N'2')
INSERT [dbo].[T_GameTypes] ([GameTypeID], [GameTypeName]) VALUES (1, N'BlackJack')
INSERT [dbo].[T_GameTypes] ([GameTypeID], [GameTypeName]) VALUES (2, N'SlotMachine')
SET IDENTITY_INSERT [dbo].[T_TransactionTypes] ON 

INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (1, N'Bonus     ')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (2, N'Deposit   ')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (3, N'Win       ')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (4, N'Lose      ')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (5, N'Cashout   ')
SET IDENTITY_INSERT [dbo].[T_TransactionTypes] OFF
