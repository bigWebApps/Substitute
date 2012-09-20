using System;
using System.Security.Authentication;

namespace Miami.Substitute.Web
{
    public class LoginProvider : Micajah.Common.Bll.Providers.LoginProvider
    {
        #region Overriden Methods

        public override bool Authenticate(string loginName, string password, bool usePasswordEncryption, params object[] details)
        {
            Miami.Substitute.Dal.User usr = new Miami.Substitute.Dal.User();
            if (!usr.UserIsSubstitute(loginName))
                throw new AuthenticationException(Resources.Resource.LoginProvider_UserIsNotSubstitute);

            return base.Authenticate(loginName, password, usePasswordEncryption, details);
        }

        #endregion
    }
}