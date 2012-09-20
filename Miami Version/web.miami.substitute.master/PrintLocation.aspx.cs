using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Miami.Substitute.Bll;
using Telerik.WebControls;
using Telerik.Web.UI;

namespace Miami.Substitute.Web.Master
{
    public partial class PrintLocation : System.Web.UI.Page
    {
        protected void Button1_Click(object sender, System.EventArgs e)
        {
            PrintList.MasterTableView.ExportToExcel();
            //if (!Use2007OfficeFormat.Checked)
            //    PrintList.MasterTableView.ExportToExcel(cbFilterRegion.SelectedItem.Text.Replace(" ", "") + "_" + cbFilterLocation.SelectedItem.Text.Replace(" ", "") + "_CallList_" + DateTime.Now.Date.GetDateTimeFormats()[91].Substring(0, 10).Replace("-", "_"), false, true);
            //PrintList.MasterTableView.ExportToExcel(cbFilterRegion.SelectedItem.Text.Replace(" ", "") + "_" + cbFilterLocation.SelectedItem.Text.Replace(" ", "") + "_CallList_" + DateTime.Now.Date.GetDateTimeFormats()[91].Substring(0, 10).Replace("-", "_"), false, true);
            //else
            //    PrintList.MasterTableView.ExportToExcel2007(cbFilterRegion.SelectedItem.Text.Replace(" ", "") + "_" + cbFilterLocation.SelectedItem.Text.Replace(" ", "") + "_CallList_" + DateTime.Now.Date.GetDateTimeFormats()[91].Substring(0, 10).Replace("-", "_"), false, true);
        }

        protected void Button2_Click(object sender, System.EventArgs e)
        {
            PrintList.MasterTableView.ExportToWord();
            //if (!Use2007OfficeFormat.Checked)
            //    PrintList.MasterTableView.ExportToWord(cbFilterRegion.SelectedItem.Text.Replace(" ", "") + "_" + cbFilterLocation.SelectedItem.Text.Replace(" ", "") + "_CallList_" + DateTime.Now.Date.GetDateTimeFormats()[91].Substring(0, 10).Replace("-", "_"), false, true);
            //else
            //    PrintList.MasterTableView.ExportToWord2007(cbFilterRegion.SelectedItem.Text.Replace(" ", "") + "_" + cbFilterLocation.SelectedItem.Text.Replace(" ", "") + "_CallList_" + DateTime.Now.Date.GetDateTimeFormats()[91].Substring(0, 10).Replace("-", "_"), false, true);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["lblStatusSelected"] = 1;
            Session["lblDateSelectedTo"] = null;
            Session["lblDateSelected"] = null;
            Session["SortDefault"] = true;
            Session["IsFirstTime"] = null;
            Session["SelectedRange"] = "all";
            if (!IsPostBack)
            {
                Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
                DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
                lblLocationSelected.Text = dv[0]["LocationId"].ToString();
                DefaultLocationLabel.Text = "Location: <b>" + dv[0]["LocationName"] + "</b>&nbsp;&nbsp;Region: <b>" + dv[0]["RegionName"] + "</b>";                
                PrintList.DataBind();
                SetNoRecords();
            }
        }

        protected void PrintLocation_CheckedChanged(object sender, EventArgs e)
        {
            int userId; int.TryParse(((System.Web.UI.WebControls.CheckBox)(sender)).ValidationGroup, out userId);

            Miami.Substitute.Bll.Preferred preferred = new Miami.Substitute.Bll.Preferred();
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();

            substitute.LoadByUserId(userId);
            int substId = substitute.SubstituteId;
            int locId = Convert.ToInt32(lblLocationSelected.Text);

            preferred.DeleteForClerkSubstitute(locId, substId);

            if (((System.Web.UI.WebControls.CheckBox)(sender)).Checked)
                preferred.ClerkInsert(locId, substId);
        }

        protected void PrintList_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem)
                ((HyperLink)e.Item.FindControl("EditLink")).Attributes["onclick"] = MasterPage.GetOpenWindowScript("UpdateUserModal.aspx?UserId=" + ((Telerik.Web.UI.GridDataItem)e.Item).GetDataKeyValue("UserId").ToString(), ModalWindow.ID);
        }

        private void SetNoRecords()
        {
            bool isNoRecords = PrintList.MasterTableView.Items.Count == 0;
            lblNoRecords.Visible = isNoRecords;
            //Use2007OfficeFormat.Visible = !isNoRecords;
            Button2.Visible = !isNoRecords;
            Button1.Visible = !isNoRecords;
            PrintList.Visible = !isNoRecords;
        }

        protected void lbAddSubstitute_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddSubstitute.aspx?LocationId=" + lblLocationSelected.Text);
        }
    }
}