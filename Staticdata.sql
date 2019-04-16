USE [Casino]
GO
/****** Object:  Table [dbo].[T_ConfigParams]    Script Date: 12/04/2019 13:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

INSERT [dbo].[T_ConfigParams] ([Key], [Value]) VALUES (N'FailedLoginsToBlock', N'5')
INSERT [dbo].[T_ConfigParams] ([Key], [Value]) VALUES (N'RegistrationBonus', N'10')
INSERT [dbo].[T_ConfigParams] ([Key], [Value]) VALUES (N'WinRatio', N'2')

INSERT [dbo].[T_GameTypes] ([GameTypeID], [GameTypeName]) VALUES (1, N'BlackJack')
INSERT [dbo].[T_GameTypes] ([GameTypeID], [GameTypeName]) VALUES (2, N'SlotMachine')

SET IDENTITY_INSERT [dbo].[T_TransactionTypes] ON 

INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (1, N'Bonus')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (2, N'Deposit')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (3, N'Win')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (4, N'Lose')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (5, N'Cashout')

SET IDENTITY_INSERT [dbo].[T_TransactionTypes] OFF

INSERT [dbo].[T_Genders] ([GenderId], [Gender]) VALUES (0, N'Male')
INSERT [dbo].[T_Genders] ([GenderId], [Gender]) VALUES (1, N'Female')
                                       
INSERT [dbo].[T_Countries] ([CountryId], [CountryName]) VALUES (1, N'Israel')
INSERT [dbo].[T_Countries] ([CountryId], [CountryName]) VALUES (2, N'USA')
INSERT [dbo].[T_Countries] ([CountryId], [CountryName]) VALUES (3, N'UK')

GO
