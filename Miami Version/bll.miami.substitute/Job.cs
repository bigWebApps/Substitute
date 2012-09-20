using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using Miami.Substitute.Dal;
using Miami.Substitute.Dal.Generated;
using NCI.EasyObjects;
using System.Collections;

namespace Miami.Substitute.Bll
{
    [DataObjectAttribute(true)]
    public class Job : DataObject
    {
        #region Members

        private Miami.Substitute.Dal.Job m_DalJob;
        private int m_JobId;
        public int m_locationId;
        private int m_subtypeId;
        public int m_substituteId;
        public string m_teacher;
        private int m_gradeId;
        public int m_statusId = 1;
        private DateTime m_datetimeStart;
        private DateTime m_datetimeEnd;
        private string m_room = String.Empty;
        private string m_note = String.Empty;
        private string m_subject = String.Empty;

        #endregion

        #region Constructors

        public Job()
        {
        }

        public Job(int jobId)
        {
            LoadByPrimaryKeyBase(jobId);
        }

        #endregion

        #region Private Properties

        public DateTime DatetimeStart
        {
            get { return m_datetimeStart; }
        }

        public DateTime DatetimeEnd
        {
            get { return m_datetimeEnd; }
        }

        public string Note
        {
            get { return m_note; }
        }

        #endregion

        #region Private Properties

        public Miami.Substitute.Dal.Job DalJob
        {
            get
            {
                if (m_DalJob == null) m_DalJob = new Miami.Substitute.Dal.Job();
                return m_DalJob;
            }
        }

        private void LoadEntity()
        {
            try
            {
                m_datetimeEnd = DalJob.DatetimeEnd;
                m_datetimeStart = DalJob.DatetimeStart;
                //m_gradeId = DalJob.GradeId;
                m_substituteId = DalJob.SubstituteId;
                m_locationId = DalJob.LocationId;
                m_JobId = DalJob.JobId;
                m_note = DalJob.Note;
                //m_room = DalJob.Room;
                m_statusId = DalJob.StatusId;
                //m_subtypeId = DalJob.SubtypeId;
                m_teacher = DalJob.Teacher;
                m_gradeId = DalJob.GradeId;
            }
            catch
            {
            }
        }

        #endregion

        #region Overriden Methods

        protected override void RefreshObject()
        {
            throw new System.NotImplementedException();
        }

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public int Insert(DateTime startDate, DateTime endDate, string Location, string Note, string Room, int Subtype, string teacher, int JobId, string Subject, int GradeId)
        {
            m_datetimeEnd = endDate;
            m_datetimeStart = startDate;
            m_locationId = Convert.ToInt32(Location);
            m_note = Note;
            m_room = Room;
            m_subtypeId = Subtype;
            m_teacher = teacher;
            m_subject = Subject;
            m_gradeId = GradeId;

            SetDirty();
            Update();

            (new Dal.User()).InsertUsage(3, Convert.ToInt32(Location));
            return m_JobId;
        }

        [DataObjectMethod(DataObjectMethodType.Update, true)]
        public void UpdateJob(string teacher, string Location, string JobId, DateTime DatetimeStart, DateTime DatetimeEnd, string Room, string SubtypeId, string Note, string Subject, int GradeId)
        {
            m_JobId = Convert.ToInt32(JobId);
            m_datetimeEnd = DatetimeEnd;
            m_datetimeStart = DatetimeStart;
            m_locationId = Convert.ToInt32(Location);
            m_note = Note;
            m_room = Room;
            m_subtypeId = Convert.ToInt32(SubtypeId);
            m_teacher = teacher;
            m_subject = Subject;
            m_gradeId = GradeId;

            SetDirty();
            Update();
        }

        public void SetSubstitute(int jobId, int substituteId, int status)
        {
            DalJob.SetSubstitute(jobId, substituteId, status);
            Miami.Substitute.Dal.User user = new Miami.Substitute.Dal.User();
            DataView dv = user.LoadForMain(Micajah.Common.Security.UserContext.Current.UserId);
            (new Dal.User()).InsertUsage(4, Convert.ToInt32(dv[0]["LocationId"].ToString()));
        }

        public void ConfirmJob(int jobId, int substituteId, int status, string confirmNote)
        {
            DalJob.ConfirmJob(jobId, substituteId, status, confirmNote);

            NoticeSystem.NoticeType type;
            if (status == 2)
                type = NoticeSystem.NoticeType.JobConfirmedBySubstitute;
            else
                type = NoticeSystem.NoticeType.JobDeclinedBySubstitute;

            Substitute substitute = new Substitute(substituteId);
            NoticeSystem noticeSystem = new NoticeSystem(jobId, type, substitute.UserId, 0);
            noticeSystem.Send();
        }

        public bool LoadSubstituteJob(int jobId)
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            return DalJob.LoadJobSubstitute(jobId, substitute.SubstituteId);
        }

        public bool LoadSubstituteJob(int jobId, int substituteId)
        {
            return DalJob.LoadJobSubstitute(jobId, substituteId);
        }

        public void DeleteJob(int jobId)
        {
            DalJob.DeleteJob(jobId);
        }

        public bool AddSubstituteToJob(int jobId, int substituteId)
        {
            bool isExist = DalJob.LoadJobSubstitute(jobId, substituteId);
            if (!isExist)
                DalJob.AddSubstituteToJob(jobId, substituteId);

            return isExist;
        }

        public bool DeleteSubstituteFromJob(int jobId, int substituteId)
        {
            DalJob.DeleteSubstituteFromJob(jobId, substituteId);
            return true;
        }

        protected override void UpdateObject()
        {
            if (m_JobId > 0)
            {
                DalJob.LoadByPrimaryKeyBase(m_JobId);
            }
            else
            {
                DalJob.AddNew();
            }

            DalJob.DatetimeEnd = m_datetimeEnd;
            DalJob.DatetimeStart = m_datetimeStart;
            DalJob.Note = m_note;
            DalJob.LocationId = m_locationId;
            DalJob.Room = m_room;
            DalJob.StatusId = m_statusId;
            DalJob.SubtypeId = m_subtypeId;
            DalJob.Teacher = m_teacher;
            DalJob.Subject = m_subject;
            DalJob.GradeId = m_gradeId;
            DalJob.Save();

            if (m_JobId == 0)
                m_JobId = DalJob.JobId;
        }

        protected override bool CanRefresh()
        {
            return (m_JobId > 0);
        }

        #endregion

        #region Public Methods

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAllJob()
        {
            if (DalJob.LoadAll())
            {
                return DalJob.DefaultView;
            }
            else throw new ArgumentException();
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAllJob(int locationId, int statusId, string selectedDate, string selectedDateTo)
        {
            if (DalJob.LoadAll(locationId, statusId, selectedDate, selectedDateTo))
            {
                return DalJob.DefaultView;
            }
            else
                return null;
        }

        public DataRowView LoadLastJobBySubstitute(int substituteId)
        {
            if (DalJob.LoadLastJobBySubstitute(substituteId))
            {
                DalJob.DefaultView[0]["TimeWorks"] = DalJob.DefaultView.Count.ToString();
                return DalJob.DefaultView[0];
            }
            else
                return null;
        }

        public bool IsOverlap(int jobId, int substituteId)
        {
            return DalJob.GetOverlap(jobId, substituteId) & DalJob.DefaultView.Table.Rows.Count > 0;
        }

        public bool IsOverlap(int substituteId, DateTime day)
        {
            return DalJob.GetOverlap(substituteId, day) & DalJob.DefaultView.Table.Rows.Count > 0;
        }

        public ArrayList GetOverlap(int jobId, int substituteId)
        {
            ArrayList overlap = new ArrayList();
            if (DalJob.GetOverlap(jobId, substituteId) && DalJob.DefaultView.Table.Rows.Count > 0)
            {
                foreach (DataRow dr in DalJob.DefaultView.Table.Rows)
                    overlap.Add(dr["JobId"]);
            }

            return overlap;
        }

        public DataView LoadOpenJobs()
        {
            if (DalJob.LoadOpenJobs())
            {
                return (DalJob.DefaultView);
            }
            else
                return null;
        }


        public DataView SearchOpenJobs(DateTime from, DateTime to, string locName)
        {
            locName = locName == "" ? "0" : locName;
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            if (DalJob.SearchOpenJobs(from, to, locName, substitute.SubstituteId, Micajah.Common.Security.UserContext.Current.UserId))
                return (DalJob.DefaultView);
            else
                return null;
        }

        public DataView SearchOpenJobsAll(DateTime from, DateTime to)
        {
            if (DalJob.SearchOpenJobs(from, to, "0", 0, Micajah.Common.Security.UserContext.Current.UserId))
                return (DalJob.DefaultView);
            else
                return null;
        }

        public DataView SearchOpenJobs(DateTime from, DateTime to, int status)
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            if (DalJob.SearchOpenJobs(from, to, substitute.SubstituteId, status))
                return (DalJob.DefaultView);
            else
                return null;
        }

        public DataView GetSubTypes()
        {
            if (DalJob.GetSubTypes())
                return (DalJob.DefaultView);
            else
                return null;
        }

        public DataView GetSubTypesForReport()
        {
            if (DalJob.GetSubTypesForReport())
                return (DalJob.DefaultView);
            else
                return null;
        }

        public DataView GetGrades()
        {
            if (DalJob.GetGrades())
                return (DalJob.DefaultView);
            else
                return null;
        }

        public DataView GetTimes()
        {
            if (DalJob.GetTimes())
                return (DalJob.DefaultView);
            else
                return null;
        }

        public DataRowView LoadByPrimaryKey(int jobId)
        {
            if (DalJob.LoadByPrimaryKey(jobId))
            {
                LoadEntity();
                DalJob.DefaultView.Table.Columns.Add("DateRange");
                DateTime start;
                DateTime end;
                foreach (DataRow dr in DalJob.DefaultView.Table.Rows)
                {
                    start = Convert.ToDateTime(dr["DatetimeStart"]);
                    end = Convert.ToDateTime(dr["DatetimeEnd"]);
                    dr["DateRange"] = start.ToShortDateString() + " (" + start.DayOfWeek.ToString() + ") - " + end.ToShortDateString() + " (" + end.DayOfWeek.ToString() + ")";
                }
                return (DalJob.DefaultView[0]);
            }
            else return null;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataRowView LoadByPrimaryKeyBase(int jobId)
        {
            if (DalJob.LoadByPrimaryKeyBase(jobId))
            {
                LoadEntity();
                return (DalJob.DefaultView[0]);
            }
            else return null;
        }
        #endregion
    }
}
