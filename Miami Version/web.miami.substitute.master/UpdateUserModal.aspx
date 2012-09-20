<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UpdateUserModal.aspx.cs" Inherits="UpdateUserModal" Title="Untitled Page" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">

    <script type="text/javascript">
            function CloseAndRebind() {
                GetRadWindow().BrowserWindow.refreshGrid();
                GetRadWindow().close();
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

                return oWindow;
            }

            function CancelEdit() {
                GetRadWindow().close();
            }
    </script>

    <b>Update Substitute</b>
    <br />
    <br />
    <asp:Table ID="UpdateSubstituteTable" runat="server">
        <asp:TableRow ID="TableRow1" runat="server">
            <asp:TableCell ID="TableCell1" runat="server" Text="Alt Phone" />
            <asp:TableCell ID="TableCell2" runat="server">
                <asp:TextBox runat="server" ID="AltPhone" Width="230px" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow2" runat="server">
            <asp:TableCell ID="TableCell3" runat="server" Text="Notes" />
            <asp:TableCell ID="TableCell4" runat="server">
                <asp:TextBox runat="server" ID="Notes" Width="230px" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow3" runat="server">
            <asp:TableCell ID="TableCell5" runat="server" Text="Preferred" />
            <asp:TableCell ID="TableCell6" runat="server">
                <asp:CheckBox runat="server" ID="Preferred" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableFooterRow ID="TableFooterRow1" runat="server" TableSection="TableFooter">
            <asp:TableCell ID="TableCell7" runat="server" ColumnSpan="2">
                <asp:Button runat="server" ID="UpdateButton" OnClick="SaveButton_Click" ValidationGroup="UserForm"
                    Text="Update" />&nbsp;&nbsp;or&nbsp;&nbsp;<asp:LinkButton runat="server" ID="CancelButton" Visible="true"
                        OnClick="CancelButton_Click" ValidationGroup="UserForm" CausesValidation="false"
                        Text="Cancel" />
            </asp:TableCell>
        </asp:TableFooterRow>
    </asp:Table>
</asp:Content>
