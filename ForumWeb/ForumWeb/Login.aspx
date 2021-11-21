<%@ Page Title="Đăng nhập" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ForumWeb.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/form.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" action="XuLy/XuLyLogin.aspx" runat="server" method="post" class="box">
        <h2>Đăng nhập</h2>
        <span runat="server" id="lock1" style="color: red;">Tài khoản của bạn đang bị khóa vui lòng liên hệ với admin</span>
        <span runat="server" id="err" style="color: red;">Đăng nhập không thành công</span>
        <span runat="server" id="success" style="color: green;">Đăng ký thành công</span>
        <div class="login">
            <input name="username" type="text" required>
            <label>Tài khoản</label>
        </div>
        <div class="login">
            <input type="password" name="pwd" required>
            <label>Mật khẩu</label>
        </div>
        <input type="submit" value="Đăng nhập">
        <br />
        <a class="sign" href="SignUp.aspx">Bạn chưa có tài khoản? Đăng ký ngay.</a>
    </form>
    
</asp:Content>
