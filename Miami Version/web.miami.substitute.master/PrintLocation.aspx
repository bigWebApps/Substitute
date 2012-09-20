<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PrintLocation.aspx.cs" Inherits="Miami.Substitute.Web.Master.PrintLocation" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
        function refreshGrid()
        {
           $find("<%= PrintList.ClientID %>").get_masterTableView().fireCommand("Update", 0); 
        }
        </script>

    </telerik:RadCodeBlock>
    <table width="520" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:Label Font-Size="10" ID="DefaultLocationLabel" runat="server" />
            </td>
        </tr>
    </table>
    <br />
    <asp:Label runat="server" Visible="false" ID="lblLocationSelected" Text="0" />
    <asp:Label runat="server" Visible="false" ID="lblNoRecords" meta:resourcekey="lblNoRecords" />
    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-bottom: 5px">
        <tr>
            <td>
                <asp:Button runat="server" ID="lbAddSubstitute" Text="Add Substitute to this List"
                    OnClick="lbAddSubstitute_Click" />
            </td>
            <td align="right">
                <asp:Button ID="Button1" Width="150px" meta:resourcekey="Button_ExportToExcel" OnClick="Button1_Click"
                    runat="server" />
                <asp:Button ID="Button2" Width="150px" meta:resourcekey="Button_ExportToWord" OnClick="Button2_Click"
                    runat="server" />
            </td>
        </tr>
    </table>
    <asp:UpdatePanel runat="server" ID="GridUpdatePanel">
        <ContentTemplate>
            <telerik:RadGrid ID="PrintList" OnItemDataBound="PrintList_ItemDataBound" AllowPaging="false"
                Skin="Office2007" DataSourceID="JobDataSource" runat="server" GridLines="None"
                Width="100%">
                <MasterTableView ShowHeadersWhenNoRecords="true" DataKeyNames="UserId" EditMode="InPlace"
                    Width="100%" DataSourceID="JobDataSource" AutoGenerateColumns="False">
                    <Columns>
                        <telerik:GridBoundColumn DataField="UserId" UniqueName="SubstituteIdColumn" Visible="False" />
                        <telerik:GridTemplateColumn UniqueName="PreferredColumn" meta:resourcekey="PrintList_PreferredColumn">
                            <HeaderStyle Width="50px" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <center>
                                    <%#((bool)DataBinder.Eval(Container, "DataItem.IsPreferred"))?"<img src='Images/checked.gif'>":"" %>
                                </center>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn UniqueName="ClerkPreferred" meta:resourcekey="PrintList_ClerkPreferred">
                            <HeaderStyle Width="50px" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <center>
                                    <asp:CheckBox AutoPostBack="true" OnCheckedChanged="PrintLocation_CheckedChanged" ValidationGroup='<%# DataBinder.Eval(Container, "DataItem.UserId") %>' runat="server" Checked='<%#((bool)DataBinder.Eval(Container, "DataItem.IsClerkPreferred")) %>'
                                        ID="clerkPreferred" /></center>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn ReadOnly="true" DataField="Name" meta:resourcekey="PrintList_Name"
                            UniqueName="column1">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="200px" HorizontalAlign="center" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn ReadOnly="true" DataField="EmployeeNumber" meta:resourcekey="PrintList_EmployeeNumber"
                            UniqueName="column1">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="100px" HorizontalAlign="center" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn ReadOnly="true" DataField="Subtype" meta:resourcekey="PrintList_Subtype" 
                            UniqueName="colSubtype">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="150px" HorizontalAlign="left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn ReadOnly="true" DataField="DatetimeStart" meta:resourcekey="PrintList_DatetimeStart"
                            UniqueName="column3">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="100px" HorizontalAlign="left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn ReadOnly="true" DataField="Teacher" meta:resourcekey="PrintList_Teacher"
                            UniqueName="column4">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="200px" HorizontalAlign="left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn ItemStyle-Wrap="false"
                            AllowSorting="false" DataField="Phone" HeaderText="Home Phone" />
                        <telerik:GridBoundColumn ReadOnly="true" DataField="CELL_NUMBER" HeaderText="Mobile Phone"
                            UniqueName="column2">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="150px" HorizontalAlign="left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="AltPhone" HeaderText="Alt Preferred Phone" UniqueName="column2">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="150px" HorizontalAlign="left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Note" HeaderText="Notes" UniqueName="column2">
                            <ItemStyle HorizontalAlign="Left" />
                            <HeaderStyle Width="300px" HorizontalAlign="left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn>
                            <HeaderStyle Width="50px" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <center>
                                    <asp:HyperLink ID="EditLink" runat="server" Text="Edit" NavigateUrl="#" />
                                </center>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <ExpandCollapseColumn Visible="False">
                        <HeaderStyle Width="19px" />
                    </ExpandCollapseColumn>
                    <RowIndicatorColumn Visible="False">
                        <HeaderStyle Width="20px" />
                    </RowIndicatorColumn>
                </MasterTableView>
                <ExportSettings OpenInNewWindow="True" />
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
    <asp:ObjectDataSource ID="JobRegion" runat="server" SelectMethod="LoadPreferredRegionsForCombo"
        TypeName="Miami.Substitute.Bll.Region"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="JobDataSource" runat="server" SelectMethod="LoadAllPreferredSubstitutes"
        TypeName="Miami.Substitute.Bll.User">
        <SelectParameters>
            <asp:ControlParameter Name="LocationId" ControlID="lblLocationSelected" PropertyName="Text" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:PlaceHolder runat="server" ID="plScript" />
</asp:Content>
