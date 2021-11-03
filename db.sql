USE [master]
GO
/****** Object:  Database [db_btl_ltw_nc]    Script Date: 11/3/2021 1:25:21 PM ******/
CREATE DATABASE [db_btl_ltw_nc]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_btl_ltw_nc', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\db_btl_ltw_nc.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'db_btl_ltw_nc_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\db_btl_ltw_nc_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [db_btl_ltw_nc] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_btl_ltw_nc].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_btl_ltw_nc] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [db_btl_ltw_nc] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_btl_ltw_nc] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_btl_ltw_nc] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET  ENABLE_BROKER 
GO
ALTER DATABASE [db_btl_ltw_nc] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_btl_ltw_nc] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_btl_ltw_nc] SET  MULTI_USER 
GO
ALTER DATABASE [db_btl_ltw_nc] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_btl_ltw_nc] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_btl_ltw_nc] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_btl_ltw_nc] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [db_btl_ltw_nc] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [db_btl_ltw_nc] SET QUERY_STORE = OFF
GO
USE [db_btl_ltw_nc]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 11/3/2021 1:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](255) NULL,
	[sMetaTitle] [nvarchar](255) NULL,
	[sContent] [nvarchar](255) NULL,
	[dCreatedDate] [date] NULL,
	[iBlogTypeId] [int] NULL,
	[iStatusId] [int] NULL,
	[iUserId] [int] NULL,
	[iViewCount] [int] NULL,
	[dUpdatedDate] [date] NULL,
	[bIsPinned] [bit] NULL,
 CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogType]    Script Date: 11/3/2021 1:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogType](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](255) NULL,
	[sDescription] [nvarchar](255) NULL,
	[iParentBlogTypeId] [int] NULL,
 CONSTRAINT [PK_BlogType] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 11/3/2021 1:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[iBlogId] [int] NULL,
	[iUserId] [int] NULL,
	[sContent] [nvarchar](255) NULL,
	[dCreatedDate] [date] NULL,
	[dUpdatedDate] [date] NULL,
	[iParentcommentId] [int] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fliles]    Script Date: 11/3/2021 1:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fliles](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[sUrl] [nvarchar](255) NULL,
	[iBlogId] [int] NULL,
	[iCommentId] [int] NULL,
 CONSTRAINT [PK_Fliles] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 11/3/2021 1:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[sUrl] [nvarchar](255) NULL,
	[iBlogId] [int] NULL,
	[iCommentId] [int] NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 11/3/2021 1:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[iUserId] [int] NULL,
	[dCreatedDate] [date] NULL,
	[sContent] [nvarchar](255) NULL,
	[iBlogId] [int] NULL,
	[iCommentId] [int] NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 11/3/2021 1:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](255) NULL,
	[sDescription] [nvarchar](255) NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 11/3/2021 1:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](255) NULL,
	[sDescription] [nvarchar](255) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 11/3/2021 1:25:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[iId] [int] NOT NULL,
	[sUserName] [nvarchar](255) NULL,
	[sHashedPassword] [nvarchar](255) NULL,
	[sName] [nvarchar](255) NULL,
	[sEmail] [nvarchar](255) NULL,
	[dCreatedDate] [date] NULL,
	[iPermissionId] [int] NULL,
	[sPhone] [nvarchar](255) NULL,
	[sAvatarUrl] [nvarchar](255) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Blog] ADD  CONSTRAINT [DF_Blog_dCreatedDate]  DEFAULT (getdate()) FOR [dCreatedDate]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_dCreatedDate]  DEFAULT (getdate()) FOR [dCreatedDate]
GO
ALTER TABLE [dbo].[Notification] ADD  CONSTRAINT [DF_Notification_dCreatedDate]  DEFAULT (getdate()) FOR [dCreatedDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_dCreatedDate]  DEFAULT (getdate()) FOR [dCreatedDate]
GO
USE [master]
GO
ALTER DATABASE [db_btl_ltw_nc] SET  READ_WRITE 
GO
