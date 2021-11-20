<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="BlogDetail.aspx.cs" Inherits="ForumWeb.BlogDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery-3.2.1.slim.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/popper.min.js"></script>
    <style>
        .date {
            font-size: 11px
        }

        .comment-text {
            font-size: 12px
        }

        .fs-12 {
            font-size: 12px
        }

        .shadow-none {
            box-shadow: none
        }

        .name {
            color: #007bff
        }

        .cursor:hover {
            color: blue
        }

        .cursor {
            cursor: pointer
        }

        .textarea {
            resize: none
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <form id="form_updatecmt" runat="server">
        <asp:ScriptManager runat="server" ID="sm1" />
        <asp:UpdatePanel runat="server" ID="updatePanel1">
            <ContentTemplate>
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
                                    <asp:Repeater ID="RptUser" runat="server">
                                        <ItemTemplate>
                                            <div class="box-image pb-2">
                                                <img class="w-75" src="<%#Eval("sAvatarUrl")%>" alt="<%#Eval("sName")%>" />
                                            </div>
                                            <div class="box-name">
                                                <p class="text-capitalize">Tên: <%#Eval("sName")%></p>
                                            </div>
                                            <div>
                                                Ngày tham gia: <%#Eval("dCreatedDate", "{0:dd/MM/yyyy}")%>
                                                <%-- <p><%# Eval("dCreatedDate","{0:dd/MM/yyyy}") %></p>--%>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <div class="col-9">
                                <div class="content">
                                    <asp:Repeater ID="RptBlog" runat="server" OnItemDataBound="RptBlog_ItemDataBound">
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
                                <div class="box-cmt">
                                    <div id="commentContent">
                                        <asp:Repeater ID="RptComment" runat="server" OnItemDataBound="RptCmt_ItemDataBound">
                                            <ItemTemplate>
                                                <asp:Label ID="cmtID" runat="server" Visible="false" Text='<%#Eval("iId")%>'></asp:Label>

                                                <div class="bg-white p-2">
                                                    <div class="d-flex flex-row user-info">
                                                        <img class="rounded-circle" src="<%#Eval("sAvatarUrl").ToString()==""?"Image/emptyAvatar.jpg":Eval("sAvatarUrl")%>" width="40">
                                                        <div class="d-flex flex-column justify-content-start ml-2">
                                                            <span class="d-block font-weight-bold name"><%#Eval("sName").ToString()==""?Eval("sUserName"):Eval("sName")%></span>
                                                            <span class="date text-black-50"><%#Eval("dCreatedDate", "{0:dd/MM/yyyy}")%></span>
                                                        </div>
                                                    </div>
                                                    <div class="mt-2">
                                                        <p class="comment-text"><%#Eval("sContent")%></p>
                                                    </div>
                                                    <div class="bg-white pt-0">
                                                        <div class="d-flex flex-row fs-12">
                                                            <div class="like cursor action-collapse" data-toggle="collapse" aria-expanded="true" aria-controls="cp-<%#Eval("iId")%>" href="#cp-<%#Eval("iId")%>">
                                                                <i class="fa fa-commenting-o"></i>
                                                                <span class="ml-1">Comment</span>
                                                            </div>
                                                        </div>
                                                        <%-- box-child-cmt --%>
                                                        <div class="box-child-cmt pl-4 pt-3">
                                                            <asp:Repeater ID="RptChildComment" runat="server">
                                                                <ItemTemplate>
                                                                    <div class="d-flex flex-row user-info">
                                                                        <img class="rounded-circle" src="<%#Eval("sAvatarUrl").ToString()==""?"Image/emptyAvatar.jpg":Eval("sAvatarUrl")%>" width="40">
                                                                        <div class="d-flex flex-column justify-content-start ml-2">
                                                                            <span class="d-block font-weight-bold name"><%#Eval("sName").ToString()==""?Eval("sUserName"):Eval("sName")%></span>
                                                                            <span class="date text-black-50"><%#Eval("dCreatedDate", "{0:dd/MM/yyyy}")%></span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="mt-2">
                                                                        <p class="comment-text"><%#Eval("sContent")%></p>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                        <%-- end box-child-cmt --%>
                                                    </div>
                                                    <div id="cp-<%#Eval("iId")%>" class="bg-light p-2 collapse" data-parent="#myGroup">
                                                        <div class="d-flex flex-row align-items-start">
                                                            <%--<asp:Image ID="imgChildAvartar" CssClass="rounded-circle" Width="40" ImageUrl="Image/emptyAvatar.jpg" runat="server" />--%>
                                                            <textarea id="taChildComment" runat="server" class="form-control ml-1 shadow-none textarea"></textarea>

                                                        </div>
                                                        <div class="mt-2 text-right">
                                                            <asp:LinkButton ID="LinkButton1" Tagkey='<%#Eval("iId")%>' Text='reply comment' runat="server"
                                                                OnCommand="cbAproved_Command_Rep"
                                                                CssClass="btn btn-primary btn-sm shadow-none"></asp:LinkButton>
                                                            <%--<button class="btn btn-primary btn-sm shadow-none" type="button">reply comment</button>--%>
                                                            <button class="btn btn-outline-primary btn-sm ml-1 shadow-none" type="button">Cancel</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                    <div class="bg-light p-2">
                                        <div class="d-flex flex-row align-items-start">
                                            <asp:Image ID="imgAvartar" CssClass="rounded-circle" Width="40" ImageUrl="Image/emptyAvatar.jpg" runat="server" />

                                            <textarea id="taComment" runat="server" class="form-control ml-1 shadow-none textarea"></textarea>
                                        </div>
                                        <div class="mt-2 text-right">
                                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary btn-sm shadow-none" Text="Post comment" OnClick="btnSubmit_Click" />
                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-outline-primary btn-sm ml-1 shadow-none" Text="Cancel" OnClick="btnCancel_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>
