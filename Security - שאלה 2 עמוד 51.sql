USE [master]
GO
CREATE LOGIN [NewLogin] WITH PASSWORD=N'123', DEFAULT_DATABASE=[eDate], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

USE [eDate]
GO
CREATE USER [NewUser] FOR LOGIN [NewLogin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NewUser]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NewUser]
GO

-- Deny NewUser from all permissions on the Genders table
DENY ALL ON [Lists].[Genders] TO [NewUser]
GO

CREATE VIEW [Lists].[V_Genders]
AS
	SELECT *
	FROM Lists.Genders
GO

-- Grant NewUser all permissions on the V_Genders view
GRANT ALL ON [Lists].[V_Genders] TO [NewUser]
GO
