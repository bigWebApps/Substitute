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
    public partial class EditJob : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MagicForm.ApplyColorScheme(AddJobPanelTable, WebApplicationSettings.DefaultColorScheme);

            if (!IsPostBack)
            {
                if (Page.Request.QueryString["JobId"] != null)
                    lblJobId.Text = Page.Request.QueryString["JobId"];

                Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
                DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
                lblLocationId.Text = dv[0]["LocationId"].ToString();

                Job job = new Job();
                //job.m_statusId
                job.LoadByPrimaryKeyBase(Convert.ToInt32(Page.Request.QueryString["JobId"]));
                Subtype.SelectedValue = job.DalJob.SubtypeId.ToString();
                Grade.SelectedValue = job.DalJob.GradeId.ToString();
                StartDate.SelectedDate = job.DalJob.DatetimeStart;
                EndDate.SelectedDate = job.DalJob.DatetimeEnd;
                StartTimePicker.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, job.DalJob.DatetimeStart.Hour, job.DalJob.DatetimeStart.Minute, 0);
                EndTimePicker.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, job.DalJob.DatetimeEnd.Hour, job.DalJob.DatetimeEnd.Minute, 0);
                Room.Text = job.DalJob.Room;
                Teacher.Text = job.DalJob.Teacher;
                Subject.Text = job.DalJob.Subject;
                Note.Text = job.DalJob.Note;
                StartDateValid.Text = "1";
                EndDateValid.Text = "1";

                EndDate.MinDate = StartDate.SelectedDate.Value;

                EditButton.Enabled
                    = Subtype.Enabled
                    = Grade.Enabled
                    = StartDate.Enabled
                    = EndDate.Enabled
                    = Room.Enabled
                    = Teacher.Enabled
                    = Subject.Enabled
                    = Note.Enabled
                    = job.m_statusId < 2;
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

                job.UpdateJob(Teacher.Text, lblLocationId.Text, lblJobId.Text, start, end, Room.Text, subtype.ToString(), Note.Text, Subject.Text, grade);

                Response.Redirect("Worksheet.aspx");
            }
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Worksheet.aspx");
        }
    }
}