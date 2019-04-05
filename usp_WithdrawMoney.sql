USE [Casino]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCashOutAmount]    Script Date: 05/04/2019 10:45:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_WithdrawMoney]
	@PlayerId INT,
	@CashOutAmount MONEY,
	@BillingAddress NCHAR(50),
	@PostalCode INT,
	@City NCHAR(10),
	@Country NCHAR(10)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Balance money

	-- Get the Player's Balance 
	SET @Balance = dbo.udf_getBalance(@PlayerId)

    -- Check if the requested CashOut Amount is within the Player's Balance, that is, if the withdrawl is allowed
	IF @Balance >= @CashoutAmount
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION tr_WithdrawMoney

					-- 1. Insert the CashOut Amount to the Bankroll table
					INSERT INTO utbl_Bankroll(PlayerId, TransactionTypeId, CommitedOn, Amount)
					VALUES (@PlayerId, 5/*CashOunt*/, GETDATE(), @CashOutAmount)

					-- 2. Insert the CashOut Details - where to send the cheque to - to the CashOut table
					INSERT INTO utbl_CashOut ([PlayerId], [BillingAddress], [PostalCode], [City], [Country], [CashoutAmount], [CashoutDate])
					VALUES (@PlayerId, @BillingAddress , @PostalCode, @City, @Country, @CashOutAmount, GETDATE())

					-- 2. Return allowed 
					RETURN 1
				COMMIT TRANSACTION tr_WithdrawMoney
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION tr_WithdrawMoney
			END CATCH
		END
	ELSE
		-- the amount of cashout is more than the balance and hence not allowed
		BEGIN
			-- 1. denying withdrawl
			PRINT 'The amount is not allowed for withdrawl, please check your balance.'
			
			-- 3. Return not allowed
			RETURN 0
		END
END


