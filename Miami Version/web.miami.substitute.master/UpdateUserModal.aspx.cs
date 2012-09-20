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
    private int UserId
    {
        get
        {
            int userId; int.TryParse(Request.QueryString["UserId"], out userId);
            return userId;
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
        MagicForm.ApplyColorScheme(UpdateSubstituteTable, WebApplicationSettings.DefaultColorScheme);
        ClientScript.RegisterStartupScript(Page.GetType(), "LogoDivRemove", "document.getElementById('LogoDiv').style.visibility = 'hidden';", true);
        if (!IsPostBack)
        {
            Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
            DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
            int locationId; int.TryParse(dv[0]["LocationId"].ToString(), out locationId);

            if (UserId > 0 && locationId > 0)
            {
                DataRowView drv = user.LoadSubstituteForUpdate(UserId, locationId);
                AltPhone.Text = drv["AltPhone"].ToString();
                Notes.Text = drv["Note"].ToString();
                Preferred.Checked = Convert.ToBoolean(drv["IsClerkPreferred"]);
            }
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
        DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
        int locationId; int.TryParse(dv[0]["LocationId"].ToString(), out locationId);

        Miami.Substitute.Bll.Substitute subst = new Miami.Substitute.Bll.Substitute();
        subst.LoadByUserId(UserId);

        (new Miami.Substitute.Dal.User()).UpdateSubstitute(locationId, Micajah.Common.Security.UserContext.Current.UserId, subst.SubstituteId, Preferred.Checked, AltPhone.Text, Notes.Text);
        ClientScript.RegisterStartupScript(Page.GetType(), "CloseAndRebindScript", "CloseAndRebind();", true);

    }

    protected void CancelButton_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(Page.GetType(), "CancelEditScript", "CancelEdit();", true);
    }
}
