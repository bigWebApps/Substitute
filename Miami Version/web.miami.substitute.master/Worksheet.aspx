<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Worksheet.aspx.cs" Inherits="Miami.Substitute.Web.Master.Worksheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
        function refreshGrid()
        {
           $find("<%= JobList.ClientID %>").get_masterTableView().fireCommand("Update", 0); 
        }
        </script>

    </telerik:RadCodeBlock>
    <table width="901px" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                Status:
                <asp:LinkButton OnClick="lnkOpen_Click" Font-Size="12px" runat="server" ID="lnkOpen"
                    meta:resourcekey="lnkOpen" />
                |
                <asp:LinkButton OnClick="lnkClosed_Click" Font-Size="12px" runat="server" ID="lnkClosed"
                    meta:resourcekey="lnkClosed" />
            </td>
            <td>
                <asp:Label Font-Size="10" ID="DefaultLocationLabel" runat="server" />
            </td>
            <td align="right">
                <asp:Button ID="lnkAddJob" runat="server" PostBackUrl="AddJob.aspx" Font-Size="13px"
                    Font-Bold="true" meta:resourcekey="lnkAddJob" Visible="true" />
            </td>
        </tr>
    </table>
    <br />
    <asp:Label runat="server" Visible="false" ID="lblLocationSelected" Text="0" />
    <asp:Label runat="server" Visible="false" ID="lblStatusSelected" Text="0" />
    <asp:Label runat="server" Visible="false" ID="lblDateSelected" Text="1990-01-01" />
    <asp:Label runat="server" Visible="false" ID="lblDateSelectedTo" Text="1990-01-01" />
    <asp:Label ID="lblJobId" runat="server" Visible="false" />
    <asp:Label runat="server" Visible="false" ID="lblNoRecords" meta:resourcekey="lblNoRecords" />
    <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <telerik:RadGrid Skin="Office2007" GridLines="none" ID="JobList" OnItemDataBound="JobList_ItemDataBound"
                    runat="server" Width="900px" AutoGenerateColumns="False" AllowSorting="True"
                    DataSourceID="JobDataSource" OnItemCommand="JobList_ItemCommand">
                    <MasterTableView Width="100%" DataSourceID="JobDataSource" DataKeyNames="JobId" AllowCustomSorting="True">
                        <Columns>
                            <telerik:GridButtonColumn DataTextField="JobId" meta:resourcekey="JobList_JobId"
                                UniqueName="JobId" CommandName="EditJob">
                                <ItemStyle Wrap="False" ForeColor="black" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="Period" meta:resourcekey="JobList_Period" UniqueName="DatetimeStart">
                                <ItemStyle Wrap="False" ForeColor="black" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderStyle-Wrap="false" DataField="Subtype" meta:resourcekey="JobList_Subtype"
                                UniqueName="Subtype">
                                <ItemStyle Wrap="False" ForeColor="black" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Subject" HeaderText="Subject" />
                            <telerik:GridBoundColumn ItemStyle-Width="1%" DataField="Grade" HeaderText="Grade" />
                            <telerik:GridBoundColumn HeaderStyle-Wrap="false" DataField="Teacher" meta:resourcekey="JobList_Teacher"
                                UniqueName="Teacher">
                                <ItemStyle Wrap="False" ForeColor="black" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn UniqueName="Substitute" meta:resourcekey="JobList_Substitute">
                                <ItemStyle Wrap="False" ForeColor="black" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="SubstituteLabel" Text='<%# Eval("Substitute").ToString().Length > 0 ? Eval("Substitute") : Eval("JobStatus").ToString() != "2" ? "<a href=\"SubstituteAssignment.aspx?JobId=" + Eval("JobId") + "\">Assign Sub</a>" : "" %>' />
                                    <telerik:RadToolTip ID="RadToolTip1" runat="server" Visible='<%# Eval("Substitute").ToString().Length > 0 %>'
                                        TargetControlID="SubstituteLabel" Width="300px" Animation="None" AutoCloseDelay="36000"
                                        RelativeTo="Element" ManualClose="false" ShowEvent="OnMouseOver" OffsetY="-3"
                                        OffsetX="-4" Position="MiddleRight">
                                        <table width="100%" border="0" cellpadding="3">
                                            <tr>
                                                <td style="text-align: left; padding-right: 10px; white-space: nowrap; width: 1%">
                                                    Home Phone:
                                                </td>
                                                <td>
                                                    <b>
                                                        <%# Eval("Phone") %>
                                                    </b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; padding-right: 10px; white-space: nowrap">
                                                    Mobile Phone:
                                                </td>
                                                <td>
                                                    <b>
                                                        <%# Eval("CELL_NUMBER") %>
                                                    </b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; padding-right: 10px; white-space: nowrap">
                                                    Alt Preferred Phone:
                                                </td>
                                                <td>
                                                    <b>
                                                        <%# Eval("AltPhone")%>
                                                    </b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; padding-right: 10px; white-space: nowrap">
                                                    Email:
                                                </td>
                                                <td>
                                                    <b>
                                                        <%# Eval("Email")%>
                                                    </b>
                                                </td>
                                            </tr>
                                        </table>
                                    </telerik:RadToolTip>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn ItemStyle-ForeColor="Black" ItemStyle-HorizontalAlign="Center"
                                HeaderText="Substitute Status" UniqueName="SubstituteStatus">
                                <ItemTemplate>
                                    <asp:Literal runat="server" ID="SubstituteStatusLiteral" Text='<%# Eval("SubstituteStatus")%>'
                                        Visible='<%# Convert.ToInt32(Eval("StatusId")) != 3 %>' />
                                    <asp:HyperLink runat="server" ID="SubstituteStatusLink" Text='<%# Eval("SubstituteStatus")%>'
                                        NavigateUrl="#" Visible='<%# Convert.ToInt32(Eval("StatusId")) == 3 %>' />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn HeaderStyle-Wrap="false" DataField="Status" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-HorizontalAlign="Center" HeaderText="Job Status" UniqueName="Status" />
                            <telerik:GridTemplateColumn ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="DeleteLinkButton" Font-Bold="false" Font-Size="11px"
                                        CommandName="Delete" meta:resourcekey="DeleteLinkButton" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="TemplateColumn2">
                                <ItemTemplate>
                                    </td></tr><tr>
                                        <td colspan="11" style="border-bottom: solid 1px #AFB8BD">
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td>
                                                        <img src="Images/spacer.gif" width="40" height="1" />
                                                    </td>
                                                    <td width="100%">
                                                        Job Notes:
                                                        <%# Eval("Note")%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Literal runat="server" ID="ConfirmNote" Text="Confirmation Notes: " Visible='<%# Eval("ConfirmNote").ToString().Length > 0 %>' />
                                                        <%# Eval("ConfirmNote")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
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
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" VisibleStatusbar="false"
        Behaviors="Close" Modal="True" Width="355px" Height="200px" ShowContentDuringLoad="false"
        ReloadOnShow="true">
        <Windows>
            <telerik:RadWindow ID="ModalWindow" runat="server" />
        </Windows>
    </telerik:RadWindowManager>
    <asp:ObjectDataSource ID="JobDataSource" runat="server" SelectMethod="LoadAllJob"
        TypeName="Miami.Substitute.Bll.Job">
        <SelectParameters>
            <asp:ControlParameter Name="locationId" Type="int32" ControlID="lblLocationSelected"
                PropertyName="Text" />
            <asp:ControlParameter Name="statusId" Type="int32" ControlID="lblStatusSelected"
                PropertyName="Text" />
            <asp:ControlParameter Name="selectedDate" Type="string" ControlID="lblDateSelected"
                PropertyName="Text" />
            <asp:ControlParameter Name="selectedDateTo" Type="string" ControlID="lblDateSelectedTo"
                PropertyName="Text" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:PlaceHolder runat="server" ID="plScript" />
</asp:Content>
