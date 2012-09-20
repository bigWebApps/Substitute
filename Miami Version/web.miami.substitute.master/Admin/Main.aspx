<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Main.aspx.cs" Inherits="Miami.Substitute.Web.Master.Main" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <mits:DetailMenu ID="DetailMenu1" runat="server" RepeatColumns="1">
    </mits:DetailMenu>
</asp:Content>
