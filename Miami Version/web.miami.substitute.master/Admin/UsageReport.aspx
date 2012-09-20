<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UsageReport.aspx.cs" Inherits="Admin_UsageReport" Title="Untitled Page"
    Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel1" RenderMode="Inline">
        <ContentTemplate>
            <asp:LinkButton runat="server" ID="ByDayLink" Text="Usage By Day" OnClick="ByDayLink_Click" />
            |
            <asp:LinkButton runat="server" ID="ByLocationLink" OnClick="ByLocationLink_Click"
                Text="Usage By Locations" />
            <br />
            <br />
            <asp:UpdatePanel runat="server" ID="ByLocationPanel" RenderMode="Inline">
                <ContentTemplate>
                    <asp:DropDownList runat="server" ID="MonthList" />
                    <asp:DropDownList runat="server" ID="YearList" />
                    <asp:Button runat="server" ID="SelectButton" Text="Select" OnClick="SelectButton_Click" />
                    <br />
                    <br />
                    <radG:RadGrid ID="UsageReportByLocation" runat="server" Width="500px" DataSourceID="UsageReportByLocationDataSource"
                        AutoGenerateColumns="False" Skin="Classic" GridLines="None" meta:resourcekey="UsageReportResource1">
                        <MasterTableView Width="100%" AllowCustomSorting="True" DataSourceID="UsageReportByLocationDataSource">
                            <Columns>
                                <radG:GridBoundColumn DataField="LocationName" HeaderText="Location" UniqueName="DateStamp">
                                    <ItemStyle HorizontalAlign="Center" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="LoginsClerks" HeaderText="Logins Clerks" meta:resourcekey="GridBoundColumnResource2"
                                    UniqueName="LoginsClerks">
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="LoginsSubstitutes" HeaderText="Logins Substitutes"
                                    meta:resourcekey="GridBoundColumnResource3" UniqueName="LoginsSubstitutes">
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="JobsCreated" HeaderText="Jobs Created" meta:resourcekey="GridBoundColumnResource4"
                                    UniqueName="JobsCreated">
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="JobsAccepted" HeaderText="Jobs Accepted" meta:resourcekey="GridBoundColumnResource5"
                                    UniqueName="JobsAccepted">
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                            </Columns>
                            <ExpandCollapseColumn Visible="False">
                                <HeaderStyle Width="19px" />
                            </ExpandCollapseColumn>
                            <RowIndicatorColumn Visible="False">
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                        </MasterTableView>
                    </radG:RadGrid>
                    <asp:ObjectDataSource ID="UsageReportByLocationDataSource" SelectMethod="GetUsageReport"
                        runat="server" TypeName="Miami.Substitute.Dal.User">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="MonthList" PropertyName="SelectedValue" Name="Month"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="YearList" PropertyName="SelectedValue" Name="Year"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdatePanel runat="server" ID="ByDayPanel" RenderMode="Inline">
                <ContentTemplate>
                    <radG:RadGrid ID="UsageReport" runat="server" Width="500px" DataSourceID="UsageReportDataSource"
                        AutoGenerateColumns="False" Skin="Classic" OnItemDataBound="UsageReport_ItemDataBound" GridLines="None" meta:resourcekey="UsageReportResource1">
                        <MasterTableView Width="100%" AllowCustomSorting="True" DataSourceID="UsageReportDataSource">
                            <Columns>
                                <radG:GridBoundColumn DataField="DateStamp" HeaderText="Date" meta:resourcekey="GridBoundColumnResource1"
                                    UniqueName="DateStamp">
                                    <ItemStyle HorizontalAlign="Center" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="LoginsClerks" HeaderText="Logins Clerks" meta:resourcekey="GridBoundColumnResource2"
                                    UniqueName="LoginsClerks">
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="LoginsSubstitutes" HeaderText="Logins Substitutes"
                                    meta:resourcekey="GridBoundColumnResource3" UniqueName="LoginsSubstitutes">
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="JobsCreated" HeaderText="Jobs Created" meta:resourcekey="GridBoundColumnResource4"
                                    UniqueName="JobsCreated">
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="JobsAccepted" HeaderText="Jobs Accepted" meta:resourcekey="GridBoundColumnResource5"
                                    UniqueName="JobsAccepted">
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                            </Columns>
                            <ExpandCollapseColumn Visible="False">
                                <HeaderStyle Width="19px" />
                            </ExpandCollapseColumn>
                            <RowIndicatorColumn Visible="False">
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                        </MasterTableView>
                    </radG:RadGrid>
                    <asp:ObjectDataSource ID="UsageReportDataSource" SelectMethod="GetUsageReport" runat="server"
                        TypeName="Miami.Substitute.Dal.User" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
