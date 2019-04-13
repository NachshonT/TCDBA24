USE [Casino]
GO

DECLARE @RC int
DECLARE @PlalyerId int
DECLARE @BonusAmount money

-- Bonus amount 
set  @PlalyerId = 1  
set @BonusAmount = 10	

EXECUTE @RC = [dbo].[P_PlayerGrantBonus] 
   @PlalyerId
  ,@BonusAmount
GO


