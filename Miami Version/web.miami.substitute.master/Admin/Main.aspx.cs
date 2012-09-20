using System;

namespace Miami.Substitute.Web.Master
{
    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.VisibleLeftArea = false;
            Master.VisibleMainMenu = false;
            Master.VisiblePageTitle = false;
            Master.VisibleBreadCrumbs = false;
        }
    }
}