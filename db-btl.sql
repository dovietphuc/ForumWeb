USE [master]
GO
/****** Object:  Database [db_btl_ltw_nc]    Script Date: 11/3/2021 1:25:21 PM ******/
CREATE DATABASE [db_btl_ltw_nc]
GO
USE [db_btl_ltw_nc]
GO

USE [db_btl_ltw_nc]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 11/20/2021 5:46:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[sName] [nvarchar](255) NULL,
	[sMetaTitle] [nvarchar](255) NULL,
	[sContent] [nvarchar](max) NULL,
	[dCreatedDate] [date] NULL,
	[iBlogTypeId] [int] NULL,
	[iStatusId] [int] NULL,
	[iUserId] [int] NULL,
	[iViewCount] [int] NULL,
	[dUpdatedDate] [datetime] NULL,
	[bIsPinned] [bit] NULL,
 CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogType]    Script Date: 11/20/2021 5:46:21 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 11/20/2021 5:46:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[iBlogId] [int] NULL,
	[iUserId] [int] NULL,
	[sContent] [nvarchar](max) NULL,
	[dCreatedDate] [datetime] NULL,
	[dUpdatedDate] [datetime] NULL,
	[iParentcommentId] [int] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fliles]    Script Date: 11/20/2021 5:46:21 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 11/20/2021 5:46:21 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 11/20/2021 5:46:21 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 11/20/2021 5:46:21 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 11/20/2021 5:46:21 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 11/20/2021 5:46:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[iId] [int] IDENTITY(1,1) NOT NULL,
	[sUserName] [nvarchar](255) NULL,
	[sHashedPassword] [nvarchar](255) NULL,
	[sName] [nvarchar](255) NULL,
	[sEmail] [nvarchar](255) NULL,
	[dCreatedDate] [date] NULL,
	[iPermissionId] [int] NULL,
	[sPhone] [nvarchar](255) NULL,
	[sAvatarUrl] [nvarchar](255) NULL,
	[iStatus] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[iId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/*SET IDENTITY_INSERT [dbo].[Blog] ON 

INSERT [dbo].[Blog] ([iId], [sName], [sMetaTitle], [sContent], [dCreatedDate], [iBlogTypeId], [iStatusId], [iUserId], [iViewCount], [dUpdatedDate], [bIsPinned]) VALUES (1, N'Báo cáo mẫu môn Quản trị mạng', NULL, N'Đây là 2 báo cáo mẫu môn : Quản trị mạng mình mình có sưu tầm trước đây.
Hi vọng sẽ hữu ích với mọi người.', CAST(N'2021-11-14' AS Date), NULL, 1, NULL, 0, NULL, NULL)
INSERT [dbo].[Blog] ([iId], [sName], [sMetaTitle], [sContent], [dCreatedDate], [iBlogTypeId], [iStatusId], [iUserId], [iViewCount], [dUpdatedDate], [bIsPinned]) VALUES (2, N'Báo cáo mẫu môn Quản trị mạng', NULL, N'Đây là 2 báo cáo mẫu môn : Quản trị mạng mình mình có sưu tầm trước đây.
Hi vọng sẽ hữu ích với mọi người.', CAST(N'2021-11-14' AS Date), NULL, 1, NULL, 0, NULL, NULL)
INSERT [dbo].[Blog] ([iId], [sName], [sMetaTitle], [sContent], [dCreatedDate], [iBlogTypeId], [iStatusId], [iUserId], [iViewCount], [dUpdatedDate], [bIsPinned]) VALUES (3, N'tieu đề', NULL, N'noi dung 1', CAST(N'2021-11-15' AS Date), 1, NULL, 1, 1, NULL, 0)
INSERT [dbo].[Blog] ([iId], [sName], [sMetaTitle], [sContent], [dCreatedDate], [iBlogTypeId], [iStatusId], [iUserId], [iViewCount], [dUpdatedDate], [bIsPinned]) VALUES (4, N'tieu đề 1 ', NULL, N'noi dung 1', CAST(N'2021-11-18' AS Date), 1, NULL, 2, 2, NULL, 0)
INSERT [dbo].[Blog] ([iId], [sName], [sMetaTitle], [sContent], [dCreatedDate], [iBlogTypeId], [iStatusId], [iUserId], [iViewCount], [dUpdatedDate], [bIsPinned]) VALUES (5, N'tieu de 2', NULL, N'noi dung 2', CAST(N'2021-11-18' AS Date), 2, NULL, 2, 8, NULL, 0)
INSERT [dbo].[Blog] ([iId], [sName], [sMetaTitle], [sContent], [dCreatedDate], [iBlogTypeId], [iStatusId], [iUserId], [iViewCount], [dUpdatedDate], [bIsPinned]) VALUES (6, N'rety', NULL, N'ẻty', CAST(N'2021-11-18' AS Date), 1, NULL, 2, 1, NULL, 0)
INSERT [dbo].[Blog] ([iId], [sName], [sMetaTitle], [sContent], [dCreatedDate], [iBlogTypeId], [iStatusId], [iUserId], [iViewCount], [dUpdatedDate], [bIsPinned]) VALUES (7, N'tieu đề2345', NULL, N'2345', CAST(N'2021-11-18' AS Date), 2, NULL, 2, 0, NULL, 0)
INSERT [dbo].[Blog] ([iId], [sName], [sMetaTitle], [sContent], [dCreatedDate], [iBlogTypeId], [iStatusId], [iUserId], [iViewCount], [dUpdatedDate], [bIsPinned]) VALUES (8, N'1234', NULL, N'12341324', CAST(N'2021-11-18' AS Date), 2, NULL, 2, 1, NULL, 0)
SET IDENTITY_INSERT [dbo].[Blog] OFF
GO
SET IDENTITY_INSERT [dbo].[BlogType] ON 

INSERT [dbo].[BlogType] ([iId], [sName], [sDescription], [iParentBlogTypeId]) VALUES (1, N'Thể loại 1', NULL, NULL)
INSERT [dbo].[BlogType] ([iId], [sName], [sDescription], [iParentBlogTypeId]) VALUES (2, N'Thể Loại 2', NULL, NULL)
SET IDENTITY_INSERT [dbo].[BlogType] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([iId], [iBlogId], [iUserId], [sContent], [dCreatedDate], [dUpdatedDate], [iParentcommentId]) VALUES (1, 5, 2, N'noi dung demo', CAST(N'2021-11-20T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Comment] ([iId], [iBlogId], [iUserId], [sContent], [dCreatedDate], [dUpdatedDate], [iParentcommentId]) VALUES (2, 5, 1, N'user 1 cmt', CAST(N'2021-11-20T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Comment] ([iId], [iBlogId], [iUserId], [sContent], [dCreatedDate], [dUpdatedDate], [iParentcommentId]) VALUES (3, 5, 2, N'demo', CAST(N'2021-11-20T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Comment] ([iId], [iBlogId], [iUserId], [sContent], [dCreatedDate], [dUpdatedDate], [iParentcommentId]) VALUES (4, 5, 2, N'hi', CAST(N'2021-11-20T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Comment] ([iId], [iBlogId], [iUserId], [sContent], [dCreatedDate], [dUpdatedDate], [iParentcommentId]) VALUES (5, 5, 2, N'demo cmt', CAST(N'2021-11-20T00:00:00.000' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
SET IDENTITY_INSERT [dbo].[Fliles] ON 

INSERT [dbo].[Fliles] ([iId], [sUrl], [iBlogId], [iCommentId]) VALUES (1, N'file/admin1_63772841237925nhat-th-web-sql.sql', 8, NULL)
INSERT [dbo].[Fliles] ([iId], [sUrl], [iBlogId], [iCommentId]) VALUES (2, N'file/admin1_63772841518598New Text Document.txt', 8, NULL)
INSERT [dbo].[Fliles] ([iId], [sUrl], [iBlogId], [iCommentId]) VALUES (3, N'file/admin1_63772841237925nhat-th-web-sql.sql', 7, NULL)
SET IDENTITY_INSERT [dbo].[Fliles] OFF
GO
SET IDENTITY_INSERT [dbo].[Images] ON 

INSERT [dbo].[Images] ([iId], [sUrl], [iBlogId], [iCommentId]) VALUES (1, N'images/lake-district-background.jpg', 1, NULL)
INSERT [dbo].[Images] ([iId], [sUrl], [iBlogId], [iCommentId]) VALUES (2, N'images/lake-district-background.jpg', 1, NULL)
INSERT [dbo].[Images] ([iId], [sUrl], [iBlogId], [iCommentId]) VALUES (3, N'~/App_Data/Image/67819780_861114670928894_4974516257068941312_o.jpg', 3, NULL)
INSERT [dbo].[Images] ([iId], [sUrl], [iBlogId], [iCommentId]) VALUES (4, N'~/Image/admin1_63772838928950lich hoc.png', 4, NULL)
INSERT [dbo].[Images] ([iId], [sUrl], [iBlogId], [iCommentId]) VALUES (5, N'Image/admin1_63772841027840lich hoc.png', 5, NULL)
INSERT [dbo].[Images] ([iId], [sUrl], [iBlogId], [iCommentId]) VALUES (6, N'Image/admin1_63772841027866tientien.png', 5, NULL)
SET IDENTITY_INSERT [dbo].[Images] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([iId], [sUserName], [sHashedPassword], [sName], [sEmail], [dCreatedDate], [iPermissionId], [sPhone], [sAvatarUrl]) VALUES (1, N'admin', N'1849190365', NULL, NULL, CAST(N'2021-11-14' AS Date), NULL, NULL, NULL)
INSERT [dbo].[User] ([iId], [sUserName], [sHashedPassword], [sName], [sEmail], [dCreatedDate], [iPermissionId], [sPhone], [sAvatarUrl]) VALUES (2, N'admin1', N'1849190365', N'hồ long nhật', N'holongnhat2000@gmail.com', CAST(N'2021-11-18' AS Date), NULL, N'0866721300', N'UserAvt/admin1_avt67819780_861114670928894_4974516257068941312_o.jpg')
SET IDENTITY_INSERT [dbo].[User] OFF*/
GO
ALTER TABLE [dbo].[Blog] ADD  CONSTRAINT [DF_Blog_dCreatedDate]  DEFAULT (getdate()) FOR [dCreatedDate]
GO
ALTER TABLE [dbo].[Comment] ADD  CONSTRAINT [DF_Comment_dCreatedDate]  DEFAULT (getdate()) FOR [dCreatedDate]
GO
ALTER TABLE [dbo].[Notification] ADD  CONSTRAINT [DF_Notification_dCreatedDate]  DEFAULT (getdate()) FOR [dCreatedDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_dCreatedDate]  DEFAULT (getdate()) FOR [dCreatedDate]
GO
/****** Object:  StoredProcedure [dbo].[create_comment]    Script Date: 11/20/2021 5:46:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[create_comment]
@blogId int,
@userId int,
@content nvarchar(max)
as
begin
	insert into Comment(iBlogId,iUserId,sContent)
	values (@blogId,@userId,@content)
end
GO
/****** Object:  StoredProcedure [dbo].[search_text_blog]    Script Date: 11/20/2021 5:46:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[search_text_blog]
@text nvarchar(255),
@top int
as
begin
	select TOP(@top) * from Blog WHERE sName like '%' + @text + '%' ORDER BY dCreatedDate DESC
end
GO
/****** Object:  StoredProcedure [dbo].[select_comment_by_idBlog]    Script Date: 11/20/2021 5:46:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[select_comment_by_idBlog]
@blogId int
as
begin
	select c.sContent,u.sName,c.dCreatedDate,u.sAvatarUrl,u.sUserName from Comment c join [User] u 
	on c.iUserId = u.iId
	where c.iBlogId   = @blogId
end
GO
/****** Object:  StoredProcedure [dbo].[select_user_by_idBlog]    Script Date: 11/20/2021 5:46:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[select_user_by_idBlog]
@blogId int
as
begin
	select u.* from Blog b join [User] u 
	on b.iUserId = u.iId
	where b.iId = @blogId
end
GO
/****** Object:  StoredProcedure [dbo].[update_view_blog]    Script Date: 11/20/2021 5:46:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[update_view_blog]
@blogId int
as
begin
	UPDATE [dbo].[Blog]
	set iViewCount = iViewCount + 1
	where [iId] = @blogId
end
GO

ALTER proc [dbo].[select_comment_by_idBlog]
@blogId int
as
begin
	select c.iId, c.sContent,u.sName,c.dCreatedDate,u.sAvatarUrl,u.sUserName from Comment c join [User] u 
	on c.iUserId = u.iId
	where c.iBlogId   = @blogId
end
go

create proc [dbo].[select_comment_by_iParentcommentId]
@iParentcommentId int
as
begin
	select c.iId, c.sContent,u.sName,c.dCreatedDate,u.sAvatarUrl,u.sUserName from Comment c join [User] u 
	on c.iUserId = u.iId
	where c.iParentcommentId   = @iParentcommentId
end
go

create proc [dbo].[create_child_comment]
@blogId int,
@userId int,
@content nvarchar(max)
as
begin
	insert into Comment(iParentcommentId,iUserId,sContent)
	values (@blogId,@userId,@content)
end
go

SET IDENTITY_INSERT [dbo].[BlogType] ON 

INSERT [dbo].[BlogType] ([iId], [sName], [sDescription], [iParentBlogTypeId]) VALUES (1, N'Hỏi đáp', NULL, NULL)
INSERT [dbo].[BlogType] ([iId], [sName], [sDescription], [iParentBlogTypeId]) VALUES (2, N'Kho tài liệu', NULL, NULL)
INSERT [dbo].[BlogType] ([iId], [sName], [sDescription], [iParentBlogTypeId]) VALUES (3, N'Thông báo', NULL, NULL)
INSERT [dbo].[BlogType] ([iId], [sName], [sDescription], [iParentBlogTypeId]) VALUES (4, N'Blog', NULL, NULL)

	INSERT [dbo].[BlogType] ([sName], [sDescription], [iParentBlogTypeId]) VALUES (N'Đời sống', NULL, 1)
	INSERT [dbo].[BlogType] ([sName], [sDescription], [iParentBlogTypeId]) VALUES (N'Học tập', NULL, 1)
	INSERT [dbo].[BlogType] ([sName], [sDescription], [iParentBlogTypeId]) VALUES (N'Công việc', NULL, 1)

	INSERT [dbo].[BlogType] ([sName], [sDescription], [iParentBlogTypeId]) VALUES (N'Bài tập lớn', NULL, 2)
	INSERT [dbo].[BlogType] ([sName], [sDescription], [iParentBlogTypeId]) VALUES (N'Tài liệu tham khảo', NULL, 2)
	INSERT [dbo].[BlogType] ([sName], [sDescription], [iParentBlogTypeId]) VALUES (N'Đề thi', NULL, 2)

SET IDENTITY_INSERT [dbo].[BlogType] OFF 
GO

INSERT INTO [dbo].[Permission] ([sName],[sDescription]) VALUES (N'Admin',NULL)
INSERT INTO [dbo].[Permission] ([sName],[sDescription]) VALUES (N'Normal',NULL)

GO

GO

INSERT INTO [dbo].[Status] ([sName],[sDescription]) VALUES (N'Đã duyệt', NULL)
INSERT INTO [dbo].[Status] ([sName],[sDescription]) VALUES (N'Chưa duyệt', NULL)

GO

ALTER proc [dbo].[search_text_blog]
@text nvarchar(255),
@top int
as
begin
	select TOP(@top) * from Blog JOIN [Status] ON [Status].iId = [Blog].iStatusId WHERE [Status].sName like N'Đã duyệt' AND (Blog.sName like '%' + @text + '%') ORDER BY dCreatedDate DESC
end
GO

CREATE proc [dbo].[search_text_blog_for_admin]
@text nvarchar(255),
@top int
as
begin
	select TOP(@top) * from Blog WHERE Blog.sName like '%' + @text + '%' ORDER BY dCreatedDate DESC
end
GO

CREATE PROCEDURE [dbo].[Update_Status_User]
	@Id int,
	@Status bit
AS
BEGIN
	Update [User]
	set iStatus = @Status
	where iId = @Id
END

GO