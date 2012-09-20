<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TemplateEdit.ascx.cs" Inherits="Miami.Substitute.Web.Master.TemplateEditControl" %>
<asp:UpdatePanel runat="server" ID="UpdatePanel1" RenderMode="Inline">
<ContentTemplate>
<asp:label runat="server" id="TextLabel" meta:resourcekey="TextLabel" /> "<asp:label runat="server" id="TemplateNameLabel" Font-Bold="true" />" template.
<br /><br />
<asp:label runat="server" id="TipsLabel" meta:resourcekey="TipsLabel" />
<br /><br />
<asp:Button runat="server" ID="SaveButton" meta:resourcekey="SaveButton" OnClick="SaveButton_Click" /> 
<asp:Button runat="server" ID="CancelButton" meta:resourcekey="CancelButton" OnClick="CancelButton_Click" /> 
<asp:Button runat="server" ID="DeleteButton" meta:resourcekey="DeleteButton" OnClick="DeleteButton_Click" />
<br />
<table border="0" width="100%">
<tr>
    <td width="300px" valign="top">
        <asp:TextBox ID="TemplateText" TextMode="MultiLine" runat="server" Rows="30" Columns="100" Height="300px" />
    </td>
    <td valign="top">
        <asp:Label runat="server" meta:resourcekey="ListVariablesLabel" ID="ListVariablesLabel" />
    </td>
</tr>
</table>
<asp:Label runat="server" ID="TemplateIdLabel" Visible="false" />
</ContentTemplate>
</asp:UpdatePanel>