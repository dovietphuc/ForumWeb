<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="User1.aspx.cs" Inherits="ForumWeb.User1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="">
            <form id="form_userupdate" runat="server">
                <div id="messageID" runat="server">
                </div>
                <asp:ScriptManager ID="sm2" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Repeater ID="rptrUser" runat="server">
                            <HeaderTemplate>
                                <table class="table">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col"># Id</th>
                                            <th scope="col">User name</th>
                                            <th scope="col">Created date </th>
                                            <th scope="col">Role </th>
                                            <th scope="col">Trạng thái</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id="tr-<%#Eval("iId")%>">
                                    <th scope="row"><%#Eval("iId")%></th>
                                    <td><%#Eval("sUserName")%></td>
                                    <td><%#Eval("dCreatedDate")%></td>
                                    <td><%#Eval("iPermissionId").ToString()=="1"?"admin":"user"%></td>
                                    <td>
                                        <asp:LinkButton
                                            Tagkey='<%#Eval("iId")%>'
                                            Text='<%#(Eval("iStatus").ToString() == "1" ? "Đang hoạt động" : "Khóa")%>'
                                            runat="server"
                                            OnCommand="cbAproved_Command" />

                                    </td>
                                </tr>

                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                    </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </form>

        </div>
    </div>
</asp:Content>
