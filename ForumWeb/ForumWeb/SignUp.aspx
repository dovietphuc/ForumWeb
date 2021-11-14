<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="ForumWeb.SignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/form.css" rel="stylesheet" />
    <script type="text/javascript">
        function checkSignUp() {
            let pwd = document.getElementById("pwd").value;
            let repwd = document.getElementById("re-pwd").value;
            if (pwd != repwd) {
                alert("Mật khẩu xác nhận không chính xác");
                return false;
            } 
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form2" action="XuLy/XuLySignUp.aspx" runat="server" method="post" onsubmit="return checkSignUp()" class="box" >
        <h2>Đăng ký</h2>
        <div class="login">
            <input name="username" type="text" required>
            <label>Tài khoản</label>
        </div>
        <div class="login">
            <input id="pwd" name="pwd" type="password" required>
            <label>Mật khẩu</label>
        </div>
        <div class="login">
            <input id="re-pwd" name="re-pwd" type="password" required>
            <label>Nhập lại mật khẩu</label>
        </div>
        <input type="submit" value="Đăng ký">
        <br />
        <a class="sign" href="Login.aspx">Bạn đã có tài khoản? Đăng nhập ngay.</a>
    </form>
</asp:Content>
