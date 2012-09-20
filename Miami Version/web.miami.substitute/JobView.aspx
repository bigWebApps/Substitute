<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="JobView.aspx.cs" Inherits="Miami.Substitute.Web.JobView" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" Runat="Server">
   <mits:MagicForm ColorScheme="Blue" ObjectName="Job" ID="JobForm" runat="server" DataSourceID="JobDataSource"
    DataKeyNames="JobId" AutoGenerateRows="False" Visible="true" DefaultMode="ReadOnly">
    <Fields>
        <mits:ValidatedTextBoxField ItemStyle-BackColor="#E2E0FF" HeaderStyle-BackColor="#E2E0FF" ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="JobId" meta:resourcekey="JobList_JobIdField" />
        <mits:ValidatedTextBoxField ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="DatetimeStart" meta:resourcekey="JobList_DatetimeStartField" />
        <mits:ValidatedTextBoxField ItemStyle-BackColor="#E2E0FF" HeaderStyle-BackColor="#E2E0FF" ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="DatetimeEnd" meta:resourcekey="JobList_DatetimeEndField" />
        <mits:ValidatedTextBoxField ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="Region" meta:resourcekey="JobList_RegionField" />
        <mits:ValidatedTextBoxField ItemStyle-BackColor="#E2E0FF" HeaderStyle-BackColor="#E2E0FF" ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="Location" meta:resourcekey="JobList_LocationField" />
        <mits:ValidatedTextBoxField ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="Teacher" meta:resourcekey="JobList_TeacherField" />
        <mits:ValidatedTextBoxField ItemStyle-BackColor="#E2E0FF" HeaderStyle-BackColor="#E2E0FF" ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="Subtype" meta:resourcekey="JobList_SubtypeField" />
        <mits:ValidatedTextBoxField ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="Status" meta:resourcekey="JobList_StatusField" />
        <mits:ValidatedTextBoxField ItemStyle-BackColor="#E2E0FF" HeaderStyle-BackColor="#E2E0FF" ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="Room" meta:resourcekey="JobList_RoomField" />
        <mits:ValidatedTextBoxField ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="Subject" HeaderText="Subject Area" />
        <mits:ValidatedTextBoxField ItemStyle-BackColor="#E2E0FF" HeaderStyle-BackColor="#E2E0FF" ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="GradeName" HeaderText="Grade Level" />
        <mits:ValidatedTextBoxField ItemStyle-Height="22" ItemStyle-Font-Bold="true" DataField="Note" meta:resourcekey="JobList_NoteField" />
    </Fields>
</mits:MagicForm>
    <br />
    <asp:Button ID="lbApply" runat="server" Text="Apply for this Job" OnClick="lbApply_Click" />
    <asp:Literal runat="server" ID="orLiteral" Text="or " />
    <asp:LinkButton runat="server" ID="ReturnJobsListLinkButton" Font-Bold="true" Text="Return to Jobs List" PostBackUrl="~/SearchOpenJobs.aspx" />
    <asp:Button ID="lbCancel" runat="server" OnClientClick="return confirm('Are you sure you want to cancel your application for this job?')" Text="Cancel Job Application" OnClick="lbCancel_Click" /><br />
    <asp:Label ID="lblApplyHelpText" Visible="false" runat="server" Text="You have already applied this job" />
    <asp:Label ID="OverlapLabel" Visible="false" runat="server" ForeColor="red" meta:resourcekey="OverlapCaption" />
    <asp:ObjectDataSource ID="JobDataSource" runat="server"
    SelectMethod="LoadByPrimaryKey" TypeName="Miami.Substitute.Bll.Job">
    <SelectParameters>
        <asp:QueryStringParameter Name="JobId" Type="Int32" QueryStringField="JobId" />
    </SelectParameters>
</asp:ObjectDataSource>
</asp:Content>

