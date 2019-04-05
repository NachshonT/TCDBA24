USE [master]
GO
/****** Object:  Database [Casino]    Script Date: 05/04/2019 10:34:59 ******/
CREATE DATABASE [Casino]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Casino', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Casino\Casino.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Casino_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\Casino\Casino_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [Casino] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Casino', N'ON'
GO
ALTER DATABASE [Casino] SET QUERY_STORE = OFF
GO
USE [Casino]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Casino]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_getBalance]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	Retrieves balance on the player account
-- =============================================
CREATE FUNCTION [dbo].[udf_getBalance] (@PlayerId int)
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
/****** Object:  UserDefinedFunction [dbo].[udf_IsBlocked]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	This function checks if the Player is blocked
-- =============================================
CREATE FUNCTION [dbo].[udf_IsBlocked](@PlayerId INT)
RETURNS BIT
AS
BEGIN
	RETURN 0
END



GO
/****** Object:  UserDefinedFunction [dbo].[usf_Check_PW_stength]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[usf_Check_PW_stength]

  (@Password nchar(10))
  
  Returns int
  

BEGIN
      DECLARE @Isstrong int;
    
	       If   
               @Password COLLATE Latin1_General_BIN LIKE '%[a-z]%[a-z]%' AND
               @Password COLLATE Latin1_General_BIN LIKE '%[A-Z]%[A-Z]%' AND
               @Password LIKE '%[0-9]%[0-9]%' AND
               --@Password LIKE '%[~!@#$%^&]%[~!@#$%^&]%' AND
               LEN(@Password) >= 5	
		    
	      SET @Isstrong = 1;
	      ELSE SET @Isstrong = 0;
		   
   Return @Isstrong;
END;


GO
/****** Object:  Table [dbo].[utbl_Bankroll]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Bankroll](
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
/****** Object:  Table [dbo].[utbl_CashOut]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_CashOut](
	[PlayerId] [int] NOT NULL,
	[BillingAddress] [nchar](50) NOT NULL,
	[PostalCode] [int] NOT NULL,
	[City] [nchar](10) NOT NULL,
	[Country] [nchar](10) NOT NULL,
	[CashoutAmount] [money] NOT NULL,
	[CashoutDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[utbl_Countries]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Countries](
	[CountryId] [smallint] IDENTITY(1,1) NOT NULL,
	[CountryName] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Countries_CountryID] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[utbl_Deposits]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Deposits](
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
/****** Object:  Table [dbo].[utbl_GameManagers]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_GameManagers](
	[GameManagerId] [int] NOT NULL,
	[GameManagerName] [nchar](10) NOT NULL,
 CONSTRAINT [PK_utbl_GameManagers] PRIMARY KEY CLUSTERED 
(
	[GameManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[utbl_GameRounds]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_GameRounds](
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
/****** Object:  Table [dbo].[utbl_GameTypes]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_GameTypes](
	[GameTypeID] [tinyint] NOT NULL,
	[GameTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_utbl_GameTypes] PRIMARY KEY CLUSTERED 
(
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[utbl_Gender]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Gender](
	[GenderId] [tinyint] IDENTITY(1,1) NOT NULL,
	[Gender] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[utbl_LoginHistory]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_LoginHistory](
	[PlayerId] [int] NOT NULL,
	[LoginFrom] [datetime] NOT NULL,
	[LoginTo] [datetime] NOT NULL,
	[LoginSuccessYN] [bit] NOT NULL,
 CONSTRAINT [PK_utbl_LoginHistory] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[utbl_MillionPasswords]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_MillionPasswords](
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_utbl_MillionPasswords] PRIMARY KEY CLUSTERED 
(
	[Password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[utbl_PasswordHistory]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_PasswordHistory](
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
/****** Object:  Table [dbo].[utbl_Players]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_Players](
	[PlayerId] [int] NOT NULL,
	[PlayerName] [nchar](10) NOT NULL,
	[Password] [nchar](10) NOT NULL,
	[FirstName] [nchar](20) NOT NULL,
	[LastName] [nchar](20) NOT NULL,
	[Address] [nchar](100) NULL,
	[CountryId] [smallint] NOT NULL,
	[Email] [nchar](100) NOT NULL,
	[GenderId] [tinyint] NULL,
	[Birthdate] [date] NOT NULL,
	[IsBlocked]  AS ([dbo].[udf_IsBlocked]([PlayerId])),
	[Balance]  AS ([dbo].[udf_getBalance]([PlayerId])),
 CONSTRAINT [PK_Players] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[utbl_SlotMachineGames]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_SlotMachineGames](
	[GameNo] [int] NOT NULL,
	[Wheel1] [int] NOT NULL,
	[Wheel2] [int] NOT NULL,
	[Wheel3] [int] NOT NULL,
	[IsWin] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[utbl_TransactionType]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[utbl_TransactionType](
	[TransactionTypeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[TransactionTypeName] [nchar](10) NOT NULL,
 CONSTRAINT [PK_TransactionType] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_utbl_Bankroll_PlayerId]    Script Date: 05/04/2019 10:34:59 ******/
CREATE NONCLUSTERED INDEX [IX_utbl_Bankroll_PlayerId] ON [dbo].[utbl_Bankroll]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_utbl_Bankroll_TransactionTypeId]    Script Date: 05/04/2019 10:34:59 ******/
CREATE NONCLUSTERED INDEX [IX_utbl_Bankroll_TransactionTypeId] ON [dbo].[utbl_Bankroll]
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_utbl_Bankroll_PlayerId_TransactionId]    Script Date: 05/04/2019 10:34:59 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_utbl_Bankroll_PlayerId_TransactionId] ON [dbo].[utbl_Bankroll]
(
	[PlayerId] ASC,
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_Countries_CountryName]    Script Date: 05/04/2019 10:34:59 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Countries_CountryName] ON [dbo].[utbl_Countries]
(
	[CountryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PasswordHistory]    Script Date: 05/04/2019 10:34:59 ******/
CREATE NONCLUSTERED INDEX [IX_PasswordHistory] ON [dbo].[utbl_PasswordHistory]
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PlayersCountryId]    Script Date: 05/04/2019 10:34:59 ******/
CREATE NONCLUSTERED INDEX [IX_PlayersCountryId] ON [dbo].[utbl_Players]
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[utbl_Bankroll] ADD  CONSTRAINT [DF_utbl_Bankroll_CommitedOn]  DEFAULT (getdate()) FOR [CommitedOn]
GO
ALTER TABLE [dbo].[utbl_Deposits] ADD  CONSTRAINT [DF_utbl_Deposit_DepositedOn]  DEFAULT (getdate()) FOR [DepositedOn]
GO
ALTER TABLE [dbo].[utbl_GameRounds] ADD  CONSTRAINT [DF_utbl_GameRounds_BetMadeOn]  DEFAULT (getdate()) FOR [BetMadeOn]
GO
ALTER TABLE [dbo].[utbl_Bankroll]  WITH CHECK ADD  CONSTRAINT [FK_utbl_Bankroll_utbl_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[utbl_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[utbl_Bankroll] CHECK CONSTRAINT [FK_utbl_Bankroll_utbl_Players]
GO
ALTER TABLE [dbo].[utbl_Bankroll]  WITH CHECK ADD  CONSTRAINT [FK_utbl_Bankroll_utbl_TransactionType] FOREIGN KEY([TransactionTypeId])
REFERENCES [dbo].[utbl_TransactionType] ([TransactionTypeId])
GO
ALTER TABLE [dbo].[utbl_Bankroll] CHECK CONSTRAINT [FK_utbl_Bankroll_utbl_TransactionType]
GO
ALTER TABLE [dbo].[utbl_Deposits]  WITH NOCHECK ADD  CONSTRAINT [FK_utbl_Deposits_utbl_Bankroll] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[utbl_Bankroll] ([TransactionId])
GO
ALTER TABLE [dbo].[utbl_Deposits] NOCHECK CONSTRAINT [FK_utbl_Deposits_utbl_Bankroll]
GO
ALTER TABLE [dbo].[utbl_PasswordHistory]  WITH CHECK ADD  CONSTRAINT [FK_PasswordHistory_Players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[utbl_Players] ([PlayerId])
GO
ALTER TABLE [dbo].[utbl_PasswordHistory] CHECK CONSTRAINT [FK_PasswordHistory_Players]
GO
ALTER TABLE [dbo].[utbl_Players]  WITH CHECK ADD  CONSTRAINT [FK_Players_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[utbl_Countries] ([CountryId])
GO
ALTER TABLE [dbo].[utbl_Players] CHECK CONSTRAINT [FK_Players_Countries]
GO
ALTER TABLE [dbo].[utbl_Players]  WITH CHECK ADD  CONSTRAINT [FK_Players_Gender] FOREIGN KEY([GenderId])
REFERENCES [dbo].[utbl_Gender] ([GenderId])
GO
ALTER TABLE [dbo].[utbl_Players] CHECK CONSTRAINT [FK_Players_Gender]
GO
ALTER TABLE [dbo].[utbl_Players]  WITH CHECK ADD  CONSTRAINT [FK_utbl_Players_utbl_LoginHistory] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[utbl_LoginHistory] ([PlayerId])
GO
ALTER TABLE [dbo].[utbl_Players] CHECK CONSTRAINT [FK_utbl_Players_utbl_LoginHistory]
GO
ALTER TABLE [dbo].[utbl_Deposits]  WITH CHECK ADD  CONSTRAINT [CK_utbl_Deposit_ExpiryDate] CHECK  (([ExpiryDate]>=getdate()))
GO
ALTER TABLE [dbo].[utbl_Deposits] CHECK CONSTRAINT [CK_utbl_Deposit_ExpiryDate]
GO
ALTER TABLE [dbo].[utbl_Deposits]  WITH CHECK ADD  CONSTRAINT [CK_utbl_Deposit_MaxAmount] CHECK  (([DepositAmount]=(1000)))
GO
ALTER TABLE [dbo].[utbl_Deposits] CHECK CONSTRAINT [CK_utbl_Deposit_MaxAmount]
GO
ALTER TABLE [dbo].[utbl_PasswordHistory]  WITH CHECK ADD  CONSTRAINT [CK_PasswordHistory_EffectiveFrom_LT_EffectiveTo] CHECK  (([EffectiveFrom]>[EffectiveTo]))
GO
ALTER TABLE [dbo].[utbl_PasswordHistory] CHECK CONSTRAINT [CK_PasswordHistory_EffectiveFrom_LT_EffectiveTo]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCashOutAmount]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetCashOutAmount]
	-- Add the parameters for the stored procedure here
	@PlayerId int,
	@CashOutAmount money
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE 
     @balance money

    	-- Check Round's outcome - win or lose
	if @balance >= @CashoutAmount -- the amount of cashout is allowed for  withdrawl
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
/****** Object:  StoredProcedure [dbo].[usp_Player_registration]    Script Date: 05/04/2019 10:34:59 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_PlayerLogin]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 23-03-2019
-- Description:	Login Procedure
-- =============================================
CREATE PROCEDURE [dbo].[usp_PlayerLogin] 
	@PlayerName nchar(10),
	@TryPassword nchar(10)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @PlayerId INT, @Password NCHAR(10)

	-- Get the PalyerId for the supplied PlayerName
	SELECT  @PlayerId = PlayerId
	FROM utbl_Players 
	WHERE PlayerName = @PlayerName

	
	-- Check if the supplied PalyerName is valid, that is, we got a PlayerId
	IF (@PlayerId IS NOT NULL)
		BEGIN
			-- Get the Password for the PlayerId
			SELECT @Password = Password
			FROM utbl_Players
			WHERE PlayerId = @PlayerId

			-- Check if the supplied Password matches the Player's Password
			IF (@Password = @TryPassword)
				BEGIN
					--Insert a new success row into the Login History table
					INSERT INTO utbl_LoginHistory (PlayerId, LoginFrom, LoginSuccessYN)
					VALUES (@PlayerId, GETDATE(), 1)

					-- Retrun success
					RETURN 1
				END
			ELSE
				BEGIN
					--Insert a new failure row into the Login History table
					INSERT INTO utbl_LoginHistory (PlayerId, LoginFrom, LoginSuccessYN)
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
/****** Object:  StoredProcedure [dbo].[usp_PlaySlotMachineRound]    Script Date: 05/04/2019 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nachshon Tamir Alex Kriel Irina Zubkova	
-- Create date: 29-03-2019
-- Description:	Round of Slot Machine game
-- =============================================
CREATE PROCEDURE [dbo].[usp_PlaySlotMachineRound]
	-- Add the parameters for the stored procedure here
	@PlayerId int,
	@BetAmount money


AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @Wheel1 tinyint, @Wheel2 tinyint, @Wheel3 tinyint

   set @Wheel1 = rand (1-6)
   set @Wheel2 = rand (1-6)
   set @Wheel3 = rand (1-6)

   -- Check Round's outcome - win or lose
	if @Wheel1 = @Wheel2 and @Wheel2 = @Wheel3 -- Win!!!
		BEGIN
			-- 1. Insert round's outcome to utbl_GameRounds table
			insert into utbl_GameRounds (PlayerId, GameTypeId, BetAmount, IsWin)
			values (@PlayerId, 2, @BetAmount, 1)

			-- 2. Insert Win amount (BetAmount * 2) to Bankroll table
			insert into utbl_Bankroll (PlayerId, TransactionTypeId, Amount)
			values (@PlayerId, 4, @BetAmount * 2)

			-- 3. Return Win
			RETURN 1
		END
	ELSE -- Lose!!!
		BEGIN
			-- 1. Insert round's outcome to utbl_GameRounds table
			insert into utbl_GameRounds (PlayerId, GameTypeId, BetAmount, IsWin)
			values (@PlayerId, 2, @BetAmount, 0)

			-- 2. Insert Lose amount to Bankroll table
			insert into utbl_Bankroll (PlayerId, TransactionTypeId, Amount)
			values (@PlayerId, 5, @BetAmount)

			-- 3. Return Lose
			RETURN 0
		END 


END

GO
USE [master]
GO
ALTER DATABASE [Casino] SET  READ_WRITE 
GO
