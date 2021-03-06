USE [master]
GO
/****** Object:  Database [db_Thuchanh]    Script Date: 10/22/2021 12:48:08 PM ******/
CREATE DATABASE [db_Thuchanh]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_Thuchanh', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\db_Thuchanh.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'db_Thuchanh_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\db_Thuchanh_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_Thuchanh].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_Thuchanh] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_Thuchanh] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_Thuchanh] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_Thuchanh] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_Thuchanh] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_Thuchanh] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [db_Thuchanh] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_Thuchanh] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_Thuchanh] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_Thuchanh] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_Thuchanh] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_Thuchanh] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_Thuchanh] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_Thuchanh] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_Thuchanh] SET  DISABLE_BROKER 
GO
ALTER DATABASE [db_Thuchanh] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_Thuchanh] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_Thuchanh] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_Thuchanh] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_Thuchanh] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_Thuchanh] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_Thuchanh] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_Thuchanh] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_Thuchanh] SET  MULTI_USER 
GO
ALTER DATABASE [db_Thuchanh] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_Thuchanh] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_Thuchanh] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_Thuchanh] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [db_Thuchanh]
GO
/****** Object:  Table [dbo].[tblCategories]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategories](
	[PK_iCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[sCategoryName] [nvarchar](255) NULL,
	[sDescription] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblCategories] PRIMARY KEY CLUSTERED 
(
	[PK_iCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblNews]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNews](
	[PK_iNewsID] [int] IDENTITY(1,1) NOT NULL,
	[sTitle] [nvarchar](255) NULL,
	[sAbstract] [nvarchar](255) NULL,
	[sContent] [nvarchar](255) NULL,
	[tPostedDate] [datetime] NULL,
	[iViewTimes] [int] NULL,
	[bIsAproved] [bit] NULL,
	[Fk_iUserId] [int] NULL,
	[sThumbnail] [varchar](200) NULL,
 CONSTRAINT [PK_tblNews] PRIMARY KEY CLUSTERED 
(
	[PK_iNewsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblNewsCategory]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblNewsCategory](
	[PK_iNewsCategory] [int] IDENTITY(1,1) NOT NULL,
	[FK_iCategoryID] [int] NULL,
	[FK_iNewsID] [int] NULL,
 CONSTRAINT [PK_tblNewsCategory] PRIMARY KEY CLUSTERED 
(
	[PK_iNewsCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[PK_iUserID] [int] IDENTITY(1,1) NOT NULL,
	[sUserName] [nvarchar](255) NULL,
	[sPassword] [nvarchar](255) NULL,
	[iLoginTimes] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[PK_iUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCategories] ON 

INSERT [dbo].[tblCategories] ([PK_iCategoryID], [sCategoryName], [sDescription]) VALUES (1, N'Thể thao', N'tin tức về thể thao')
INSERT [dbo].[tblCategories] ([PK_iCategoryID], [sCategoryName], [sDescription]) VALUES (2, N'Điện tử', N'tin tức về điện tử')
INSERT [dbo].[tblCategories] ([PK_iCategoryID], [sCategoryName], [sDescription]) VALUES (3, N'Giải trí', N'Demo giải trí')
SET IDENTITY_INSERT [dbo].[tblCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[tblNews] ON 

INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (1, N'Tình huống lịch sử: Con số lo sợ và cảnh báo ''sự trừng phạt''10', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-08T10:31:46.993' AS DateTime), NULL, 1, NULL, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (2, N'Tình huống lịch sử: Con số lo sợ và cảnh báo ''sự trừng phạt''10', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-08T10:32:02.790' AS DateTime), NULL, 1, NULL, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (3, N'Tình huống lịch sử: Con số lo sợ và cảnh báo ''sự trừng phạt''10', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-08T10:35:39.133' AS DateTime), NULL, 1, NULL, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (4, N'Tình huống lịch sử: Con số lo sợ và cảnh báo ''sự trừng phạt''10', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-08T10:36:59.170' AS DateTime), NULL, 1, NULL, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (5, N'Tiêu đề', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-08T10:46:07.373' AS DateTime), NULL, 1, NULL, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (6, N'1234', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-18T15:10:30.503' AS DateTime), NULL, 1, NULL, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (7, N'12345', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-18T15:15:17.860' AS DateTime), NULL, 1, NULL, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (8, N'123456', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-18T15:22:47.613' AS DateTime), NULL, 1, NULL, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (9, N'123456', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-18T15:22:56.900' AS DateTime), NULL, 1, NULL, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (10, N'ádf', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-18T15:25:59.370' AS DateTime), NULL, 1, 6, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
INSERT [dbo].[tblNews] ([PK_iNewsID], [sTitle], [sAbstract], [sContent], [tPostedDate], [iViewTimes], [bIsAproved], [Fk_iUserId], [sThumbnail]) VALUES (12, N'Tình huống lịch sử: Con số lo sợ và cảnh báo ''sự trừng phạt''10', NULL, N'Sau làn sóng dịch Covid-19 lần thứ 4, chỉ có 2-3% hộ gia đình cho rằng vẫn ổn. Người giàu cũng thắt chặt chi tiêu và đặt mối quan tâm dịch bệnh, có công ăn việc làm lên hàng đầu.', CAST(N'2021-10-22T10:12:43.057' AS DateTime), NULL, NULL, 6, N'Images/con-so-lich-su-lam-bien-doi-hanh-vi-tieu-dung-hau-dai-dich-covid-19-6.jpg')
SET IDENTITY_INSERT [dbo].[tblNews] OFF
GO
SET IDENTITY_INSERT [dbo].[tblNewsCategory] ON 

INSERT [dbo].[tblNewsCategory] ([PK_iNewsCategory], [FK_iCategoryID], [FK_iNewsID]) VALUES (1, 1, 4)
INSERT [dbo].[tblNewsCategory] ([PK_iNewsCategory], [FK_iCategoryID], [FK_iNewsID]) VALUES (2, 2, 5)
INSERT [dbo].[tblNewsCategory] ([PK_iNewsCategory], [FK_iCategoryID], [FK_iNewsID]) VALUES (3, 2, 6)
INSERT [dbo].[tblNewsCategory] ([PK_iNewsCategory], [FK_iCategoryID], [FK_iNewsID]) VALUES (4, 3, 7)
INSERT [dbo].[tblNewsCategory] ([PK_iNewsCategory], [FK_iCategoryID], [FK_iNewsID]) VALUES (5, 3, 8)
INSERT [dbo].[tblNewsCategory] ([PK_iNewsCategory], [FK_iCategoryID], [FK_iNewsID]) VALUES (6, 3, 9)
INSERT [dbo].[tblNewsCategory] ([PK_iNewsCategory], [FK_iCategoryID], [FK_iNewsID]) VALUES (7, 2, 10)
INSERT [dbo].[tblNewsCategory] ([PK_iNewsCategory], [FK_iCategoryID], [FK_iNewsID]) VALUES (8, 1, 12)
SET IDENTITY_INSERT [dbo].[tblNewsCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUsers] ON 

INSERT [dbo].[tblUsers] ([PK_iUserID], [sUserName], [sPassword], [iLoginTimes]) VALUES (5, N'admin', N'qcuUjjuWC3w=', NULL)
INSERT [dbo].[tblUsers] ([PK_iUserID], [sUserName], [sPassword], [iLoginTimes]) VALUES (6, N'demo2', N'Lg/QWXFkEZU=', NULL)
INSERT [dbo].[tblUsers] ([PK_iUserID], [sUserName], [sPassword], [iLoginTimes]) VALUES (9, N'nhat123', N'oUah6S4gJUA=', NULL)
INSERT [dbo].[tblUsers] ([PK_iUserID], [sUserName], [sPassword], [iLoginTimes]) VALUES (10, N'nhat1', N'qcuUjjuWC3w=', NULL)
INSERT [dbo].[tblUsers] ([PK_iUserID], [sUserName], [sPassword], [iLoginTimes]) VALUES (13, N'admin1', N'Lg/QWXFkEZU=', NULL)
SET IDENTITY_INSERT [dbo].[tblUsers] OFF
GO
ALTER TABLE [dbo].[tblNews] ADD  CONSTRAINT [DF_tblNews_tPostedDate]  DEFAULT (getdate()) FOR [tPostedDate]
GO
/****** Object:  StoredProcedure [dbo].[ChangePassword]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChangePassword]
	@id int,
	@UserName nvarchar(255),
	@Password nvarchar(255),
	@NewPassword nvarchar(255)
AS
BEGIN

 update tblUsers
		set sPassword = @NewPassword
		where PK_iUserID = @Id and sUserName = @UserName and sPassword = @Password
		select iif(@@ROWCOUNT>0,1,0) as res

END
GO
/****** Object:  StoredProcedure [dbo].[Create_Tin]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Create_Tin]
	@title nvarchar(255),
	@thumbnail varchar(200),
	@description nvarchar(255),
	@content nvarchar(255),
	@CategoryId int,
	@UserId int
AS
BEGIN
INSERT INTO tblNews (sTitle,sContent,[sThumbnail],Fk_iUserId)
VALUES (@title, @content,@thumbnail,@UserId)

DECLARE @lastIdNews int;

set @lastIdNews  =  @@IDENTITY 

INSERT INTO [dbo].[tblNewsCategory]([FK_iCategoryID],[FK_iNewsID])
VALUES (@CategoryId, @lastIdNews)
END
GO
/****** Object:  StoredProcedure [dbo].[Get_All_Categories]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_All_Categories]
	
AS
BEGIN

select * from tblCategories

END
GO
/****** Object:  StoredProcedure [dbo].[select_news_child]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[select_news_child]
	@CategoryId int
AS
begin
	select [PK_iNewsID],[sTitle],[sAbstract],[sContent],[tPostedDate],[iViewTimes],[bIsAproved],[sThumbnail] from tblNews n join tblNewsCategory nc on n.PK_iNewsID = nc.FK_iNewsID
	where nc.FK_iCategoryID = @CategoryId
end
GO
/****** Object:  StoredProcedure [dbo].[StoredLogin]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[StoredLogin]
	@UserName nvarchar(255),
	@Password nvarchar(255)
AS
BEGIN
	Select * from tblUsers where [sUserName] = @UserName and [sPassword] = @Password
END
GO
/****** Object:  StoredProcedure [dbo].[StoredRegister]    Script Date: 10/22/2021 12:48:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StoredRegister]
	@UserName nvarchar(255),
	@Password nvarchar(255)
AS
BEGIN
	if not exists (select * from tblUsers where sUserName = @UserName)
		begin
				INSERT INTO tblUsers(sUserName, [sPassword])
				VALUES (@UserName, @Password);
			select 1
		end
	else
		begin
			select 0
		end
END
GO
USE [master]
GO
ALTER DATABASE [db_Thuchanh] SET  READ_WRITE 
GO
