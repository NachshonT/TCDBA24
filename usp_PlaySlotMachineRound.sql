USE [Casino]
GO

/****** Object:  StoredProcedure [dbo].[usp_PlaySlotMachineRound]    Script Date: 29/03/2019 12:57:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 29-03-2019
-- Description:	Round of Slot Machine game
-- =============================================
CREATE PROCEDURE [dbo].[usp_PlaySlotMachineRound]
	-- Add the parameters for the stored procedure here
	@PlayerId int,
	@BetAmount money


AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Wheel1 tinyint, @Wheel2 tinyint, @Wheel3 tinyint

   set @Wheel1 = rand (1-6)
   set @Wheel2 = rand (1-6)
   set @Wheel3 = rand (1-6)

   -- Check Round's outcome - win or lose
	if @Wheel1 = @Wheel2 and @Wheel2 = @Wheel3 -- Win!!!
		BEGIN
			-- 1. Insert round's outcome to utbl_GameRounds table
			insert into utbl_GameRounds (PlayerId, GameTypeId, BetAmount, IsWin)
			values (@PlayerId, 2, @BetAmount, 1)

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
			values (@PlayerId, 2, @BetAmount, 0)

			-- 2. Insert Lose amount to Bankroll table
			insert into utbl_Bankroll (PlayerId, TransactionTypeId, Amount)
			values (@PlayerId, 5, @BetAmount)

			-- 3. Return Lose
			RETURN 0
		END 


END

GO

