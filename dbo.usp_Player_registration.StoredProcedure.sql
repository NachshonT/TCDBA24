USE [Casino]
GO
/****** Object:  StoredProcedure [dbo].[usp_Player_registration]    Script Date: 29/03/2019 10:21:25 ******/
DROP PROCEDURE [dbo].[usp_Player_registration]
GO
/****** Object:  StoredProcedure [dbo].[usp_Player_registration]    Script Date: 29/03/2019 10:21:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_Player_registration](

 @UserID INT, 
 @PlayerName nchar(10),
 @Password nchar(10),
 @FIrstName nchar(20), 
 @LastName nchar(20),
 @Address nchar(100),
 @CountryID smallint,
 @Email nchar(100),
 @GenderID tinyint,
 @BirthDay date)

 
AS  
BEGIN  
      insert into dbo.utbl_Players  (PlayerId,PlayerName, [Password], FirstName, LastName, [Address], CountryId, Email, GenderId, Birthdate)
      values( @UserID, @PlayerName, @Password, @FIrstName, @LastName, @Address, @CountryID, @Email, @GenderID, @BirthDay)  
END  





GO
