<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AddSubstitute.aspx.cs" Inherits="Miami.Substitute.Web.Master.AddSubstitute" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <table width="1%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:Panel runat="server" ID="IdPanel" DefaultButton="btnSearch">
                    <table width="1%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="white-space: nowrap;">
                                Employee ID:</td>
                            <td>
                                <mits:ValidatedTextBox runat="server" TabIndex="1" ID="tbEmployeeId" />
                            </td>
                            <td>
                                &nbsp;<asp:Button runat="server" TabIndex="2" ID="btnSearch" OnClick="btnSearch_Click"
                                    Text="Search" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel runat="server" ID="NamePanel" DefaultButton="btnSearchName">
                    <table width="1%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="white-space: nowrap;">
                                &nbsp;&nbsp;<b>OR</b>&nbsp; Employee Name:</td>
                            <td>
                                <mits:ValidatedTextBox runat="server" TabIndex="3" ID="tbEmployeeName" />
                            </td>
                            <td>
                                &nbsp;<asp:Button runat="server" TabIndex="4" UseSubmitBehavior="true" ID="btnSearchName"
                                    OnClick="btnSearchName_Click" Text="Search" /></td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <mits:CommonGridView ColorScheme="Blue" ID="SubstituteList" runat="server" Width="500px"
        AutoGenerateColumns="False" EnableSelect="false" OnSelectedIndexChanged="SubstituteList_SelectedIndexChanged"
        DataKeyNames="UserId" Visible="False" EmptyDataText="Substitute not found on this criteria">
        <Columns>
            <mits:ValidatedTextBoxField DataField="UserId" meta:resourcekey="SubstituteForm_UserId">
                <ItemStyle Width="250px" />
            </mits:ValidatedTextBoxField>
            <mits:ValidatedTextBoxField DataField="Firstname" meta:resourcekey="SubstituteForm_Firstname">
                <ItemStyle Width="250px" />
            </mits:ValidatedTextBoxField>
            <mits:ValidatedTextBoxField DataField="Lastname" meta:resourcekey="SubstituteForm_Lastname">
                <ItemStyle Width="250px" />
            </mits:ValidatedTextBoxField>
            <mits:ValidatedTextBoxField DataField="Subtype" meta:resourcekey="SubstituteForm_Subtype">
                <ItemStyle Width="250px" />
            </mits:ValidatedTextBoxField>
            <mits:ButtonField CommandName="Select" Text="Add" />
        </Columns>
    </mits:CommonGridView>
</asp:Content>
