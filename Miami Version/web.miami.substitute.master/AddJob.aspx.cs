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
using Micajah.Common.Application;

namespace Miami.Substitute.Web.Master
{
    public partial class AddJob : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MagicForm.ApplyColorScheme(AddJobPanelTable, WebApplicationSettings.DefaultColorScheme);

            if (!IsPostBack)
            {
                Session["lblStatusSelected"] = 1;
                Session["lblDateSelectedTo"] = null;
                Session["lblDateSelected"] = null;
                Session["IsFirstTime"] = null;
                Session["SortDefault"] = true;
                Session["SelectedRange"] = "all";
                Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
                DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
                lblLocationId.Text = dv[0]["LocationId"].ToString();
                StartDate.MinDate = DateTime.Now.Date;
                EndDate.MinDate = DateTime.Now.Date;
                StartDate.SelectedDate = DateTime.Now.Date;
                StartTimePicker.TimeView.StartTime = new TimeSpan(1, 0, 0);
                StartTimePicker.TimeView.EndTime = new TimeSpan(22, 0, 0);
                StartTimePicker.TimeView.Interval = new TimeSpan(0, 15, 0);
                StartTimePicker.TimeView.Columns = 4;
                StartTimePicker.TimeView.Width = 280;
                StartTimePicker.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 7, 0, 0);
                EndTimePicker.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 17, 0, 0);
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            if (EndDate.IsEmpty)
            {
                EndDateValid.Text = string.Empty;
                EndDateRequired.Validate();
                EndDateValid.Text = "1";
            }
            else
            {
                Bll.Job job = new Job();
                int grade; int.TryParse(Grade.SelectedValue, out grade);
                int subtype; int.TryParse(Subtype.SelectedValue, out subtype);

                DateTime start = new DateTime(StartDate.SelectedDate.Value.Year, StartDate.SelectedDate.Value.Month, StartDate.SelectedDate.Value.Day, StartTimePicker.SelectedDate.Value.Hour, StartTimePicker.SelectedDate.Value.Minute, 0);
                DateTime end = new DateTime(EndDate.SelectedDate.Value.Year, EndDate.SelectedDate.Value.Month, EndDate.SelectedDate.Value.Day, EndTimePicker.SelectedDate.Value.Hour, EndTimePicker.SelectedDate.Value.Minute, 0);

                if (start > end)
                    end = start;

                job.Insert(start, end, lblLocationId.Text, Note.Text, Room.Text, subtype, Teacher.Text, 0, Subject.Text, grade);

                Response.Redirect("Worksheet.aspx");
            }
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Worksheet.aspx");
        }
    }
}