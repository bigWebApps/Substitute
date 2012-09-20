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
using System.ComponentModel;

namespace Miami.Substitute.Web.Master
{
    public partial class MailLogsControl : System.Web.UI.UserControl
    {
        protected bool isAdmin = false;

        [Browsable(true)]
        public bool IsAdmin
        {
            get
            {
                return isAdmin;
            }
            set
            {
                isAdmin = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (MailLogList.Items.Count == 0)
                    RadToolTipManager1.Enabled = false;
                Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
                DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
                DefaultLocationLabel.Text = "Location: <b>" + dv[0]["LocationName"] + "</b><br>Region: <b>" + dv[0]["RegionName"] + "</b>";

                SMTPServerLabel.Text = "SMTP Server: <b>" + System.Configuration.ConfigurationManager.AppSettings["SmtpServer"] + "</b>";
                MailModeLabel.Text = "Mode: ";
                if (Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["UseTestEmailAddress"]))
                    MailModeLabel.Text += "<b>Test</b>";
                else
                    MailModeLabel.Text += "<b>Live</b>";

                DefaultLocationLabel.Visible = !IsAdmin;
            }
        }

        protected void OnAjaxUpdate(object sender, Telerik.Web.UI.ToolTipUpdateEventArgs args)
        {
            int index = args.TargetControlID.LastIndexOf("_");
            string elementID = args.TargetControlID.Substring(index + 1);
            this.UpdateToolTip(args.Value, args.UpdatePanel);
        }

        private void UpdateToolTip(string value, UpdatePanel panel)
        {
            int mailLogId; int.TryParse(value, out mailLogId);
            Dal.MailLog mailLog = new Miami.Substitute.Dal.MailLog();
            mailLog.LoadByPrimaryKey(mailLogId);
            Label message = new Label();
            message.Text = mailLog.Message;
            panel.ContentTemplateContainer.Controls.Add(message);
        }

        protected void MailLogList_DataBound(object sender, EventArgs e)
        {
            int mailLogId;
            foreach (Telerik.WebControls.GridDataItem dgi in MailLogList.Items)
            {
                mailLogId = Convert.ToInt32(dgi.KeyValues.Split('"')[1]);
                RadToolTipManager1.TargetControls.Add(dgi.FindControl("MessageLink").ClientID, mailLogId.ToString(), true);
            }
        }

        protected void MailLogDataSource_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!IsAdmin)
            {
                Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
                DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
                e.InputParameters["LocationId"] = dv[0]["LocationId"];
            }
        }
    }
}