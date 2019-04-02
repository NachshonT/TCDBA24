SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 29-03-2019
-- Description:	Round of Slot Machine game
-- =============================================
CREATE PROCEDURE usp_PlayBlackJackRound
	-- Add the parameters for the stored procedure here
	@PlayerId int,
	@BetAmount money,
	@NumOfCardsToDeal tinyint


AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Declare local temporary table variable to hold the values of the cards dealt to the Player
	DECLARE @utbl_DealtCards_Temp TABLE (CardSymbol TINYINT, CardValue TINYINT)

	DECLARE @CardDealt TINYINT = 1, @CardSymbol TINYINT, @CardValue TINYINT
	
	-- Randomize the Player's cards
	WHILE (@CardDealt <= @NumOfCardsToDeal)
		BEGIN
			INSERT INTO @utbl_DealtCards_Temp (CardType, CardValue)
			VALUES (RAND(1-4), RAND(1-13))

			-- Increment the counter
			SET @CardDealt += 1
		END


   -- Check Round's outcome - win or lose
	if-- Win!!!
		BEGIN
			-- 1. Insert round's outcome to utbl_GameRounds table
			insert into utbl_GameRounds (PlayerId, GameTypeId, BetAmount, IsWin)
			values (@PlayerId, 1, @BetAmount, 1)

			-- 2. Insert Win amount (BetAmount * 2) to Bankroll table
			insert into utbl_Bankroll (PlayerId, TransactionTypeId, Amount)
			values (@PlayerId, 4, @BetAmount * 2)

			-- 3. Return Win
			RETURN 1
		END
	ELSE -- Lose!!!
		BEGIN
			-- 1. Insert round's outcome to utbl_GameRounds table
			insert into utbl_GameRounds (PlayerId, GameTypeId, BetAmount, IsWin)
			values (@PlayerId, 1, @BetAmount, 0)

			-- 2. Insert Lose amount to Bankroll table
			insert into utbl_Bankroll (PlayerId, TransactionTypeId, Amount)
			values (@PlayerId, 5, @BetAmount)

			-- 3. Return Lose
			RETURN 0
		END 


END
GO
