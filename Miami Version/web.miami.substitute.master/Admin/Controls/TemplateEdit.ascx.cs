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

namespace Miami.Substitute.Web.Master
{
    public partial class TemplateEditControl : System.Web.UI.UserControl
    {
        public event EventHandler<EventArgs> Action;

        public int TemplateId
        {
            get { return Convert.ToInt32(TemplateIdLabel.Text); }
            set { TemplateIdLabel.Text = value.ToString(); }
        }

        public void Fill()
        {
            Miami.Substitute.Dal.Template template = new Miami.Substitute.Dal.Template();
            template.LoadByPrimaryKey(TemplateId);
            TemplateNameLabel.Text = template.Header;
            TemplateText.Text = template.Text;
            DeleteButton.Enabled = TemplateText.Text.Length > 0;
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            if (TemplateId == 0) return;
            Miami.Substitute.Dal.Template template = new Miami.Substitute.Dal.Template();
            template.LoadByPrimaryKey(TemplateId);
            template.Text = TemplateText.Text;
            template.Save();            
            if (Action != null) Action(sender, e);
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            if (Action != null) Action(sender, e);
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            if (TemplateId == 0) return;
            Miami.Substitute.Dal.Template template = new Miami.Substitute.Dal.Template();
            template.LoadByPrimaryKey(TemplateId);
            template.Text = String.Empty;
            template.Save();    
            if (Action != null) Action(sender, e);
        }
    }
}