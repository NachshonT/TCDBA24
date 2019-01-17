-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 16.1.2019
-- Description:	This procedure creates a new database user with the same permissions as an existing user
-- =============================================
CREATE PROCEDURE P_DuplicateUser 
	@UserToDuplicateName SYSNAME, 
	@NewUserName SYSNAME, 
	@Success BIT OUTPUT
AS
BEGIN
	-- Initialize Success output parameter to... Failure
	SET @Success = 0

	-- Declare local variables
	DECLARE
		@PrincipalID INT,
		@PrincipalType CHAR(1),
		@DEFAULT_SCHEMA SYSNAME,
		@DEFAULT_LANGUAGE SYSNAME

	-- Get the UserToDuplicate's Properties into local variables
	SELECT
		@PrincipalID = sysPrincipals.principal_id,
		@PrincipalType = sysPrincipals.[type],
		@DEFAULT_SCHEMA = sysPrincipals.default_schema_name,
		@DEFAULT_LANGUAGE = sysPrincipals.default_language_lcid
	FROM sys.database_principals AS sysPrincipals
	WHERE sysPrincipals.name = @UserToDuplicateName

	-- Check if the UserToDuplicate was found, i.e., that there realy already is a User by the name @UserToDuplicateName
	IF @PrincipalID IS NULL
		RETURN

	-- Randomize an 8 digits Password
	DECLARE @stSQL NVARCHAR(200),
					@NewLoginName SYSNAME = @NewUserName,
					@PASSWORD NVARCHAR(100) = CONCAT
																		(
																			ROUND(RAND() * 9, 0),
																			ROUND(RAND() * 9, 0),
																			ROUND(RAND() * 9, 0),
																			ROUND(RAND() * 9, 0),
																			ROUND(RAND() * 9, 0),
																			ROUND(RAND() * 9, 0),
																			ROUND(RAND() * 9, 0),
																			ROUND(RAND() * 9, 0)
																		)
	--Principal type:
		--A = Application role
		--C = User mapped to a certificate
		--E = External user from Azure Active Directory
		--G = Windows group
		--K = User mapped to an asymmetric key
		--R = Database role
		--S = SQL user
		--U = Windows user
		--X = External group from Azure Active Directory group or applications
	SET @stSQL = CASE @PrincipalType
								WHEN 'S' THEN
									-- Create the SQL User
									'CREATE USER ' + @NewUserName + ' WITHOUT LOGIN WITH PASSWORD=' + @Password + ' DEFAULT_SCHEMA=' + @DEFAULT_SCHEMA + ' DEFAULT_LANGUAGE=' + @DEFAULT_LANGUAGE

								WHEN 'U' THEN
									-- Create the Login for the @NewUserName
									'USE [master] GO ' +
									'CREATE LOGIN ' + @NewLoginName + ' WITH PASSWORD=N''' + @Password + ''' , DEFAULT_DATABASE=' + DB_NAME() + ', DEFAULT_LANGUAGE=' + @DEFAULT_LANGUAGE + ', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF GO ' +

									-- Create the User associated with the newly created Login
									'USE ' + DB_NAME() + ' GO ' +
									'CREATE USER ' + @NewUserName + ' FOR LOGIN ' + @NewLoginName + ' GO '
							END

		-- Check if there's something to execute
		IF @stSQL IS NOT NULL
			BEGIN TRY
				EXECUTE @stSQL
			END TRY
			BEGIN CATCH
				RETURN
			END CATCH
		ELSE
			RETURN

		--Check if the User was created
		IF NOT EXISTS (SELECT [name] FROM sys.sysusers AS sysUsers WHERE sysUsers.name = @NewUserName)
			RETURN

	-- Get the @PrincipalID that corresponds to @UserToDuplicateName Permissions to be set for @NewUserName also
	SELECT sysPermisions.
	INTO #T_sysPermisions_Temp
	FROM sys.database_permissions AS sysPermisions
	WHERE sysPermisions.grantee_principal_id = 5 --@PrincipalID

	-- טוב, בשלב הזה קצת התעייפתי
	-- Probably a Cursor is needed here to iterate on the UserToDuplicate's Permissions and add a similar Permission to NewUser for each of them
	GRANT #T_sysPermisions_Temp.permission_name ON 

	-- Finaly, if the code got to here it means Success!
	SET @Success = 1
END
