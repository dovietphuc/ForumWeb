<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="BlogDetail.aspx.cs" Inherits="ForumWeb.BlogDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.2.1.slim.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/popper.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1" >
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
                    <div class="user">
                        <div class="box-btn">
                           \
                        </div>
                        <asp:Repeater ID="RptUser" runat="server">
                            <ItemTemplate>

                                <div>
                                    <a href="#<%#Eval("iId")%>"><%#Eval("sName")%></a>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="col-9">
                    <div class="content">
                        <asp:Repeater ID="RptBlog" runat="server" OnItemDataBound="RptBlog_ItemDataBound" >
                            <ItemTemplate>
                                <%--<asp:HiddenField ID="hdfBlogID" runat="server" Value='<%#Eval("iId")%>' />--%>
                                <asp:Label ID="hdfBlogID" runat="server" Visible="false" Text='<%#Eval("iId")%>'></asp:Label>
                                <div>
                                    <a href="/BlogDetail.aspx?Id=<%#Eval("iId")%>"><%#Eval("sName")%></a>
                                    <p><%#Eval("sContent")%></p>
                                </div>
                                <div class="box-image">
                                    <asp:Repeater ID="RptImages" runat="server">
                                        <ItemTemplate>
                                            <div class="pb-2">
                                                <img style="" class="w-100" src="<%#Eval("sUrl")%>" alt="" />
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <div class="box-file">
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <div id="contentFile" runat="server">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
