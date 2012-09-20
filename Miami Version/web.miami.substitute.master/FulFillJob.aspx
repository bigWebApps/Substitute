<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FulFillJob.aspx.cs" Inherits="Miami.Substitute.Web.Master.FulFillJob" %>
<%@ Register TagPrefix="radC" Namespace="Telerik.WebControls" Assembly="RadComboBox.NET2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" Runat="Server">

<mits:MagicForm ColorScheme="Blue" ShowCloseButton="Always" DataKeyNames="JobId" ObjectName="New Job" ID="JobForm" runat="server" Visible="true"
  AutoGenerateRows="false" AutoGenerateInsertButton = "true" DefaultMode="Insert" DataSourceID="JobDataSource" OnItemInserted="JobForm_ItemInserted" OnItemCommand="JobForm_ItemCommand">
  <Fields>
    <mits:ValidatedDatePickerField Required="true" DataField="startDate" meta:resourcekey="JobForm_startDate" />
    <mits:ValidatedDatePickerField Required="true" DataField="endDate" meta:resourcekey="JobForm_endDate" />
    <asp:TemplateField HeaderText="Region">
        <itemtemplate>
           <mits:ValidatedComboBox Required="true" Runat="server" ID="regCombo" DataSourceID="JobRegion" DataTextField="Name" DataValueField="RegionId" OnClientSelectedIndexChanged="LoadLocations" />
        </itemtemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Location">
        <itemtemplate>
           <mits:ValidatedComboBox Required="true" Width="240" AutoPostBack="true"  nowrap="True" Runat="server" ID="locCombo" /> 
        </itemtemplate>
    </asp:TemplateField>
    <mits:ValidatedTextBoxField DataField="Room" meta:resourcekey="JobForm_Room" />
    <asp:TemplateField HeaderText="Teacher">
        <itemtemplate>
           <img src="Images/spacer.gif" width="2" />
           <radC:RadComboBox ID="cbTeachers" DropDownWidth="100" LoadingMessage="Loading Teachers..."  runat="server" 
                SkinsPath="~/RadControls/ComboBox/Skins" Skin="WindowsGray" AutoPostBack="true" EnableLoadOnDemand="True" OnItemsRequested="cbTeachers_ItemsRequested"
                 OnSelectedIndexChanged="cbTeachers_SelectedIndexChanged">
           </radC:RadComboBox>
        </itemtemplate>
    </asp:TemplateField>
    <mits:ValidatedComboBoxField DataField="Subtype" DataSourceId="DSSubtypes" DataTextField="Name" DataValueField="SubtypeId" meta:resourcekey="JobForm_Subtype" />
    <mits:ValidatedTextBoxField DataField="Note" Rows="4" Columns="44" TextMode="MultiLine" meta:resourcekey="JobForm_Note" />  
 </Fields>
 </mits:MagicForm>

<mits:MagicForm ColorScheme="Blue" ShowCloseButton="Always" DataKeyNames="JobId" ObjectName="Job" ID="JobFormView" runat="server" Visible="False"
  AutoGenerateRows="false" DefaultMode="ReadOnly">
  <Fields>
    <mits:ValidatedDatePickerField Required="true" DataField="DatetimeStart" meta:resourcekey="JobForm_startDate" />
    <mits:ValidatedDatePickerField Required="true" DataField="DatetimeEnd" meta:resourcekey="JobForm_endDate" />
    <mits:ValidatedTextBoxField DataField="Region" meta:resourcekey="JobForm_Region" />
    <mits:ValidatedTextBoxField DataField="Location" meta:resourcekey="JobForm_Location" />
    <mits:ValidatedTextBoxField DataField="Room" meta:resourcekey="JobForm_Room" />
    <mits:ValidatedTextBoxField DataField="Teacher" meta:resourcekey="JobForm_Teacher" />
    <mits:ValidatedComboBoxField DataField="SubtypeId" DataSourceId="DSSubtypes" DataTextField="Name" DataValueField="SubtypeId" meta:resourcekey="JobForm_Subtype" />
    <mits:ValidatedTextBoxField DataField="Note" TextMode="MultiLine" meta:resourcekey="JobForm_Note" />  
 </Fields>
 </mits:MagicForm>
 
 <asp:Label Visible="false" ID="lblLocationId" Text="0" runat="server" />
 <asp:Label Visible="false" ID="lblTeacherId" runat="server"></asp:Label>
 <asp:Label Visible="false" ID="lblRegionId" runat="server"></asp:Label>
 <asp:ObjectDataSource ID="DSSubtypes" SelectMethod="GetSubTypes" runat="server" TypeName="Miami.Substitute.Bll.Job" />
 
 <asp:ObjectDataSource ID="JobDataSource" SelectMethod="LoadByPrimaryKey" InsertMethod="Insert" runat="server" TypeName="Miami.Substitute.Bll.Job" OnInserted="JobDataSource_Inserted">
        <InsertParameters>
            <asp:Parameter Name="startDate" Type="DateTime" />
            <asp:Parameter Name="endDate" Type="DateTime" />
            <asp:ControlParameter ControlID="lblLocationId" DefaultValue="0" Name="Location" PropertyName="Text" Type="String" Size="500" />
            <asp:Parameter Name="Note" Type="String" />
            <asp:Parameter Name="Room" Type="String" />
            <asp:Parameter Name="Subtype" Type="String" />
            <asp:ControlParameter ControlID="lblTeacherId" DefaultValue="" Name="TeacherId" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="lblRegionId" DefaultValue="" Name="Region" PropertyName="Text" Type="String" />
            <asp:Parameter Name="JobId" Type="Int32" Direction="ReturnValue" />
        </InsertParameters>
</asp:ObjectDataSource>
<br /><br />
<asp:Label Visible="False" ID="lblAvailSubs" runat="server" meta:resourcekey="lblAvailSubs" Font-Bold="True" ForeColor="Black" /><br />
<mits:CommonGridView ColorScheme="Blue" ID="SubstituteList" runat="server" Width="565px" DataSourceID="JobSubstitutes"
    AutoGenerateColumns="False" EnableSelect="true" DataKeyNames="SubstituteId" Visible="false" EmptyDataText="No available Substitutes for current job" OnAction="SubstituteList_Action">
    <Columns>
        <mits:ValidatedCheckBoxField DataField="IsPreferred" meta:resourcekey="SubstituteList_IsPreferred" >
            <headerstyle width="1px" />
        </mits:ValidatedCheckBoxField>
        <mits:ValidatedTextBoxField DataField="Name" meta:resourcekey="SubstituteList_Name" />
        <mits:ValidatedTextBoxField DataField="DateLastWorked" meta:resourcekey="SubstituteList_DateLastWorked" />
        <mits:ValidatedTextBoxField DataField="TimeWorked" meta:resourcekey="SubstituteList_TimeWorked" />
        <mits:ValidatedTextBoxField DataField="Phone" meta:resourcekey="SubstituteList_Phone" />
        <mits:ButtonField CommandName="Select" meta:resourcekey="SubstituteList_Select">
            <headerstyle width="1px" />
        </mits:ButtonField>
    </Columns>
</mits:CommonGridView>

<asp:Label id="lblJobId" runat="server" visible="false" />
<asp:ObjectDataSource ID="JobRegion" runat="server"
    SelectMethod="LoadAllRegionForCombo" TypeName="Miami.Substitute.Bll.Region">
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="JobSubstitutes" runat="server"
    SelectMethod="LoadAvailables" TypeName="Miami.Substitute.Bll.Substitute">
    <SelectParameters>
        <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:PlaceHolder runat="server" ID="plScript" />

</asp:Content>
