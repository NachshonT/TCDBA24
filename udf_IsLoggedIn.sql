USE [Casino]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_IsLoggedIn]    Script Date: 05/04/2019 12:01:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 05-04-2019
-- Description:	This function checks if the Player is logged in
-- =============================================
ALTER FUNCTION [dbo].[udf_IsLoggedIn](@PlayerId INT)
RETURNS BIT
AS
BEGIN
	DECLARE @IsLoggedIn bit = 0

   
	SELECT @IsLoggedIn = 1
	FROM [dbo].[utbl_LoginHistory] 
	WHERE PlayerId = @PlayerId AND 
			LoginFrom >= GETDATE () AND 
			LoginTo IS NULL AND 
			LoginSuccessYN = 1

	RETURN @IsLoggedIn 
END

