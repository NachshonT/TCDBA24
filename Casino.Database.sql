USE [master]
GO
CREATE DATABASE [Casino]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CasinoPrimary', FILENAME = N'C:\Users\123\Documents\My Projects\TCDBA24\Casino\Data\Drive1_Primary\Casino.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [Secondary1] 
( NAME = N'CasinoSecondary1', FILENAME = N'C:\Users\123\Documents\My Projects\TCDBA24\Casino\Data\Drive2\SecondaryFG1\Casino1.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [Secondary2] 
( NAME = N'CasinoSecondary2', FILENAME = N'C:\Users\123\Documents\My Projects\TCDBA24\Casino\Data\Drive3\SecondaryFG2\Casino2.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
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
CREATE ASSEMBLY [Casino]
FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C01030065A5AC5C0000000000000000E00002210B010B000006000000060000000000007E250000002000000040000000000010002000000002000004000000000000000600000000000000008000000002000000000000030060850000100000100000000010000010000000000000100000000000000000000000302500004B00000000400000A002000000000000000000000000000000000000006000000C000000F82300001C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E7465787400000084050000002000000006000000020000000000000000000000000000200000602E72737263000000A0020000004000000004000000080000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000000C000000000000000000000000000040000042000000000000000000000000000000006025000000000000480000000200050070200000880300000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000133001000C000000010000110017280500000A0A2B00062A1E02280600000A2A42534A4201000100000000000C00000076342E302E33303331390000000005006C00000038010000237E0000A40100006801000023537472696E6773000000000C030000080000002355530014030000100000002347554944000000240300006400000023426C6F620000000000000002000001471502000900000000FA2533001600000100000008000000020000000200000001000000060000000400000001000000010000000200000000000A0001000000000006002A0023000A0052003D000A005D003D000600A30090001300B70000000600E600C60006000601C6000A0046012B0100000000010000000000010001000100100015000000050001000100502000000000960067000A0001006820000000008618810011000200000001008700210081001500310081001B0039008100110041008100110011005B0125000900810011002000230020002E000B0030002E00130039002E001B0042002B000480000000000000000000000000000000002401000004000000000000000000000001001A0000000000040000000000000000000000010031000000000000000000003C4D6F64756C653E00436173696E6F2E646C6C0055444673006D73636F726C69620053797374656D004F626A6563740053797374656D2E446174610053797374656D2E446174612E53716C54797065730053716C426F6F6C65616E0053716C537472696E6700465F53514C434C525F50617373776F726449735374726F6E67002E63746F720050617373776F72640053797374656D2E446961676E6F73746963730044656275676761626C6541747472696275746500446562756767696E674D6F6465730053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300436F6D70696C6174696F6E52656C61786174696F6E734174747269627574650052756E74696D65436F6D7061746962696C69747941747472696275746500436173696E6F004D6963726F736F66742E53716C5365727665722E5365727665720053716C46756E6374696F6E417474726962757465006F705F496D706C69636974000000032000000000006E1BD2EBD3BA724A9A5CAD830416865F0008B77A5C561934E0890600011109110D032000010520010111150420010108040100000005000111090204070111090801000701000000000801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F7773010000000000000065A5AC5C00000000020000001C0100001424000014060000525344536F14454A65EDF944AD5FC1BF6D9766DE01000000633A5C55736572735C3132335C446F63756D656E74735C4D792050726F6A656374735C544344424132345C436173696E6F5C417373656D626C6965735C6F626A5C44656275675C436173696E6F2E70646200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005825000000000000000000006E250000002000000000000000000000000000000000000000000000602500000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF25002000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100100000001800008000000000000000000000000000000100010000003000008000000000000000000000000000000100000000004800000058400000440200000000000000000000440234000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE00000100000000000000000000000000000000003F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B004A4010000010053007400720069006E006700460069006C00650049006E0066006F0000008001000001003000300030003000300034006200300000002C0002000100460069006C0065004400650073006300720069007000740069006F006E000000000020000000300008000100460069006C006500560065007200730069006F006E000000000030002E0030002E0030002E003000000038000B00010049006E007400650072006E0061006C004E0061006D006500000043006100730069006E006F002E0064006C006C00000000002800020001004C006500670061006C0043006F00700079007200690067006800740000002000000040000B0001004F0072006900670069006E0061006C00460069006C0065006E0061006D006500000043006100730069006E006F002E0064006C006C0000000000340008000100500072006F006400750063007400560065007200730069006F006E00000030002E0030002E0030002E003000000038000800010041007300730065006D0062006C0079002000560065007200730069006F006E00000030002E0030002E0030002E00300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000C000000803500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
WITH PERMISSION_SET = SAFE

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--  =============================================
-- Author:		Nachshon Tamir Alex Krigel Irina Zubkova	
-- Create date: 06-04-2019
-- Description:	This procedure plays a Round of Black Jack Game
-- =============================================
CREATE PROCEDURE [dbo].[P_BlackJackPlayRound] 
	@PlayerId INT, 
	@RequestedCardsCount TINYINT,
	@BetAmount MONEY
AS
BEGIN
	SET NOCOUNT ON;
	-- Check if the Player's Bankroll Balance allowes for the BetAmount (equal or higher)
	IF @BetAmount > dbo.F_PlayerGetBalance(@PlayerId)
		BEGIN
			DECLARE @msg NVARCHAR(2048) = 'The bet amount is : ' + CAST(@BetAmount AS NVARCHAR) + '. The Palyer''s bankroll balance is : ' + CAST(dbo.F_PlayerGetBalance(@PlayerId) AS NVARCHAR) + '. The bet amount can''t exceed the bankroll balance. The bet was canceled';
			-- Note! the preceeding line to a 'THROW' must be explicitly ended with a semi colon
			THROW 51003, @msg , 1
		END

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

	-- Check if SUM(Player) > 21 => Player Lose!
	IF (@PlayerSum > 21)
		BEGIN
			-- The Player's Bankroll needs to be Debited with her BetAmount
			EXECUTE P_PlayerLoses @PlayerId, @BetAmount
			RETURN 0
		END
	ELSE
		-- The Dealer draws cards one-by-one
		BEGIN
			DECLARE @KeepDrawing BIT = 1
			WHILE @KeepDrawing = 1
				BEGIN
					-- Randomly 'pick' a card from
					SET @RandSymbol = CAST(ROUND(RAND() * 4 + 0.5, 0) AS TINYINT)
					SET @RandFaceNumber = CAST(ROUND(RAND() * 13 + 0.5, 0) AS TINYINT)

					-- Watch this :
					-- The cards are dealt from one(!) pack of cards, that is, a player can't be dealt the same card twice in a single round
					-- This constraint is already easily achieved through the T_BlackJackDealtCards primary key
					INSERT INTO T_BlackJackDealtCards(BlackJackRoundId, Symbol, FaceNumber, IsHouse)
					VALUES (@BlackJackRoundId, @RandSymbol, @RandFaceNumber, 1)

					-- Get the SUM(FaceNumber) for the Dealer
					DECLARE @DealerSum TINYINT

					SELECT @DealerSum = SUM(FaceNumber)
					FROM T_BlackJackDealtCards
					WHERE BlackJackRoundId = @BlackJackRoundId AND
								IsHouse = 1

					IF @DealerSum > 21 -- Player Wins! Dealer Lose!
						BEGIN
							EXECUTE P_PlayerWins @PlayerId, @WinAmount
							RETURN 1
						END
					ELSE
						IF @DealerSum >= @PlayerSum -- House Wins! Player Lose!
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 8.4.2019
-- Description:	This function returns a random generated 'Strong' password
-- =============================================
CREATE PROCEDURE [dbo].[P_PasswordGenerateStrong]
(
	@PlayerId INT,
	@NewPassword AS NVARCHAR(10) = '' OUTPUT
)
AS
BEGIN
	DECLARE @RandPasswordLength TINYINT, @RandCharacterType TINYINT, @i TINYINT = 0

	-- Generate a random integer value between 5-10
	SET @RandPasswordLength = CAST(ROUND(RAND() * 5 + 5 + 0.5, 0) AS TINYINT)

	-- Iterate to add characters to the generating password one by one
	WHILE @i < @RandPasswordLength
		BEGIN
			-- Randomize the type of the next character to be added to the password - Upper case letter, Lower case letter, digit
			SET @RandCharacterType = CAST(ROUND(RAND() * 3 + 0.5, 0) AS TINYINT)

			SET @NewPassword += 
				CASE @RandCharacterType
					-- Upper case letter
					WHEN 1 THEN CAST((ROUND(RAND() * 26 + 65 + 0.5, 0)) AS NVARCHAR(1))

					-- Randomize a lower case letter
					WHEN 2 THEN CAST((ROUND(RAND() * 26 + 97 + 0.5, 0)) AS NVARCHAR(1))

					-- digit
					WHEN 3 THEN CAST(ROUND(RAND() * 9, 0) AS NVARCHAR(1))
				END

			SET @i += 1
		END

	-- Check if the new generated Password is 'Strong' (contains at least 1 lower case, 1 upper case and 1 digit).
	--	Otherwise, make a recursive call to try again.
	IF NOT (dbo.F_PasswordIsStrong(@PlayerId, @NewPassword) = 1)
		BEGIN
			SET @NewPassword = ''
			EXECUTE dbo.P_PasswordGenerateStrong @PlayerId, @NewPassword OUTPUT
		END

END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_PlayerCashout]
	@PlayerId INT,
	@CashOutAmount MONEY,
	@BillingAddress NCHAR(50) = NULL,
	@PostalCode INT = NULL,
	@City NCHAR(10) = NULL,
	@CountryId SMALLINT = NULL
AS
BEGIN

	SET NOCOUNT ON;

    -- Check if the requested CashOut Amount is within the Player's Balance, that is, if the withdrawl is allowed
	IF @CashoutAmount <= dbo.F_PlayerGetBalance(@PlayerId)
		BEGIN

			BEGIN TRY

				BEGIN TRANSACTION tr_WithdrawMoney

					-- Insert the CashOut Amount to the Bankroll table
					INSERT INTO T_Bankroll(PlayerId, TransactionTypeId, Amount)
					VALUES (@PlayerId, 5/*CashOunt*/, @CashOutAmount)

					-- Store the TransactionId in a local variable
					DECLARE @TransactionId INT = @@IDENTITY

					-- Insert the CashOut Details - where to send the cheque to - to the T_CashOutDetails table
					INSERT INTO T_CashOutDetails([CashoutId], [BillingAddress], [PostalCode], [City], [CountryId], [CashoutAmount])
					VALUES (@TransactionId, @BillingAddress , @PostalCode, @City, @CountryId, @CashOutAmount)

				COMMIT TRANSACTION tr_WithdrawMoney

			END TRY

			BEGIN CATCH
				ROLLBACK TRANSACTION tr_WithdrawMoney
			END CATCH

		END
	ELSE
		-- the amount of cashout is more than the balance and hence not allowed
		BEGIN
			DECLARE @msg NVARCHAR(2048) = 'The requested cashout amount is : ' + CAST(@CashoutAmount AS NVARCHAR) + '. The Palyer''s bankroll balance is : ' + CAST(dbo.F_PlayerGetBalance(@PlayerId) AS NVARCHAR) + '. The Cashout amount can''t exceed the bankroll balance. The operation was canceled';
			-- Note! the preceeding line to a 'THROW' must be explicitly ended with a semi colon
			THROW 51001, @msg , 1
		END
END




GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 9.4.2019
-- Description:	This procedure is used to insert a Player's Comment into the T_PlayersComments table
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerCommentInsert] 
	@PlayerId INT,
	@CommentTitle NVARCHAR(100),
	@CommentText NVARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON;

  INSERT INTO T_PlayersComments (PlayerId, CommentTitle, CommentText)
	VALUES (@PlayerId, @CommentTitle, @CommentText)
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 8.4.2019
-- Description:	This Procedure is used to Deposite money into the Player's account (Bankroll)
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerDeposit] 
	@PlalyerId INT, 
	@DepositAmount MONEY
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO T_Bankroll(PlayerId, TransactionTypeId, Amount)
	VALUES (@PlalyerId, 2/*Deposit*/, @DepositAmount)

END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 8.4.2019
-- Description:	This Procedure is used to grant the Player's account (Bankroll) with a Bonus
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerGrantBonus]
	@PlalyerId INT, 
	@BonusAmount MONEY
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO T_Bankroll(PlayerId, TransactionTypeId, Amount)
	VALUES (@PlalyerId, 1/*Bonus*/, @BonusAmount)

END


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	A registered Player makes a Login attempt
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerLogin] 
	@PlayerName nchar(10),
	@TryPassword nchar(10)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @PlayerId INT, @IsLoggedIn BIT, @IsBlocked BIT

	-- Get the PalyerId for the supplied PlayerName
	SELECT @PlayerId = PlayerId,
					@IsLoggedIn = IsLoggedIn,
					@IsBlocked = IsBlocked
	FROM T_Players 
	WHERE PlayerName = @PlayerName

	-- Check if the supplied PalyerName is valid, that is, we got a PlayerId and
	IF @PlayerId IS NULL
		BEGIN
			DECLARE @msg NVARCHAR(2048) = 'The PlayerName ''' + @PlayerName + ''' could not be found';
			-- Note! the preceeding line to a 'THROW' must be explicitly ended with a semi colon
			THROW 51004, @msg , 1
		END
	ELSE
		-- Check that the Player is not already LoggedIn
		-- and not blocked due to 5 prior consecutive failed login attempts
		IF NOT @IsLoggedIn = 1 AND NOT @IsBlocked = 1
			BEGIN
				-- Get the Password for the PlayerId
				DECLARE @Password NCHAR(10) = dbo.F_PlayerGetPassword(@PlayerId)

				-- Check if the supplied Password matches the Player's Password
				IF (@Password = @TryPassword)
					BEGIN
						--Insert a new successfull attempt row into the T_LoginHistory table
						INSERT INTO T_LoginHistory (PlayerId, IsSuccessfullLogin)
						VALUES (@PlayerId,  1)

						-- Retrun success
						RETURN 1
					END
				ELSE
					BEGIN
						--Insert a new failed attempt row into the T_LoginHistory table
						INSERT INTO T_LoginHistory (PlayerId, IsSuccessfullLogin)
						VALUES (@PlayerId, 0)

						-- Retrun failure
						RETURN 0
					END
			END
		ELSE
			-- Retrun failure
			RETURN 0
END







GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 9.4.2019
-- Description:	This procedure is used to logout the user
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerLogout] 
	@PlayerId INT
AS
BEGIN
	SET NOCOUNT ON;

   UPDATE T_LoginHistory
	 SET [LoginTo] = GETDATE()
	 WHERE PlayerId = @PlayerId AND
					[LoginTo] IS NULL AND 
					[IsSuccessfullLogin] = 1
END

GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[P_PlayerRegister]
(
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
	-- Input Validation :
	-- Check if the Password is strong
	IF NOT dbo.F_PasswordIsStrong(@Password, @PlayerName) = 1
		BEGIN;
			-- Note! the preceeding line to a 'THROW' must be explicitly ended with a semi colon
			THROW 51002, 'The password that was provided is not a ''strong'' password' , 1
		END

	INSERT INTO dbo.T_Players
	(
		PlayerName,
--		[Password],
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
		@PlayerName,
--		@Password,
		@FIrstName,
		@LastName,
		@Address,
		@CountryID,
		@Email,
		@GenderID,
		@BirthDay
	)

	DECLARE @PlayerID INT = @@IDENTITY

	-- Save the Password in the T_PasswordHistory table to enforce the rull that prohibits the reuse of old passwords
	INSERT INTO T_PasswordHistory (PlayerId, [Password], IsCurrent)
	VALUES (@PlayerID, @Password, 1)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 6.4.2019
-- Description:	This procedure is used to suggest a non existing PlayerName when a new registering Player chooses an already existing PlayerName
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerSuggestName] 
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 8.4.2019
-- Description:	This procedure updates the Player's details
-- =============================================
CREATE PROCEDURE [dbo].[P_PlayerUpdate] 
	@PlayerId INT,
	@PlayerName NVARCHAR(10),
	@NewPassword NVARCHAR(10),
	@FirstName NVARCHAR(20),
	@LastName NVARCHAR(20),
	@Address NVARCHAR(100),
	@CountryId SMALLINT,
	@Email NVARCHAR(100),
	@GenderId TINYINT,
	@BirthDay DATE
AS
BEGIN
	SET NOCOUNT ON;

	-- Input Validation :
	-- Check if the Password is strong
	IF NOT dbo.F_PasswordIsStrong(@NewPassword, @PlayerName) = 1
		BEGIN;
			-- Note! the preceeding line to a 'THROW' must be explicitly ended with a semi colon
			THROW 51002, 'The password that was provided is not a ''strong'' password' , 1
		END

	BEGIN TRANSACTION tranPlayerUpdate

	BEGIN TRY
		UPDATE T_Players
			SET
				--[Password] = @NewPassword,
				FirstName = @FirstName,
				LastName = @LastName,
				[Address] = @Address,
				CountryId = @CountryId,
				Email = @Email,
				GenderId = @GenderId,
				Birthdate = @BirthDay
		WHERE PlayerId = @PlayerId

		-- Extract the CurPassword from the local table variable
		DECLARE @CurPassword NVARCHAR(10) = dbo.F_PlayerGetCurPassword(@PlayerId)

		IF @CurPassword != @NewPassword
			BEGIN
				-- Set the EffctiveTo of the CurPassword to right now
				UPDATE T_PasswordHistory
				SET IsCurrent = 0
				WHERE PlayerId = @PlayerId AND
							IsCurrent = 1

				-- Save the Password in the T_PasswordHistory table to enforce the rull that prohibits the reuse of old passwords
				INSERT INTO T_PasswordHistory (PlayerId, [Password], IsCurrent)
				VALUES (@PlayerID, @NewPassword, 1)
			END

		COMMIT TRANSACTION tranPlayerUpdate
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION tranPlayerUpdate
	END CATCH

END

GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 9.4.2019
-- Description:	This procedure is used to set a configuration parameter's value in the T_ConfigParams table
-- =============================================
CREATE PROCEDURE [dbo].[P_SetConfigParam] 
(
	@Key NVARCHAR(50),
	@Value SQL_VARIANT
)
AS
BEGIN
		UPDATE T_ConfigParams
		SET Value = @Value
		WHERE [Key] = @Key
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 29-03-2019
-- Description:	Round of Slot Machine game
-- =============================================
CREATE PROCEDURE [dbo].[P_SlotMachinePlayRound]
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 9.4.2019
-- Description:	This function is used to get a configuration parameter value from the T_ConfigParams table
-- =============================================
CREATE FUNCTION [dbo].[F_GetConfigParam] 
(
	@Key NVARCHAR(50)
)
RETURNS SQL_VARIANT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Value SQL_VARIANT

	SELECT @Value = Value
	FROM T_ConfigParams
	WHERE [Key] = @Key

	-- Return the result of the function
	RETURN @Value

END

GO
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

	-- A 'Strong' Password meets the following cumulative requirements :

	-- 1. It is at least 5 characters long
	IF LEN(@Password) >= 5

		-- 2. It is a combination of at least 1 capital letter, at least 1 small letter and at least 1 digit
		IF @Password LIKE '%[A-Z]%' AND
				@Password LIKE '%[a-z]%' AND
				@Password LIKE '%[0-9]%'

			-- 3. It is not the same as the PlayerName
			IF @Password != @PlayerName

				-- 4. It does not contain any combination of capital letters/small letters/digits with the word 'password'
				--		like 'password7' or 'pass3word'
				IF LOWER(@Password) NOT LIKE '%[0-9]%p%[0-9]%a%[0-9]%s%[0-9]%s%[0-9]%w%[0-9]%o%[0-9]%r%[0-9]%d%[0-9]%'

					-- 5. It does not apear in the list of 1 million frequently used passwords
					IF NOT EXISTS (SELECT * FROM T_MillionPasswords WHERE [Password] = @Password)

						-- 6. Call the SQL CLR function to run later placed checks on the 'IsStrong' Password
						IF [dbo].[F_SQLCLR_PasswordIsStrong](@Password) = 1
							SET @IsStrong = 1

	RETURN @IsStrong
END;






GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	Retrieves balance on the player account
-- =============================================
CREATE FUNCTION [dbo].[F_PlayerGetBalance] (@PlayerId int)
RETURNS MONEY
AS
BEGIN
	DECLARE @SumToAdd MONEY, @SumToSubtract MONEY
	 
	SELECT @SumToAdd = SUM(Amount)
	FROM T_Bankroll
	WHERE TransactionTypeId IN (1/*Bonus*/, 2/*Deposit*/, 3/*Win*/) AND PlayerId = @PlayerId

	SELECT @SumToSubtract = SUM(Amount)
	FROM T_Bankroll
	WHERE TransactionTypeId IN (4/*Lose*/, 5/*Cashout*/) AND PlayerId = @PlayerId

	RETURN @SumToAdd - @SumToSubtract
END







GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir
-- Create date: 9.4.2019
-- Description:	This function returns the Player's CurrentPassword from amongst the PasswordHistory entries
-- =============================================
CREATE FUNCTION [dbo].[F_PlayerGetPassword] 
(
	@PlayerId int
)
RETURNS NVARCHAR(10)
AS
BEGIN
	
	DECLARE @CurPassword NVARCHAR(10)

	SELECT @CurPassword = [Password]
	FROM T_PasswordHistory
	WHERE PlayerId = @PlayerId AND
				IsCurrent = 1

	RETURN @CurPassword

END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	This function checks if the Player is blocked due to consecutive failed login attempts
-- =============================================
CREATE FUNCTION [dbo].[F_PlayerIsBlocked](@PlayerId INT)
RETURNS BIT
AS
BEGIN
	-- Declare a local table variable to store the Player's recent login attempts
	DECLARE @T_RecentLogins AS TABLE
	(
		IsSuccessfullLogin BIT,
		LoginOrdinal INT
	)

	INSERT INTO @T_RecentLogins (IsSuccessfullLogin, LoginOrdinal)
	SELECT [IsSuccessfullLogin],
					ROW_NUMBER() OVER (ORDER BY LoginFrom DESC) AS LoginOrdinal
	FROM T_LoginHistory
	WHERE PlayerId = @PlayerId 
	ORDER BY LoginFrom DESC

	-- Get the value of the 'FailedLoginsToBlock' configuration param
	DECLARE @FailedLoginsToBlock TINYINT = CAST(dbo.F_GetConfigParam('FailedLoginsToBlock') AS TINYINT)

	DECLARE @RecentFailedLoginsCount TINYINT

	-- Count how many recent failed login attempts were made within the scope of the last FailedLoginsToBlock
	SELECT @RecentFailedLoginsCount = COUNT(*)
	FROM @T_RecentLogins
	WHERE [IsSuccessfullLogin] = 0 AND
		LoginOrdinal <= @FailedLoginsToBlock

	IF (@RecentFailedLoginsCount >= @FailedLoginsToBlock)
		RETURN 1

	RETURN 0

END

GO
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
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[F_SQLCLR_PasswordIsStrong](@Password [nvarchar](10))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [Casino].[UDFs].[F_SQLCLR_PasswordIsStrong]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Bankroll](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[PlayerId] [int] NOT NULL,
	[TransactionTypeId] [tinyint] NOT NULL,
	[CommitedOn] [timestamp] NOT NULL,
	[Amount] [money] NOT NULL
) ON [PRIMARY]

GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_CashOutDetails](
	[CashoutId] [int] NOT NULL,
	[BillingAddress] [nvarchar](100) NULL,
	[PostalCode] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[CountryId] [smallint] NULL,
	[CashoutAmount] [money] NOT NULL,
	[CashedoutOn] [timestamp] NOT NULL,
 CONSTRAINT [PK_T_CashOutDetails] PRIMARY KEY CLUSTERED 
(
	[CashoutId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_ConfigParams](
	[Key] [nvarchar](50) NOT NULL,
	[Value] [sql_variant] NOT NULL
) ON [PRIMARY]

GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Genders](
	[GenderId] [tinyint] NOT NULL,
	[Gender] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_LoginHistory](
	[PlayerId] [int] NOT NULL,
	[LoginFrom] [timestamp] NOT NULL,
	[LoginTo] [datetime] NULL,
	[IsSuccessfullLogin] [bit] NOT NULL,
 CONSTRAINT [PK_T_LoginHistory] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC,
	[LoginFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_PasswordHistory](
	[PlayerId] [int] NOT NULL,
	[Password] [nchar](10) NOT NULL,
	[IsCurrent] [bit] NOT NULL,
	[SetOn] [timestamp] NOT NULL,
 CONSTRAINT [PK_PasswordHistory] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC,
	[Password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Players](
	[PlayerId] [int] IDENTITY(1,1) NOT NULL,
	[PlayerName] [nvarchar](10) NOT NULL,
	[Password] [nvarchar](50) NULL,
	[FirstName] [nvarchar](20) NULL,
	[LastName] [nvarchar](20) NULL,
	[Address] [nvarchar](100) NULL,
	[CountryId] [smallint] NULL,
	[Email] [nvarchar](100) NULL,
	[GenderId] [tinyint] NULL,
	[Birthdate] [date] NULL,
	[Balance]  AS ([dbo].[F_PlayerGetBalance]([PlayerId])),
	[IsBlocked]  AS ([dbo].[F_PlayerIsBlocked]([PlayerId])),
	[IsLoggedIn]  AS ([dbo].[F_PlayerIsLoggedIn]([PlayerId])),
 CONSTRAINT [PK_T_Players_PlayerId] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_PlayersComments](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[PlayerId] [int] NOT NULL,
	[CommentTitle] [nchar](10) NULL,
	[CommentText] [nvarchar](1000) NULL,
	[CreatedOn] [timestamp] NOT NULL,
 CONSTRAINT [PK_T_PlayersComments] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
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
CREATE UNIQUE CLUSTERED INDEX [UQ_T_Bankroll_PlayerId_TransactionTypeId_TransactionId] ON [dbo].[T_Bankroll]
(
	[PlayerId] ASC,
	[TransactionTypeId] ASC,
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
INSERT [dbo].[T_ConfigParams] ([Key], [Value]) VALUES (N'RegistrationBonus', CAST(N'10' AS nvarchar(2)))
INSERT [dbo].[T_ConfigParams] ([Key], [Value]) VALUES (N'FailedLoginsToBlock', CAST(N'5' AS nvarchar(1)))
SET IDENTITY_INSERT [dbo].[T_Countries] ON 

INSERT [dbo].[T_Countries] ([CountryId], [CountryName]) VALUES (1, N'Israel              ')
SET IDENTITY_INSERT [dbo].[T_Countries] OFF
INSERT [dbo].[T_GameTypes] ([GameTypeID], [GameTypeName]) VALUES (1, N'Black Jack')
INSERT [dbo].[T_GameTypes] ([GameTypeID], [GameTypeName]) VALUES (2, N'Slot Machine')
INSERT [dbo].[T_Genders] ([GenderId], [Gender]) VALUES (0, N'Male      ')
INSERT [dbo].[T_Genders] ([GenderId], [Gender]) VALUES (1, N'Female    ')
INSERT [dbo].[T_LoginHistory] ([PlayerId], [LoginTo], [IsSuccessfullLogin]) VALUES (1, CAST(0x0000AA2A00C6FE3B AS DateTime), 1)
INSERT [dbo].[T_LoginHistory] ([PlayerId], [LoginTo], [IsSuccessfullLogin]) VALUES (1, CAST(0x0000AA2A00CBCC15 AS DateTime), 1)
INSERT [dbo].[T_LoginHistory] ([PlayerId], [LoginTo], [IsSuccessfullLogin]) VALUES (1, NULL, 0)
INSERT [dbo].[T_LoginHistory] ([PlayerId], [LoginTo], [IsSuccessfullLogin]) VALUES (1, NULL, 0)
INSERT [dbo].[T_LoginHistory] ([PlayerId], [LoginTo], [IsSuccessfullLogin]) VALUES (1, NULL, 0)
INSERT [dbo].[T_LoginHistory] ([PlayerId], [LoginTo], [IsSuccessfullLogin]) VALUES (1, NULL, 0)
INSERT [dbo].[T_LoginHistory] ([PlayerId], [LoginTo], [IsSuccessfullLogin]) VALUES (1, NULL, 0)
INSERT [dbo].[T_PasswordHistory] ([PlayerId], [Password], [IsCurrent]) VALUES (1, N'12abCD    ', 0)
INSERT [dbo].[T_PasswordHistory] ([PlayerId], [Password], [IsCurrent]) VALUES (1, N'34efKI    ', 0)
INSERT [dbo].[T_PasswordHistory] ([PlayerId], [Password], [IsCurrent]) VALUES (1, N'11aaBB    ', 1)
SET IDENTITY_INSERT [dbo].[T_Players] ON 

INSERT [dbo].[T_Players] ([PlayerId], [PlayerName], [Password], [FirstName], [LastName], [Address], [CountryId], [Email], [GenderId], [Birthdate]) VALUES (1, N'NachshonT ', N'11aaBB    ', N'Nachshon', N'Tamir', N'20/6 Ha''avoda St. Tel Aviv, Israel', 1, N'nachshon.tamir@gmail.com', 0, CAST(0xA3F50A00 AS Date))
SET IDENTITY_INSERT [dbo].[T_Players] OFF
SET IDENTITY_INSERT [dbo].[T_TransactionTypes] ON 

INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (1, N'Bonus     ')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (2, N'Deposit   ')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (3, N'Win       ')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (4, N'Lose      ')
INSERT [dbo].[T_TransactionTypes] ([TransactionTypeId], [TransactionTypeName]) VALUES (5, N'Cashout   ')
SET IDENTITY_INSERT [dbo].[T_TransactionTypes] OFF
ALTER TABLE [dbo].[T_Bankroll] ADD  CONSTRAINT [PK_T_Bankroll_TransactionId] PRIMARY KEY NONCLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_T_Bankroll_PlayerId] ON [dbo].[T_Bankroll]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_T_Bankroll_TransactionTypeId] ON [dbo].[T_Bankroll]
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_T_PasswordHistory_PlayerId_IsCurrent] ON [dbo].[T_PasswordHistory]
(
	[PlayerId] ASC,
	[IsCurrent] ASC
)
INCLUDE ( 	[Password]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_T_Players_CountryId] ON [dbo].[T_Players]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_T_Players_Email] ON [dbo].[T_Players]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [UQ_T_Players_PlayerName] ON [dbo].[T_Players]
(
	[PlayerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_T_PlayersComments_PlayerId] ON [dbo].[T_PlayersComments]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T_PasswordHistory] ADD  CONSTRAINT [DF_T_PasswordHistory_IsCurrent]  DEFAULT ((1)) FOR [IsCurrent]
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
ALTER TABLE [dbo].[T_PasswordHistory]  WITH CHECK ADD  CONSTRAINT [FK_T_PasswordHistory_T_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[T_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[T_PasswordHistory] CHECK CONSTRAINT [FK_T_PasswordHistory_T_Players]
GO
ALTER TABLE [dbo].[T_Players]  WITH CHECK ADD  CONSTRAINT [FK_T_Players_T_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[T_Countries] ([CountryId])
GO
ALTER TABLE [dbo].[T_Players] CHECK CONSTRAINT [FK_T_Players_T_Countries]
GO
ALTER TABLE [dbo].[T_Players]  WITH NOCHECK ADD  CONSTRAINT [FK_T_Players_T_Genders] FOREIGN KEY([GenderId])
REFERENCES [dbo].[T_Genders] ([GenderId])
GO
ALTER TABLE [dbo].[T_Players] CHECK CONSTRAINT [FK_T_Players_T_Genders]
GO
ALTER TABLE [dbo].[T_PlayersComments]  WITH CHECK ADD  CONSTRAINT [FK_T_PlayersComments_T_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[T_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[T_PlayersComments] CHECK CONSTRAINT [FK_T_PlayersComments_T_Players]
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
USE [master]
GO
ALTER DATABASE [Casino] SET  READ_WRITE 
GO
