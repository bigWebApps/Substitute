<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MailLogsControl.ascx.cs"
    Inherits="Miami.Substitute.Web.Master.MailLogsControl" %>
<table width="800" border="0">
    <tr>
        <td width="750">
            <asp:Label Font-Size="10" ID="DefaultLocationLabel" runat="server" />
        </td>
        <td nowrap>
            <asp:Label Font-Size="10" ID="SMTPServerLabel" runat="server" /><br />
            <asp:Label Font-Size="10" ID="MailModeLabel" runat="server" /><br />
        </td>
    </tr>
</table>
<br />
<asp:UpdatePanel runat="server" ID="UpdatePanel1" RenderMode="Inline">
    <ContentTemplate>
        <radG:RadGrid ID="MailLogList" runat="server" Width="800px" DataSourceID="MailLogDataSource"
            AutoGenerateColumns="False" GridLines="None" AllowPaging="True" PageSize="100"
            OnDataBound="MailLogList_DataBound">
            <MasterTableView Width="100%" AllowCustomSorting="True" DataKeyNames="MailLogId"
                DataSourceID="MailLogDataSource">
                <Columns>
                    <radG:GridBoundColumn DataField="SendDate" ItemStyle-HorizontalAlign="Center" meta:resourcekey="MailLogList_SendDate"
                        UniqueName="SendDate" />
                    <radG:GridBoundColumn DataField="MailFrom" ItemStyle-HorizontalAlign="Center" meta:resourcekey="MailLogList_MailFrom"
                        UniqueName="MailFrom" />
                    <radG:GridBoundColumn DataField="MailTo" ItemStyle-HorizontalAlign="Center" meta:resourcekey="MailLogList_MailTo"
                        UniqueName="MailTo" />
                    <radG:GridBoundColumn DataField="Subject" ItemStyle-HorizontalAlign="Center" meta:resourcekey="MailLogList_Subject"
                        UniqueName="Subject" />
                    <radG:GridTemplateColumn ItemStyle-HorizontalAlign="Center" meta:resourcekey="MailLogList_Message"
                        UniqueName="TemplateColumn">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="MessageLink" CommandArgument='<%# Eval("MailLogId") %>'
                                OnClientClick="return false" meta:resourcekey="MailLogList_ShowMessage" />
                        </ItemTemplate>
                    </radG:GridTemplateColumn>
                </Columns>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="19px" />
                </ExpandCollapseColumn>
                <RowIndicatorColumn Visible="False">
                    <HeaderStyle Width="20px" />
                </RowIndicatorColumn>
            </MasterTableView>
        </radG:RadGrid>
        <asp:ObjectDataSource ID="MailLogDataSource" SelectMethod="GetAllMailLogByLocationId"
            runat="server" TypeName="Miami.Substitute.Dal.MailLog" OnSelecting="MailLogDataSource_Selecting">
            <SelectParameters>
                <asp:Parameter Name="LocationId" Type="int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </ContentTemplate>
</asp:UpdatePanel>
<telerik:RadToolTipManager runat="server" ID="RadToolTipManager1" Position="Center"
    RelativeTo="Element" Width="500px" ShowEvent="OnClick" Height="400px" Animation="None"
    Sticky="true" Skin="WebBlue" OnAjaxUpdate="OnAjaxUpdate">
</telerik:RadToolTipManager>
