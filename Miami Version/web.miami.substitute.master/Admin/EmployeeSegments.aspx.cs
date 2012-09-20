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

namespace Miami.Substitute.Web.Master
{
    public partial class EmployeeSegments : System.Web.UI.Page
    {
        private int userId
        {
            get
            {
                int id = 0;
                int.TryParse(Request.QueryString["UserId"], out id);
                return id;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && userId > 0)
            {
                Dal.User user = new Miami.Substitute.Dal.User();
                EmployeeSegmentsList.DataSource = user.GetEmployeeSegments(userId);
                EmployeeSegmentsList.DataBind();
            }

            Master.VisibleLeftArea = false;
            Master.VisibleMainMenu = false;
            Master.VisiblePageTitle = false;
            Master.VisibleBreadCrumbs = false;
            Master.VisibleApplicationLogo = false;
            Master.VisibleFooter = false;
            Master.VisibleHeader = false;
        }
    }
}