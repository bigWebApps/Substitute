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
using System.Web.Mail;

namespace Miami.Substitute.Web
{
    public partial class JobView : System.Web.UI.Page
    {
        private int jobId = 0;
        private int substituteId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["JobId"] != null)
                jobId = Convert.ToInt32(Request.QueryString["JobId"]);

            Dal.SubstituteExceptions substituteExceptions = new Miami.Substitute.Dal.SubstituteExceptions();

            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            substituteId = substitute.SubstituteId;

            Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job();
            job.LoadByPrimaryKeyBase(jobId);            

            bool isApplied = job.LoadSubstituteJob(jobId, substituteId);
            lbApply.Visible = !isApplied;
            lblApplyHelpText.Visible = isApplied;            

            bool overlap = job.IsOverlap(jobId, substituteId);
            bool overlapExceptions = substituteExceptions.IsOverlapped(substitute.UserId, job.DatetimeStart.Date, job.DatetimeEnd.Date);
            OverlapLabel.Visible = overlap;
            lblApplyHelpText.Visible = lblApplyHelpText.Visible & !overlap;
            lbApply.Enabled = lbApply.Enabled & !overlap;
            lbCancel.Visible = isApplied;
            if (overlapExceptions && lbApply.Enabled)
                lbApply.OnClientClick = (string)GetLocalResourceObject("OverlapConfirmText");

            orLiteral.Visible = ReturnJobsListLinkButton.Visible = lbApply.Visible;
        }

        protected void lbApply_Click(object sender, EventArgs e)
        {
            Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job();
            job.AddSubstituteToJob(jobId, substituteId);
            lbApply.Enabled = false;

            Miami.Substitute.Bll.NoticeSystem noticeSystem = new Miami.Substitute.Bll.NoticeSystem(jobId, Miami.Substitute.Bll.NoticeSystem.NoticeType.JobAppliedForBySubstitute, Micajah.Common.Security.UserContext.Current.UserId, 0);
            noticeSystem.Send();

            Response.Redirect("SearchOpenJobs.aspx");
        }

        protected void lbCancel_Click(object sender, EventArgs e)
        {
            Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job();
            job.LoadByPrimaryKeyBase(jobId);           
            if (job.m_statusId == 2) 
            {
                Miami.Substitute.Bll.NoticeSystem noticeSystem = new Miami.Substitute.Bll.NoticeSystem(jobId, Miami.Substitute.Bll.NoticeSystem.NoticeType.AcceptedJobCancelledBySubstitute, Micajah.Common.Security.UserContext.Current.UserId, 0);
                noticeSystem.Send();
            }

            job.DeleteSubstituteFromJob(jobId, substituteId);
            lbApply.Enabled = true;

            Response.Redirect("SearchOpenJobs.aspx");
        }
    }
}