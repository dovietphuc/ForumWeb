<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ForumWeb.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.2.1.slim.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/popper.min.js"></script></asp:Content>
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
                    <div class="category-menu">
                        <div class="box-btn">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
                                Đăng bài
                            </button>
                        </div>
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
                <div class="col-9">
                    <div class="content">
                        <asp:Repeater ID="RptBlog" runat="server">
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div>
                                    <a href="/BlogDetail.aspx?Id=<%#Eval("iId")%>"><%#Eval("sName")%></a>
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
    <!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Đăng bài</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <textarea class="ta-dangbai">
        </textarea>
           <input type="file" class="upload-image" id="">
           <input type="file" class="upload-file" id="">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
</asp:Content>
