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
using Telerik.WebControls;

namespace Miami.Substitute.Web.Master
{
    public partial class SubstituteList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PartTimeSelectBox.Items.Add(new RadComboBoxItem("All Substitutes", ""));
                PartTimeSelectBox.Items.Add(new RadComboBoxItem("Show All", "All"));
                PartTimeSelectBox.Items.Add(new RadComboBoxItem("Part-time Teachers", "Yes"));
                PartTimeSelectBox.Items.Add(new RadComboBoxItem("No Part-time Teachers", "No"));
            };
        }

        protected void cbFilter_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            UpdateSubstituteListReport();
        }

        protected void lbSearch_Click(object sender, EventArgs e)
        {
            UpdateSubstituteListReport();
        }

        protected void UpdateSubstituteListReport()
        {
            if (cbFilter.Value.Length == 0)
                cbFilter.Value = "0";            
            SubstituteListReport.DataBind();
        }
    }
}