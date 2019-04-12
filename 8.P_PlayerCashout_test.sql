USE [Casino]
GO

DECLARE @RC int
DECLARE @PlayerId int
DECLARE @CashOutAmount money
DECLARE @BillingAddress nchar(50)
DECLARE @PostalCode int
DECLARE @City nchar(10)
DECLARE @CountryId smallint

-- Cashout a valid amount (less or equal to balance)

SET  @PlayerId  = 1
SET @CashOutAmount = 10

EXECUTE @RC = [dbo].[P_PlayerCashout] 
   @PlayerId
  ,@CashOutAmount
  ,@BillingAddress
  ,@PostalCode
  ,@City
  ,@CountryId



-- Cashout a invalid amount (more than balance amount)

SET  @PlayerId  = 1
SET @CashOutAmount = 1000

EXECUTE @RC = [dbo].[P_PlayerCashout] 
   @PlayerId
  ,@CashOutAmount
  ,@BillingAddress
  ,@PostalCode
  ,@City
  ,@CountryId
GO





