<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" ValidateRequest="false" AutoEventWireup="true" CodeFile="EditTemplates.aspx.cs" Inherits="Miami.Substitute.Web.Master.EditTemplates" %>
<%@ Register Src="~/Admin/Controls/TemplateEdit.ascx" TagName="TemplateEdit" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" Runat="Server">
<asp:UpdatePanel runat="server" ID="UpdatePanel1" RenderMode="Inline">
<ContentTemplate>
    <asp:Panel ID="TemplateListPanel" runat="server">
    <asp:Repeater DataSourceID="TemplateDS" ID="Templates" runat="server" OnItemCommand="Templates_ItemCommand">
    <ItemTemplate>
        <asp:Table runat="server" BorderWidth="0px" Width="500px" CellPadding="3">
            <asp:TableRow>
                <asp:TableCell>
                    <b><%# Eval("Header") %></b><br />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell>
                    <%# Eval("Description") %>
                </asp:TableCell>
            </asp:TableRow>
             <asp:TableRow>
                <asp:TableCell>
                    <asp:Table runat="server" BorderColor="lightgray" BorderWidth="2px" Width="500px">
                        <asp:TableRow>
                            <asp:TableCell ID="TextCell">
                                <asp:LinkButton runat="server" ID="EditLink" meta:resourcekey="EditLink" CommandName="Edit" CommandArgument='<%# Eval("TemplateId") %>' />
                                &nbsp;<%# Eval("Text").ToString() %>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
             </asp:TableRow>
        </asp:Table>
        <br />
    </ItemTemplate>
    </asp:Repeater>
    </asp:Panel>
    <asp:ObjectDataSource ID="TemplateDS" runat="server" 
        SelectMethod="LoadAllTemplates" TypeName="Miami.Substitute.Dal.Template" />
</ContentTemplate>
</asp:UpdatePanel>
<asp:UpdatePanel runat="server" ID="UpdatePanel2" RenderMode="Inline">
<ContentTemplate>
    <uc1:TemplateEdit ID="TemplateEditControl" runat="server" Visible="false" OnAction="TemplateEditControl_Action" />
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>

