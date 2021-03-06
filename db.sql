USE [master]
GO
/****** Object:  Database [db_btl_ltw_nc]    Script Date: 11/3/2021 1:25:21 PM ******/
CREATE DATABASE [db_btl_ltw_nc]
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
	[sContent] [nvarchar](4000) NULL,
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
	[sContent] [nvarchar](4000) NULL,
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
	[iId] [int] IDENTITY(1,1) NOT NULL,
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

create proc select_user_by_idBlog
@blogId int
as
begin
	select u.* from Blog b join [User] u 
	on b.iUserId = u.iId
	where b.iId = @blogId
end
go

CREATE proc search_text_blog
@text nvarchar(255),
@top int
as
begin
	select TOP(@top) * from Blog WHERE sName like '%' + @text + '%' ORDER BY dCreatedDate DESC
end

go
create proc [dbo].[select_comment_by_idBlog]
@blogId int
as
begin
	select c.sContent,u.sName,c.dCreatedDate,u.sAvatarUrl,u.sUserName from Comment c join [User] u 
	on c.iUserId = u.iId
	where c.iBlogId   = @blogId
end
go
create proc [dbo].[create_comment]
@blogId int,
@userId int,
@content nvarchar(max)
as
begin
	insert into Comment(iBlogId,iUserId,sContent)
	values (@blogId,@userId,@content)
end
go

create proc [dbo].[update_view_blog]
@blogId int
as
begin
	UPDATE [dbo].[Blog]
	set iViewCount = iViewCount + 1
	where [iId] = @blogId
end
go

