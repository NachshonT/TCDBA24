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

-- Betting an incorrect amount of money - more than the Player's Balance

set @PlayerId = 1
set @BetAmount = 3000

EXECUTE [dbo].[P_SlotMachinePlayRound] 
   @PlayerId
  ,@BetAmount
GO


