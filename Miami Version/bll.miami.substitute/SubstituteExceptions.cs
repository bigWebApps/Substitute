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
    public class SubstituteExceptions : DataObject
    {
        #region Members

        private Miami.Substitute.Dal.SubstituteExceptions m_DalSubstitute;
        private int m_SubstituteExceptionsId;
        private int m_SubstituteId;
        private DateTime m_DateStart;
        private DateTime m_DateEnd;

        #endregion

        #region Constructors

        public SubstituteExceptions()
        {
            m_DateStart = DateTime.Now;
            m_DateEnd = DateTime.Now;
            m_SubstituteId = 0;
            m_SubstituteExceptionsId = 0;
        }

        public SubstituteExceptions(int substituteExceptionsId)
        {
            LoadByPrimaryKey(substituteExceptionsId);
        }

        #endregion

        #region Public Properties

        public int SubstituteExceptionsId
        {
            get { return m_SubstituteExceptionsId; }
        }

        public int SubstituteId
        {
            get 
            {
                if (m_SubstituteId == 0)
                    m_SubstituteId = GetSubstituteIdByUserId(Micajah.Common.Security.UserContext.Current.UserId);
                return m_SubstituteId;
            }
            set
            {
                SetDirty();
                m_SubstituteId = value;
            }
        }

        public DateTime DateStart
        {
            get { return m_DateStart; }
            set
            {
                SetDirty();
                m_DateStart = value;
            }
        }

        public DateTime DateEnd
        {
            get { return m_DateEnd; }
            set
            {
                SetDirty();
                m_DateEnd = value;
            }
        }

        #endregion

        #region Private Properties

        private Miami.Substitute.Dal.SubstituteExceptions DalSubstitute
        {
            get
            {
                if (m_DalSubstitute == null) m_DalSubstitute = new Miami.Substitute.Dal.SubstituteExceptions();
                return m_DalSubstitute;
            }
        }

        #endregion

        #region Private Methods

        private void Reset()
        {
            m_DateStart = DateTime.Now;
            m_DateEnd = DateTime.Now;
            m_SubstituteId = 0;
            m_SubstituteExceptionsId = 0;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        private void LoadEntity()
        {
            Reset();
            m_SubstituteExceptionsId = DalSubstitute.SubstituteExceptionsId;
            m_SubstituteId = DalSubstitute.SubstituteId;
            m_DateStart = DalSubstitute.DateStart;
            m_DateEnd = DalSubstitute.DateEnd;

            SetDirty(false);
        }

        #endregion

        #region Overriden Methods

        protected override void RefreshObject()
        {
            throw new System.NotImplementedException();
        }

        [DataObjectMethod(DataObjectMethodType.Insert)]
        public int Insert(DateTime startDate)
        {
            Reset();
            m_DateStart = startDate;
            SetDirty();
            Update();
            return m_SubstituteExceptionsId;
        }

        protected override void UpdateObject()
        {
            if (m_SubstituteExceptionsId > 0)
            {
                DalSubstitute.LoadByPrimaryKey(m_SubstituteExceptionsId);
            }
            else
            {
                DalSubstitute.AddNew();
            }

            DalSubstitute.SubstituteId = SubstituteId;
            DalSubstitute.DateStart = m_DateStart;
            DalSubstitute.DateEnd = m_DateEnd;
            DalSubstitute.Save();

            if (m_SubstituteExceptionsId == 0) m_SubstituteExceptionsId = DalSubstitute.SubstituteExceptionsId;
        }

        protected override bool CanRefresh()
        {
            return (m_SubstituteExceptionsId > 0);
        }

        #endregion

        #region Public Methods


        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAllByUserId()
        {
            if (DalSubstitute.LoadAllByUserId(Micajah.Common.Security.UserContext.Current.UserId))
            {
                return DalSubstitute.DefaultView;
            }
            else 
                return null;
        }

        [DataObjectMethod(DataObjectMethodType.Delete)]
        public void Delete(int substituteExceptionsId)
        {
            DalSubstitute.Query.ClearAll();
            DalSubstitute.Where.SubstituteExceptionsId.Operator = WhereParameter.Operand.Equal;
            DalSubstitute.Where.SubstituteExceptionsId.Value = substituteExceptionsId;
            if (DalSubstitute.Query.Load())
            {
                DalSubstitute.DeleteAll();
                DalSubstitute.Save();
            }
        }

        public void DeleteBySubstituteId()
        {
            Miami.Substitute.Dal.Substitute substitute = new Miami.Substitute.Dal.Substitute();
            substitute.LoadByUserId(Micajah.Common.Security.UserContext.Current.UserId);

            DalSubstitute.Query.ClearAll();
            DalSubstitute.Where.SubstituteId.Operator = WhereParameter.Operand.Equal;
            DalSubstitute.Where.SubstituteId.Value = substitute.SubstituteId;
            if (DalSubstitute.Query.Load())
            {
                DalSubstitute.DeleteAll();
                DalSubstitute.Save();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataRowView LoadByPrimaryKey(int substituteExceptionsId)
        {
            if (DalSubstitute.LoadByPrimaryKey(substituteExceptionsId))
            {
                LoadEntity();
                return (DalSubstitute.DefaultView[0]);
            }
            else throw new ArgumentException();
        }

        public int GetSubstituteIdByUserId(int userId)
        {
            if (userId>0)
            {
                Miami.Substitute.Dal.Substitute substitute = new Miami.Substitute.Dal.Substitute();
                substitute.Query.ClearAll();
                substitute.Where.UserId.Operator = WhereParameter.Operand.Equal;
                substitute.Where.UserId.Value = userId;

                if (substitute.Query.Load())
                    return (substitute.SubstituteId);
            }
            return 0;
        }

        #endregion
    }
}
