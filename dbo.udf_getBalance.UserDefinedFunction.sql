USE [Casino]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_getBalance]    Script Date: 29/03/2019 10:21:25 ******/
DROP FUNCTION [dbo].[udf_getBalance]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_getBalance]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	Retrieves balance on the player account
-- =============================================
CREATE FUNCTION [dbo].[udf_getBalance] (@PlayerId int)
RETURNS MONEY
AS
BEGIN
	DECLARE @SumToAdd MONEY, @SumToSubtract MONEY
	 
	SELECT @SumToAdd = SUM(Amount)
	FROM utbl_Bankroll
	WHERE TransactionId IN (1, 2, 4) AND PlayerId = @PlayerId

	SELECT @SumToSubtract = SUM(Amount)
	FROM utbl_Bankroll
	WHERE TransactionId IN (3, 5) AND PlayerId = @PlayerId

	RETURN @SumToAdd - @SumToSubtract
END



GO
