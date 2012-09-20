using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Data;
using Miami.Substitute.Dal;
using Miami.Substitute.Dal.Generated;
using NCI.EasyObjects;

namespace Miami.Substitute.Bll
{
    [DataObjectAttribute(true)]
    public class Substitute : DataObject
    {
        #region Members 

        private Miami.Substitute.Dal.Substitute m_DalSubstitute;
        private int m_SubstituteId;
        private int m_UserId;
        private string m_AvailabilityTimeStart;
        private string m_AvailabilityTimeEnd;
        private string m_AvailabilityWeekDays;

        #endregion

        #region Constructors

        public Substitute()
        {
            m_AvailabilityTimeStart = string.Empty;
            m_AvailabilityTimeEnd = string.Empty;
            m_AvailabilityWeekDays = string.Empty;
            m_UserId = 0;
            m_SubstituteId = 0;
        }

        public Substitute(int substituteId)
        {
            LoadByPrimaryKey(substituteId);
        }

        #endregion

        #region Public Properties

        public int SubstituteId
        {
            get { return m_SubstituteId; }
        }

        public int UserId
        {
            get { return m_UserId; }
            set
            {
                SetDirty();
                m_UserId = value;
            }
        }

        public string AvailabilityTimeStart
        {
            get { return m_AvailabilityTimeStart; }
            set
            {
                SetDirty();
                m_AvailabilityTimeStart = value;
            }
        }

        public string AvailabilityTimeEnd
        {
            get { return m_AvailabilityTimeEnd; }
            set
            {
                SetDirty();
                m_AvailabilityTimeEnd = value;
            }
        }

        public string AvailabilityWeekDays
        {
            get { return m_AvailabilityWeekDays; }
            set
            {
                SetDirty();
                m_AvailabilityWeekDays = value;
            }
        }

        #endregion

        #region Private Properties

        private Miami.Substitute.Dal.Substitute DalSubstitute
        {
            get
            {
                if (m_DalSubstitute == null) m_DalSubstitute = new Miami.Substitute.Dal.Substitute();
                return m_DalSubstitute;
            }
        }

        #endregion

        #region Private Methods

        private void Reset()
        {
            m_AvailabilityTimeStart = string.Empty;
            m_AvailabilityTimeEnd = string.Empty;
            m_AvailabilityWeekDays = string.Empty;
            m_UserId = 0;
            m_SubstituteId = 0;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        private void LoadEntity()
        {
            Reset();
            m_SubstituteId = DalSubstitute.SubstituteId;
            m_UserId = DalSubstitute.UserId;
            m_AvailabilityTimeStart = DalSubstitute.AvailabilityTimeStart;
            m_AvailabilityTimeEnd = DalSubstitute.AvailabilityTimeEnd;
            m_AvailabilityWeekDays = DalSubstitute.AvailabilityWeekDays;
            SetDirty(false);
        }

        #endregion

        #region Overriden Methods

        protected override void RefreshObject()
        {
            throw new System.NotImplementedException();
        }

        [DataObjectMethod(DataObjectMethodType.Update)]
        public int Update(string availabilityTimeStart, string availabilityTimeEnd, string availabilityWeekDays)
        {
            LoadByUserId();
            m_AvailabilityTimeStart = availabilityTimeStart;
            m_AvailabilityTimeEnd = availabilityTimeEnd;
            m_AvailabilityWeekDays = availabilityWeekDays;

            SetDirty();
            Update();

            return m_SubstituteId;
        }

        [DataObjectMethod(DataObjectMethodType.Update)]
        public int Update(int userId, string altPhone)
        {
            LoadByUserId(userId);
            DalSubstitute.UpdateAltPhone(SubstituteId, altPhone);
            return m_SubstituteId;
        }

        [DataObjectMethod(DataObjectMethodType.Insert)]
        public int Insert(string availabilityTimeStart, string availabilityTimeEnd, string availabilityWeekDays)
        {
            Reset();
            m_UserId = Micajah.Common.Security.UserContext.Current.UserId;
            m_AvailabilityTimeStart = availabilityTimeStart;
            m_AvailabilityTimeEnd = availabilityTimeEnd;
            m_AvailabilityWeekDays = availabilityWeekDays;
            SetDirty();
            Update();

            return m_SubstituteId;
        }

        public int Insert(int userId, string availabilityTimeStart, string availabilityTimeEnd, string availabilityWeekDays)
        {
            Reset();
            m_UserId = userId;
            m_AvailabilityTimeStart = availabilityTimeStart;
            m_AvailabilityTimeEnd = availabilityTimeEnd;
            m_AvailabilityWeekDays = availabilityWeekDays;
            SetDirty();
            Update();

            return m_SubstituteId;
        }

        protected override void UpdateObject()
        {
            if (m_SubstituteId > 0)
            {
                DalSubstitute.LoadByPrimaryKey(m_SubstituteId);
            }
            else
            {
                DalSubstitute.AddNew();
            }

            DalSubstitute.UserId = m_UserId;
            DalSubstitute.AvailabilityTimeStart = m_AvailabilityTimeStart;
            DalSubstitute.AvailabilityTimeEnd = m_AvailabilityTimeEnd;
            DalSubstitute.AvailabilityWeekDays = m_AvailabilityWeekDays;

            DalSubstitute.Save();

            if (m_SubstituteId == 0) m_SubstituteId = DalSubstitute.SubstituteId;
        }

        protected override bool CanRefresh()
        {
            return (m_SubstituteId > 0);
        }

        #endregion

        #region Public Methods

            
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataRowView LoadByPrimaryKey(int substituteId)
        {
            if (DalSubstitute.LoadByPrimaryKey(substituteId))
            {
                LoadEntity();
                return (DalSubstitute.DefaultView[0]);
            }
            else throw new ArgumentException();
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAvailables(int jobId)
        {
            if (DalSubstitute.LoadAvailables(jobId))
            {
                int substituteId = 0;
                int locationId = 0;
                bool isAvailable;
                Job job = new Job(jobId);
                Substitute substitute = new Substitute();
                Dal.Preferred pref = new Miami.Substitute.Dal.Preferred();
                Dal.SubstituteExceptions substituteExceptions = new Miami.Substitute.Dal.SubstituteExceptions();                
                DataRowView drv;
                DalSubstitute.DefaultView.Table.Columns.Add("IsApplied");
                DalSubstitute.DefaultView.Table.Columns.Add("TimeWorks");
                DalSubstitute.DefaultView.Table.Columns.Add("DatetimeStart");
                DalSubstitute.DefaultView.Table.Columns.Add("VisibleAssign");
                foreach (DataRow dr in DalSubstitute.DefaultView.Table.Rows)
                {
                    if (dr["SubstituteId"] != null && dr["SubstituteId"] != DBNull.Value)
                    {
                        substituteId = Convert.ToInt32(dr["SubstituteId"]);
                        substitute = new Substitute(substituteId);
                        locationId = Convert.ToInt32(dr["JobLocationId"]);
                        isAvailable = !substituteExceptions.IsOverlapped(substitute.UserId, job.DatetimeStart, job.DatetimeEnd);
                        
                        drv = job.LoadLastJobBySubstitute(substituteId);
                        if (drv != null)
                        {
                            dr["TimeWorks"] = drv["TimeWorks"];
                            dr["DatetimeStart"] = drv["DatetimeStart"];
                        }
                        
                        if (job.IsOverlap(jobId, substituteId))
                        {
                            dr["IsApplied"] = "<img src='Images/clerkassigned.gif' border='0'>";
                            dr["VisibleAssign"] = 0;
                        }
                        else if (!isAvailable)
                        {
                            dr["IsApplied"] = "<img src='Images/notapplied.gif' border='0'>";
                            dr["VisibleAssign"] = 0;
                        }
                        else
                        {
                            if (job.LoadSubstituteJob(jobId, substituteId))
                                dr["IsApplied"] = "<img src='Images/applied.gif' border='0'>";
                            else
                                dr["IsApplied"] = "<img src='Images/blue.gif' border='0'>";
                            dr["VisibleAssign"] = 1;
                        }
                    }
                    else
                    {
                        dr["IsApplied"] = "<img src='Images/notapplied.gif' border='0'>";
                        dr["VisibleAssign"] = 0;
                    }
                }
                DalSubstitute.DefaultView.Sort = "IsClerkPreferred DESC, IsPreferred DESC";
                return DalSubstitute.DefaultView;
            }
            else
                return null;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadSubstituteListForReport()
        {
            return LoadSubstituteListForReport(0, String.Empty, String.Empty);
        }

        public DataView LoadSubstituteListForReport(int subtype, string name, string partTime)
        {
            if (string.IsNullOrEmpty(name))
                name = string.Empty;
            if (string.IsNullOrEmpty(partTime))
                partTime = string.Empty;
            if (DalSubstitute.LoadSubstituteListForReport(subtype, name, partTime))
                return DalSubstitute.DefaultView;
            else
                return null;
        }
        
        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView SearchSubstitute(int userId)
        {
            if (DalSubstitute.SearchSubstitute(userId))
                return DalSubstitute.DefaultView;
            else
                return null;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView SearchSubstitute(string name)
        {
            if (DalSubstitute.SearchSubstitute(name))
                return DalSubstitute.DefaultView;
            else
                return null;
        }

        public DataRowView LoadByUserId()
        {
            return LoadByUserId(Micajah.Common.Security.UserContext.Current.UserId);
        }

        public DataRowView LoadByUserId(int userId)
        {
            if (DalSubstitute.LoadByUserId(userId))
            {
                LoadEntity();
                return (DalSubstitute.DefaultView[0]);
            }
            else
            {
                Reset();
                Insert(userId,String.Empty, String.Empty, String.Empty);
                LoadEntity();
                return (DalSubstitute.DefaultView[0]);
            }
        }

        public DataRowView LoadLocationBySubstituteId
        {
            get
            {
                if (DalSubstitute.LoadLocationBySubstituteId(SubstituteId))
                    return (DalSubstitute.DefaultView[0]);
                else
                    return null;
            }
        }

        public void UpdateLocation(int locationId)
        {
            DalSubstitute.UpdateLocation(SubstituteId, locationId);
        }

        public void AddSubstituteToList(int locationId)
        {
            DalSubstitute.AddSubstituteToList(SubstituteId, locationId);
        }

        #endregion
    }
}
