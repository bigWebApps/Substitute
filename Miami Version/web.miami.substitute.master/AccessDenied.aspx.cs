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

public partial class AccessDenied : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RACF.RACF_User racfUser = this.Context.User as RACF.RACF_User;
        MessageLabel.Text = "Your account " + racfUser.EmployeeNumber + " was not found in RACF, please contact your administrator.";
    }
}
