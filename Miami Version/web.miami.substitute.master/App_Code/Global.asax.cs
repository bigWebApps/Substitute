using System;
using System.Security.Authentication;
using System.Configuration;
using Micajah.Common.Application;
using Micajah.ErrorTrackerHelper2.ErrorTracker;

namespace Miami.Substitute.Web.Master
{
    public class Global : WebApplication
    {
        #region Overriden Methods

        protected override void Application_Start(object sender, EventArgs e)
        {

            Micajah.Common.Dal.TableAdapters.ITableAdapter adapter = WebApplication.OrganizationDataSetTableAdapters.UsersGroupsTableAdapter;
            adapter.SelectCommand.CommandText = "Mc_SelectAllUsersGroupsFiltered";
            adapter.SelectCommand.Parameters.Add(new System.Data.SqlClient.SqlParameter("GroupId", System.Data.SqlDbType.Int, 11, System.Data.ParameterDirection.Input, false, 0, 0, string.Empty, System.Data.DataRowVersion.Default, 3));
            Micajah.Common.Application.WebApplicationSettings.AuthenticationMode = System.Web.Configuration.AuthenticationMode.None;
            base.Application_Start(sender, e);
            Miami.Substitute.Dal.ConnectionStringProvider.ConnectionString = WebApplicationSettings.ConnectionString;
        }

        protected override void Application_Error(object sender, EventArgs e)
        {
            Exception exc = Server.GetLastError().GetBaseException();
            Micajah.ErrorTrackerHelper2.Helper.ReportApplicationException(exc);

            //RACF.RACF_User racfUser = this.Context.User as RACF.RACF_User;
            //if (!WebApplication.LoginProvider.LoginNameExists(racfUser.EmployeeNumber))
            //    Response.Redirect("AccessDenied.aspx");

            Exception exa = Server.GetLastError();
            Exception ex = exa.GetBaseException();
            Application.Add("ERROR_MESSAGE", ex.Message);
            Application.Add("ERROR_SOURCE", ex.Source);
        }

        protected override void Session_Start(object sender, EventArgs e)
        {
            base.Session_Start(sender, e);
            bool success = false;
            try
            {
                //RACF.RACF_User racfUser = this.Context.User as RACF.RACF_User;                
                //if (WebApplication.LoginProvider.LoginNameExists(racfUser.EmployeeNumber))
                //{
                //    success = WebApplication.LoginProvider.Authenticate(racfUser.EmployeeNumber, null, false);
                //    Session.Add("RacfLocation", racfUser.EmployeeLocation);
                //    Session.Add("RacfLocationName", racfUser.EmployeeLocation);
                //    Micajah.Common.Security.UserContext.Current.Add("RacfIsAdmin", racfUser.IsInRole("265"));

                    success = WebApplication.LoginProvider.Authenticate("000203", null, false);
                    Session.Add("RacfLocation", "41");
                    Session.Add("RacfLocationName", "test");
                //}
            }
            catch (AuthenticationException) { }

            if (success)
                Response.Redirect(Micajah.Common.Bll.EmbeddedResources.ActiveOrganizationPageVirtualPath);
            else
                Response.Redirect("AccessDenied.aspx");
        }

        #endregion
    }
}