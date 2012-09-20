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
using System.Drawing;

namespace Miami.Substitute.Web
{
    public partial class UpdateLocation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.CustomName = (string)GetLocalResourceObject("CustomName");
        }

        protected void CheckChanged(Object sender, System.EventArgs e)
        {
            ((sender as CheckBox).Parent.Parent as GridItem).Selected = true;
            if (LocationGrid.SelectedValue != null)
            {
                Miami.Substitute.Bll.Preferred preferred = new Miami.Substitute.Bll.Preferred();
                if (((CheckBox)sender).Checked)
                {
                    if ((((sender as CheckBox).Parent.Parent as GridItem)).OwnerTableView.DataKeyNames[0] == "RegionId")
                    {
                        Miami.Substitute.Bll.Location location = new Miami.Substitute.Bll.Location();
                        DataView locs = location.LoadAllLocation(Convert.ToInt16(LocationGrid.SelectedValue));

                        preferred.DeleteByRegion(Convert.ToInt16(LocationGrid.SelectedValue));

                        foreach (DataRowView dr in locs)
                            preferred.Insert(Convert.ToInt32(dr["LocationId"]));

                        LocationGrid.DataBind();
                    }
                    else
                        preferred.Insert(Convert.ToInt32(LocationGrid.SelectedValue));
                }
                else
                {
                    if ((((sender as CheckBox).Parent.Parent as GridItem)).OwnerTableView.DataKeyNames[0] == "RegionId")
                    {
                        Miami.Substitute.Bll.Location location = new Miami.Substitute.Bll.Location();
                        preferred.DeleteByRegion(Convert.ToInt16(LocationGrid.SelectedValue));
                        LocationGrid.DataBind();
                    }
                    else
                        preferred.Delete(Convert.ToInt32(LocationGrid.SelectedValue));
                }
            }
        }

        protected void LocationGrid_PreRender(object sender, EventArgs e)
        {
            if (IsFirst.Text == "True")
            {
                foreach (GridDataItem gdi in ((Telerik.WebControls.RadGrid)(sender)).Items)
                {
                    int countItems = 0;
                    int countSelected = 0;
                    if (((Telerik.WebControls.GridItem)(gdi)).HasChildItems)
                        foreach (GridDataItem gdiDetails in gdi.ChildItem.NestedTableViews[0].Items)
                        {
                            ((System.Web.UI.WebControls.CheckBox)(gdiDetails.Cells[2].Controls[1])).Checked = Convert.ToBoolean(gdiDetails.Cells[5].Text);
                            gdiDetails.Selected = Convert.ToBoolean(gdiDetails.Cells[5].Text);
                            countItems++;
                            if (gdiDetails.Selected)
                                countSelected++;
                        }
                    ((System.Web.UI.WebControls.CheckBox)(gdi.Cells[2].Controls[1])).Checked = Convert.ToBoolean(gdi.Cells[5].Text);
                    gdi.Selected = false; //Convert.ToBoolean(gdi.Cells[4].Text);
                    gdi.Expanded = false;
                    if (gdi.HasChildItems)
                        gdi.Cells[3].Text = "(" + countItems.ToString() + "/" + countSelected.ToString() + ")";

                    if (countSelected > 0 && countSelected != countItems)
                    {
                        ((System.Web.UI.WebControls.CheckBox)(gdi.Cells[2].Controls[1])).BorderColor = Color.Gray;
                        ((System.Web.UI.WebControls.CheckBox)(gdi.Cells[2].Controls[1])).BorderWidth = new Unit(1);
                        ((System.Web.UI.WebControls.CheckBox)(gdi.Cells[2].Controls[1])).BorderStyle = BorderStyle.Solid;
                    }

                }
                IsFirst.Text = "False";
            }
            else
            {
                foreach (GridDataItem gdi in ((Telerik.WebControls.RadGrid)(sender)).Items)
                {
                    int countItems = 0;
                    int countSelected = 0;
                    if (((Telerik.WebControls.GridItem)(gdi)).HasChildItems)
                        foreach (GridDataItem gdiDetails in gdi.ChildItem.NestedTableViews[0].Items)
                        {
                            countItems++;
                            if (Convert.ToBoolean(gdiDetails.Cells[5].Text))
                                countSelected++;
                        }
                    gdi.Selected = false;
                    if (gdi.HasChildItems)
                        gdi.Cells[3].Text = "(" + countItems.ToString() + "/" + countSelected.ToString() + ")";
                }
            }
        }

        protected void btnSaveSelected_Click(object sender, EventArgs e)
        {
            string value = String.Empty;
            ArrayList regions = new ArrayList();
            ArrayList locations = new ArrayList();

            foreach (GridDataItem gdi in ((Telerik.WebControls.RadGrid)(LocationGrid)).Items)
            {
                if (((Telerik.WebControls.GridItem)(gdi)).HasChildItems)
                    foreach (GridDataItem gdiDetails in gdi.ChildItem.NestedTableViews[0].Items)
                    {
                        if (((System.Web.UI.WebControls.CheckBox)(gdiDetails.Cells[2].Controls[1])).Checked)
                            locations.Add(gdiDetails.Cells[4].Text);
                    }
                if (((System.Web.UI.WebControls.CheckBox)(gdi.Cells[2].Controls[1])).Checked)
                    regions.Add(gdi.Cells[4].Text);
            }


            Miami.Substitute.Bll.Preferred preferred = new Miami.Substitute.Bll.Preferred();
            Miami.Substitute.Bll.Location location = new Miami.Substitute.Bll.Location();

            preferred.DeleteForSubstitute();

            for (int i = 0; i < locations.Count; i++)
            {
                int val = Convert.ToInt32(locations[i]);
                preferred.Insert(val);
            }

            for (int i = 0; i < regions.Count; i++)
            {
                int val = Convert.ToInt32(regions[i]);
                preferred.DeleteByRegion(val);
                DataView locs = location.LoadAllLocation(val);
                if (locs != null)
                    foreach (DataRowView dr in locs)
                        preferred.Insert(Convert.ToInt32(dr["LocationId"]));
            }

            Response.Redirect("Default.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}