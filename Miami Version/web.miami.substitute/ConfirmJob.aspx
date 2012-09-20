<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConfirmJob.aspx.cs" Inherits="ConfirmJob" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Confirm Job</title>
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%" border="0">
            <tr>
                <td>
                    <img src="Images/logo-top.gif" />
                </td>
                <td align="right">
                    <img src="Images/logo.gif" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div style="padding: 20px 0px 0px 20px">
                        <asp:Label runat="server" ID="Message" Font-Bold="true" />
                        <br /><br /><br /><br />You can close this browser window now.
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
