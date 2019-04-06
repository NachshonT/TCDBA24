USE [master]
GO
/****** Object:  Database [Casino]    Script Date: 06/04/2019 16:49:26 ******/
CREATE DATABASE [Casino]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CasinoPrimary', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\UserDBs\Casino\Casino.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [SCONDARY] 
( NAME = N'CasinoSecondary1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\UserDBs\Casino\Casino1.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
( NAME = N'CasinoSecondary2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\UserDBs\Casino\Casino2.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Casino_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\UserDBs\Casino\Casino.log' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Casino] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Casino].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Casino] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Casino] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Casino] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Casino] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Casino] SET ARITHABORT OFF 
GO
ALTER DATABASE [Casino] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Casino] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Casino] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Casino] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Casino] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Casino] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Casino] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Casino] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Casino] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Casino] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Casino] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Casino] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Casino] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Casino] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Casino] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Casino] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Casino] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Casino] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Casino] SET RECOVERY FULL 
GO
ALTER DATABASE [Casino] SET  MULTI_USER 
GO
ALTER DATABASE [Casino] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Casino] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Casino] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Casino] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Casino]
GO
/****** Object:  UserDefinedTableType [dbo].[T_DealtCardsType]    Script Date: 06/04/2019 16:49:26 ******/
CREATE TYPE [dbo].[T_DealtCardsType] AS TABLE(
	[CardId] [tinyint] NULL,
	[Symbol] [tinyint] NULL,
	[FaceNumber] [tinyint] NULL,
	[AlreadyDelt] [bit] NULL
)
GO
/****** Object:  StoredProcedure [dbo].[P_DealCards]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 06-04-2019
-- Description:	This function returns a temporary table of @CountOfCardsToDeal dealt cards out of a @PackOfCards
-- =============================================
CREATE PROCEDURE [dbo].[P_DealCards]
(
	@T_FreshPackOfCards T_DealtCardsType READONLY,
	@CountOfCardsToDeal TINYINT
)
AS
BEGIN
	DECLARE @T_DealtCards TABLE
	(
		[Symbol] [tinyint] NULL,
		[FaceNumber] [tinyint] NULL
	)

	DECLARE @DealtCardId TINYINT, @i TINYINT = 1

	-- Iterate to the Count Of Cards To Deal
	WHILE @i <= @CountOfCardsToDeal
	BEGIN
		-- Randomly 'pick' a card from
		SET @DealtCardId = RAND (1-52)

		-- Insert the 'picked' card to the @T_FreshPackOfCards table variable
		INSERT INTO @T_DealtCards (Symbol, FaceNumber)
		SELECT Symbol, FaceNumber
		FROM @T_FreshPackOfCards 
		WHERE CardId = @DealtCardId AND AlreadyDelt = 0

		SET @i += 1
	END

	SELECT * from @T_DealtCards
END


GO
/****** Object:  StoredProcedure [dbo].[P_GetCashOutAmount]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_GetCashOutAmount]
	@PlayerId int,
	@CashOutAmount money
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @balance money

	-- Get the Player's Balance 
	SET @balance = dbo.udf_getBalance(@PlayerId)

    -- Check Round's outcome - win or lose
	if @balance >= @CashoutAmount -- the amount of cashout is allowed for withdrawl
		BEGIN
			-- 1. Insert round's outcome to utbl_GameRounds table
			insert into utbl_CashOut (PlayerId, CashoutAmount, CashoutDate)
			values (@PlayerId, @CashOutAmount, getdate())

			-- 2. Return allowed 
			RETURN 1
		END

	else
	 -- the amount of cashout is more than the balance and hence not allowed
		BEGIN
			-- 1. denying withdrawl
			print 'The amount is not allowed for withdrawl, please check your balance.'

			
			-- 3. Return not allowed
			RETURN 0
			END
END





GO
/****** Object:  StoredProcedure [dbo].[P_PlayBJRound]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 06-04-2019
-- Description:	Round of Black Jack Game
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayBJRound] 
	@PlayerId int, 
	@RequestedCardsCount tinyint

AS
BEGIN
	SET NOCOUNT ON;
	--Deal the request cards count to the player.

	--DECLARE @T_DealtCards [dbo].[T_DealtCardsType]
	--EXECUTE @T_DealtCards = dbo.P_DealCards(
	
	 -- Check if the sum exceeds 21


	 --Check the dealer's count of cards


	 --Check if dealers cards total more or less 21



END

GO
/****** Object:  StoredProcedure [dbo].[P_PlayerLogin]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	Login Procedure
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerLogin] 
	@PlayerName nchar(10),
	@TryPassword nchar(10)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @PlayerId INT, @Password NCHAR(10)

	-- Get the PalyerId for the supplied PlayerName
	SELECT  @PlayerId = PlayerId
	FROM T_Players 
	WHERE PlayerName = @PlayerName

	
	-- Check if the supplied PalyerName is valid, that is, we got a PlayerId
	IF (@PlayerId IS NOT NULL)
		BEGIN
			-- Get the Password for the PlayerId
			SELECT @Password = Password
			FROM T_Players
			WHERE PlayerId = @PlayerId

			-- Check if the supplied Password matches the Player's Password
			IF (@Password = @TryPassword)
				BEGIN
					--Insert a new success row into the Login History table
					INSERT INTO T_LoginHistory (PlayerId, LoginFrom, IsSuccessfullLogin)
					VALUES (@PlayerId, GETDATE(), 1)

					-- Retrun success
					RETURN 1
				END
			ELSE
				BEGIN
					--Insert a new failure row into the Login History table
					INSERT INTO T_LoginHistory (PlayerId, LoginFrom, IsSuccessfullLogin)
					VALUES (@PlayerId, GETDATE(), 0)

					-- Retrun failure
					RETURN 0
				END
		END
	ELSE
		-- Retrun failure
		RETURN 0
END






GO
/****** Object:  StoredProcedure [dbo].[P_PlayerRegister]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[P_PlayerRegister]
(
	@UserID INT, 
	@PlayerName NCHAR(10),
	@Password NCHAR(10),
	@FIrstName NCHAR(20), 
	@LastName NCHAR(20),
	@Address NCHAR(100),
	@CountryID SMALLINT,
	@Email NCHAR(100),
	@GenderID TINYINT,
	@BirthDay DATE
)

 
AS  
BEGIN  
	INSERT INTO dbo.T_Players
	(
		PlayerId,
		PlayerName,
		[Password],
		FirstName,
		LastName,
		[Address],
		CountryId,
		Email,
		GenderId,
		Birthdate
	)
	VALUES
	(
		@UserID,
		@PlayerName,
		@Password,
		@FIrstName,
		@LastName,
		@Address,
		@CountryID,
		@Email,
		@GenderID,
		@BirthDay
	)  
END  








GO
/****** Object:  StoredProcedure [dbo].[P_PlaySlotMachineRound]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 29-03-2019
-- Description:	Round of Slot Machine game
-- =============================================
CREATE PROCEDURE [dbo].[P_PlaySlotMachineRound]
	@PlayerId INT,
	@BetAmount MONEY

AS

BEGIN

	SET NOCOUNT ON;

	DECLARE @Wheel1 TINYINT, @Wheel2 TINYINT, @Wheel3 TINYINT

	SET @Wheel1 = rand (1-6)
  SET @Wheel2 = rand (1-6)
  SET @Wheel3 = rand (1-6)

   -- Check Round's outcome - win or lose
	IF @Wheel1 = @Wheel2 and @Wheel2 = @Wheel3 -- Win!!!
		BEGIN
			-- 1. Insert round's outcome to T_GameRounds table
			INSERT INTO T_GameRounds (PlayerId, GameTypeId, BetAmount, IsWin)
			VALUES (@PlayerId, 2, @BetAmount, 1)

			-- 2. Insert Win amount (BetAmount * 2) to Bankroll table
			INSERT INTO T_Bankroll (PlayerId, TransactionTypeId, Amount)
			VALUES (@PlayerId, 4, @BetAmount * 2)

			-- 3. Return Win
			RETURN 1
		END
	ELSE -- Lose!!!
		BEGIN
			-- 1. Insert round's outcome to T_GameRounds table
			INSERT INTO T_GameRounds (PlayerId, GameTypeId, BetAmount, IsWin)
			VALUES (@PlayerId, 2, @BetAmount, 0)

			-- 2. Insert Lose amount to Bankroll table
			INSERT INTO T_Bankroll (PlayerId, TransactionTypeId, Amount)
			VALUES (@PlayerId, 5, @BetAmount)

			-- 3. Return Lose
			RETURN 0
		END 
END




GO
/****** Object:  StoredProcedure [dbo].[P_SuggestPlayerName]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 6.4.2019
-- Description:	This procedure is used to suggest a non existing PlayerName when a new registering Player chooses an already existing PlayerName
-- =============================================
CREATE PROCEDURE [dbo].[P_SuggestPlayerName] 
(
	@ChosenExistingPlayerName NVARCHAR(10),
	@SuggestedPlayerName NVARCHAR(10) OUTPUT
)
AS
BEGIN
	DECLARE @CountExisting TINYINT

	WHILE 1 = 1
		BEGIN
			SET @SuggestedPlayerName = @ChosenExistingPlayerName + ROUND(RAND() * 1000, 0)
			
			SELECT @CountExisting = COUNT(*) FROM T_Players WHERE PlayerName = @SuggestedPlayerName

			IF @CountExisting = 0
				RETURN
		END

END


GO
/****** Object:  StoredProcedure [dbo].[P_WithdrawMoney]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_WithdrawMoney]
	@PlayerId INT,
	@CashOutAmount MONEY,
	@BillingAddress NCHAR(50),
	@PostalCode INT,
	@City NCHAR(10),
	@Country NCHAR(10)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Balance money

	-- Get the Player's Balance 
	SET @Balance = dbo.udf_getBalance(@PlayerId)

    -- Check if the requested CashOut Amount is within the Player's Balance, that is, if the withdrawl is allowed
	IF @Balance >= @CashoutAmount
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION tr_WithdrawMoney

					-- 1. Insert the CashOut Amount to the Bankroll table
					INSERT INTO utbl_Bankroll(PlayerId, TransactionTypeId, CommitedOn, Amount)
					VALUES (@PlayerId, 5/*CashOunt*/, GETDATE(), @CashOutAmount)

					-- 2. Insert the CashOut Details - where to send the cheque to - to the CashOut table
					INSERT INTO utbl_CashOut ([PlayerId], [BillingAddress], [PostalCode], [City], [Country], [CashoutAmount], [CashoutDate])
					VALUES (@PlayerId, @BillingAddress , @PostalCode, @City, @Country, @CashOutAmount, GETDATE())

					-- 2. Return allowed 
					RETURN 1
				COMMIT TRANSACTION tr_WithdrawMoney
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION tr_WithdrawMoney
			END CATCH
		END
	ELSE
		-- the amount of cashout is more than the balance and hence not allowed
		BEGIN
			-- 1. denying withdrawl
			PRINT 'The amount is not allowed for withdrawl, please check your balance.'
			
			-- 3. Return not allowed
			RETURN 0
		END
END





GO
/****** Object:  UserDefinedFunction [dbo].[F_PasswordIsStrong]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[F_PasswordIsStrong]
(
	@Password NVARCHAR(10),
	@PlayerName NVARCHAR(10)
)

RETURNS BIT

BEGIN

	DECLARE @IsStrong BIT = 0

	-- A 'Strong' Password meets the following cumulative characteristics :

	-- 1. It is at least 5 characters long
	IF LEN(@Password) >= 5

		-- 2. It is a combination of at least 1 capital letter, at least 1 small letter and at least 1 digit
		IF @Password LIKE '%[A-Z]%' AND
				@Password LIKE '%[a-z]%' AND
				@Password LIKE '%[0-9]%'

			-- 3. It is not equal to the PlayerName
			IF @Password != @PlayerName

				-- 4. It does not contain any combination of capital letters / small letters / digits of the word 'password'
				--		like 'password7' or 'pass3word'
				IF LOWER(@Password) NOT LIKE '%[0-9]%p%[0-9]%a%[0-9]%s%[0-9]%s%[0-9]%w%[0-9]%o%[0-9]%r%[0-9]%d%[0-9]%'

					-- 5. It does not apear in the list of 1 million frequently used passwords
					IF NOT EXISTS (SELECT * FROM T_MillionPasswords WHERE [Password] = @Password)
						SET @IsStrong = 1

	RETURN @IsStrong
END;





GO
/****** Object:  UserDefinedFunction [dbo].[F_PlayerBalance]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	Retrieves balance on the player account
-- =============================================
CREATE FUNCTION [dbo].[F_PlayerBalance] (@PlayerId int)
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
/****** Object:  UserDefinedFunction [dbo].[F_PlayerIsBlocked]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	This function checks if the Player is blocked
-- =============================================
CREATE FUNCTION [dbo].[F_PlayerIsBlocked](@PlayerId INT)
RETURNS BIT
AS
BEGIN
	DECLARE @FailedRecentLoginAttemptsCount TINYINT, @IsBlocked BIT

	SELECT TOP 1 @FailedRecentLoginAttemptsCount = COUNT(IsSuccessfullLogin) OVER (PARTITION BY [IsSuccessfullLogin] ORDER BY LoginFrom DESC)
	FROM T_LoginHistory
	WHERE PlayerId = @PlayerId AND IsSuccessfullLogin = 0

	IF (@FailedRecentLoginAttemptsCount >= 5)
		SET @IsBlocked = 1
	ELSE
		SET @IsBlocked = 0

	RETURN @IsBlocked

END






GO
/****** Object:  UserDefinedFunction [dbo].[F_PlayerIsLoggedIn]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 05-04-2019
-- Description:	This function checks if the Player is logged in
-- =============================================
CREATE FUNCTION [dbo].[F_PlayerIsLoggedIn](@PlayerId INT)
RETURNS BIT
AS
BEGIN
	DECLARE @IsLoggedIn bit = 0

   
	SELECT @IsLoggedIn = 1
	FROM [dbo].[utbl_LoginHistory] 
	WHERE PlayerId = @PlayerId AND 
			LoginFrom <= GETDATE () AND 
			LoginTo IS NULL AND 
			LoginSuccessYN = 1

	RETURN @IsLoggedIn 
END


GO
/****** Object:  Table [dbo].[T_Bankroll]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Bankroll](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[PlayerId] [int] NOT NULL,
	[TransactionTypeId] [tinyint] NOT NULL,
	[CommitedOn] [datetime] NOT NULL,
	[Amount] [money] NOT NULL,
 CONSTRAINT [PK_utbl_Bankroll_TransactionId] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_BJDealtCards]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_BJDealtCards](
	[RoundId] [int] NOT NULL,
	[FaceNumber] [tinyint] NOT NULL,
	[Symbol] [tinyint] NOT NULL,
	[IsHouse] [bit] NOT NULL,
	[CreatedOn] [timestamp] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_BJRounds]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_BJRounds](
	[BJRoundId] [int] NOT NULL,
	[PlayerId] [int] NOT NULL,
	[IsWin] [bit] NULL,
 CONSTRAINT [PK_T_BJRounds] PRIMARY KEY CLUSTERED 
(
	[BJRoundId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_CashOut]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_CashOut](
	[PlayerId] [int] NOT NULL,
	[BillingAddress] [nchar](50) NOT NULL,
	[PostalCode] [int] NOT NULL,
	[City] [nchar](10) NOT NULL,
	[Country] [nchar](10) NOT NULL,
	[CashoutAmount] [money] NOT NULL,
	[CashoutDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Countries]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Countries](
	[CountryId] [smallint] IDENTITY(1,1) NOT NULL,
	[CountryName] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Countries_CountryID] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Deposits]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_Deposits](
	[TransactionId] [int] NOT NULL,
	[CCNumber] [char](17) NOT NULL,
	[ExpiryDate] [date] NOT NULL,
	[FirstName] [nchar](10) NOT NULL,
	[LastName] [nchar](10) NOT NULL,
	[DepositedOn] [datetime] NOT NULL,
	[DepositAmount] [money] NOT NULL,
 CONSTRAINT [PK_utbl_Deposit] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_GameManagers]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_GameManagers](
	[GameManagerId] [int] NOT NULL,
	[GameManagerName] [nchar](10) NOT NULL,
 CONSTRAINT [PK_utbl_GameManagers] PRIMARY KEY CLUSTERED 
(
	[GameManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_GameRounds]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_GameRounds](
	[GameRoundID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [int] NOT NULL,
	[GameTypeID] [tinyint] NOT NULL,
	[BetAmount] [money] NOT NULL,
	[BetMadeOn] [datetime] NOT NULL,
	[IsWin] [bit] NOT NULL,
 CONSTRAINT [PK_utbl_GameRounds] PRIMARY KEY CLUSTERED 
(
	[GameRoundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_GameTypes]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_GameTypes](
	[GameTypeID] [tinyint] NOT NULL,
	[GameTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_utbl_GameTypes] PRIMARY KEY CLUSTERED 
(
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Gender]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Gender](
	[GenderId] [tinyint] IDENTITY(1,1) NOT NULL,
	[Gender] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_LoginHistory]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_LoginHistory](
	[PlayerId] [int] NOT NULL,
	[LoginFrom] [datetime] NOT NULL,
	[LoginTo] [datetime] NOT NULL,
	[IsSuccessfullLogin] [bit] NOT NULL,
 CONSTRAINT [PK_utbl_LoginHistory] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC,
	[LoginFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_MillionPasswords]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_MillionPasswords](
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_utbl_MillionPasswords] PRIMARY KEY CLUSTERED 
(
	[Password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_PackOfCards]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_PackOfCards](
	[CardID] [tinyint] IDENTITY(1,1) NOT NULL,
	[FaceNumber] [tinyint] NOT NULL,
	[Symbol] [tinyint] NOT NULL,
 CONSTRAINT [PK_T_PackOfCards] PRIMARY KEY CLUSTERED 
(
	[CardID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_PasswordHistory]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_PasswordHistory](
	[PlayerId] [int] NOT NULL,
	[Password] [nchar](10) NOT NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[EffectiveTo] [datetime] NULL,
 CONSTRAINT [PK_PasswordHistory] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC,
	[EffectiveFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Players]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Players](
	[PlayerId] [int] NOT NULL,
	[PlayerName] [nvarchar](10) NOT NULL,
	[Password] [nvarchar](10) NOT NULL,
	[FirstName] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NULL,
	[Address] [nvarchar](100) NULL,
	[CountryId] [smallint] NULL,
	[Email] [nvarchar](100) NULL,
	[GenderId] [tinyint] NULL,
	[Birthdate] [date] NULL,
	[Balance]  AS ([dbo].[F_PlayerBalance]([PlayerId])),
	[IsBlocked]  AS ([dbo].[F_PlayerIsBlocked]([PlayerId])),
	[IsLoggedIn]  AS ([dbo].[F_PlayerIsLoggedIn]([PlayerId])),
 CONSTRAINT [PK_T_Players_PlayerId] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_SlotMachineGames]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_SlotMachineGames](
	[GameNo] [int] NOT NULL,
	[Wheel1] [int] NOT NULL,
	[Wheel2] [int] NOT NULL,
	[Wheel3] [int] NOT NULL,
	[IsWin] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_TransactionType]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_TransactionType](
	[TransactionTypeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[TransactionTypeName] [nchar](10) NOT NULL,
 CONSTRAINT [PK_TransactionType] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[F_GetFreshPackOfCards]    Script Date: 06/04/2019 16:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
--  Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 06-04-2019
-- Description:	This function returns a fresh pack of cards from T_PackOfCards
-- =============================================
CREATE FUNCTION [dbo].[F_GetFreshPackOfCards]
(
)
RETURNS TABLE 
AS
RETURN 
(
	
	SELECT * from T_PackOfCards
)

GO
/****** Object:  Index [IX_utbl_Bankroll_PlayerId]    Script Date: 06/04/2019 16:49:26 ******/
CREATE NONCLUSTERED INDEX [IX_utbl_Bankroll_PlayerId] ON [dbo].[T_Bankroll]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_utbl_Bankroll_TransactionTypeId]    Script Date: 06/04/2019 16:49:26 ******/
CREATE NONCLUSTERED INDEX [IX_utbl_Bankroll_TransactionTypeId] ON [dbo].[T_Bankroll]
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_utbl_Bankroll_PlayerId_TransactionId]    Script Date: 06/04/2019 16:49:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_utbl_Bankroll_PlayerId_TransactionId] ON [dbo].[T_Bankroll]
(
	[PlayerId] ASC,
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_Countries_CountryName]    Script Date: 06/04/2019 16:49:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Countries_CountryName] ON [dbo].[T_Countries]
(
	[CountryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PackOfCards_Symbol_FaceNumber]    Script Date: 06/04/2019 16:49:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_PackOfCards_Symbol_FaceNumber] ON [dbo].[T_PackOfCards]
(
	[Symbol] ASC,
	[FaceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PasswordHistory]    Script Date: 06/04/2019 16:49:26 ******/
CREATE NONCLUSTERED INDEX [IX_PasswordHistory] ON [dbo].[T_PasswordHistory]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_T_Players_CountryId]    Script Date: 06/04/2019 16:49:26 ******/
CREATE NONCLUSTERED INDEX [IX_T_Players_CountryId] ON [dbo].[T_Players]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_T_Players_Email]    Script Date: 06/04/2019 16:49:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_T_Players_Email] ON [dbo].[T_Players]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_T_Players_PlayerName]    Script Date: 06/04/2019 16:49:26 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_T_Players_PlayerName] ON [dbo].[T_Players]
(
	[PlayerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T_Bankroll] ADD  CONSTRAINT [DF_utbl_Bankroll_CommitedOn]  DEFAULT (getdate()) FOR [CommitedOn]
GO
ALTER TABLE [dbo].[T_Deposits] ADD  CONSTRAINT [DF_utbl_Deposit_DepositedOn]  DEFAULT (getdate()) FOR [DepositedOn]
GO
ALTER TABLE [dbo].[T_GameRounds] ADD  CONSTRAINT [DF_utbl_GameRounds_BetMadeOn]  DEFAULT (getdate()) FOR [BetMadeOn]
GO
ALTER TABLE [dbo].[T_Bankroll]  WITH CHECK ADD  CONSTRAINT [FK_utbl_Bankroll_utbl_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[T_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[T_Bankroll] CHECK CONSTRAINT [FK_utbl_Bankroll_utbl_Players]
GO
ALTER TABLE [dbo].[T_Bankroll]  WITH CHECK ADD  CONSTRAINT [FK_utbl_Bankroll_utbl_TransactionType] FOREIGN KEY([TransactionTypeId])
REFERENCES [dbo].[T_TransactionType] ([TransactionTypeId])
GO
ALTER TABLE [dbo].[T_Bankroll] CHECK CONSTRAINT [FK_utbl_Bankroll_utbl_TransactionType]
GO
ALTER TABLE [dbo].[T_BJDealtCards]  WITH CHECK ADD  CONSTRAINT [FK_T_BJDealtCards_T_BJRounds] FOREIGN KEY([RoundId])
REFERENCES [dbo].[T_BJRounds] ([BJRoundId])
GO
ALTER TABLE [dbo].[T_BJDealtCards] CHECK CONSTRAINT [FK_T_BJDealtCards_T_BJRounds]
GO
ALTER TABLE [dbo].[T_BJRounds]  WITH CHECK ADD  CONSTRAINT [FK_T_BJRounds_T_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[T_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[T_BJRounds] CHECK CONSTRAINT [FK_T_BJRounds_T_Players]
GO
ALTER TABLE [dbo].[T_Deposits]  WITH NOCHECK ADD  CONSTRAINT [FK_utbl_Deposits_utbl_Bankroll] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[T_Bankroll] ([TransactionId])
GO
ALTER TABLE [dbo].[T_Deposits] NOCHECK CONSTRAINT [FK_utbl_Deposits_utbl_Bankroll]
GO
ALTER TABLE [dbo].[T_GameRounds]  WITH CHECK ADD  CONSTRAINT [FK_T_GameRounds_T_Players] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[T_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[T_GameRounds] CHECK CONSTRAINT [FK_T_GameRounds_T_Players]
GO
ALTER TABLE [dbo].[T_GameRounds]  WITH CHECK ADD  CONSTRAINT [FK_utbl_GameRounds_utbl_GameTypes] FOREIGN KEY([GameTypeID])
REFERENCES [dbo].[T_GameTypes] ([GameTypeID])
GO
ALTER TABLE [dbo].[T_GameRounds] CHECK CONSTRAINT [FK_utbl_GameRounds_utbl_GameTypes]
GO
ALTER TABLE [dbo].[T_LoginHistory]  WITH CHECK ADD  CONSTRAINT [FK_T_LoginHistory_T_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[T_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[T_LoginHistory] CHECK CONSTRAINT [FK_T_LoginHistory_T_Players]
GO
ALTER TABLE [dbo].[T_PasswordHistory]  WITH CHECK ADD  CONSTRAINT [FK_PasswordHistory_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[T_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[T_PasswordHistory] CHECK CONSTRAINT [FK_PasswordHistory_Players]
GO
ALTER TABLE [dbo].[T_Players]  WITH CHECK ADD  CONSTRAINT [FK_Players_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[T_Countries] ([CountryId])
GO
ALTER TABLE [dbo].[T_Players] CHECK CONSTRAINT [FK_Players_Countries]
GO
ALTER TABLE [dbo].[T_Players]  WITH CHECK ADD  CONSTRAINT [FK_Players_Gender] FOREIGN KEY([GenderId])
REFERENCES [dbo].[T_Gender] ([GenderId])
GO
ALTER TABLE [dbo].[T_Players] CHECK CONSTRAINT [FK_Players_Gender]
GO
ALTER TABLE [dbo].[T_Deposits]  WITH CHECK ADD  CONSTRAINT [CK_utbl_Deposit_ExpiryDate] CHECK  (([ExpiryDate]>=getdate()))
GO
ALTER TABLE [dbo].[T_Deposits] CHECK CONSTRAINT [CK_utbl_Deposit_ExpiryDate]
GO
ALTER TABLE [dbo].[T_Deposits]  WITH CHECK ADD  CONSTRAINT [CK_utbl_Deposit_MaxAmount] CHECK  (([DepositAmount]=(1000)))
GO
ALTER TABLE [dbo].[T_Deposits] CHECK CONSTRAINT [CK_utbl_Deposit_MaxAmount]
GO
ALTER TABLE [dbo].[T_PasswordHistory]  WITH CHECK ADD  CONSTRAINT [CK_PasswordHistory_EffectiveFrom_LT_EffectiveTo] CHECK  (([EffectiveFrom]>[EffectiveTo]))
GO
ALTER TABLE [dbo].[T_PasswordHistory] CHECK CONSTRAINT [CK_PasswordHistory_EffectiveFrom_LT_EffectiveTo]
GO
USE [master]
GO
ALTER DATABASE [Casino] SET  READ_WRITE 
GO
