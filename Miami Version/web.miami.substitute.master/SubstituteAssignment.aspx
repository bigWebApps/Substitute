<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SubstituteAssignment.aspx.cs" Inherits="Miami.Substitute.Web.Master.SubstituteAssignment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
        function refreshGrid()
        {
           $find("<%= SubstituteList.ClientID %>").get_masterTableView().fireCommand("Update", 0); 
        }
        </script>

    </telerik:RadCodeBlock>
    <table width="600px" border="0">
        <tr>
            <td>
                <mits:MagicForm ColorScheme="Blue" Width="100%" Style="border-left-style: none; border-right-style: none"
                    ObjectName="Job" ID="JobForm" runat="server" DataSourceID="JobDataSource" DataKeyNames="JobId"
                    AutoGenerateRows="False" RepeatColumns="2" Visible="true" DefaultMode="ReadOnly">
                    <Fields>
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="JobId" meta:resourcekey="JobList_JobIdField" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="Status" meta:resourcekey="JobList_StatusField" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="DateRange" meta:resourcekey="JobList_DateRangeField" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="Subtype" meta:resourcekey="JobList_SubtypeField" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="Location" meta:resourcekey="JobList_LocationField" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="Room" meta:resourcekey="JobList_RoomField" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="Region" meta:resourcekey="JobList_RegionField" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="Teacher" meta:resourcekey="JobList_TeacherField" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="Subject" HeaderText="Subject Area" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Smaller"
                            DataField="GradeName" HeaderText="Grade Level" />
                    </Fields>
                </mits:MagicForm>
            </td>
        </tr>
        <tr class="Mf_R">
            <td class="Mf_R" style="background-color: #F1F0FF">
                Note:
                <asp:Label Font-Bold="true" runat="server" ID="jobNote" />
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:UpdatePanel runat="server" ID="GridUpdatePanel">
        <ContentTemplate>
            <telerik:RadGrid ID="SubstituteList" OnItemDataBound="SubstituteList_ItemDataBound"
                OnItemCommand="SubstituteList_ItemCommand" AllowPaging="false" Skin="Office2007"
                DataSourceID="JobSubstitutes" runat="server" GridLines="None" Width="100%" AutoGenerateColumns="false"
                AllowSorting="true">
                <MasterTableView ShowHeadersWhenNoRecords="true" DataKeyNames="UserId" EditMode="InPlace"
                    DataSourceID="JobSubstitutes" AutoGenerateColumns="False">
                    <Columns>
                        <telerik:GridTemplateColumn UniqueName="PreferredColumn" HeaderText="Subs Favorite Location"
                            HeaderStyle-Width="1px" HeaderStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle"
                            ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <center>
                                    <%#((bool)DataBinder.Eval(Container, "DataItem.IsPreferred"))?"<img src='Images/checked.gif'>":"&nbsp;" %>
                                </center>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="ClerkPreferred" HeaderText="Preferred" HeaderStyle-Width="1px"
                            ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <center>
                                    <asp:CheckBox AutoPostBack="true" OnCheckedChanged="SubstituteAssignment_CheckedChanged"
                                        ValidationGroup='<%# DataBinder.Eval(Container, "DataItem.SubstituteId") %>'
                                        runat="server" Checked='<%#((bool)DataBinder.Eval(Container, "DataItem.IsClerkPreferred")) %>'
                                        ID="clerkPreferred" /></center>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="13"
                            HeaderText="&nbsp;" DataField="IsApplied" />
                        <telerik:GridBoundColumn ItemStyle-Width="1%" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                            SortExpression="Name" DataField="Name" meta:resourcekey="SubstituteList_Name" />
                        <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Center" AllowSorting="false"
                            DataField="SubtypeName" meta:resourcekey="SubstituteList_SubtypeName" />
                        <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Center" AllowSorting="false"
                            DataField="DatetimeStart" meta:resourcekey="SubstituteList_DatetimeStart" />
                        <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Center" AllowSorting="false"
                            DataField="TimeWorks" meta:resourcekey="SubstituteList_TimeWorks" />
                        <telerik:GridBoundColumn ItemStyle-Width="1%" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                            AllowSorting="false" DataField="Phone" HeaderText="Home Phone" />
                        <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Center" AllowSorting="false"
                            DataField="CELL_NUMBER" ItemStyle-Wrap="false" HeaderText="Mobile Phone" />
                        <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Center" AllowSorting="false"
                            DataField="AltPhone" ItemStyle-Wrap="false" HeaderText="Alt Preferred Phone" />
                        <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Center" AllowSorting="false"
                            HeaderStyle-Wrap="false" DataField="Note" HeaderText="Notes" />
                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" ItemStyle-Width="1px">
                            <ItemTemplate>
                                <div style="white-space: nowrap">
                                    <asp:LinkButton runat="server" ID="SelectLinkButton" Visible="true" CommandName="Select"
                                        CommandArgument='<%# DataBinder.Eval(Container, "DataItem.SubstituteId") %>'
                                        meta:resourcekey="SubstituteList_Select" /></div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn ItemStyle-Wrap="false" ItemStyle-Width="1%">
                            <ItemTemplate>
                                <asp:HyperLink ID="EditLink" runat="server" Text="Edit Note & Phone" NavigateUrl="#" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </ContentTemplate>
    </asp:UpdatePanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" VisibleStatusbar="false"
        Behaviors="Close" Modal="True" Width="355px" Height="250px" ShowContentDuringLoad="false"
        ReloadOnShow="true">
        <Windows>
            <telerik:RadWindow ID="ModalWindow" runat="server" />
        </Windows>
    </telerik:RadWindowManager>
    <br />
    <table width="100%" border="0">
        <tr>
            <td width="1">
                <img src="Images/applied.gif" /></td>
            <td>
                Substitute applied for this job</td>
        </tr>
        <tr>
            <td>
                <img src="Images/blue.gif" /></td>
            <td>
                Substitute's calendar shows this date available</td>
        </tr>
        <tr>
            <td>
                <img src="Images/clerkassigned.gif" /></td>
            <td>
                Substitute is already accepted for a job for this date</td>
        </tr>
        <tr>
            <td>
                <img src="Images/notapplied.gif" /></td>
            <td>
                Substitute has not specified these dates as available for work</td>
        </tr>
    </table>
    <asp:Label ID="lblJobId" runat="server" Visible="false" />
    <asp:ObjectDataSource ID="JobSubstitutes" runat="server" SelectMethod="LoadAvailables"
        TypeName="Miami.Substitute.Bll.Substitute">
        <SelectParameters>
            <asp:QueryStringParameter Name="jobId" Type="Int32" QueryStringField="JobId" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="JobDataSource" runat="server" SelectMethod="LoadByPrimaryKey"
        TypeName="Miami.Substitute.Bll.Job">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblJobId" Name="jobId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
