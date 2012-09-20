<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Locations.aspx.cs" Inherits="Miami.Substitute.Web.Master.Locations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <mits:CommonGridView ColorScheme="Blue" AllowPaging="false" ID="LocationsList" runat="server"
        Width="720px" AutoGenerateColumns="False" EnableSelect="false" Visible="True">
        <Columns>
            <mits:ValidatedTextBoxField DataField="LName" meta:resourcekey="LocationsList_LName" />
            <asp:TemplateField meta:resourcekey="LocationsList_Template">
                <itemtemplate>
           <%# Eval("CountUsers")%> (<%# Eval("CountPreferredUsers")%>)
        </itemtemplate>
            </asp:TemplateField>
            <mits:ValidatedTextBoxField DataField="UName" meta:resourcekey="LocationsList_UName" />
            <mits:ValidatedTextBoxField DataField="Email" meta:resourcekey="LocationsList_Email" />
        </Columns>
    </mits:CommonGridView>
    <br />
    <br />
    <b>Clerk's default Locations</b><br />
    <br />
    <mits:CommonGridView ColorScheme="Blue" ID="DefaultLocationsList" runat="server"
        Width="500px" DataSourceID="DSDefaultLocations" AutoGenerateColumns="False" EnableSelect="false"
        Visible="True">
        <Columns>
            <mits:ValidatedTextBoxField DataField="UName" meta:resourcekey="LocationsList_UName" />
            <mits:ValidatedTextBoxField DataField="LName" meta:resourcekey="LocationsList_LName" />
        </Columns>
    </mits:CommonGridView>
    <asp:ObjectDataSource ID="DSDefaultLocations" runat="server" SelectMethod="GetDefaultLocations"
        TypeName="Miami.Substitute.Bll.Location"></asp:ObjectDataSource>
</asp:Content>
