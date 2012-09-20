<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DomainLogin.aspx.cs" Inherits="Miami.Substitute.Web.DomainLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Domain Login</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label runat="server" ID="ErrorLabel" Font-Size="Medium" Visible="false" ForeColor="red" Font-Bold="true" />
        <br />
        <br />
        <asp:LinkButton runat="server" meta:resourcekey="loginButton" ID="loginButton" Visible="false" OnClick="loginButton_Click" />
    </div>
    </form>
</body>
</html>
