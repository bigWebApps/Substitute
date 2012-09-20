using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using Dal.Miami.Substitute.Generated;
using System.Data;

namespace Bll.Miami.Substitute
{
    public class UserProfile : DataObject
    {
        #region Members

        private Dal.Miami.Substitute.UserProfile m_DalUserProfile;
        private int m_UserProfileId;
        private int m_UserId;
        private string m_Phone;
        private string m_Address;
        private string m_Address2;
        private string m_Email;
        private int m_JobPosition;
        private string m_JobAssignmentDescription;
        private string m_Appendage;

        #endregion

        #region Constructors

        public UserProfile()
        {
        }

        public UserProfile(int userProfileId)
        {
            LoadByPrimaryKey(userProfileId);
        }

        public UserProfile(int userProfileId, int userId,
            string phone, string address, string address2, string email, int jobPosition, string jobAssignmentDescription, string appendage)
        {
            m_UserProfileId = userProfileId;
            m_UserId = userId;
            m_Phone = phone;
            m_Address = address;
            m_Address2 = address2;
            m_Email = email;
            m_JobPosition = jobPosition;
            m_JobAssignmentDescription = jobAssignmentDescription;
            m_Appendage = appendage;
        }

        #endregion

        #region Public Properties

        public int UserProfileId
        {
            get { return m_UserProfileId; }
        }

        public int UserId
        {
            get { return m_UserId; }
        }

        public string Phone
        {
            get { return m_Phone; }
            set
            {
                SetDirty();
                m_Phone = value;
            }
        }

        public string Address
        {
            get { return m_Address; }
            set
            {
                SetDirty();
                m_Address = value;
            }
        }

        public string Address2
        {
            get { return m_Address2; }
            set
            {
                SetDirty();
                m_Address2 = value;
            }
        }

        public string Email
        {
            get { return m_Email; }
            set
            {
                SetDirty();
                m_Email = value;
            }
        }

        public int JobPosition
        {
            get { return m_JobPosition; }
            set
            {
                SetDirty();
                m_JobPosition = value;
            }
        }

        public string JobAssignmentDescription
        {
            get { return m_JobAssignmentDescription; }
            set
            {
                SetDirty();
                m_JobAssignmentDescription = value;
            }
        }

        public string Appendage
        {
            get { return m_Appendage; }
            set
            {
                SetDirty();
                m_Appendage = value;
            }
        }

        public string UserProfileName
        {
            get { return string.Concat(m_Address2, ", ", m_Email); }
        }

        #endregion

        #region Private Properties

        private Dal.Miami.Substitute.UserProfile DalUserProfile
        {
            get
            {
                if (m_DalUserProfile == null) m_DalUserProfile = new Dal.Miami.Substitute.UserProfile();
                return m_DalUserProfile;
            }
        }

        #endregion

        #region Private Methods

        private void Reset()
        {
            m_UserProfileId = 0;
            m_UserId = 0;
            m_Phone = String.Empty;
            m_Address = String.Empty;
            m_Address2 = String.Empty;
            m_Email = String.Empty;
            m_JobPosition = 0;
            m_JobAssignmentDescription = String.Empty;
            m_Appendage = String.Empty;
        }

        private void LoadEntity()
        {
            Reset();

            m_UserProfileId = DalUserProfile.UserProfileId;
            m_UserId = DalUserProfile.UserId;
            m_Phone = DalUserProfile.Phone;
            m_Address = DalUserProfile.Address;
            m_Address2 = DalUserProfile.Address2;
            m_Email = DalUserProfile.Email;
            m_JobPosition = DalUserProfile.JobPosition;
            m_JobAssignmentDescription = DalUserProfile.JobAssignmentDescription;
            m_Appendage = DalUserProfile.Appendage;

            SetDirty();
        }

        #endregion

        #region Overriden Methods

        protected override void RefreshObject()
        {
            throw new System.NotImplementedException();
        }

        protected override void UpdateObject()
        {
        }

        protected override bool CanRefresh()
        {
            return (m_UserProfileId > 0);
        }

        #endregion

        #region Public Methods

        public DataView LoadAllUserProfile()
        {
            if (DalUserProfile.LoadAll())
            {
                return DalUserProfile.DefaultView;
            }
            else throw new ArgumentException();
        }

        public DataRowView LoadByPrimaryKey(int userProfileId)
        {
            if (DalUserProfile.LoadByPrimaryKey(userProfileId))
            {
                LoadEntity();
                return (DalUserProfile.DefaultView[0]);
            }
            else throw new ArgumentException();
        }

        public DataRowView LoadByUserId(int userId)
        {
            if (DalUserProfile.LoadByPrimaryKey(userId))
            {
                LoadEntity();
                return (DalUserProfile.DefaultView[0]);
            }
            else throw new ArgumentException();
        }

        #endregion
    }

}
