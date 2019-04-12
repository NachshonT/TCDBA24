USE [Casino]
GO

DECLARE @RC int
DECLARE @PlayerId int
DECLARE @RequestedCardsCount tinyint
DECLARE @BetAmount money

-- Betting the correct amount of money 
set @PlayerId = 1
set @RequestedCardsCount = 3
set @BetAmount = 50

EXECUTE @RC = [dbo].[P_BlackJackPlayRound] 
   @PlayerId
  ,@RequestedCardsCount
  ,@BetAmount

-- Betting an invalid amount - more than the deposited amount
set @PlayerId = 1
set @RequestedCardsCount = 3
set @BetAmount = 2000

EXECUTE @RC = [dbo].[P_BlackJackPlayRound] 
   @PlayerId
  ,@RequestedCardsCount
  ,@BetAmount
GO


