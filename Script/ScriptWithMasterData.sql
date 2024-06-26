USE [master]
GO
/****** Object:  Database [TopUp]    Script Date: 04/04/2024 18:59:08 ******/
CREATE DATABASE [TopUp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TopUp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TopUp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TopUp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TopUp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TopUp] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TopUp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TopUp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TopUp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TopUp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TopUp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TopUp] SET ARITHABORT OFF 
GO
ALTER DATABASE [TopUp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TopUp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TopUp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TopUp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TopUp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TopUp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TopUp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TopUp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TopUp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TopUp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TopUp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TopUp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TopUp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TopUp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TopUp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TopUp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TopUp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TopUp] SET RECOVERY FULL 
GO
ALTER DATABASE [TopUp] SET  MULTI_USER 
GO
ALTER DATABASE [TopUp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TopUp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TopUp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TopUp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TopUp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TopUp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TopUp', N'ON'
GO
ALTER DATABASE [TopUp] SET QUERY_STORE = OFF
GO
USE [TopUp]
GO
/****** Object:  Table [dbo].[Beneficiaries]    Script Date: 04/04/2024 18:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Beneficiaries](
	[UId] [bigint] IDENTITY(1,1) NOT NULL,
	[NickName] [varchar](20) NULL,
	[MobileNumber] [varchar](10) NULL,
	[CountryCode] [varchar](10) NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[LastUpdatedBy] [varchar](50) NULL,
	[LastUpdatedAt] [datetime] NULL,
	[UserId] [bigint] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Beneficiaries] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currencies]    Script Date: 04/04/2024 18:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currencies](
	[UId] [bigint] IDENTITY(1,1) NOT NULL,
	[Currency] [varchar](10) NULL,
 CONSTRAINT [PK_Currencies] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TopUpOptions]    Script Date: 04/04/2024 18:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopUpOptions](
	[UId] [bigint] IDENTITY(1,1) NOT NULL,
	[Amount] [int] NULL,
	[CurrencyId] [bigint] NULL,
 CONSTRAINT [PK_TopUpOptions] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 04/04/2024 18:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UId] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[IsVerified] [bit] NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdatedBy] [varchar](50) NULL,
	[LastUpdatedAt] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTransactions]    Script Date: 04/04/2024 18:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTransactions](
	[UId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NULL,
	[TransactionType] [varchar](10) NULL,
	[Amount] [decimal](18, 2) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdatedBy] [varchar](50) NULL,
	[LastUpdatedAt] [datetime] NULL,
	[BeneficiaryId] [bigint] NULL,
	[CurrencyId] [bigint] NULL,
 CONSTRAINT [PK_UserTransactions] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserWalletBalances]    Script Date: 04/04/2024 18:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserWalletBalances](
	[UId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NULL,
	[Balance] [decimal](18, 2) NULL,
	[CurrencyId] [bigint] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[LastUpdatedBy] [varchar](50) NULL,
	[LastUpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_UserWalletBalances] PRIMARY KEY CLUSTERED 
(
	[UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Beneficiaries] ON 

INSERT [dbo].[Beneficiaries] ([UId], [NickName], [MobileNumber], [CountryCode], [CreatedAt], [CreatedBy], [LastUpdatedBy], [LastUpdatedAt], [UserId], [IsActive]) VALUES (2, N'TomB', N'0544066653', N'+971', CAST(N'2024-04-04T16:01:56.667' AS DateTime), N'1', N'1', CAST(N'2024-04-04T13:24:57.140' AS DateTime), 1, 1)
INSERT [dbo].[Beneficiaries] ([UId], [NickName], [MobileNumber], [CountryCode], [CreatedAt], [CreatedBy], [LastUpdatedBy], [LastUpdatedAt], [UserId], [IsActive]) VALUES (3, N'ZenA', N'0169758085', N'+971', CAST(N'2024-04-04T02:14:52.133' AS DateTime), N'1', N'2', CAST(N'2024-04-04T16:08:50.357' AS DateTime), 2, 1)
INSERT [dbo].[Beneficiaries] ([UId], [NickName], [MobileNumber], [CountryCode], [CreatedAt], [CreatedBy], [LastUpdatedBy], [LastUpdatedAt], [UserId], [IsActive]) VALUES (4, N'BenB', N'4973441455', N'+971', CAST(N'2024-04-04T08:57:48.037' AS DateTime), N'1', N'1', CAST(N'2024-04-04T08:57:48.037' AS DateTime), 4, 1)
INSERT [dbo].[Beneficiaries] ([UId], [NickName], [MobileNumber], [CountryCode], [CreatedAt], [CreatedBy], [LastUpdatedBy], [LastUpdatedAt], [UserId], [IsActive]) VALUES (5, N'TomA', N'8357730789', N'+971', CAST(N'2024-04-04T16:01:46.180' AS DateTime), N'1', N'1', CAST(N'2024-04-04T16:01:46.180' AS DateTime), 1, 1)
INSERT [dbo].[Beneficiaries] ([UId], [NickName], [MobileNumber], [CountryCode], [CreatedAt], [CreatedBy], [LastUpdatedBy], [LastUpdatedAt], [UserId], [IsActive]) VALUES (6, N'TomC', N'8357730789', N'+971', CAST(N'2024-04-04T16:01:56.667' AS DateTime), N'1', N'1', CAST(N'2024-04-04T16:08:02.270' AS DateTime), 2, 1)
INSERT [dbo].[Beneficiaries] ([UId], [NickName], [MobileNumber], [CountryCode], [CreatedAt], [CreatedBy], [LastUpdatedBy], [LastUpdatedAt], [UserId], [IsActive]) VALUES (7, N'TomD', N'5449444432', N'+971', CAST(N'2024-04-04T16:01:56.667' AS DateTime), NULL, NULL, NULL, 2, 1)
SET IDENTITY_INSERT [dbo].[Beneficiaries] OFF
GO
SET IDENTITY_INSERT [dbo].[Currencies] ON 

INSERT [dbo].[Currencies] ([UId], [Currency]) VALUES (1, N'AED')
SET IDENTITY_INSERT [dbo].[Currencies] OFF
GO
SET IDENTITY_INSERT [dbo].[TopUpOptions] ON 

INSERT [dbo].[TopUpOptions] ([UId], [Amount], [CurrencyId]) VALUES (1, 5, 1)
INSERT [dbo].[TopUpOptions] ([UId], [Amount], [CurrencyId]) VALUES (2, 10, 1)
INSERT [dbo].[TopUpOptions] ([UId], [Amount], [CurrencyId]) VALUES (3, 20, 1)
INSERT [dbo].[TopUpOptions] ([UId], [Amount], [CurrencyId]) VALUES (4, 30, 1)
INSERT [dbo].[TopUpOptions] ([UId], [Amount], [CurrencyId]) VALUES (5, 50, 1)
INSERT [dbo].[TopUpOptions] ([UId], [Amount], [CurrencyId]) VALUES (6, 75, 1)
INSERT [dbo].[TopUpOptions] ([UId], [Amount], [CurrencyId]) VALUES (7, 100, 1)
SET IDENTITY_INSERT [dbo].[TopUpOptions] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UId], [FirstName], [LastName], [IsVerified], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt], [IsActive]) VALUES (1, N'Tom', N'A', 1, N'System', CAST(N'2024-04-04T16:01:56.667' AS DateTime), N'', NULL, 1)
INSERT [dbo].[Users] ([UId], [FirstName], [LastName], [IsVerified], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt], [IsActive]) VALUES (2, N'Jez', N'B', 1, N'System', CAST(N'2024-04-04T16:01:56.667' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Users] ([UId], [FirstName], [LastName], [IsVerified], [CreatedBy], [CreatedAt], [LastUpdatedBy], [LastUpdatedAt], [IsActive]) VALUES (4, N'Jacob', N'C', 0, N'System', CAST(N'2024-04-04T16:01:56.667' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[UserWalletBalances] ON 

INSERT [dbo].[UserWalletBalances] ([UId], [UserId], [Balance], [CurrencyId], [CreatedAt], [CreatedBy], [LastUpdatedBy], [LastUpdatedAt]) VALUES (1, 1, CAST(20.00 AS Decimal(18, 2)), 1, CAST(N'2024-04-04T16:01:56.667' AS DateTime), N'System', N'1', CAST(N'2024-04-04T11:07:59.377' AS DateTime))
INSERT [dbo].[UserWalletBalances] ([UId], [UserId], [Balance], [CurrencyId], [CreatedAt], [CreatedBy], [LastUpdatedBy], [LastUpdatedAt]) VALUES (3, 2, CAST(10.00 AS Decimal(18, 2)), 1, CAST(N'2024-04-04T16:01:56.667' AS DateTime), N'System', N'2', CAST(N'2024-04-04T12:25:07.543' AS DateTime))
INSERT [dbo].[UserWalletBalances] ([UId], [UserId], [Balance], [CurrencyId], [CreatedAt], [CreatedBy], [LastUpdatedBy], [LastUpdatedAt]) VALUES (4, 4, CAST(39.00 AS Decimal(18, 2)), 1, CAST(N'2024-04-04T16:01:56.667' AS DateTime), N'System', N'1', CAST(N'2024-04-04T12:33:49.597' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserWalletBalances] OFF
GO
ALTER TABLE [dbo].[Beneficiaries]  WITH CHECK ADD  CONSTRAINT [FK_Beneficiaries_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UId])
GO
ALTER TABLE [dbo].[Beneficiaries] CHECK CONSTRAINT [FK_Beneficiaries_Users]
GO
ALTER TABLE [dbo].[TopUpOptions]  WITH CHECK ADD  CONSTRAINT [FK_TopUpOptions_Currencies] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currencies] ([UId])
GO
ALTER TABLE [dbo].[TopUpOptions] CHECK CONSTRAINT [FK_TopUpOptions_Currencies]
GO
ALTER TABLE [dbo].[UserTransactions]  WITH CHECK ADD  CONSTRAINT [FK_UserTransactions_Beneficiaries] FOREIGN KEY([BeneficiaryId])
REFERENCES [dbo].[Beneficiaries] ([UId])
GO
ALTER TABLE [dbo].[UserTransactions] CHECK CONSTRAINT [FK_UserTransactions_Beneficiaries]
GO
ALTER TABLE [dbo].[UserTransactions]  WITH CHECK ADD  CONSTRAINT [FK_UserTransactions_Currencies] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currencies] ([UId])
GO
ALTER TABLE [dbo].[UserTransactions] CHECK CONSTRAINT [FK_UserTransactions_Currencies]
GO
ALTER TABLE [dbo].[UserTransactions]  WITH CHECK ADD  CONSTRAINT [FK_UserTransactions_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UId])
GO
ALTER TABLE [dbo].[UserTransactions] CHECK CONSTRAINT [FK_UserTransactions_Users]
GO
ALTER TABLE [dbo].[UserWalletBalances]  WITH CHECK ADD  CONSTRAINT [FK_UserWalletBalances_Currencies] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currencies] ([UId])
GO
ALTER TABLE [dbo].[UserWalletBalances] CHECK CONSTRAINT [FK_UserWalletBalances_Currencies]
GO
ALTER TABLE [dbo].[UserWalletBalances]  WITH CHECK ADD  CONSTRAINT [FK_UserWalletBalances_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UId])
GO
ALTER TABLE [dbo].[UserWalletBalances] CHECK CONSTRAINT [FK_UserWalletBalances_Users]
GO
USE [master]
GO
ALTER DATABASE [TopUp] SET  READ_WRITE 
GO
