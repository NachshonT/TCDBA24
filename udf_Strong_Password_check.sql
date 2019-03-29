

ALTER FUNCTION udf_Strong_Password_check (@Password nchar(10))
  
  Returns bit
  
AS
BEGIN
    Declare @result as tinyint
    
	    if exists (SELECT [Password] FROM utbl_MilionPasswords WHERE @Password = [Password]) 
		 
		 set @result = 0
		 ELSE
		 set @result = 1
	
	Return @result  				
END;