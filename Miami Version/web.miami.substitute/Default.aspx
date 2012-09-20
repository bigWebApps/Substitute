<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Miami.Substitute.Web.DefaultPage" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <table width="100%" border="0">
        <tr>
            <td style="width: 50px;">
            </td>
            <td>
                <asp:Label Font-Bold="true" ID="lblName" runat="server" />
                <br />
                <br />
                <asp:Label Font-Bold="true" ID="lblResponseTitle" meta:resourcekey="lblResponseTitle"
                    runat="server" />
                <mits:CommonGridView ColorScheme="Blue" ID="ResponseGridView" runat="server" Width="565px"
                    AutoGenerateColumns="False" DataKeyNames="JobId">
                    <Columns>
                        <mits:TemplateField meta:resourcekey="JobList_JobIdField">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="JobIdLinkButton" Text='<%# DataBinder.Eval(Container, "DataItem.JobId")%>' />
                                <telerik:RadToolTip ID="RadToolTip1" runat="server" TargetControlID="JobIdLinkButton"
                                    Width="200px" RelativeTo="Element" ManualClose="true" OffsetY="-3" OffsetX="-4" ShowEvent="onclick" Position="MiddleRight">
                                    <table width="100%" border="0" cellpadding="3">
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Job Id:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.JobId")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="white-space: nowrap; text-align: right; padding-right: 10px">
                                                Start Date:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.DatetimeStart")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                End Date:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.DatetimeEnd")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Region:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Region")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Location:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Location")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Teacher:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Teacher")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Subtype:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Subtype")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Room:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Room")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="text-align: right; padding-right: 10px">
                                                Note:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Note")%>
                                                </b>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadToolTip>
                            </ItemTemplate>
                        </mits:TemplateField>
                        <mits:ValidatedTextBoxField DataField="DatetimeStart" meta:resourcekey="JobList_DatetimeStartField" />
                        <mits:ValidatedTextBoxField DataField="DatetimeEnd" meta:resourcekey="JobList_DatetimeEndField" />
                        <mits:ValidatedTextBoxField DataField="Region" meta:resourcekey="JobList_RegionField" />
                        <mits:ValidatedTextBoxField DataField="Location" meta:resourcekey="JobList_LocationField" />
                        <mits:ValidatedTextBoxField DataField="Teacher" meta:resourcekey="JobList_TeacherField" />
                        <mits:TemplateField ItemStyle-Width="1%" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" OnCommand="Accept_Command" CommandName="Accept" CommandArgument='<%# Eval("JobId") %>'
                                    ID="AcceptLinkButton" OnClientClick='<%# Eval("JobId", "return confirm(\"You are about to accept Job #{0}. Click \\\"OK\\\", if you are sure you want to accept this job assignment.\")")%>'
                                    Text="Accept" />&nbsp;
                                <asp:LinkButton runat="server" OnCommand="Decline_Command" CommandName="Decline"
                                    CommandArgument='<%# Eval("JobId") %>' ID="DeclineLinkButton" OnClientClick='<%# Eval("JobId", "return confirm(\"You are about to decline Job #{0}. Click \\\"OK\\\", if you are sure you want to decline this job assignment.\")")%>'
                                    Text="Decline" />
                            </ItemTemplate>
                        </mits:TemplateField>
                    </Columns>
                </mits:CommonGridView>
                <br />
                <table width="100%" border="0">
                    <tr>
                        <td width="250" valign="top">
                            <mits:DetailMenu ID="DetailMenu1" runat="server" RepeatColumns="1" />
                        </td>
                        <td valign="top">
                            <mits:MagicForm ColorScheme="Blue" ObjectName="Profile" ID="ViewProfile" runat="server"
                                DataKeyNames="UserId" AutoGenerateRows="False" AutoGenerateInsertButton="False"
                                AutoGenerateEditButton="False" Visible="True">
                                <Fields>
                                    <mits:ValidatedTextBoxField DataField="FullName" ItemStyle-BackColor="#E2E0FF" HeaderStyle-BackColor="#E2E0FF"
                                        ItemStyle-Font-Bold="true" MaxLength="255" Columns="60" Required="True" meta:resourcekey="ViewProfile_NameField" />
                                    <mits:ValidatedTextBoxField DataField="ContactInfo" ItemStyle-Font-Bold="true" MaxLength="255"
                                        Columns="60" Required="True" meta:resourcekey="ViewProfile_ContactField" />
                                    <mits:ValidatedTextBoxField DataField="JobCode" ItemStyle-BackColor="#E2E0FF" HeaderStyle-BackColor="#E2E0FF"
                                        ItemStyle-Font-Bold="true" MaxLength="255" Columns="60" Required="True" meta:resourcekey="ViewProfile_JobCodeField" />
                                    <mits:ValidatedTextBoxField DataField="Subtype" ItemStyle-Font-Bold="true" MaxLength="255"
                                        Columns="60" Required="True" meta:resourcekey="ViewProfile_SubtypeField" />
                                    <mits:ValidatedTextBoxField DataField="SubjectLevel" ItemStyle-BackColor="#E2E0FF"
                                        HeaderStyle-BackColor="#E2E0FF" ItemStyle-Font-Bold="true" ItemStyle-Wrap="false"
                                        Columns="60" Required="True" meta:resourcekey="ViewProfile_SubjectLevel" />
                                </Fields>
                            </mits:MagicForm>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:Label Font-Bold="true" ID="lblUpcomingJobs" meta:resourcekey="lblUpcomingJobs"
                    runat="server" />
                <br />
                <br />
                <mits:CommonGridView ColorScheme="Blue" ID="JobList" runat="server" Width="565px"
                    AutoGenerateColumns="False" DataKeyNames="JobId" meta:resourcekey="JobList_NoJobFound"
                    OnRowCancelingEdit="JobList_RowCancelingEdit">
                    <Columns>
                        <mits:TemplateField meta:resourcekey="JobList_JobIdField">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="JobIdLinkButton" Text='<%# DataBinder.Eval(Container, "DataItem.JobId")%>' />
                                <telerik:RadToolTip ID="RadToolTip1" runat="server" TargetControlID="JobIdLinkButton"
                                    Width="200px" RelativeTo="Element" ManualClose="true" ShowEvent="onclick" OffsetY="-3" OffsetX="-4" Position="MiddleRight">
                                    <table width="100%" border="0" cellpadding="3">
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Job Id:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.JobId")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="white-space: nowrap; text-align: right; padding-right: 10px">
                                                Start Date:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.DatetimeStart")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                End Date:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.DatetimeEnd")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Region:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Region")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Location:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Location")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Teacher:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Teacher")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Subtype:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Subtype")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Room:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Room")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="text-align: right; padding-right: 10px">
                                                Note:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Note")%>
                                                </b>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadToolTip>
                            </ItemTemplate>
                        </mits:TemplateField>
                        <mits:ValidatedTextBoxField DataField="DatetimeStart" meta:resourcekey="JobList_DatetimeStartField" />
                        <mits:ValidatedTextBoxField DataField="DatetimeEnd" meta:resourcekey="JobList_DatetimeEndField" />
                        <mits:ValidatedTextBoxField DataField="Region" meta:resourcekey="JobList_RegionField" />
                        <mits:ValidatedTextBoxField DataField="Location" meta:resourcekey="JobList_LocationField" />
                        <mits:ValidatedTextBoxField DataField="Teacher" meta:resourcekey="JobList_TeacherField" />
                        <mits:TemplateField ItemStyle-Width="1%" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="SelectLinkButton" CommandName="Select" Text="View" />&nbsp;
                                <asp:LinkButton runat="server" ID="CancelLinkButton" OnClientClick='<%# Eval("JobId", "return confirm(\"You are about to cancel your accepted job #{0}, Are you sure you want to cancel this job assignment?\")")%>'
                                    CommandName="Cancel" Text="Cancel this Job" />
                                <telerik:RadToolTip ID="RadToolTip2" runat="server" TargetControlID="SelectLinkButton"
                                    Width="200px" RelativeTo="Element" ManualClose="true" ShowEvent="onclick" OffsetY="-3" OffsetX="-4" Position="MiddleRight">
                                    <table width="100%" border="0" cellpadding="3">
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Job Id:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.JobId")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="white-space: nowrap; text-align: right; padding-right: 10px">
                                                Start Date:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.DatetimeStart")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                End Date:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.DatetimeEnd")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Region:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Region")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Location:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Location")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Teacher:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Teacher")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Subtype:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Subtype")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 10px">
                                                Room:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Room")%>
                                                </b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" style="text-align: right; padding-right: 10px">
                                                Note:
                                            </td>
                                            <td>
                                                <b>
                                                    <%# DataBinder.Eval(Container, "DataItem.Note")%>
                                                </b>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadToolTip>
                            </ItemTemplate>
                        </mits:TemplateField>
                    </Columns>
                </mits:CommonGridView>
            </td>
        </tr>
    </table>
</asp:Content>
