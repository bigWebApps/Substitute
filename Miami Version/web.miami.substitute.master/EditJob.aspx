<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="EditJob.aspx.cs" Inherits="Miami.Substitute.Web.Master.EditJob" %>

<%@ Register TagPrefix="radC" Namespace="Telerik.WebControls" Assembly="RadComboBox.NET2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
        <!--
        function OnDateSelected(sender, e) 
        {          
            var startDate = $find("<%= StartDate.ClientID %>");
            var endDate = $find("<%= EndDate.ClientID %>");
            endDate.set_minDate(startDate.get_selectedDate()); 
        }
        -->
        </script>

    </telerik:RadCodeBlock>
    
    <asp:Table ID="AddJobPanelTable" runat="server" Width="430px">
        <asp:TableRow ID="TableRow1" runat="server">
            <asp:TableCell ID="TableCell1" runat="server" Width="140px" Wrap="false" meta:resourcekey="JobForm_startDate" />
            <asp:TableCell ID="TableCell2" runat="server">
                        &nbsp;&nbsp;<telerik:RadDatePicker ClientEvents-OnDateSelected="OnDateSelected" runat="server" Skin="WebBlue"
                            ID="StartDate" Calendar-ShowRowHeaders="false" />
                        &nbsp;&nbsp;&nbsp;&nbsp;<telerik:RadTimePicker ClientEvents-OnDateSelected="OnDateSelected" runat="server" Skin="WebBlue"
                            ID="StartTimePicker" />
                        <div style="display: none">
                            <asp:TextBox runat="server" ID="StartDateValid" ValidationGroup="UserForm" />
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="red"
                            Display="Dynamic" ControlToValidate="StartDateValid" ValidationGroup="UserForm"
                            Font-Bold="true" Font-Size="12px" Text="<br>&nbsp;&nbsp;You must enter a value" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow2" runat="server">
            <asp:TableCell ID="TableCell3" runat="server" Width="140px" Wrap="false" meta:resourcekey="JobForm_endDate" />
            <asp:TableCell ID="TableCell4" runat="server">
                        &nbsp;&nbsp;<telerik:RadDatePicker ClientEvents-OnDateSelected="OnDateSelected" runat="server" Skin="WebBlue"
                            ID="EndDate" Calendar-ShowRowHeaders="false" />
                        &nbsp;&nbsp;&nbsp;&nbsp;<telerik:RadTimePicker ClientEvents-OnDateSelected="OnDateSelected" runat="server" Skin="WebBlue"
                            ID="EndTimePicker" />
                        <div style="display: none">
                            <asp:TextBox runat="server" ID="EndDateValid" Text="1" ValidationGroup="UserForm" />
                        </div>
                        <asp:RequiredFieldValidator ID="EndDateRequired" runat="server" ForeColor="red" Display="Dynamic"
                            ControlToValidate="EndDateValid" ValidationGroup="UserForm" Font-Bold="true"
                            Font-Size="12px" Text="<br>&nbsp;&nbsp;You must enter a value" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow3" runat="server">
            <asp:TableCell ID="TableCell5" runat="server" Wrap="false" meta:resourcekey="JobForm_Room" />
            <asp:TableCell ID="TableCell6" runat="server">
                <mits:ValidatedTextBox runat="server" ID="Room" Columns="58" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow4" runat="server">
            <asp:TableCell ID="TableCell7" runat="server" Wrap="false" meta:resourcekey="JobForm_Teacher" />
            <asp:TableCell ID="TableCell8" runat="server">
                <mits:ValidatedTextBox runat="server" ID="Teacher" Columns="58" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow5" runat="server">
            <asp:TableCell ID="TableCell9" runat="server" Wrap="false" meta:resourcekey="JobForm_Subtype" />
            <asp:TableCell ID="TableCell10" runat="server">
                &nbsp;&nbsp;<telerik:RadComboBox runat="server" ID="Subtype" Width="319px" Skin="WebBlue"
                    DataSourceID="DSSubtypes" DataTextField="Name" DataValueField="SubtypeId" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow6" runat="server">
            <asp:TableCell ID="TableCell11" runat="server" Wrap="false" meta:resourcekey="JobForm_Subject" />
            <asp:TableCell ID="TableCell12" runat="server">
                <mits:ValidatedTextBox runat="server" ID="Subject" ValidationGroup="UserForm" Required="true"
                    Columns="58" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow7" runat="server">
            <asp:TableCell ID="TableCell13" runat="server" Wrap="false" meta:resourcekey="JobForm_Grade" />
            <asp:TableCell ID="TableCell14" runat="server">
                &nbsp;&nbsp;<telerik:RadComboBox runat="server" ID="Grade" Skin="WebBlue" Width="319px"
                    DataSourceID="DSGrades" DataTextField="Name" DataValueField="GradeId" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow8" runat="server">
            <asp:TableCell ID="TableCell15" runat="server" Wrap="false" meta:resourcekey="JobForm_Note" />
            <asp:TableCell ID="TableCell16" runat="server">
                <mits:ValidatedTextBox runat="server" ID="Note" TextMode="MultiLine" Rows="8" Columns="60" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableFooterRow ID="TableFooterRow1" runat="server" TableSection="TableFooter">
            <asp:TableCell ID="TableCell17" runat="server" ColumnSpan="2" Style="padding-left: 136px">
                <asp:Button runat="server" ID="EditButton" OnClick="SaveButton_Click" ValidationGroup="UserForm"
                    Text="Edit Job" />&nbsp;&nbsp;&nbsp;&nbsp;<font style="font-weight: normal">or</font>&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton
                        runat="server" ID="CancelButton" Visible="true" OnClick="CancelButton_Click"
                        ValidationGroup="UserForm" CausesValidation="false" Text="Cancel" />
            </asp:TableCell>
        </asp:TableFooterRow>
    </asp:Table>
    <asp:Label Visible="false" ID="lblTeacherId" runat="server"></asp:Label>
    <asp:Label Visible="false" ID="lblLocationId" Text="0" runat="server" />
    <asp:Label Visible="false" ID="lblJobId" runat="server"></asp:Label>
    <asp:ObjectDataSource ID="DSSubtypes" SelectMethod="GetSubTypes" runat="server" TypeName="Miami.Substitute.Bll.Job" />
    <asp:ObjectDataSource ID="DSGrades" SelectMethod="GetGrades" runat="server" TypeName="Miami.Substitute.Bll.Job" />
</asp:Content>
