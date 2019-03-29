USE [Casino]
GO
/****** Object:  StoredProcedure [dbo].[usp_PlayerLogin]    Script Date: 29/03/2019 10:21:25 ******/
DROP PROCEDURE [dbo].[usp_PlayerLogin]
GO
/****** Object:  StoredProcedure [dbo].[usp_PlayerLogin]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	Login Procedure
-- =============================================
CREATE PROCEDURE [dbo].[usp_PlayerLogin] 
	@PlayerName nchar(10),
	@TryPassword nchar(10)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @PlayerId INT, @Password NCHAR(10)

	-- Get the PalyerId for the supplied PlayerName
	SELECT  @PlayerId = PlayerId
	FROM utbl_Players 
	WHERE PlayerName = @PlayerName

	
	-- Check if the supplied PalyerName is valid, that is, we got a PlayerId
	IF (@PlayerId IS NOT NULL)
		BEGIN
			-- Get the Password for the PlayerId
			SELECT @Password = Password
			FROM utbl_Players
			WHERE PlayerId = @PlayerId

			-- Check if the supplied Password matches the Player's Password
			IF (@Password = @TryPassword)
				BEGIN
					--Insert a new success row into the Login History table
					INSERT INTO utbl_LoginHistory (PlayerId, LoginFrom, LoginSuccessYN)
					VALUES (@PlayerId, GETDATE(), 1)

					-- Retrun success
					RETURN 1
				END
			ELSE
				BEGIN
					--Insert a new failure row into the Login History table
					INSERT INTO utbl_LoginHistory (PlayerId, LoginFrom, LoginSuccessYN)
					VALUES (@PlayerId, GETDATE(), 0)

					-- Retrun failure
					RETURN 0
				END
		END
	ELSE
		-- Retrun failure
		RETURN 0
END



GO
