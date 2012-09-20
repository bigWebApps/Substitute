<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DiagnosticReport.aspx.cs" Inherits="Miami.Substitute.Web.Master.SubstituteList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <asp:UpdatePanel runat="server" ID="UpdatePanel1" RenderMode="Inline">
        <ContentTemplate>
            <table width="1" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="1">
                        Name:
                    </td>
                    <td width="1">
                        <mits:ValidatedTextBox Columns="30" runat="server" ID="tbName" />
                    </td>
                    <td width="1">
                        &nbsp;&nbsp;<asp:LinkButton meta:resourcekey="lbSearch" runat="server" ID="lbSearch"
                            OnClick="lbSearch_Click" /></td>
                    <td width="1">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Filter:</td>
                    <td width="200">
                        <mits:ValidatedComboBox DataSourceID="DSSubtypes" DataTextField="Name" DataValueField="Desc"
                            OnSelectedIndexChanged="cbFilter_SelectedIndexChanged" runat="server" ID="cbFilter"
                            AutoPostBack="true" />
                    </td>
                    <td width="1">
                        <mits:ValidatedComboBox runat="server" ID="PartTimeSelectBox" AutoPostBack="true"
                            OnSelectedIndexChanged="cbFilter_SelectedIndexChanged" />
                    </td>
                </tr>
            </table>
            <br />
            <radG:RadGrid ID="SubstituteListReport" DataSourceID="DiagnosticDataSource" runat="server"
                Width="800px" AutoGenerateColumns="False" Skin="Classic" AllowSorting="False"
                GridLines="None" AllowPaging="True" PageSize="20">
                <MasterTableView Width="100%" AllowCustomSorting="True">
                    <Columns>
                        <radG:GridHyperLinkColumn DataTextField="LastName" meta:resourcekey="SubstituteListReport_LastName"
                            UniqueName="LastName" DataNavigateUrlField="UserId" DataNavigateUrlFormatString="javascript:window.showModalDialog('EmployeeSegments.aspx?UserId={0}','Employee Segments','dialogWidth:400px;dialogHeight:400px');">
                        </radG:GridHyperLinkColumn>
                        <radG:GridBoundColumn DataField="FirstName" meta:resourcekey="SubstituteListReport_FirstName"
                            UniqueName="column">
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="EmployeeNumber" meta:resourcekey="SubstituteListReport_EmployeeNumber"
                            UniqueName="column">
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn ItemStyle-Wrap="false" DataField="CellPhone" meta:resourcekey="SubstituteListReport_CellPhone"
                            UniqueName="column1">
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="Email" meta:resourcekey="SubstituteListReport_EmailAddress"
                            UniqueName="column2">
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="SubStatus" ItemStyle-HorizontalAlign="Center" meta:resourcekey="SubstituteListReport_SubStatus"
                            UniqueName="column3">
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
            <asp:ObjectDataSource ID="DSSubtypes" SelectMethod="GetSubTypesForReport" runat="server"
                TypeName="Miami.Substitute.Bll.Job" />
            <asp:ObjectDataSource ID="DiagnosticDataSource" EnableCaching="true" EnableViewState="true"
                SelectMethod="LoadSubstituteListForReport" runat="server" TypeName="Miami.Substitute.Bll.Substitute">
                <SelectParameters>
                    <asp:ControlParameter ControlID="cbFilter" PropertyName="Value" Name="Subtype" Type="Int32" />
                    <asp:ControlParameter ControlID="tbName" PropertyName="Text" Name="Name" Type="string" />
                    <asp:ControlParameter ControlID="PartTimeSelectBox" PropertyName="Value" Name="PartTime"
                        Type="string" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
