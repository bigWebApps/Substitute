<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MailLogsAdmin.aspx.cs" Inherits="Miami.Substitute.Web.Master.MailLogsAdmin" Title="Untitled Page" %>
<%@ Register Src="~/Admin/Controls/MailLogsControl.ascx" TagName="MailLogsControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" Runat="Server">

<uc1:MailLogsControl runat="server" ID="MailLogsCtrl" IsAdmin="true" />

</asp:Content>

