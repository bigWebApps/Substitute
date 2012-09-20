<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SearchOpenJobs.aspx.cs" Inherits="Miami.Substitute.Web.SearchOpenJobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="Server">
    <div id="container">
        <div id="body">
            <table width="100%" border="0" runat="server" id="tblSearch">
                <tr>
                    <td width="440px">
                        <mits:DateRange ID="drJobs" runat="server" DateRangeParts="Present,Future" FiscalYearEnd="2008-07-01"
                            DateRangeSelected="Next365Days" />
                    </td>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <td width="1%">
                                        <img src="Images/spacer.gif" height="1" width="7" />All Schools<br />
                                        <img src="Images/spacer.gif" height="2" /><br />
                                        <radC:RadComboBox Width="300" Skin="WindowsGray" runat="server" ID="tbJobs" DataSourceID="JobLocations"
                                            DataTextField="Name" DataValueField="Value" />
                                    </td>
                                    <td width="100%" style="padding-left: 15px; padding-bottom: 1px">
                                        <img src="Images/spacer.gif" height="18" /><br />
                                        <asp:Button runat="server" ID="btnJobs" Text="Search" OnClick="btnJobs_Click" /></td>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <asp:Label ID="lblError" runat="server" meta:resourcekey="lblError" Font-Size="Medium"
                ForeColor="black" />
            <asp:LinkButton ID="lnkClickHere" Font-Size="medium" runat="server" Text="click here"
                PostBackUrl="UpdateLocation.aspx" />
            <asp:Label ID="lblError2" runat="server" meta:resourcekey="lblError2" Font-Bold="False"
                Font-Size="Medium" ForeColor="black" /><br />
            <div style="padding-left: 10px">
                <mits:CommonGridView ColorScheme="Blue" ID="JobList" runat="server" Width="1000px"
                    AutoGenerateColumns="False" DataKeyNames="JobId" meta:resourcekey="JobList_NoJobs"
                    OnSelectedIndexChanged="JobList_SelectedIndexChanged">
                    <Columns>
                        <mits:ButtonField ItemStyle-Width="1%" ItemStyle-Wrap="false" CommandName="Select"
                            DataTextField="JobId" meta:resourcekey="JobList_JobIdField" />
                        <mits:ValidatedTextBoxField ItemStyle-Width="1%" DataField="DatetimeStart" meta:resourcekey="JobList_DatetimeStartField" />
                        <mits:ValidatedTextBoxField ItemStyle-Width="1%" DataField="DatetimeEnd" meta:resourcekey="JobList_DatetimeEndField" />
                        <mits:ValidatedTextBoxField ItemStyle-Wrap="false" ItemStyle-Width="1%" DataField="Region"
                            meta:resourcekey="JobList_RegionField">
                            <ItemStyle Wrap="False" />
                        </mits:ValidatedTextBoxField>
                        <mits:ValidatedTextBoxField ItemStyle-Width="1%" DataField="Location" meta:resourcekey="JobList_LocationField">
                            <ItemStyle Wrap="False" />
                        </mits:ValidatedTextBoxField>
                        <mits:ValidatedTextBoxField DataField="Teacher" meta:resourcekey="JobList_TeacherField" />
                        <mits:ValidatedTextBoxField DataField="Subject" HeaderText="Subject" />
                        <mits:ValidatedTextBoxField ItemStyle-Width="1%" DataField="Grade" HeaderText="Grade" />
                        <mits:ButtonField ItemStyle-Width="1%" CommandName="Select" meta:resourcekey="JobList_DetailsField" />
                    </Columns>
                </mits:CommonGridView>
            </div>
        </div>
        <div id="footer">
            <asp:Panel runat="server" ID="OverlapCaptionPanel" Style="padding-left: 10px; padding-top: 10px">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="1%">
                            <img src="Images/overlap.gif" />
                        </td>
                        <td>
                            &nbsp;<asp:Literal runat="server" ID="OverlapCaption" meta:resourcekey="OverlapCaption" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Label ID="lblLegend" runat="server" Text="" /><br />
        </div>
    </div>
    <asp:ObjectDataSource ID="JobLocations" runat="server" SelectMethod="LoadLocationForSearch"
        TypeName="Miami.Substitute.Bll.Location"></asp:ObjectDataSource>
</asp:Content>
