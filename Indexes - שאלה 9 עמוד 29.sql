SELECT *
  FROM [eDate].[Operation].[Members] WITH(FORCESEEK, INDEX(pk_Members_c_Id))
  WHERE [Id] NOT IN (5, 6, 7, 8)