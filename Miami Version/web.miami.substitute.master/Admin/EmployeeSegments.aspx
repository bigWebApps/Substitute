<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="EmployeeSegments.aspx.cs" Inherits="Miami.Substitute.Web.Master.EmployeeSegments"
    Title="Employee Segments" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <radG:RadGrid ID="EmployeeSegmentsList" runat="server" Width="300px" AutoGenerateColumns="False"
        Skin="Classic" AllowSorting="False" GridLines="None" AllowPaging="True" PageSize="20">
        <MasterTableView>
            <Columns>
                <radG:GridBoundColumn ItemStyle-Wrap="false" DataField="Location" HeaderText="Location" />
                <radG:GridBoundColumn ItemStyle-Wrap="false" DataField="Paycode" HeaderText="Paycode" />
                <radG:GridBoundColumn ItemStyle-Wrap="false" DataField="BoardCode" HeaderText="BoardCode" />                
            </Columns>
        </MasterTableView>
    </radG:RadGrid>
</asp:Content>
