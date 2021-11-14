<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="ForumWeb.SignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/form.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box">
        <h2>Đăng ký</h2>
        <div class="login">
            <input type="text" required>
            <label>Tài khoản</label>
        </div>
        <div class="login">
            <input type="password" required>
            <label>Mật khẩu</label>
        </div>
        <input type="submit" value="Đăng nhập">
        <br />
        <a class="sign" href="Login.aspx">Bạn chưa có tài khoản? Đăng ký ngay.</a>
    </div>
</asp:Content>
