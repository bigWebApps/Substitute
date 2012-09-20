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
using Micajah.Common.WebControls;
using Micajah.Common.Application;
using System.Globalization;

public partial class UpdateUserModal : System.Web.UI.Page
{
    private int JobId
    {
        get
        {
            int jobId; int.TryParse(Request.QueryString["JobId"], out jobId);
            return jobId;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {        
        this.Master.VisibleHeader = false;
        this.Master.VisibleMainMenu = false;
        this.Master.VisibleBreadCrumbs = false;
        this.Master.VisibleLeftArea = false;
        this.Master.VisibleApplicationLogo = false;
        this.Master.VisiblePageTitle = false;
        this.Master.VisibleFooter = false;
        MagicForm.ApplyColorScheme(UpdateJobTable, WebApplicationSettings.DefaultColorScheme);

        ClientScript.RegisterStartupScript(Page.GetType(), "LogoDivRemove", "document.getElementById('LogoDiv').style.visibility = 'hidden';", true);        
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job(JobId);
        Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute(job.m_substituteId);

        Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
        DataView userView = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);

        string confirmNote = String.Format("Confirmed by Clerk {0} on {1} {2}", userView[0]["FirstName"].ToString().Trim() + " " + userView[0]["LastName"].ToString().Trim(), DateTime.Now.ToShortDateString(), DateTime.Now.ToShortTimeString());
        job.ConfirmJob(JobId, substitute.SubstituteId, 2, confirmNote + " " + Notes.Text);

        ClientScript.RegisterStartupScript(Page.GetType(), "WorksheetCloseAndRebindScript", "CloseAndRebind();", true);
    }

    protected void CancelButton_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(Page.GetType(), "WorksheetCancelEditScript", "CancelEdit();", true);
    }
}
