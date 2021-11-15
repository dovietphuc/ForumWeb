<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="ForumWeb.Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.min.css" crossorigin="anonymous">
    <link href="../css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" crossorigin="anonymous">
    <link href="../themes/explorer-fas/theme.css" media="all" rel="stylesheet" type="text/css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
    <script src="../js/plugins/piexif.js" type="text/javascript"></script>
    <script src="../js/plugins/sortable.js" type="text/javascript"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="../js/fileinput.js" type="text/javascript"></script>
    <script src="../js/locales/fr.js" type="text/javascript"></script>
    <script src="../js/locales/es.js" type="text/javascript"></script>
    <script src="../themes/fas/theme.js" type="text/javascript"></script>
    <script src="../themes/explorer-fas/theme.js" type="text/javascript"></script>
    <style>
        form {
            background-color: #f1f1f1;
            margin: 10px 5%;
            border-radius: 12px;
            padding: 24px;
        }

        input[type="text"] {
            padding: 6px;
            width: 100%;
            border-radius: 6px;
            border: none;
        }

        textarea {
            padding: 6px;
            width: 100%;
            min-height: 200px;
            border-radius: 6px;
            border: none;
        }

        .btnSubmit {
            background-color: chartreuse;
            padding: 10px;
            transition: 0.25s;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }

            .btnSubmit:hover {
                background-color: #000000;
                color: chartreuse;
            }

        .cancel {
            display: inline-block;
            background-color: #b60000;
            padding: 10px;
            transition: 0.25s;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            color: #000;
            text-decoration: none;
        }

            .cancel:hover {
                background-color: #000000;
                color: #b60000;
                text-decoration: none;
            }

        .btn-wrap {
            text-align: right;
        }

        .listbox {
            width: 100%;
            border-radius: 6px;
            padding: 6px;
            margin-top: 6px;
            border: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="uploadform" runat="server">
        <label>Thể loại</label><br />
        <asp:ListBox ID="ListBoxCategories" CssClass="listbox" runat="server" DataSourceID="CategoriesDataSource" DataTextField="sName" DataValueField="iId" />
        <asp:SqlDataSource ID="CategoriesDataSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:dbconnect %>"
            SelectCommand="SELECT * FROM [BlogType]" />
        <hr />
        <input type="text" id="txtTitle" runat="server" name="txtTitle" required="required" placeholder="Tiêu đề cuộc thảo luận" />

        <hr />
        <textarea name="txtContent" id="txtContent" runat="server" required="required" placeholder="Nội dung"></textarea>
        <hr />
        <label>Thêm ảnh</label><br />
        <asp:FileUpload ID="iUpload" runat="server" AllowMultiple="true" />
        <hr />
        <label>Thêm tệp đính kèm</label><br />
        <asp:FileUpload ID="fUpload" runat="server" AllowMultiple="true" />
        <hr />
        <div class="btn-wrap">
            <asp:Button ID="btnSubmit" runat="server" Text="Đăng bài" CssClass="btnSubmit" OnClick="btnSubmit_Click" />
            <a class="cancel" href="Index.aspx">Hủy</a>
        </div>
    </form>
</asp:Content>
