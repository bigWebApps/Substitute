<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UpdateLocation.aspx.cs" Inherits="Miami.Substitute.Web.UpdateLocation" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <asp:Label ID="IsFirst" runat="server" Text="True" Visible="False" />
    <radG:RadGrid CommandItemDisplay="Top" runat="server" ID="LocationGrid" BackImageUrl=""
        CatalogIconImageUrl="" DataSourceID="RegionList" GridLines="None" AutoGenerateColumns="False"
        Skin="WebBlue" ShowHeader="False" OnPreRender="LocationGrid_PreRender" Width="720px"
        AllowMultiRowSelection="False">
        <MasterTableView DataSourceID="RegionList" DataKeyNames="RegionId" EditMode="InPlace"
            EnableTheming="false" HierarchyLoadMode="ServerBind" CommandItemDisplay="TopAndBottom"
            BackColor="Transparent">
            <CommandItemTemplate>
                <table width="100%" border="0" style="padding-top: 10px; padding-bottom: 10px" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="1%">
                            <asp:Button Style="vertical-align: top" ID="btnSaveSelected" runat="server" Visible="True"
                                OnClick="btnSaveSelected_Click" CommandName="IsSave" Font-Bold="true" CommandArgument="True"
                                meta:resourcekey="btnSaveSelected" />
                        </td>
                        <td>
                            &nbsp;&nbsp;or
                            <asp:LinkButton Style="vertical-align: top" ID="btnCancel" runat="server" Visible="True"
                                CommandName="IsCancel" Font-Bold="true" CommandArgument="True" OnClick="btnCancel_Click"
                                meta:resourcekey="btnCancel" />
                        </td>
                    </tr>
                </table>
            </CommandItemTemplate>
            <ExpandCollapseColumn>
                <HeaderStyle Width="2px" />
            </ExpandCollapseColumn>
            <RowIndicatorColumn Visible="False">
                <HeaderStyle Width="20px" />
            </RowIndicatorColumn>
            <Columns>
                <radG:GridTemplateColumn UniqueName="TemplateColumn">
                    <HeaderStyle Width="1px" />
                    <ItemTemplate>                        
                        <asp:CheckBox runat="server" ID="cbItem" />
                    </ItemTemplate>
                </radG:GridTemplateColumn>
                <radG:GridTemplateColumn UniqueName="TemplateColumn2">
                    <HeaderStyle Width="20px" />
                    <ItemTemplate>
                    </ItemTemplate>
                </radG:GridTemplateColumn>
                <radG:GridBoundColumn DataField="RegionId" UniqueName="column" Visible="False">
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="IsChecked" UniqueName="column" Visible="False">
                </radG:GridBoundColumn>
                <radG:GridBoundColumn AllowFiltering="False" ItemStyle-Font-Size="13px" ItemStyle-Font-Bold="true" AllowSorting="False" DataField="Name"
                    UniqueName="NameField">
                    <HeaderStyle Width="250px" />
                </radG:GridBoundColumn>
                <radG:GridButtonColumn CommandName="ExpandCollapse" meta:resourcekey="LocationGrid_ExpandCollapse"
                    UniqueName="DetailsField">
                    <HeaderStyle Width="250px" />
                </radG:GridButtonColumn>
            </Columns>
            <DetailTables>
                <radG:GridTableView runat="server" DataSourceID="LocationDataSource" HierarchyLoadMode="Client"
                    ShowHeadersWhenNoRecords="False" DataKeyNames="LocationId" EditMode="InPlace"
                    GroupLoadMode="Client" HierarchyDefaultExpanded="True" ShowHeader="True">
                    <HeaderStyle HorizontalAlign="Left" />
                    <ParentTableRelation>
                        <radG:GridRelationFields DetailKeyField="RegionId" MasterKeyField="RegionId"></radG:GridRelationFields>
                    </ParentTableRelation>
                    <Columns>
                        <radG:GridTemplateColumn UniqueName="TemplateColumn">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="CheckBox1" />
                            </ItemTemplate>
                        </radG:GridTemplateColumn>
                        <radG:GridTemplateColumn UniqueName="TemplateColumn2">
                            <HeaderStyle Width="1" />
                            <ItemTemplate>
                            </ItemTemplate>
                        </radG:GridTemplateColumn>
                        <radG:GridBoundColumn DataField="LocationId" UniqueName="column" Visible="False">
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="IsChecked" UniqueName="column" Visible="False">
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="Name" UniqueName="NameField" HeaderText="Name">
                            <HeaderStyle Width="230px"></HeaderStyle>
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="Street" UniqueName="StreetField" meta:resourcekey="LocationGrid_StreetField">
                            <HeaderStyle Width="170px"></HeaderStyle>
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="City" UniqueName="CityField" meta:resourcekey="LocationGrid_CityField">
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="ZipCode" UniqueName="ZipCodeField" meta:resourcekey="LocationGrid_ZipField">
                            <HeaderStyle Width="50px"></HeaderStyle>
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="PhoneNumOffice" UniqueName="PhoneNumOfficeField"
                            meta:resourcekey="LocationGrid_PhoneField">
                            <HeaderStyle Width="100px"></HeaderStyle>
                        </radG:GridBoundColumn>
                    </Columns>
                    <ExpandCollapseColumn Visible="False">
                        <HeaderStyle Width="19px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <RowIndicatorColumn Visible="False">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                </radG:GridTableView>
            </DetailTables>
            <ItemStyle BackColor="#D1D1FF" />
            <AlternatingItemStyle BackColor="#E2E2FF" />
        </MasterTableView>
    </radG:RadGrid><br />
    <br />
    <asp:ObjectDataSource ID="RegionList" SelectMethod="LoadAllRegion" runat="server"
        TypeName="Miami.Substitute.Bll.Region" />
    <asp:ObjectDataSource ID="LocationDataSource" SelectMethod="LoadAllLocation" runat="server"
        TypeName="Miami.Substitute.Bll.Location">
        <SelectParameters>
            <asp:ControlParameter ControlID="LocationGrid" Name="RegionId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
