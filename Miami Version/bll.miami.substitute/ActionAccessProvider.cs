using System;
using System.Collections.Generic;
using System.Text;
using Micajah.Common.Bll;
using System.Web;

namespace Miami.Substitute.Bll
{
    public class ActionAccessProvider : IAccessProvider<Action>
    {
        public bool AccessDenied(Action obj)        
        {
            return false;
            if (Micajah.Common.Security.UserContext.Current.ContainsKey("RacfIsAdmin") && Micajah.Common.Security.UserContext.Current["RacfIsAdmin"].ToString().Length > 0)
            {
                bool isAdmin; bool.TryParse(Micajah.Common.Security.UserContext.Current["RacfIsAdmin"].ToString(), out isAdmin);
                return !isAdmin;
            }
            else
                return true;
        }
    }
}
