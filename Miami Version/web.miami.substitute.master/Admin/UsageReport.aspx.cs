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

public partial class Admin_UsageReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            System.Globalization.DateTimeFormatInfo d = new System.Globalization.DateTimeFormatInfo();

            for (int i = 0; i < 12; i++)
                MonthList.Items.Add(new ListItem(d.MonthNames[i], (i+1).ToString()));
            YearList.Items.Add(new ListItem(DateTime.Now.Year.ToString(), DateTime.Now.Year.ToString()));
            YearList.Items.Add(new ListItem(DateTime.Now.AddYears(-1).Year.ToString(), DateTime.Now.AddYears(-1).Year.ToString()));
            MonthList.SelectedValue = DateTime.Now.Month.ToString();
            YearList.SelectedValue = DateTime.Now.Year.ToString();
            ByDayLink.Font.Bold = true;
            ByLocationPanel.Visible = false;            
        }
    }

    protected void UsageReport_ItemDataBound(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        if (e.Item.ItemType == Telerik.WebControls.GridItemType.Item || e.Item.ItemType == Telerik.WebControls.GridItemType.AlternatingItem)
        {
            DateTime date = Convert.ToDateTime(e.Item.Cells[2].Text);
            e.Item.Cells[2].Text = date.ToString("MM/dd/yyyy").Replace('.','/');
        }
    }

    protected void SelectButton_Click(object sender, EventArgs e)
    {
        UsageReportByLocation.DataBind();
    }

    protected void ByDayLink_Click(object sender, EventArgs e)
    {
        ByDayLink.Font.Bold = true;
        ByLocationLink.Font.Bold = false;
        ByDayPanel.Visible = true;
        ByLocationPanel.Visible = false;
    }

    protected void ByLocationLink_Click(object sender, EventArgs e)
    {
        ByDayLink.Font.Bold = false;
        ByLocationLink.Font.Bold = true;
        ByDayPanel.Visible = false;
        ByLocationPanel.Visible = true;
    }
}
