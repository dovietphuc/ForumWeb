<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ForumWeb.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.2.1.slim.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/popper.min.js"></script>
    <style type="text/css">
        .category-menu {
            background-color: #f1f1f1;
            border-radius: 12px;
            padding: 10px;
        }

        .content {
            background-color: #f1f1f1;
            border-radius: 12px;
            padding: 10px;
        }

        .blog-item {
            padding-top: 15px;
        }

        [class^="category-item-level-"] {
            list-style: none;
            padding: 10px;
        }

        .category-item-level-2 {
            padding-left: 30px;
        }

        .sub-link {
            background-color: #f1f1f1;
            display: inline-block;
            padding: 5px 10px;
            margin-bottom: 10px;
            border-radius: 6px 24px 24px 6px;
        }

        .btn {
            display: block;
            background-color: #007bff;
            color: #fff;
            width: 100%;
        }

        .avatar {
            background-color: #000;
            width: 50px;
            height: 50px;
            margin: 10px;
        }

        .blog-sub-link {
            background-color: burlywood;
            display: inline-block;
            padding: 2px 6px;
            border-radius: 24px 6px 6px 24px;
            float: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="banner-index">
        <div class="alert alert-primary" role="alert">
            <div class="container">
                <div class="row">
                    Xin chào bạn tới trang web này
                </div>
            </div>
        </div>
    </div>
    <div id="main-index">
        <div class="container">
            <div class="row">
                <div class="col-3">
                    <div class="box-btn" style="margin-bottom: 10px;">
                        <a href="Upload.aspx" class="btn btn-primary">Đăng bài</a>
                    </div>
                    <div class="category-menu">
                        <asp:Repeater ID="RptCategory" runat="server" OnItemDataBound="RptCategory_ItemDataBound">
                            <HeaderTemplate>
                                <li class="category-item-level-0">
                                    <a href="Index.aspx">Tất cả</a>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <li class="category-item-level-1">
                                    <a href="Index.aspx?categoryid=<%#Eval("iId")%>"><%#Eval("sName")%></a>
                                    <asp:Repeater ID="RptSubCategory" runat="server">
                                        <ItemTemplate>
                                            <li class="category-item-level-2">
                                                <a href="Index.aspx?categoryid=<%#Eval("iId")%>"><%#Eval("sName")%></a>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </li>
                            </ItemTemplate>
                            <FooterTemplate>
                                </li>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="col-9">
                    <div id="headerLink" class="sub-link" runat="server">
                    </div>
                    <form id="form1" runat="server">
                        <asp:ScriptManager runat="server" ID="sm" />
                        <asp:UpdatePanel runat="server" ID="updatePanel">
                            <ContentTemplate>
                                <div class="content">
                                    <asp:Repeater ID="RptBlog" runat="server" OnItemDataBound="RptBlog_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="blog-item">
                                                <div style="float: left">
                                                    <asp:Image ID="imgAvatar" runat="server" ImageUrl="UserAvt/default_avt.svg" CssClass="avatar" />
                                                </div>
                                                <div>
                                                    <div id="blogTypeLink" class="blog-sub-link" runat="server">
                                                    </div>
                                                    <a class="title" id="txtNguoiDang" runat="server" href="#">Người đăng</a> - 
                                                    <a class="title" href="/BlogDetail.aspx?Id=<%#Eval("iId")%>"><%#Eval("sName")%></a> - 
                                                    <span class="title" style="font-size: small;"><%#((DateTime)Eval("dCreatedDate")).ToString("dd/MM/yyyy")%></span>
                                                    <p><%#Eval("sContent").ToString().Trim().Substring(0, 149)%>...</p                                                    <div style="font-size: small;">
                                                        <span id="cmtCount" runat="server">0 bình luận</span> - 
                                                        <span><%#Eval("iViewCount")%> lượt xem</span>
                                                    </div>
                                                </div>
                                                <hr />
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:Button ID="btnLoadMore" CssClass="btn" runat="server" Text="Tải thêm" OnClick="btnLoadMore_Click" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </form>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
