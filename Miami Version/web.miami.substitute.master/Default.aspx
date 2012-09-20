<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Miami.Substitute.Web.Master.Default" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <table width="100%" border="0">
        <tr>
            <td style="width: 50px;">
            </td>
            <td>
                <asp:Label Font-Bold="true" Font-Size="10" ID="lblName" runat="server" />
                <br />
                <br />
                <asp:Label Font-Size="10" ID="DefaultLocationLabel" Font-Bold="true" runat="server" />
                <br />
                <br />
                <mits:DetailMenu ID="DetailMenu1" runat="server" RepeatColumns="1" />
            </td>
        </tr>
    </table>
</asp:Content>
