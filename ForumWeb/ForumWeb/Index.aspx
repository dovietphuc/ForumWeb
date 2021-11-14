<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ForumWeb.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
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
                <div class="col-lg-3">
                    <div class="category-menu">
                        <asp:Repeater ID="RptCategory" runat="server">
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div>
                                    <a href="#<%#Eval("iId")%>"><%#Eval("sName")%></a>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="content">
                        <asp:Repeater ID="RptBlog" runat="server">
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div>
                                    <a href="#<%#Eval("iId")%>"><%#Eval("sName")%></a>
                                    <p><%#Eval("sContent")%></p>
                                </div>
                            </ItemTemplate>
                            <FooterTemplate>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
