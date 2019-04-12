USE [Casino]
GO

DECLARE @RC int
DECLARE @PlayerName nvarchar(10)
DECLARE @TryPassword nvarchar(10)

-- Loging in with correct user and password

set @PlayerName = 'Alex'
set @TryPassword = 'Al45677'

EXECUTE @RC = [dbo].[P_PlayerLogin] 
   @PlayerName
  ,@TryPassword
GO

USE [Casino]
GO

DECLARE @RC int
DECLARE @PlayerName nvarchar(10)
DECLARE @TryPassword nvarchar(10)

-- Loging in with correct user and but incorrect password (user already logged in)

set @PlayerName = 'Alex'
set @TryPassword = 'Al45678'

EXECUTE @RC = [dbo].[P_PlayerLogin] 
   @PlayerName
  ,@TryPassword
GO





