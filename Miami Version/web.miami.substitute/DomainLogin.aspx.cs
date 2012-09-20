using System;
using System.Data;
using System.Web;
using System.Web.Security;
using Micajah.Common.Bll;
using Micajah.Common.Application;
using System.Globalization;

namespace Miami.Substitute.Web
{
    public partial class DomainLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Micajah.Common.Security.UserContext.Current != null && Micajah.Common.Security.UserContext.Current.UserId > 0)
                    Response.Redirect("~/default.aspx");

                string[] parts = this.Request.LogonUserIdentity.Name.Split('\\');
                if (parts.Length > 1)
                {
                    string loginName = parts[1];
                    if (loginName.Length > 0)
                    {
                        if (WebApplication.LoginProvider.Authenticate(loginName, null, false))
                            Response.Redirect(EmbeddedResources.ActiveOrganizationPageVirtualPath);
                    }
                }
                FormsAuthentication.RedirectToLoginPage();
            }
            catch (Exception ex)
            {
                ErrorLabel.Text = Resources.Resource.LoginProvider_UserIsNotSubstitute;
                ErrorLabel.Visible = true;
                loginButton.Visible = true;
            }            
        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            FormsAuthentication.RedirectToLoginPage();
        }
}
}