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
    public partial class AddSubstitute : System.Web.UI.Page
    {
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            int id;
            int.TryParse(tbEmployeeId.Text, out id);
            DataView dv = substitute.SearchSubstitute(id);
            SubstituteList.Visible = true;
            SubstituteList.DataSource = dv;
            SubstituteList.DataBind();

        }

        protected void btnSearchName_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(tbEmployeeName.Text))
            {
                Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
                DataView dv = substitute.SearchSubstitute(tbEmployeeName.Text);
                SubstituteList.Visible = true;
                SubstituteList.DataSource = dv;
                SubstituteList.DataBind();
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["LocationId"] == null)
                Response.Redirect("PrintLocation.aspx");
        }

        protected void SubstituteList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(SubstituteList.SelectedValue.ToString()))
            {
                Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
                int id;
                int.TryParse(SubstituteList.SelectedValue.ToString(), out id);
                int locationId;
                int.TryParse(Request.QueryString["LocationId"].ToString(), out locationId);
                substitute.LoadByUserId(id);
                substitute.AddSubstituteToList(locationId);
                Response.Redirect("PrintLocation.aspx");
            }
        }
    }
}