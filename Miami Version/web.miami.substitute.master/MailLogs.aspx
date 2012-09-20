<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MailLogs.aspx.cs" Inherits="Miami.Substitute.Web.Master.MailLogs" Title="Untitled Page" %>
<%@ Register Src="~/Admin/Controls/MailLogsControl.ascx" TagName="MailLogsControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" Runat="Server">

<uc1:MailLogsControl runat="server" ID="MailLogsCtrl" />

</asp:Content>

