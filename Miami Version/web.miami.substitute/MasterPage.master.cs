using System;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using Miami.Substitute.Bll;
using System.Globalization;

namespace Miami.Substitute.Web
{
    public partial class MasterPage : Micajah.Common.Pages.MasterPage
    {
        protected override void OnInit(EventArgs e)
        {
            //            base.OnInit(e);
            Page.SmartNavigation = true;
            this.VisibleMainMenu = false;
            this.VisibleLeftArea = false;

            string script = "window.open(\"" + string.Format(CultureInfo.InvariantCulture, "http://miamiwstasub.litekb.com/?popup=true&a={0}", System.Web.HttpUtility.UrlEncodeUnicode(Page.Request.Url.PathAndQuery)).Replace("\"", "&quot;") + "\", '_blank', 'location=0,menubar=0,resizable=1,scrollbars=1,status=0,titlebar=0,toolbar=0,top=' + Mp_GetPopupPositionY(event) + ',left=' + Mp_GetPopupPositionX(675)  + ',width=675,height=634');return false;";
            helpLink.Attributes["onClick"] = script;

            string resourceName = this.Page.Request.RawUrl.Replace(Page.Request.ApplicationPath + "/", string.Empty);
            if (GetLocalResourceObject(resourceName) != null)
            {
                videoRadToolTip.Visible = videoLink.Visible = videoLiteral.Visible = embeddedVideo.Visible = true;
                embeddedVideo.Text = (string)GetLocalResourceObject(resourceName);
            }
        }
    }
}