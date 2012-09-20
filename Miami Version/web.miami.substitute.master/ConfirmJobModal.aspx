<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ConfirmJobModal.aspx.cs" Inherits="UpdateUserModal" Title="Untitled Page" %>

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

    <b>Confirm Job</b>
    <br />
    <br />
    <asp:Table ID="UpdateJobTable" runat="server">
        <asp:TableRow ID="TableRow2" runat="server">
            <asp:TableCell ID="TableCell3" runat="server" Wrap="false" Text="Confirm Note" />
            <asp:TableCell ID="TableCell4" runat="server">
                <asp:TextBox runat="server" ID="Notes" Columns="40" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableFooterRow ID="TableFooterRow1" runat="server" TableSection="TableFooter">
            <asp:TableCell ID="TableCell7" runat="server" ColumnSpan="2">
                <asp:Button runat="server" ID="UpdateButton" OnClick="SaveButton_Click" Text="Confirm Job" />
                &nbsp;&nbsp;or&nbsp;&nbsp;
                <asp:LinkButton runat="server" ID="CancelButton" Visible="true" OnClick="CancelButton_Click"
                    ValidationGroup="UserForm" CausesValidation="false" Text="Cancel" />
            </asp:TableCell>
        </asp:TableFooterRow>
    </asp:Table>
</asp:Content>
