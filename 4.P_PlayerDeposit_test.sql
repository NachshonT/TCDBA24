USE [Casino]
GO

DECLARE @PlalyerId int
DECLARE @DepositAmount money

-- Depositin a valid amount
set @PlalyerId = 1
set @DepositAmount = 200


EXECUTE [dbo].[P_PlayerDeposit] 
   @PlalyerId
  ,@DepositAmount


-- Depositing an invalid amount (Deposited valued are limited by configureable value inititaly set to 1000)
set @PlalyerId = 1
set @DepositAmount = 1200


EXECUTE [dbo].[P_PlayerDeposit] 
   @PlalyerId
  ,@DepositAmount
GO
