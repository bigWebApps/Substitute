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
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["pageid"] != null) return;

            Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
            DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId); 
            if (Session["IsCounted"] == null || Convert.ToInt32(Session["IsCounted"]) == 0)
            {
                user.InsertUsage(1, Convert.ToInt32(dv[0]["LocationId"].ToString()));
                Session["IsCounted"] = 1;
            }
            
            if (user.FirstName.Length > 0)
            {
                lblName.Text = "Hi, " + Convert.ToString(user.FirstName[0].ToString().ToUpper() + user.FirstName.ToLower().Substring(1, user.FirstName.IndexOf(' ')>1?user.FirstName.IndexOf(' '):user.FirstName.Length - 1)).TrimEnd(' ');
                DefaultLocationLabel.Text = dv[0]["RegionName"] + "&nbsp;&nbsp;>&nbsp;&nbsp;" + dv[0]["LocationName"];
            }

            Master.VisibleLeftArea = false;
            Master.VisibleMainMenu = false;
            Master.VisiblePageTitle = false;
            Master.VisibleBreadCrumbs = false;
        }
    }
}
