USE [Casino]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_IsBlocked]    Script Date: 29/03/2019 10:21:25 ******/
DROP FUNCTION [dbo].[udf_IsBlocked]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_IsBlocked]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	This function checks if the Player is blocked
-- =============================================
CREATE FUNCTION [dbo].[udf_IsBlocked](@PlayerId INT)
RETURNS BIT
AS
BEGIN
	RETURN 0
END



GO
