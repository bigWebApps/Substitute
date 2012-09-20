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
using Micajah.Common.WebControls;

namespace Miami.Substitute.Web.Master
{
    public partial class SubstituteAssignment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["JobId"] != null)
            {
                Dal.Job job = new Miami.Substitute.Dal.Job();
                job.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString["JobId"]));
                jobNote.Text = job.Note;
                lblJobId.Text = Request.QueryString["JobId"];
            }
            else
                Response.Redirect("Worksheet.aspx");
        }

        protected void SubstituteList_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                int substituteId = Convert.ToInt32(e.CommandArgument);
                int jobId = Convert.ToInt32(lblJobId.Text);
                Job job = new Job();
                ArrayList jobOverLaps = job.GetOverlap(jobId, substituteId);
                if (jobOverLaps.Count > 0)
                {
                    for (int i = 0; i < jobOverLaps.Count; i++)
                        job.DeleteSubstituteFromJob(Convert.ToInt32(jobOverLaps[i]), substituteId);
                }

                job.SetSubstitute(jobId, substituteId, 3);
                Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute(substituteId);

                NoticeSystem noticeSystem = new NoticeSystem(jobId, NoticeSystem.NoticeType.JobAcceptedByClerk, substitute.UserId, Micajah.Common.Security.UserContext.Current.UserId);
                noticeSystem.Send();
                Response.Redirect("Worksheet.aspx", true);
            }
        }

        protected void SubstituteList_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem)
            {
                ((HyperLink)e.Item.FindControl("EditLink")).Attributes["onclick"] = MasterPage.GetOpenWindowScript("UpdateUserModal.aspx?UserId=" + ((Telerik.Web.UI.GridDataItem)e.Item).GetDataKeyValue("UserId").ToString(), ModalWindow.ID);
                string confirm = "return confirm('Are you sure you want to assign \"" + ((System.Data.DataRowView)(e.Item.DataItem)).Row["Name"].ToString().TrimEnd(' ') + "\" to the job #" + lblJobId.Text + "')";
                ((LinkButton)e.Item.FindControl("SelectLinkButton")).OnClientClick = confirm;
                ScriptManager.GetCurrent(this.Page).RegisterPostBackControl(((LinkButton)e.Item.FindControl("SelectLinkButton")));
            }
        }

        protected void SubstituteAssignment_CheckedChanged(object sender, EventArgs e)
        {
            int substId; int.TryParse(((System.Web.UI.WebControls.CheckBox)(sender)).ValidationGroup, out substId);

            Miami.Substitute.Bll.Preferred preferred = new Miami.Substitute.Bll.Preferred();
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();

            Dal.Job job = new Miami.Substitute.Dal.Job();
            job.LoadByPrimaryKeyBase(Convert.ToInt32(Request.QueryString["JobId"]));
            int locId = job.LocationId;

            preferred.DeleteForClerkSubstitute(locId, substId);

            if (((System.Web.UI.WebControls.CheckBox)(sender)).Checked)
                preferred.ClerkInsert(locId, substId);
        }

        //protected void SubstituteList_Action(object sender, CommonGridViewActionEventArgs e)
        //{
        //    int substituteId = Convert.ToInt32(SubstituteList.DataKeys[e.RowIndex].Value);
        //    int jobId = Convert.ToInt32(lblJobId.Text);
        //    Job job = new Job();
        //    ArrayList jobOverLaps = job.GetOverlap(jobId, substituteId);
        //    if (jobOverLaps.Count > 0)
        //    {
        //        for (int i = 0; i < jobOverLaps.Count; i++)
        //            job.DeleteSubstituteFromJob(Convert.ToInt32(jobOverLaps[i]), substituteId);
        //    }

        //    job.SetSubstitute(jobId, substituteId, 3);
        //    Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute(substituteId);

        //    NoticeSystem noticeSystem = new NoticeSystem(jobId, NoticeSystem.NoticeType.JobAcceptedByClerk, substitute.UserId, Micajah.Common.Security.UserContext.Current.UserId);
        //    noticeSystem.Send();
        //    Response.Redirect("Worksheet.aspx");
        //}
    }
}   