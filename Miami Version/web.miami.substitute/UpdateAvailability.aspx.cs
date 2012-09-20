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
using Micajah.Common.WebControls;

namespace Miami.Substitute.Web
{
    public partial class UpdateAvailability : System.Web.UI.Page
    {
        private DataView acceptedJobs;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                FillCalendar();

            this.Master.VisiblePageTitle = false;

            if (Session["saved"] != null)
                lblSaved.Visible = true;
            else
                lblSaved.Visible = false;

            Session["saved"] = null;
        }

        private bool IsOverlapDay(DateTime day)
        {
            if (acceptedJobs != null)
            {
                foreach (DataRowView drv in acceptedJobs)
                {
                    DateTime startDate = Convert.ToDateTime(drv["DatetimeStart"]);
                    DateTime endDate = Convert.ToDateTime(drv["DatetimeEnd"]);
                    if  (
                            day.Year >= startDate.Year && day.Month >= startDate.Month && day.Day >= startDate.Day 
                            && day.Year <= endDate.Year && day.Month <= endDate.Month && day.Day <= endDate.Day
                        )
                        return true;
                }
            }
            return false;
        }

        private void FillCalendar()
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId(Micajah.Common.Security.UserContext.Current.UserId);

            ((DropDownList)AvailabilityForm.FindControl("availabilityTimeStart")).SelectedValue = substitute.AvailabilityTimeStart;
            ((DropDownList)AvailabilityForm.FindControl("availabilityTimeEnd")).SelectedValue = substitute.AvailabilityTimeEnd;

            Miami.Substitute.Bll.SubstituteExceptions subExceptions = new Miami.Substitute.Bll.SubstituteExceptions();
            DataView dv = subExceptions.LoadAllByUserId();
            if (dv != null)
                foreach (DataRowView drv in dv)
                    if (substitute.AvailabilityWeekDays.Contains((((int)(Convert.ToDateTime(drv["DateStart"]).DayOfWeek)) + 1).ToString()))
                        RadCalendarExceptions.SelectedDates.Add(new Telerik.WebControls.RadDate(Convert.ToDateTime(drv["DateStart"])));

            DateTime curDate = DateTime.Now.AddDays(-(DateTime.Now.Day - 1));
            Bll.Job job = new Miami.Substitute.Bll.Job();
            acceptedJobs = job.SearchOpenJobs(DateTime.Now, DateTime.Now.AddYears(10), 2);
            while (curDate < DateTime.Now.AddYears(1))
            {
                Telerik.WebControls.RadCalendarDay radCalendarDay = new Telerik.WebControls.RadCalendarDay();
                radCalendarDay.Date = curDate;
                if (IsOverlapDay(curDate))
                {
                    radCalendarDay.ItemStyle.CssClass= "overlap";
                    radCalendarDay.IsSelectable = false;
                }
                else if (curDate >= DateTime.Now && substitute.AvailabilityWeekDays.Contains((((int)(curDate.DayOfWeek))+1).ToString()))
                {
                    radCalendarDay.ItemStyle.ForeColor = System.Drawing.Color.Green;
                    radCalendarDay.IsSelectable = true;
                    radCalendarDay.IsDisabled = false;
                }
                else
                {
                    radCalendarDay.IsSelectable = false;
                    radCalendarDay.IsDisabled = true;
                }

                RadCalendarExceptions.SpecialDays.Add(radCalendarDay);
                curDate = curDate.AddDays(1);
            }
        }

        protected void WeekDaysList_Updating(object sender, ObjectDataSourceMethodEventArgs e)
        {
            if (e == null) return;
            e.InputParameters["availabilityTimeStart"] = ((DropDownList)AvailabilityForm.FindControl("availabilityTimeStart")).SelectedValue;
            e.InputParameters["availabilityTimeEnd"] = ((DropDownList)AvailabilityForm.FindControl("availabilityTimeEnd")).SelectedValue;
        }

        protected void AvailabilityForm_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            FillCalendar();
            Session["saved"] = true;
            Response.Redirect("UpdateAvailability.aspx");
        }

        protected void AvailabilityForm_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
                Response.Redirect("Default.aspx");
        }

        protected void btnSaveExceptions_Click(object sender, EventArgs e)
        {
            Miami.Substitute.Bll.SubstituteExceptions subExceptions = new Miami.Substitute.Bll.SubstituteExceptions();
            subExceptions.DeleteBySubstituteId();

            foreach (Telerik.WebControls.RadDate selDate in RadCalendarExceptions.SelectedDates)
                subExceptions.Insert(selDate.Date);

            Response.Redirect("UpdateAvailability.aspx");
        }
    }
}
