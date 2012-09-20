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

namespace Miami.Substitute.Web
{
    public partial class DefaultPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["pageid"] != null) return;

            Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job();
            JobList.DataSource = job.SearchOpenJobs(DateTime.Now.Date.AddDays(-1), DateTime.Now.AddYears(10), 2);
            JobList.DataBind();

            DataView dv = job.SearchOpenJobs(DateTime.Now.Date.AddDays(-1), DateTime.Now.AddYears(10), 3);
            if (dv != null && dv.Count > 0)
            {
                ResponseGridView.DataSource = dv;
                ResponseGridView.DataBind();
            }
            else
            {
                ResponseGridView.Visible = false;
                lblResponseTitle.Visible = false;
            }
            

            Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
            dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
            if (Session["IsCounted"] == null || Convert.ToInt32(Session["IsCounted"]) == 0)
            {
                user.InsertUsage(2, Convert.ToInt32(dv[0]["LocationId"].ToString()));
                Session["IsCounted"] = 1;
            }

            dv.Table.Columns.Add("FullName", Type.GetType("System.String"));
            dv[0]["FullName"] = dv[0]["FirstName"] + " " + dv[0]["MiddleName"] + (String)(dv[0]["MiddleName"].ToString().Length > 0 ? ". " : "") + dv[0]["LastName"];

            dv.Table.Columns.Add("ContactInfo", Type.GetType("System.String"));
            dv[0]["ContactInfo"] = dv[0]["Address"] + "<br>" + dv[0]["Address2"] + "<br>" + dv[0]["Phone"] + "<br>" + dv[0]["EmailProfile"];

            dv.Table.Columns.Add("JobCode", Type.GetType("System.String"));
            dv[0]["JobCode"] = dv[0]["JobPosition"] + " / " + dv[0]["JobAssignmentDescription"];

            if (user.FirstName.Length > 0)
                lblName.Text = "Hi, " + Convert.ToString(user.FirstName[0].ToString().ToUpper() + user.FirstName.ToLower().Substring(1, user.FirstName.Length - 1)).TrimEnd(' ');

            dv.Table.Columns.Add("SubjectLevel", Type.GetType("System.String"));
            dv[0]["SubjectLevel"] = "<table border='0' cellspacing='0' cellpadding='0'>";
            //DataView dvCoverage = user.LoadCoverage(Micajah.Common.Security.UserContext.Current.UserId);
            //if (dvCoverage != null && dvCoverage.Table != null && dvCoverage.Table.Rows.Count > 0)
            //{
            //    foreach (DataRow dr in dvCoverage.Table.Rows)
            //    {
            //        if (!dr.IsNull("SubjectName") && !dr.IsNull("LevelName") && !dr.IsNull("ExpireYear") != null)
            //            dv[0]["SubjectLevel"] += "<tr><td><b>" + dr["SubjectName"].ToString() + "</b></td><td><b>&nbsp;/&nbsp;</b></td><td><b>" + dr["LevelName"].ToString() + "</b></td><td><b>&nbsp;/&nbsp;</b></td><td><b>" + dr["ExpireYear"].ToString() + "</b></td></tr>";
            //    }
            //}
            dv[0]["SubjectLevel"] += "</table>";

            ViewProfile.DataSource = dv;
            ViewProfile.DataBind();

            Master.VisibleLeftArea = false;
            Master.VisibleMainMenu = false;
            Master.VisiblePageTitle = false;
            Master.VisibleBreadCrumbs = false;
        }

        protected void Accept_Command(object sender, CommandEventArgs e)
        {
            int jobId; int.TryParse(e.CommandArgument.ToString(), out jobId);
            Bll.Substitute substitute = new Bll.Substitute();
            substitute.LoadByUserId(Micajah.Common.Security.UserContext.Current.UserId);
            Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
            DataView userView = user.LoadForMain(substitute.UserId);
            string confirmNote = String.Format("Confirmed by Substitute {0} on {1} {2}", userView[0]["FirstName"].ToString().Trim() + " " + userView[0]["LastName"].ToString().Trim(), DateTime.Now.ToShortDateString(), DateTime.Now.ToShortTimeString());
            (new Bll.Job()).ConfirmJob(jobId, substitute.SubstituteId, 2, confirmNote);
            Response.Redirect("Default.aspx");
        }

        protected void Decline_Command(object sender, CommandEventArgs e)
        {
            int jobId; int.TryParse(e.CommandArgument.ToString(), out jobId);
            Bll.Substitute substitute = new Bll.Substitute();
            substitute.LoadByUserId(Micajah.Common.Security.UserContext.Current.UserId);
            (new Bll.Job()).ConfirmJob(jobId, substitute.SubstituteId, 1, string.Empty);
            Response.Redirect("Default.aspx");
        }

        protected void JobList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            int jobId; int.TryParse(JobList.DataKeys[e.RowIndex].Value.ToString(), out jobId);
            Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job();
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            job.DeleteSubstituteFromJob(jobId, substitute.SubstituteId);

            Miami.Substitute.Bll.NoticeSystem noticeSystem = new Miami.Substitute.Bll.NoticeSystem(jobId, Miami.Substitute.Bll.NoticeSystem.NoticeType.AcceptedJobCancelledBySubstitute, Micajah.Common.Security.UserContext.Current.UserId, 0);
            noticeSystem.Send();

            Response.Redirect("Default.aspx");
        }
    }
}