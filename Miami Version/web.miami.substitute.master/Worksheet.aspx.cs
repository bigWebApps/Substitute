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

namespace Miami.Substitute.Web.Master
{
    public partial class Worksheet : System.Web.UI.Page
    {
        protected enum Status
        {
            All,
            Open,
            Closed
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
            DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
            lblLocationSelected.Text = dv[0]["LocationId"].ToString();
            DefaultLocationLabel.Text = "Location: <b>" + dv[0]["RegionName"] + "&nbsp;&nbsp;&nbsp;&nbsp;" + dv[0]["LocationName"] + "</b>";
            if (Request.QueryString["Assign"] != null && Request.QueryString["Assign"].ToString().Length > 0)
            {
                Session["Assign"] = Request.QueryString["Assign"].ToString();
                Response.Redirect("Worksheet.aspx");
            }

            if (Session["lblStatusSelected"] != null && Session["lblStatusSelected"].ToString().Length > 0)
                lblStatusSelected.Text = Session["lblStatusSelected"].ToString();
            else
                lblStatusSelected.Text = "1";

            if (Session["lblDateSelected"] != null && Session["lblDateSelected"].ToString().Length > 0)
                lblDateSelected.Text = Session["lblDateSelected"].ToString();
            else
                lblDateSelected.Text = string.Empty;

            if (Session["lblDateSelectedTo"] != null && Session["lblDateSelectedTo"].ToString().Length > 0)
                lblDateSelectedTo.Text = Session["lblDateSelectedTo"].ToString();
            else
                lblDateSelectedTo.Text = string.Empty;

            IndicateSelected();

            JobList.DataBind();
            bool isNoRecords = JobList.MasterTableView.Items.Count == 0;
            lblNoRecords.Visible = isNoRecords;
            JobList.Visible = !isNoRecords;
        }

        private void IndicateSelected()
        {
            switch (lblStatusSelected.Text)
            {
                case "1":
                    lnkOpen.ForeColor = System.Drawing.Color.Green;
                    break;
                case "2":
                    lnkClosed.ForeColor = System.Drawing.Color.Green;
                    break;
            }
        }

        private void storeToSessionAndRedirect()
        {
            Session["lblStatusSelected"] = lblStatusSelected.Text;
            Session["lblDateSelectedTo"] = lblDateSelectedTo.Text;
            Session["lblDateSelected"] = lblDateSelected.Text;
            Response.Redirect("Worksheet.aspx", false);
        }

        protected void JobList_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem)
                ((HyperLink)e.Item.FindControl("SubstituteStatusLink")).Attributes["onclick"] = MasterPage.GetOpenWindowScript("ConfirmJobModal.aspx?JobId=" + ((Telerik.Web.UI.GridDataItem)e.Item).GetDataKeyValue("JobId").ToString(), ModalWindow.ID);
        }

        protected void lnkOpen_Click(object sender, EventArgs e)
        {
            lblStatusSelected.Text = Convert.ToInt32(Status.Open).ToString();
            storeToSessionAndRedirect();
        }

        protected void lnkClosed_Click(object sender, EventArgs e)
        {
            lblStatusSelected.Text = Convert.ToInt32(Status.Closed).ToString();
            storeToSessionAndRedirect();
        }

        protected void lnkAll_Click(object sender, EventArgs e)
        {
            lblStatusSelected.Text = Convert.ToInt32(Status.All).ToString();
            storeToSessionAndRedirect();
        }

        protected void lnkDateSelect_Click(object sender, EventArgs e)
        {
            switch (((System.Web.UI.WebControls.LinkButton)(sender)).CommandArgument)
            {
                case "today":
                    lblDateSelected.Text = lblDateSelectedTo.Text = DateTime.Now.Date.ToString();
                    break;
                case "tomorrow":
                    lblDateSelected.Text = lblDateSelectedTo.Text = DateTime.Now.Date.AddDays(1).ToString();
                    break;
                case "yesterday":
                    lblDateSelected.Text = lblDateSelectedTo.Text = DateTime.Now.Date.AddDays(-1).ToString();
                    break;
                case "week":
                    int current = Convert.ToInt16(DateTime.Now.Date.DayOfWeek);
                    current--;
                    current = 0 - current;
                    DateTime startWeek = DateTime.Now.Date.AddDays(current);
                    lblDateSelected.Text = startWeek.ToString();
                    lblDateSelectedTo.Text = startWeek.AddDays(6).ToString();
                    break;
                case "all":
                    lblDateSelected.Text = lblDateSelectedTo.Text = "1990-01-01";
                    break;
                default:
                    break;
            }
            Session["SelectedRange"] = ((System.Web.UI.WebControls.LinkButton)(sender)).CommandArgument;
            storeToSessionAndRedirect();
        }

        protected void JobList_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName != "Sort")
            {
                int jobId; int.TryParse(((System.Data.DataRowView)(e.Item.DataItem)).Row["JobId"].ToString(), out jobId);
                if (e.CommandName == "EditJob")
                    Response.Redirect("EditJob.aspx?JobId=" + jobId.ToString());
                else if (e.CommandName == "Delete")
                {
                    Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job();
                    job.LoadByPrimaryKeyBase(jobId);
                    if (job.m_substituteId > 0)
                    {
                        Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute(job.m_substituteId);
                        Miami.Substitute.Bll.NoticeSystem noticeSystem = new Miami.Substitute.Bll.NoticeSystem(jobId, Miami.Substitute.Bll.NoticeSystem.NoticeType.AcceptedJobDeletedByClerk, substitute.UserId, Micajah.Common.Security.UserContext.Current.UserId);
                        noticeSystem.Send();
                    }
                    job.DeleteJob(jobId);
                    Response.Redirect("Worksheet.aspx");
                }
            }
        }
    }
}