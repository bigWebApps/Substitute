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
    public partial class EditTemplates : System.Web.UI.Page
    {
        protected void Templates_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            TemplateEditControl.TemplateId = Convert.ToInt32(e.CommandArgument);
            TemplateEditControl.Fill();
            TemplateEditControl.Visible = true;
            TemplateListPanel.Visible = false;
        }

        protected void TemplateEditControl_Action(object sender, EventArgs e)
        {
            Templates.DataBind();
            TemplateEditControl.Visible = false;
            TemplateListPanel.Visible = true;
        }
    }
}