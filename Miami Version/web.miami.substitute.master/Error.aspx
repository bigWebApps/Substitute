<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Miami.Substitute.Web.Master.Error" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
  <HEAD>
    <title>Error</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio.NET 7.0">
    <meta name="CODE_LANGUAGE" content="Visual Basic 7.0">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
  </HEAD>
  <body MS_POSITIONING="GridLayout" bgcolor="lightsteelblue">
    <form id="Form1" method="post" runat="server">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="middle" width="50" height="40">
							</td>
							<td width="507">
								<font style="FONT-SIZE:20px" color="black" face="TREBUCHET MS"><em>A System Error Has 
										Occurred</em> </font>
							</td>
						<tr>
							<td align="left" colspan="2">
							</td>
						</tr>
						<tr>
							<td width="50">&nbsp;</td>
							<td width="507">
								<p>An unexpected error has occurred. Your request was not able to be completed. You 
									may try to complete your request again, however. If the problem persists, 
									please contact System User Support. You may visit the <a href="http://oit.dadeschools.net/sus.html">
										SUS homepage</a> for contact information, or you may call directly at 
									305-995-3705.
								</p>
								<p>
									When reporting this error, please note the information below. In addition, 
									please attempt to jot down the steps you took prior to receiving this message.
								</p>
								<font style="FONT-SIZE:16px" color="white" face="TREBUCHET MS"><span><b>Error Details</b>
									</span></font>
								<DIV style="BORDER-RIGHT: white 1px solid; BORDER-TOP: white 1px solid; FONT-SIZE: 10pt; OVERFLOW: auto; BORDER-LEFT: white 1px solid; WIDTH: 500px; COLOR: black; BORDER-BOTTOM: white 1px solid; HEIGHT: 143px; BACKGROUND-COLOR: Gainsboro">
									<SAMP><B>Error:</B><br><asp:label id="ERROR_MESSAGE" runat="server" width="1600px"></asp:label><BR><BR><BR>
									<B>Location:</B><BR><asp:label id="ERROR_SOURCE" runat="server"></asp:label>
									<BR><BR><!-- ********* INSERT ERROR HERE - END   ********* --></SAMP></DIV>
							</td>
						</tr>
					</table>
    </form>
</body>
</html>
