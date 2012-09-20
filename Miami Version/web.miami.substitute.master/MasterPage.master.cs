using System;
using Micajah.Common.Bll;
using System.Globalization;
using Miami.Substitute.Bll;
using System.Web;

namespace Miami.Substitute.Web.Master
{
    public partial class MasterPage : Micajah.Common.Pages.MasterPage
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            Page.SmartNavigation = true;
            this.VisibleFooterLinks = false;
            this.VisibleMainMenu = false;
            this.VisibleLeftArea = false;
            AdminLink.Visible = AdminWrap.Visible = !IsDenied;

            string script = "window.open(\"" + PreserveDoubleQuote(string.Format(CultureInfo.InvariantCulture, "http://miamiwsta.litekb.com/?popup=true&a={0}", HttpUtility.UrlEncodeUnicode(Page.Request.Url.PathAndQuery))) + "\", '_blank', 'location=0,menubar=0,resizable=1,scrollbars=1,status=0,titlebar=0,toolbar=0,top=' + Mp_GetPopupPositionY(event) + ',left=' + Mp_GetPopupPositionX(675)  + ',width=675,height=634');return false;";
            helpLink.Attributes["onClick"] = script;

            string resourceName = this.Page.Request.RawUrl.Replace(Page.Request.ApplicationPath+"/", string.Empty);
            if (GetLocalResourceObject(resourceName) != null)
            {
                videoLink.Visible = videoLiteral.Visible = true;
                embeddedVideo.Text = (string)GetLocalResourceObject(resourceName);
            }            
        }

        protected string PreserveDoubleQuote(string value)
        {
            if (!string.IsNullOrEmpty(value)) return value.Replace("\"", "&quot;");
            return value;            
        }

        protected bool IsDenied
        {
            get
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

        public static string GetOpenWindowScript(string url, string windowId)
        {
            return string.Format(CultureInfo.InvariantCulture, "javascript:radopen('{0}', '{1}');return false;", url, windowId);
        }

    }
}