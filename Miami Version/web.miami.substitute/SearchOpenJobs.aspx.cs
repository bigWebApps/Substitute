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

namespace Miami.Substitute.Web
{
    public partial class SearchOpenJobs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Miami.Substitute.Bll.Preferred preferred = new Miami.Substitute.Bll.Preferred();
            VisibleControls(preferred.IsPreferredExists);
            Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job();
            lblLegend.Text = String.Empty;
            JobList.DataSource = job.SearchOpenJobs(drJobs.DateStart, drJobs.DateEnd, tbJobs.Value);
            JobList.DataBind();
            Highlight();
        }

        protected void Highlight()
        {
            Miami.Substitute.Dal.SubstituteExceptions DalSubstitute = new Miami.Substitute.Dal.SubstituteExceptions();
            Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job();
            Label appliedLabel = new Label();
            appliedLabel.Text = "&nbsp;&nbsp;(Applied)";
            appliedLabel.Font.Bold = true;
            appliedLabel.ForeColor = System.Drawing.Color.Green;
            foreach (GridViewRow gvr in JobList.Rows)
            {
                int overlap = Convert.ToInt32(((System.Data.DataView)(JobList.DataSource)).Table.Rows[gvr.RowIndex]["Overlap"]);
                if (overlap == 0)
                {
                    int jobId = Convert.ToInt32(JobList.DataKeys[gvr.RowIndex].Value);
                    if (job.LoadSubstituteJob(jobId))
                        gvr.Cells[0].Controls.Add(appliedLabel);
                }
                else
                {
                    gvr.Cells[0].BackColor = System.Drawing.Color.FromArgb(255, 111, 111);
                }

                if (DalSubstitute.IsOverlapped(Micajah.Common.Security.UserContext.Current.UserId, Convert.ToDateTime(gvr.Cells[1].Text), Convert.ToDateTime(gvr.Cells[2].Text)))
                {
                    ((System.Web.UI.WebControls.WebControl)(gvr.Cells[0].Controls[0])).ToolTip = GetLocalResourceObject("ToolTip_Availability").ToString();
                    ((System.Web.UI.WebControls.WebControl)(gvr.Cells[1])).ForeColor = System.Drawing.Color.DarkOrange;
                    ((System.Web.UI.WebControls.WebControl)(gvr.Cells[2])).ForeColor = System.Drawing.Color.DarkOrange;

                    if (lblLegend.Text.Length == 0)
                        lblLegend.Text = gvr.Cells[1].Text + GetLocalResourceObject("ToolTip_Highlighted").ToString();
                }
            }
        }

        protected void btnJobs_Click(object sender, EventArgs e)
        {
            Miami.Substitute.Bll.Job job = new Miami.Substitute.Bll.Job();
            JobList.DataSource = job.SearchOpenJobs(drJobs.DateStart, drJobs.DateEnd, tbJobs.Value);
            JobList.DataBind();
            Highlight();
        }

        private void VisibleControls(bool visible)
        {
            tblSearch.Visible = visible;
            JobList.Visible = visible;
            OverlapCaptionPanel.Visible = visible;
            lblError.Visible = !visible;
            lblError2.Visible = !visible;
            lnkClickHere.Visible = !visible;
        }

        protected void JobList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect("JobView.aspx?JobId=" + JobList.SelectedValue.ToString());
        }
    }
}