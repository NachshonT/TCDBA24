USE [Casino]
GO
/****** Object:  UserDefinedFunction [dbo].[usf_Check_PW_stength]    Script Date: 29/03/2019 10:21:25 ******/
DROP FUNCTION [dbo].[usf_Check_PW_stength]
GO
/****** Object:  UserDefinedFunction [dbo].[usf_Check_PW_stength]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[usf_Check_PW_stength]

  (@Password nchar(10))
  
  Returns int
  

BEGIN
      DECLARE @Isstrong int;
    
	       If   
               @Password COLLATE Latin1_General_BIN LIKE '%[a-z]%[a-z]%' AND
               @Password COLLATE Latin1_General_BIN LIKE '%[A-Z]%[A-Z]%' AND
               @Password LIKE '%[0-9]%[0-9]%' AND
               --@Password LIKE '%[~!@#$%^&]%[~!@#$%^&]%' AND
               LEN(@Password) >= 5	
		    
	      SET @Isstrong = 1;
	      ELSE SET @Isstrong = 0;
		   
   Return @Isstrong;
END;


GO
