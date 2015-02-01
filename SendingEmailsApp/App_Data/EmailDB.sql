USE [master]
GO
/****** Object:  Database [EmailsDB]    Script Date: 4/4/2014 11:06:47 PM ******/
CREATE DATABASE [EmailsDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmailsDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EmailsDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EmailsDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EmailsDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EmailsDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmailsDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmailsDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmailsDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmailsDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmailsDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmailsDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmailsDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmailsDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EmailsDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmailsDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmailsDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmailsDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmailsDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmailsDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmailsDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmailsDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmailsDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmailsDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmailsDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmailsDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmailsDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmailsDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmailsDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmailsDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmailsDB] SET RECOVERY FULL 
GO
ALTER DATABASE [EmailsDB] SET  MULTI_USER 
GO
ALTER DATABASE [EmailsDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmailsDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmailsDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmailsDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EmailsDB', N'ON'
GO
USE [EmailsDB]
GO
/****** Object:  StoredProcedure [dbo].[GetEmailsToBeSend]    Script Date: 4/4/2014 11:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmailsToBeSend]
AS
BEGIN
	SELECT * FROM tblEmails WHERE EmailStatus = 0
END
	
GO
/****** Object:  StoredProcedure [dbo].[SendEmail]    Script Date: 4/4/2014 11:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SendEmail]
@EmailAddress nvarchar(200),
@EmailName nvarchar(50),
@EmailLastName nvarchar(50),
@EmailBody nvarchar(MAX)
AS
BEGIN
	INSERT INTO tblEmails VALUES (@EmailAddress,@EmailName,@EmailLastName,@EmailBody,0)
END
	
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmailStatus]    Script Date: 4/4/2014 11:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEmailStatus]
@EmailID int
AS
BEGIN
	UPDATE tblEmails SET EmailStatus = 1 WHERE EmailID = @EmailID
END
	
GO
/****** Object:  Table [dbo].[tblEmails]    Script Date: 4/4/2014 11:06:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmails](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](200) NOT NULL,
	[EmailName] [nvarchar](50) NOT NULL,
	[EmailLastName] [nvarchar](50) NOT NULL,
	[EmailBody] [nvarchar](max) NOT NULL,
	[EmailStatus] [bit] NOT NULL,
 CONSTRAINT [PK_tblEmails] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
USE [master]
GO
ALTER DATABASE [EmailsDB] SET  READ_WRITE 
GO
