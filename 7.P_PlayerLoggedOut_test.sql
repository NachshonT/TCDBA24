USE [Casino]
GO

DECLARE @RC int
DECLARE @PlayerId int

-- To log out the active user
set @PlayerId = 10

EXECUTE @RC = [dbo].[P_PlayerLogout] 
   @PlayerId




