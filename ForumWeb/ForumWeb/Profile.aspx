<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="ForumWeb.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        form {
            background-color: #f1f1f1;
            margin: 10px 5%;
            border-radius: 12px;
            padding: 24px;
            text-align: center;
        }

        .wrap {
            display: inline-block;
            text-align: left;
        }

            .wrap div {
                text-align: right;
                margin: 6px;
            }

        .input, input {
            outline: none;
            border: none;
            padding: 6px;
            border-radius: 6px;
            width: 300px;
        }

        .action {
            display: inline-block;
            background-color: chartreuse;
            padding: 10px;
            transition: 0.25s;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            color: #000;
            text-decoration: none;
        }

            .action:hover {
                background-color: #000000;
                color: chartreuse;
                text-decoration: none;
            }

        .danger {
            background-color: #ff0000;
        }

            .danger:hover {
                background-color: #000000;
                color: #ff0000;
                text-decoration: none;
            }

        .hidden {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form_updateprofile" runat="server">
        <asp:ScriptManager runat="server" ID="sm" />
        <asp:UpdatePanel runat="server" ID="updatePanel">
            <ContentTemplate>
                <div class="wrap">
                    <div>
                        <img src="UserAvt/default_avt.svg" id="imageAvt" runat="server" style="width: 100px; background-color: #000; padding: 3px;" />
                        <asp:FileUpload ID="fileAvt" runat="server" accept=".png,.jpg,.jpeg" />
                        <br />
                        <asp:Button ID="btnLoadImage" runat="server" CssClass="action" Text="Tải ảnh lên" OnClick="btnLoadImage_Click" />
                    </div>
                    <div>
                        <label>Tài khoản:</label>
                        <input type="text" id="txtUsername" runat="server" readonly />
                    </div>
                    <div>
                        <label>Họ và tên:</label>
                        <asp:TextBox ID="txtFullname" CssClass="input" runat="server" />
                    </div>
                    <div>
                        <label>Email:</label>
                        <asp:TextBox ID="txtEmail" TextMode="Email" CssClass="input" runat="server" />
                    </div>
                    <div>
                        <label>Điện thoại:</label>
                        <asp:TextBox ID="txtPhone" TextMode="Phone" CssClass="input" runat="server" />
                    </div>
                    <div>
                        <label>Ngày tạo tài khoản:</label>
                        <input type="text" id="txtTimeCreate" runat="server" readonly />
                    </div>
                    <div>
                        <ul style="color: #00ff00; list-style: none;">
                            <li id="updateProfileSuccess" runat="server">Cập nhật hồ sơ thành công</li>
                        </ul>
                        <ul style="color: #ff0000; list-style: none;">
                            <li id="updateProfileFail" runat="server">Cập nhật hồ sơ không thành công</li>
                        </ul>
                    </div>
                    <div>
                        <asp:Button ID="btnUpdate" runat="server" CssClass="action" OnClick="btnUpdate_Click" Text="Cập nhật hồ sơ" />
                    </div>
                    <hr />
                    <div>
                        <label>Mật khẩu cũ:</label>
                        <asp:TextBox ID="txtOldPWD" TextMode="Password" CssClass="input" runat="server" />
                    </div>
                    <div>
                        <label>Mật khẩu mới:</label>
                        <asp:TextBox ID="txtNewPwd" TextMode="Password" CssClass="input" runat="server" />
                    </div>
                    <div>
                        <label>Nhập lại mật khẩu mới:</label>
                        <asp:TextBox ID="txtCfPWD" TextMode="Password" CssClass="input" runat="server" />
                    </div>
                    <div>
                        <ul style="color: #ff0000; list-style: none;">
                            <li id="errSaiPWD" runat="server">Mật khẩu cũ không chính xác</li>
                            <li id="errSaiCfPWD" runat="server">Mật khẩu nhập lại không khớp</li>
                            <li id="errPWDRong" runat="server">Không được bỏ trống mật khẩu mới</li>
                        </ul>
                        <ul style="color: #00ff00; list-style: none;">
                            <li id="changePwdSuccess" runat="server">Đổi mật khẩu thành công</li>
                        </ul>
                    </div>
                    <div>
                        <asp:Button ID="btnChangePWD" runat="server" CssClass="action danger" OnClick="btnChangePWD_Click" Text="Đổi mật khẩu" />
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnLoadImage" />
            </Triggers>
        </asp:UpdatePanel>
    </form>
</asp:Content>
