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
using Miami.Substitute.Bll;
using Telerik.WebControls;
using Micajah.Common.WebControls;

namespace Miami.Substitute.Web.Master
{
    public partial class FulFillJob : System.Web.UI.Page
    {
        protected ValidatedComboBox regCombo;

        void AddJob_ItemsRequested(object o, RadComboBoxItemsRequestedEventArgs e)
        {
            try
            {
                Miami.Substitute.Bll.Location location = new Location();

                DataView dv = location.GetLocationsByRegion(Convert.ToInt32(e.Text));
                if (dv != null)
                {
                    locaCombo.Items.Clear();
                    foreach (DataRow dr in dv.Table.Rows)
                        locaCombo.Items.Add(new RadComboBoxItem(dr["Name"].ToString(), dr["LocationId"].ToString()));
                }
            }
            catch { }
        }

        void InitTeacherDDL(string input_text, int numberOfItems)
        {
            input_text = input_text.Trim();
            if (input_text == string.Empty)
                return;

            (this.JobForm.FindControl("cbTeachers") as Telerik.WebControls.RadComboBox).Items.Clear();
            input_text = input_text.Replace("*", "[*]");
            DataView dv = new Miami.Substitute.Dal.User().SearchUserByName(input_text);
            if (dv != null)
            {
                int itemOffset = numberOfItems;
                int endOffset = itemOffset + 25;
                if (endOffset > dv.Count)
                    endOffset = dv.Count;

                Telerik.WebControls.RadComboBoxItem item;
                for (int i = itemOffset; i < endOffset; i++)
                {
                    DataRowView row = dv[i];
                    item = new Telerik.WebControls.RadComboBoxItem(row["Name"].ToString(), row["UserId"].ToString());
                    item.Value = row["UserId"].ToString();
                    (this.JobForm.FindControl("cbTeachers") as Telerik.WebControls.RadComboBox).Items.Add(item);
                }
            }
        }

        protected void cbTeachers_ItemsRequested(object o, Telerik.WebControls.RadComboBoxItemsRequestedEventArgs e)
        {
            this.InitTeacherDDL(e.Text, e.NumberOfItems);
            (this.JobForm.FindControl("cbTeachers") as Telerik.WebControls.RadComboBox).SelectedIndex = 0;
        }

        protected void cbTeachers_SelectedIndexChanged(object o, Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string chart = e.Text.Trim();
            if (chart != "")
            {
                DataView dv = new Miami.Substitute.Dal.User().SearchUserByName(chart);
                lblTeacherId.Text = dv[0]["UserId"].ToString();
            }
        }

        private ValidatedComboBox regaCombo;
        private ValidatedComboBox locaCombo;

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["lblLocationSelected"] = null;
            Session["lblStatusSelected"] = null;
            Session["lblDateSelectedTo"] = null;
            Session["lblDateSelected"] = null;
            Session["selLocationId"] = null;
            Session["IsFirstTime"] = null;
            Session["SortDefault"] = true;
            Session["SelectedRange"] = "all";

            try
            {
                if (JobForm.Visible)
                {
                    regaCombo = (this.JobForm.FindControl("regCombo") as ValidatedComboBox);
                    locaCombo = (this.JobForm.FindControl("locCombo") as ValidatedComboBox);

                    locaCombo.ItemsRequested += new RadComboBoxItemsRequestedEventHandler(AddJob_ItemsRequested);
                    locaCombo.SelectedIndexChanged += new RadComboBoxSelectedIndexChangedEventHandler(locaCombo_SelectedIndexChanged);

                    Label script = new Label();
                    script.Text = "<script>";
                    script.Text += "function LoadLocations(item){ var countriesCombo = " + locaCombo.ClientID + ";";
                    script.Text += "if (item.Index > 0) {   ";
                    script.Text += "countriesCombo.RequestItems(item.Value, false);}}";
                    script.Text += "</script> ";
                    plScript.Controls.Add(script);
                }
            }
            catch { }
        }

        void locaCombo_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            lblLocationId.Text = ((Telerik.WebControls.RadComboBox)(o)).Value;
        }

        void AddJob_ItemsRequestedRegion(object o, RadComboBoxItemsRequestedEventArgs e)
        {
            Miami.Substitute.Bll.Region region = new Region();
            DataView dv = region.LoadAllRegionForCombo();
            if (dv != null)
            {
                regaCombo.Items.Clear();
                foreach (DataRow dr in dv.Table.Rows)
                    regaCombo.Items.Add(new RadComboBoxItem(dr["Name"].ToString(), dr["RegionId"].ToString()));
            }
        }

        protected void JobForm_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            JobForm.Visible = false;
            JobFormView.Visible = true;
        }

        protected void JobForm_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void JobDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            Job job = new Job();
            lblJobId.Text = e.ReturnValue.ToString();
            JobFormView.DataSource = job.LoadByPrimaryKey(Convert.ToInt32(e.ReturnValue)).DataView;
            JobFormView.DataBind();

            lblAvailSubs.Visible = true;
            SubstituteList.Visible = true;
            SubstituteList.DataBind();
        }

        protected void SubstituteList_Action(object sender, CommonGridViewActionEventArgs e)
        {
            Job job = new Job();
            job.SetSubstitute(Convert.ToInt32(lblJobId.Text), Convert.ToInt32(((System.Web.UI.WebControls.GridView)(sender)).SelectedValue), 3);
            Response.Redirect("Default.aspx");
        }
    }
}