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
            border-bottom: 1px solid #808080;
            padding-top: 15px;
        }

        .category-item-level-2{
            margin-left: 30px;
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
                        </asp:Repeater>
                    </div>
                </div>
                <div class="col-9">
                    <div class="content">
                        <asp:Repeater ID="RptBlog" runat="server">
                            <ItemTemplate>
                                <div class="blog-item">
                                    <a href="/BlogDetail.aspx?Id=<%#Eval("iId")%>"><%#Eval("sName")%></a>
                                    <p><%#Eval("sContent")%></p>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
