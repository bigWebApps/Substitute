<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UpdateAvailability.aspx.cs" Inherits="Miami.Substitute.Web.UpdateAvailability" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <asp:Label ID="lblSaved" runat="server" Visible="False" ForeColor="Red" meta:resourcekey="lblSaved" />
    <mits:MagicForm ColorScheme="Blue" ShowCloseButton="None" ObjectName="General Availability"
        DataSourceID="AvailabilityDataSource" ID="AvailabilityForm" runat="server" Visible="true"
        AutoGenerateRows="false" AutoGenerateEditButton="true" DefaultMode="Edit" OnItemUpdated="AvailabilityForm_ItemUpdated"
        OnItemCommand="AvailabilityForm_ItemCommand">
        <Fields>
            <mits:TemplateField meta:resourcekey="AvailabilityForm_StartTimeField">
                <ItemTemplate>
                    &nbsp;&nbsp;&nbsp;<asp:DropDownList runat="server" ID="availabilityTimeStart" DataTextField="Name"
                        DataValueField="Value" DataSourceID="DSTimes" />
                </ItemTemplate>
            </mits:TemplateField>
            <mits:TemplateField meta:resourcekey="AvailabilityForm_StopTimeField">
                <ItemTemplate>
                    &nbsp;&nbsp;&nbsp;<asp:DropDownList runat="server" ID="availabilityTimeEnd" DataTextField="Name"
                        DataValueField="Value" DataSourceID="DSTimes" />
                </ItemTemplate>
            </mits:TemplateField>
            <mits:ValidatedCheckBoxListField RepeatDirection="Horizontal" DataField="AvailabilityWeekDays"
                DataSourceId="WeekDaysList" DataTextField="Name" DataValueField="Value" />
        </Fields>
    </mits:MagicForm>
    <br />
    <asp:Label ID="lblExceptions" runat="server" Font-Size="13px" Visible="True" Font-Bold="true"
        meta:resourcekey="lblExceptions" /><br />
    <div style="padding-top: 3px; padding-bottom: 5px">
        <asp:Label ID="lblExceptionsHelpText" runat="server" Font-Size="11px" Visible="True"
            Font-Bold="false" meta:resourcekey="lblExceptionsHelpText" /></div>
    <radCln:RadCalendar ID="RadCalendarExceptions" runat="server" Skin="WebBlue" Width="150"
        AutoPostBack="false" EnableMultiSelect="true" EnableNavigation="false" ShowOtherMonthsDays="False"
        EnableMonthYearFastNavigation="false" MultiViewColumns="4" MultiViewRows="3"
        CultureInfo="(Default)" ShowRowHeaders="false" UseColumnHeadersAsSelectors="False"
        UseRowHeadersAsSelectors="False">
    </radCln:RadCalendar>
    <img src="Images/spacer.gif" width="1" height="2" /><br />
    <table width="595px" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="100%">
                <asp:Button ID="btnSaveExceptions" runat="server" OnClick="btnSaveExceptions_Click"
                    meta:resourcekey="btnSaveExceptions2" />
            </td>
            <td width="1%">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="1%">
                            <img src="Images/unavailable.gif" />
                        </td>
                        <td nowrap>
                            &nbsp;<asp:Literal runat="server" ID="UnavailableCaption" meta:resourcekey="UnavailableCaption" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                        <td width="1%">
                            <img src="Images/acceptedJob.gif" />
                        </td>
                        <td nowrap>
                            &nbsp;<asp:Literal runat="server" ID="AcceptedJobCaptions" meta:resourcekey="AcceptedJobCaption" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <asp:ObjectDataSource ID="WeekDaysList" SelectMethod="LoadAvailabilityWeekdays" runat="server"
        TypeName="Miami.Substitute.Dal.User" />
    <asp:ObjectDataSource ID="AvailabilityDataSource" OnUpdating="WeekDaysList_Updating"
        SelectMethod="LoadByUserId" UpdateMethod="Update" runat="server" TypeName="Miami.Substitute.Bll.Substitute">
        <UpdateParameters>
            <asp:Parameter Name="availabilityTimeStart" Type="String" />
            <asp:Parameter Name="availabilityTimeEnd" Type="String" />
            <asp:Parameter Name="availabilityWeekDays" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ExceptionDataSource" InsertMethod="Insert" runat="server"
        TypeName="Miami.Substitute.Bll.SubstituteExceptions">
        <InsertParameters>
            <asp:Parameter Name="startDate" Type="DateTime" />
            <asp:Parameter Name="endDate" Type="DateTime" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ExceptionsListDataSource" DeleteMethod="Delete" runat="server"
        SelectMethod="LoadAllByUserId" TypeName="Miami.Substitute.Bll.SubstituteExceptions">
        <DeleteParameters>
            <asp:Parameter Name="substituteExceptionsId" Type="Int32" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="DSTimes" SelectMethod="GetTimes" runat="server" TypeName="Miami.Substitute.Bll.Job" />
</asp:Content>
