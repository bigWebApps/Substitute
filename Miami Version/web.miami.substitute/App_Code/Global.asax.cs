using System;
using Micajah.Common.Application;
using Micajah.Common.Security;
using System.Security.Permissions;
using System.Reflection;
using System.Data.SqlClient;
using System.ComponentModel;
using System.Configuration;
namespace Miami.Substitute.Web
{
    public class Global : WebApplication
    {
        #region Overriden Methods

        protected override void Application_Start(object sender, EventArgs e)        
        {
            Micajah.Common.Dal.TableAdapters.ITableAdapter adapter = WebApplication.OrganizationDataSetTableAdapters.UsersGroupsTableAdapter;
            adapter.SelectCommand.CommandText = "Mc_SelectAllUsersGroupsFiltered";
            adapter.SelectCommand.Parameters.Add(new System.Data.SqlClient.SqlParameter("GroupId", System.Data.SqlDbType.Int, 11, System.Data.ParameterDirection.Input, false, 0, 0, string.Empty, System.Data.DataRowVersion.Default, 2));
            
            base.Application_Start(sender, e);

            LoginSettings.LoginLabelText = Resources.Resource.LoginSettings_LoginLabelText;
            LoginSettings.PasswordLabelText = Resources.Resource.LoginSettings_PasswordLabelText;
            LoginSettings.LoginValidationExpression = string.Empty;

            Miami.Substitute.Dal.ConnectionStringProvider.ConnectionString = WebApplicationSettings.ConnectionString;

            WebApplication.LoginProvider = new LoginProvider();
        }

        protected override void Application_Error(object sender, EventArgs e)
        {
            Exception exc = Server.GetLastError().GetBaseException();
            Micajah.ErrorTrackerHelper2.Helper.ReportApplicationException(exc);
        }

        #endregion
    }
}