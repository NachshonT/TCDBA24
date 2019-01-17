USE [eDate]
GO

/****** Object:  View [dbo].[MemberSessionsStatistics]    Script Date: 03/01/2019 21:43:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MemberSessionsStatistics]
AS
SELECT  'Country' AS GroupCategory,
	C.Name AS GroupValue, 
	COUNT(*) AS CountOfSessions,
	AVG(DATEDIFF(s, MS.LoginDateTime, MS.EndDateTime)) AS AvgSessionDuration
FROM Operation.MemberSessions AS MS
	INNER JOIN Operation.Members AS M
		ON MS.MemberId = M.Id
	INNER JOIN Lists.Countries AS C
		ON M.CountryId = C.Id
--WHERE MS.EndDateTime IS NOT NULL
GROUP BY C.Name

UNION

SELECT 
	'Gender' AS GroupCategory,
	G.Name AS GroupValue, 
	COUNT(*) AS CountOfSessions,
	AVG(DATEDIFF(s, MS.LoginDateTime, MS.EndDateTime)) AS AvgSessionDuration
FROM Operation.MemberSessions AS MS
	INNER JOIN Operation.Members AS M
		ON MS.MemberId = M.Id
	INNER JOIN Lists.Genders AS G
		ON M.GenderId = G.Id
--WHERE MS.EndDateTime IS NOT NULL
GROUP BY G.Name

UNION

SELECT
	'Marital Status' AS GroupCategory,
	M_S.Name AS GroupValue, 
	COUNT(*) AS CountOfSessions,
	AVG(DATEDIFF(s, MS.LoginDateTime, MS.EndDateTime)) AS AvgSessionDuration
FROM Operation.MemberSessions AS MS
	INNER JOIN Operation.Members AS M
		ON MS.MemberId = M.Id
	INNER JOIN Lists.MaritalStatuses AS M_S
		ON M.MaritalStatusId = M_S.Id
--WHERE MS.EndDateTime IS NOT NULL
GROUP BY M_S.Name
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MemberSessions (Operation)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 166
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Members (Operation)"
            Begin Extent = 
               Top = 16
               Left = 301
               Bottom = 140
               Right = 507
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Countries (Lists)"
            Begin Extent = 
               Top = 183
               Left = 488
               Bottom = 275
               Right = 659
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Genders (Lists)"
            Begin Extent = 
               Top = 6
               Left = 700
               Bottom = 98
               Right = 871
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MaritalStatuses (Lists)"
            Begin Extent = 
               Top = 136
               Left = 888
               Bottom = 228
               Right = 1059
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MemberSessionsStatistics'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MemberSessionsStatistics'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MemberSessionsStatistics'
GO


