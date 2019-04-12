USE [Casino]
GO

DECLARE @PlayerId int
DECLARE @BetAmount money

-- Betting the correct amount of money

set @PlayerId = 1
set @BetAmount = 10

EXECUTE [dbo].[P_SlotMachinePlayRound] 
   @PlayerId
  ,@BetAmount

-- Betting the incorrect amount of money (more than on the deposit)

set @PlayerId = 1
set @BetAmount = 30

EXECUTE [dbo].[P_SlotMachinePlayRound] 
   @PlayerId
  ,@BetAmount
GO


