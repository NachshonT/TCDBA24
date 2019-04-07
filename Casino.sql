USE [master]
GO
/****** Object:  Database [Casino]    Script Date: 07/04/2019 21:48:01 ******/
CREATE DATABASE [Casino]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CasinoPrimary', FILENAME = N'C:\Users\123\Documents\My Projects\TCDBA24\Casino\Data\Drive1_Primary\Casino.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [SCONDARY] 
( NAME = N'CasinoSecondary1', FILENAME = N'C:\Users\123\Documents\My Projects\TCDBA24\Casino\Data\Drive2_Secondary\Casino1.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
( NAME = N'CasinoSecondary2', FILENAME = N'C:\Users\123\Documents\My Projects\TCDBA24\Casino\Data\Drive2_Secondary\Casino2.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Casino_log', FILENAME = N'C:\Users\123\Documents\My Projects\TCDBA24\Casino\Data\Drive0_Log\Casino.log' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  UserDefinedTableType [dbo].[T_DealtCardsType]    Script Date: 07/04/2019 21:48:02 ******/
CREATE TYPE [dbo].[T_DealtCardsType] AS TABLE(
	[CardId] [tinyint] NULL,
	[Symbol] [tinyint] NULL,
	[FaceNumber] [tinyint] NULL,
	[AlreadyDelt] [bit] NULL
)
GO
/****** Object:  StoredProcedure [dbo].[P_DealCards]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  StoredProcedure [dbo].[P_GetCashOutAmount]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  StoredProcedure [dbo].[P_PlayBlackJackRound]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery12.sql|7|0|C:\Users\123\AppData\Local\Temp\~vs2984.sql
--  =============================================
-- Author:		Nachshon Tamir Alex Krigel Irina Zubkova	
-- Create date: 06-04-2019
-- Description:	Round of Black Jack Game
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayBlackJackRound] 
	@PlayerId INT, 
	@RequestedCardsCount TINYINT,
	@BetAmount MONEY
AS
BEGIN
	SET NOCOUNT ON;
	 -- To Do : The ratio of the BetAmount to the WinAmount needs to be fetched 
	 --					from some kind of an environmental variable that can be set by an operator of the site
	DECLARE @WinAmount MONEY = (@BetAmount * 2)

	-- Insert a new GameRound
	INSERT INTO T_GameRounds (PlayerId, GameTypeId, BetAmount)
	VALUES (@PlayerId, 1/*1=BlackJack ; 2=SlotMachine*/, @BetAmount)

	-- Save the newlly created BlackJackRoundId in a local variable
	DECLARE @BlackJackRoundId INT = @@IDENTITY

	-- Insert a new row into the T_BlackJackRounds table
	INSERT INTO T_BlackJackRounds(BlackJackRoundId, RequestedCardsCount)
	VALUES (@BlackJackRoundId, @RequestedCardsCount)

	DECLARE @RandSymbol TINYINT,
					@RandFaceNumber TINYINT,
					@DealtCardsCount TINYINT = 0

	-- Iterate to the Count Of Cards To Deal
	WHILE @DealtCardsCount < @RequestedCardsCount
		BEGIN
			-- Randomly 'pick' a card from
			SET @RandSymbol = CAST(ROUND(RAND() * 4 + 0.5, 0) AS TINYINT)
			SET @RandFaceNumber = CAST(ROUND(RAND() * 13 + 0.5, 0) AS TINYINT)

			-- Watch this :
			-- The cards are dealt from one pack of cards, that is, a player can't be dealt the same card twice in a single round
			-- This constraint is already easily achieved through the T_BlackJackDealtCards primary key which is compounded of 3 columns : BlackJackRoundId, Symbol, FaceNumber
			INSERT INTO T_BlackJackDealtCards(BlackJackRoundId, Symbol, FaceNumber, IsHouse)
			VALUES (@BlackJackRoundId, @RandSymbol, @RandFaceNumber, 0)

			-- Set the @DealtCardsCount to reflect the true count of DealtCards (taking into account the possibility mentioned above)
			SELECT @DealtCardsCount = COUNT(*)
			FROM T_BlackJackDealtCards
			WHERE BlackJackRoundId = @BlackJackRoundId AND
						IsHouse = 0
		END

		-- Get the SUM(FaceNumber) for the Player
		DECLARE @PlayerSum TINYINT
		SELECT @PlayerSum = SUM(FaceNumber)
		FROM T_BlackJackDealtCards
		WHERE BlackJackRoundId = @BlackJackRoundId AND IsHouse = 0

	 -- Check if SUM(Player) = 21 => Player Wins!
	IF (@PlayerSum = 21)
		BEGIN
			-- The Player's Bankroll needs to be credited with double her BetAmount
			EXEC dbo.P_PlayerWins @PlayerId, @WinAmount
			RETURN 1
		END
	ELSE
	 -- Check if SUM(Player) > 21 => Player Lose!
		IF (@PlayerSum > 21)
			BEGIN
				-- The Player's Bankroll needs to be Debited with her BetAmount
				EXECUTE P_PlayerLoses @PlayerId, @BetAmount
				RETURN 0
			END
		ELSE
			-- The House/Dealer draws cards one-by-one
			BEGIN
				DECLARE @KeepDrawing BIT = 1
				WHILE @KeepDrawing = 1
					BEGIN
						-- Randomly 'pick' a card from
						SET @RandSymbol = CAST(ROUND(RAND() * 4 + 0.5, 0) AS TINYINT)
						SET @RandFaceNumber = CAST(ROUND(RAND() * 13 + 0.5, 0) AS TINYINT)

						-- Watch this :
						-- The cards are dealt from one pack of cards, that is, a player can't be dealt the same card twice in a single round
						-- This constraint is already easily achieved through the T_BlackJackDealtCards primary key
						INSERT INTO T_BlackJackDealtCards(BlackJackRoundId, Symbol, FaceNumber, IsHouse)
						VALUES (@BlackJackRoundId, @RandSymbol, @RandFaceNumber, 1)

						-- Get the SUM(FaceNumber) for the Dealer
						DECLARE @DealerSum TINYINT

						SELECT @DealerSum = SUM(FaceNumber)
						FROM T_BlackJackDealtCards
						WHERE BlackJackRoundId = @BlackJackRoundId AND
									IsHouse = 1

						IF @DealerSum = 21 -- House Wins! Player Lose!
							BEGIN
								EXECUTE P_PlayerLoses @PlayerId, @BetAmount
								RETURN 0
							END
						ELSE
							IF @DealerSum > 21 -- Player Wins! Dealer Lose!
								BEGIN
									EXECUTE P_PlayerWins @PlayerId, @WinAmount
									RETURN 1
								END
							ELSE
								IF @DealerSum > @PlayerSum -- House Wins! Player Lose!
									BEGIN
										EXECUTE P_PlayerLoses @PlayerId, @BetAmount
										RETURN 0
									END
								--ELSE
									-- Keep playing
					END
			END
END
GO
/****** Object:  StoredProcedure [dbo].[P_PlayerLogin]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  StoredProcedure [dbo].[P_PlayerLoses]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 6.4.2019
-- Description:	This procedure debits the Player Bankroll account with her lose
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerLoses]
	@PlayerId INT,
	@LoseAmount MONEY
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO T_Bankroll(PlayerId, TransactionTypeId, Amount)
	VALUES (@PlayerId, 4 /*Lose*/, @LoseAmount)
END

GO
/****** Object:  StoredProcedure [dbo].[P_PlayerRegister]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  StoredProcedure [dbo].[P_PlayerWins]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 6.4.2019
-- Description:	This procedure credits the Player's Bankroll account on his win
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerWins]
	@PlayerId INT, 
	@WinAmount MONEY
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO T_Bankroll(PlayerId, TransactionTypeId, Amount)
	VALUES (@PlayerId, 3 /*Win*/, @WinAmount)

END

GO
/****** Object:  StoredProcedure [dbo].[P_PlaySlotMachineRound]    Script Date: 07/04/2019 21:48:02 ******/
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

	DECLARE @WinAmount MONEY = (@BetAmount * 2)

	-- Insert a new GameRound
	INSERT INTO T_GameRounds (PlayerId, GameTypeId, BetAmount)
	VALUES (@PlayerId, 2, @BetAmount)

	-- Store the GameRoundId in a local variable
	DECLARE @GameRoundId INT = @@IDENTITY

	DECLARE @Wheel1 TINYINT, @Wheel2 TINYINT, @Wheel3 TINYINT

	-- Random the Wheels values
	SET @Wheel1 = CAST(ROUND(RAND() * 6 + 0.5, 0) AS TINYINT)
  SET @Wheel2 = CAST(ROUND(RAND() * 6 + 0.5, 0) AS TINYINT)
  SET @Wheel3 = CAST(ROUND(RAND() * 6 + 0.5, 0) AS TINYINT)

	DECLARE @IsWin BIT 

	-- Insert round Wheels values to T_SlotMachineRounds table
	INSERT INTO T_SlotMachineRounds ([SlotMachineRoundId], [Wheel1], [Wheel2], [Wheel3])
	VALUES (@GameRoundId, @Wheel1, @Wheel2, @Wheel3)

	SELECT @IsWin = IsWin FROM T_SlotMachineRounds WHERE SlotMachineRoundId = @GameRoundId

	-- Update round's outcome to T_GameRounds table
	UPDATE T_GameRounds
	SET IsWin = @IsWin
	WHERE GameRoundID = @GameRoundId 

	-- Check Round's outcome - win or lose
	IF @IsWin = 1 -- Win!!!
		EXECUTE P_PlayerWins @PlayerId, @WinAmount
	ELSE -- Lose!!!
		EXECUTE P_PlayerLoses @PlayerId, @BetAmount
END





GO
/****** Object:  StoredProcedure [dbo].[P_SuggestPlayerName]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  StoredProcedure [dbo].[P_WithdrawMoney]    Script Date: 07/04/2019 21:48:02 ******/
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
	SET @Balance = dbo.F_PlayerBalance(@PlayerId)

    -- Check if the requested CashOut Amount is within the Player's Balance, that is, if the withdrawl is allowed
	IF @Balance >= @CashoutAmount
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION tr_WithdrawMoney

					-- 1. Insert the CashOut Amount to the Bankroll table
					INSERT INTO T_Bankroll(PlayerId, TransactionTypeId, CommitedOn, Amount)
					VALUES (@PlayerId, 5/*CashOunt*/, GETDATE(), @CashOutAmount)

					-- 2. Insert the CashOut Details - where to send the cheque to - to the CashOut table
					INSERT INTO T_CashOut ([PlayerId], [BillingAddress], [PostalCode], [City], [Country], [CashoutAmount], [CashoutDate])
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
/****** Object:  UserDefinedFunction [dbo].[F_PasswordIsStrong]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[F_PlayerBalance]    Script Date: 07/04/2019 21:48:02 ******/
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
	FROM T_Bankroll
	WHERE TransactionId IN (1, 2, 4) AND PlayerId = @PlayerId

	SELECT @SumToSubtract = SUM(Amount)
	FROM T_Bankroll
	WHERE TransactionId IN (3, 5) AND PlayerId = @PlayerId

	RETURN @SumToAdd - @SumToSubtract
END







GO
/****** Object:  UserDefinedFunction [dbo].[F_PlayerIsBlocked]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  UserDefinedFunction [dbo].[F_PlayerIsLoggedIn]    Script Date: 07/04/2019 21:48:02 ******/
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
	FROM [dbo].[T_LoginHistory] 
	WHERE PlayerId = @PlayerId AND 
			LoginFrom <= GETDATE () AND 
			LoginTo IS NULL AND 
			[IsSuccessfullLogin] = 1

	RETURN @IsLoggedIn 
END



GO
/****** Object:  Table [dbo].[T_Bankroll]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Bankroll](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[PlayerId] [int] NOT NULL,
	[TransactionTypeId] [tinyint] NOT NULL,
	[CommitedOn] [timestamp] NOT NULL,
	[Amount] [money] NOT NULL,
 CONSTRAINT [PK_utbl_Bankroll_TransactionId] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_BlackJackDealtCards]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_BlackJackDealtCards](
	[BlackJackRoundId] [int] NOT NULL,
	[Symbol] [tinyint] NOT NULL,
	[FaceNumber] [tinyint] NOT NULL,
	[IsHouse] [bit] NOT NULL,
 CONSTRAINT [PK_T_BlackJackDealtCards] PRIMARY KEY CLUSTERED 
(
	[BlackJackRoundId] ASC,
	[Symbol] ASC,
	[FaceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_BlackJackRounds]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_BlackJackRounds](
	[BlackJackRoundId] [int] NOT NULL,
	[RequestedCardsCount] [tinyint] NULL,
	[IsWin] [bit] NULL,
 CONSTRAINT [PK_T_BJRounds] PRIMARY KEY CLUSTERED 
(
	[BlackJackRoundId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_CashOutDetails]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_CashOutDetails](
	[CashoutId] [int] NOT NULL,
	[BillingAddress] [nvarchar](100) NOT NULL,
	[PostalCode] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[CountryId] [smallint] NOT NULL,
	[CashoutAmount] [money] NOT NULL,
	[CashedoutOn] [timestamp] NOT NULL,
 CONSTRAINT [PK_T_CashOutDetails] PRIMARY KEY CLUSTERED 
(
	[CashoutId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Countries]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  Table [dbo].[T_DepositsDetails]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_DepositsDetails](
	[DepositId] [int] NOT NULL,
	[CCNumber] [char](17) NOT NULL,
	[ExpiryDate] [date] NOT NULL,
	[ExpiryYear]  AS (datepart(year,[ExpiryDate])),
	[ExpiryMonth]  AS (datepart(month,[ExpiryDate])),
	[FirstName] [nchar](10) NOT NULL,
	[LastName] [nchar](10) NOT NULL,
	[DepositedOn] [timestamp] NOT NULL,
	[DepositAmount] [money] NOT NULL,
 CONSTRAINT [PK_T_DepositsDetails] PRIMARY KEY CLUSTERED 
(
	[DepositId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_GameManagers]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  Table [dbo].[T_GameRounds]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_GameRounds](
	[GameRoundID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [int] NOT NULL,
	[GameTypeID] [tinyint] NOT NULL,
	[BetAmount] [money] NOT NULL,
	[BetMadeOn] [timestamp] NOT NULL,
	[IsWin] [bit] NULL,
 CONSTRAINT [PK_utbl_GameRounds] PRIMARY KEY CLUSTERED 
(
	[GameRoundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_GameTypes]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  Table [dbo].[T_Gender]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  Table [dbo].[T_LoginHistory]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  Table [dbo].[T_MillionPasswords]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  Table [dbo].[T_PackOfCards]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_PackOfCards](
	[Symbol] [tinyint] NOT NULL,
	[FaceNumber] [tinyint] NOT NULL,
 CONSTRAINT [PK_T_PackOfCards_Symbol_FaceNumber] PRIMARY KEY CLUSTERED 
(
	[Symbol] ASC,
	[FaceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_PasswordHistory]    Script Date: 07/04/2019 21:48:02 ******/
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
/****** Object:  Table [dbo].[T_Players]    Script Date: 07/04/2019 21:48:02 ******/
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
 CONSTRAINT [PK_T_Players_PlayerId] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_SlotMachineRounds]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_SlotMachineRounds](
	[SlotMachineRoundId] [int] NOT NULL,
	[Wheel1] [tinyint] NOT NULL,
	[Wheel2] [tinyint] NOT NULL,
	[Wheel3] [tinyint] NOT NULL,
	[IsWin]  AS (case when [Wheel1]=[Wheel2] AND [Wheel2]=[Wheel3] then (1) else (0) end) PERSISTED NOT NULL,
 CONSTRAINT [PK_T_SlotMachineRounds] PRIMARY KEY CLUSTERED 
(
	[SlotMachineRoundId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_TransactionTypes]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_TransactionTypes](
	[TransactionTypeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[TransactionTypeName] [nchar](10) NOT NULL,
 CONSTRAINT [PK_TransactionType] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[F_GetFreshPackOfCards]    Script Date: 07/04/2019 21:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
--  Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 06-04-2019
-- Description:	This function returns a fresh pack of cards from T_PackOfCards
-- =============================================
CREATE FUNCTION [dbo].[F_GetFreshPackOfCards] ()
	RETURNS TABLE 
AS
RETURN 
(
	SELECT * from T_PackOfCards
)


GO
/****** Object:  Index [IX_utbl_Bankroll_PlayerId]    Script Date: 07/04/2019 21:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_utbl_Bankroll_PlayerId] ON [dbo].[T_Bankroll]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_utbl_Bankroll_TransactionTypeId]    Script Date: 07/04/2019 21:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_utbl_Bankroll_TransactionTypeId] ON [dbo].[T_Bankroll]
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_utbl_Bankroll_PlayerId_TransactionId]    Script Date: 07/04/2019 21:48:02 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_utbl_Bankroll_PlayerId_TransactionId] ON [dbo].[T_Bankroll]
(
	[PlayerId] ASC,
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_T_BlackJackDealtCards_Symbol_FaceNumber]    Script Date: 07/04/2019 21:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_T_BlackJackDealtCards_Symbol_FaceNumber] ON [dbo].[T_BlackJackDealtCards]
(
	[Symbol] ASC,
	[FaceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_Countries_CountryName]    Script Date: 07/04/2019 21:48:02 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Countries_CountryName] ON [dbo].[T_Countries]
(
	[CountryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_T_PackOfCards_FaceNumber]    Script Date: 07/04/2019 21:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_T_PackOfCards_FaceNumber] ON [dbo].[T_PackOfCards]
(
	[FaceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_T_PackOfCards_Symbol]    Script Date: 07/04/2019 21:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_T_PackOfCards_Symbol] ON [dbo].[T_PackOfCards]
(
	[Symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PasswordHistory]    Script Date: 07/04/2019 21:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_PasswordHistory] ON [dbo].[T_PasswordHistory]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_T_Players_CountryId]    Script Date: 07/04/2019 21:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_T_Players_CountryId] ON [dbo].[T_Players]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_T_Players_Email]    Script Date: 07/04/2019 21:48:02 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_T_Players_Email] ON [dbo].[T_Players]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_T_Players_PlayerName]    Script Date: 07/04/2019 21:48:02 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_T_Players_PlayerName] ON [dbo].[T_Players]
(
	[PlayerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T_Bankroll]  WITH CHECK ADD  CONSTRAINT [FK_T_Bankroll_T_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[T_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[T_Bankroll] CHECK CONSTRAINT [FK_T_Bankroll_T_Players]
GO
ALTER TABLE [dbo].[T_Bankroll]  WITH CHECK ADD  CONSTRAINT [FK_T_Bankroll_T_TransactionTypes] FOREIGN KEY([TransactionTypeId])
REFERENCES [dbo].[T_TransactionTypes] ([TransactionTypeId])
GO
ALTER TABLE [dbo].[T_Bankroll] CHECK CONSTRAINT [FK_T_Bankroll_T_TransactionTypes]
GO
ALTER TABLE [dbo].[T_BlackJackDealtCards]  WITH CHECK ADD  CONSTRAINT [FK_T_BlackJackDealtCards_T_BlackJackRounds] FOREIGN KEY([BlackJackRoundId])
REFERENCES [dbo].[T_BlackJackRounds] ([BlackJackRoundId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[T_BlackJackDealtCards] CHECK CONSTRAINT [FK_T_BlackJackDealtCards_T_BlackJackRounds]
GO
ALTER TABLE [dbo].[T_CashOutDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_T_CashOutDetails_T_Bankroll] FOREIGN KEY([CashoutId])
REFERENCES [dbo].[T_Bankroll] ([TransactionId])
GO
ALTER TABLE [dbo].[T_CashOutDetails] NOCHECK CONSTRAINT [FK_T_CashOutDetails_T_Bankroll]
GO
ALTER TABLE [dbo].[T_DepositsDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_T_DepositsDetails_T_Bankroll] FOREIGN KEY([DepositId])
REFERENCES [dbo].[T_Bankroll] ([TransactionId])
GO
ALTER TABLE [dbo].[T_DepositsDetails] NOCHECK CONSTRAINT [FK_T_DepositsDetails_T_Bankroll]
GO
ALTER TABLE [dbo].[T_GameRounds]  WITH NOCHECK ADD  CONSTRAINT [FK_T_GameRounds_T_BlackJackRounds] FOREIGN KEY([GameRoundID])
REFERENCES [dbo].[T_BlackJackRounds] ([BlackJackRoundId])
GO
ALTER TABLE [dbo].[T_GameRounds] NOCHECK CONSTRAINT [FK_T_GameRounds_T_BlackJackRounds]
GO
ALTER TABLE [dbo].[T_GameRounds]  WITH CHECK ADD  CONSTRAINT [FK_T_GameRounds_T_GameTypes] FOREIGN KEY([GameTypeID])
REFERENCES [dbo].[T_GameTypes] ([GameTypeID])
GO
ALTER TABLE [dbo].[T_GameRounds] CHECK CONSTRAINT [FK_T_GameRounds_T_GameTypes]
GO
ALTER TABLE [dbo].[T_GameRounds]  WITH CHECK ADD  CONSTRAINT [FK_T_GameRounds_T_Players] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[T_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[T_GameRounds] CHECK CONSTRAINT [FK_T_GameRounds_T_Players]
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
ALTER TABLE [dbo].[T_Players]  WITH CHECK ADD  CONSTRAINT [FK_T_Players_T_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[T_Countries] ([CountryId])
GO
ALTER TABLE [dbo].[T_Players] CHECK CONSTRAINT [FK_T_Players_T_Countries]
GO
ALTER TABLE [dbo].[T_Players]  WITH CHECK ADD  CONSTRAINT [FK_T_Players_T_Gender] FOREIGN KEY([GenderId])
REFERENCES [dbo].[T_Gender] ([GenderId])
GO
ALTER TABLE [dbo].[T_Players] CHECK CONSTRAINT [FK_T_Players_T_Gender]
GO
ALTER TABLE [dbo].[T_SlotMachineRounds]  WITH NOCHECK ADD  CONSTRAINT [FK_T_SlotMachineRounds_T_GameRounds] FOREIGN KEY([SlotMachineRoundId])
REFERENCES [dbo].[T_GameRounds] ([GameRoundID])
GO
ALTER TABLE [dbo].[T_SlotMachineRounds] NOCHECK CONSTRAINT [FK_T_SlotMachineRounds_T_GameRounds]
GO
ALTER TABLE [dbo].[T_DepositsDetails]  WITH CHECK ADD  CONSTRAINT [CK_T_DepositsDetails_ExpiryDate] CHECK  (([ExpiryDate]>=getdate()))
GO
ALTER TABLE [dbo].[T_DepositsDetails] CHECK CONSTRAINT [CK_T_DepositsDetails_ExpiryDate]
GO
ALTER TABLE [dbo].[T_DepositsDetails]  WITH CHECK ADD  CONSTRAINT [CK_T_DepositsDetails_MaxAmount] CHECK  (([DepositAmount]=(1000)))
GO
ALTER TABLE [dbo].[T_DepositsDetails] CHECK CONSTRAINT [CK_T_DepositsDetails_MaxAmount]
GO
ALTER TABLE [dbo].[T_PasswordHistory]  WITH CHECK ADD  CONSTRAINT [CK_PasswordHistory_EffectiveFrom_LT_EffectiveTo] CHECK  (([EffectiveFrom]>[EffectiveTo]))
GO
ALTER TABLE [dbo].[T_PasswordHistory] CHECK CONSTRAINT [CK_PasswordHistory_EffectiveFrom_LT_EffectiveTo]
GO
USE [master]
GO
ALTER DATABASE [Casino] SET  READ_WRITE 
GO
