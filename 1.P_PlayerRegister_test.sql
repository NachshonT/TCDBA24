USE [Casino]
GO

DECLARE @RC int
DECLARE @PlayerName nchar(10)
DECLARE @Password nchar(10)
DECLARE @FIrstName nchar(20)
DECLARE @LastName nchar(20)
DECLARE @Address nchar(100)
DECLARE @CountryID smallint
DECLARE @Email nchar(100)
DECLARE @GenderID tinyint
DECLARE @BirthDay date

--registering a valid player

SET @PlayerName = 'Alex'
SET  @Password = 'Al45677'
SET  @FIrstName = 'Alex'
SET  @LastName = 'Krigel'
SET  @Address = 'Gedera'
SET  @CountryID = 1
SET  @Email = 'ak@gmail.com'
SET @GenderID = 0
SET @BirthDay = '23-Jan-1995'

EXECUTE @RC = [dbo].[P_PlayerRegister] 
   @PlayerName
  ,@Password
  ,@FIrstName
  ,@LastName
  ,@Address
  ,@CountryID
  ,@Email
  ,@GenderID
  ,@BirthDay
GO


USE [Casino]
GO

DECLARE @RC int
DECLARE @PlayerName nchar(10)
DECLARE @Password nchar(10)
DECLARE @FIrstName nchar(20)
DECLARE @LastName nchar(20)
DECLARE @Address nchar(100)
DECLARE @CountryID smallint
DECLARE @Email nchar(100)
DECLARE @GenderID tinyint
DECLARE @BirthDay date
--registering a not valid player (same user name)

SET @PlayerName = 'Alex'
SET  @Password = 'Al45677'
SET  @FIrstName = 'Alex'
SET  @LastName = 'Krigel'
SET  @Address = 'Gedera'
SET  @CountryID = 1
SET  @Email = 'ak@gmail.com'
SET @GenderID = 0
SET @BirthDay = '23-Jan-1995'

EXECUTE @RC = [dbo].[P_PlayerRegister] 
   @PlayerName
  ,@Password
  ,@FIrstName
  ,@LastName
  ,@Address
  ,@CountryID
  ,@Email
  ,@GenderID
  ,@BirthDay
GO



