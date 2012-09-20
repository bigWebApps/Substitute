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
    public class Preferred : DataObject
    {
        #region Members

        private Miami.Substitute.Dal.Preferred m_DalPreferred;
        private int m_PreferredId;
        private int m_LocationId;
        private int m_SubstituteId;

        #endregion

        #region Constructors

        public Preferred()
        {
            m_PreferredId = 0;
            m_LocationId = 0;
            m_SubstituteId = 0;
        }

        public Preferred(int preferredId)
        {
            LoadByPrimaryKey(preferredId);
        }

        #endregion

        #region Public Properties

        public int PreferredId
        {
            get { return m_PreferredId; }
        }

        public int LocationId
        {
            get { return m_LocationId; }
            set
            {
                SetDirty();
                m_LocationId = value;
            }
        }

        public int SubstituteId
        {
            get { return m_SubstituteId; }
            set
            {
                SetDirty();
                m_SubstituteId = value;
            }
        }

        #endregion

        #region Private Properties

        private Miami.Substitute.Dal.Preferred DalPreferred
        {
            get
            {
                if (m_DalPreferred == null) m_DalPreferred = new Miami.Substitute.Dal.Preferred();
                return m_DalPreferred;
            }
        }

        #endregion

        #region Private Methods

        private void Reset()
        {
            m_PreferredId = 0;
            m_LocationId = 0;
            m_SubstituteId = 0;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        private void LoadEntity()
        {
            Reset();
            m_PreferredId = DalPreferred.PreferredId;
            m_LocationId = DalPreferred.LocationId;
            m_SubstituteId = DalPreferred.SubstituteId;
            SetDirty(false);
        }

        #endregion

        #region Overriden Methods

        protected override void RefreshObject()
        {
            throw new System.NotImplementedException();
        }

        public void DeleteForSubstitute()
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            DalPreferred.Query.ClearAll();
            DalPreferred.Where.SubstituteId.Operator = WhereParameter.Operand.Equal;
            DalPreferred.Where.SubstituteId.Value = substitute.SubstituteId;
            if (DalPreferred.Query.Load())
            {
                DalPreferred.DeleteAll();
                DalPreferred.Save();
            }
        }

        public void DeleteForClerkSubstitute(int locationId, int substituteId)
        {
            DalPreferred.DeleteClerkPreferredBySubstitute(locationId, substituteId);
        }

        public void ClerkInsert(int locationId, int substituteId)
        {
            DalPreferred.ClerkInsert(locationId, substituteId);
        }

        public void DeleteForSubstitute(int locationId, int substituteId)
        {
            DalPreferred.DeletePreferredBySubstitute(locationId, substituteId);
        }

        public void Delete(int locationId)
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            DalPreferred.Query.ClearAll();
            DalPreferred.Where.LocationId.Operator = WhereParameter.Operand.Equal;
            DalPreferred.Where.LocationId.Value = locationId;
            DalPreferred.Where.SubstituteId.Operator = WhereParameter.Operand.Equal;
            DalPreferred.Where.SubstituteId.Value = substitute.SubstituteId;
            if (DalPreferred.Query.Load())
            {
                DalPreferred.DeleteAll();
                DalPreferred.Save();
            }
        }

        public void DeleteByRegion(int regionId)
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            DalPreferred.DeleteByRegion(regionId, substitute.SubstituteId);
        }

        [DataObjectMethod(DataObjectMethodType.Update)]
        public int Update(int preferredId, int locationId, int substituteId)
        {
            Reset();
            m_PreferredId = preferredId;
            m_LocationId = locationId;
            m_SubstituteId = substituteId;

            SetDirty();
            Update();

            return m_PreferredId;
        }

        [DataObjectMethod(DataObjectMethodType.Insert)]
        public int Insert(int locationId)
        {
            Reset();

            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();

            m_LocationId = locationId;
            m_SubstituteId = substitute.SubstituteId;
            SetDirty();
            Update();

            return m_PreferredId;
        }

        public int Insert(int locationId, int substituteId)
        {
            Reset();

            m_LocationId = locationId;
            m_SubstituteId = substituteId;
            SetDirty();
            Update();

            return m_PreferredId;
        }

        protected override void UpdateObject()
        {
            if (m_PreferredId > 0)
            {
                DalPreferred.LoadByPrimaryKey(m_PreferredId);
            }
            else
            {
                DalPreferred.AddNew();
            }

            DalPreferred.PreferredId = m_PreferredId;
            DalPreferred.LocationId = m_LocationId;
            DalPreferred.SubstituteId = m_SubstituteId;

            DalPreferred.Save();

            if (m_PreferredId == 0) m_PreferredId = DalPreferred.PreferredId;
        }

        protected override bool CanRefresh()
        {
            return (m_PreferredId > 0);
        }

        #endregion

        #region Public Methods


        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataRowView LoadByPrimaryKey(int preferredId)
        {
            if (DalPreferred.LoadByPrimaryKey(preferredId))
            {
                LoadEntity();
                return (DalPreferred.DefaultView[0]);
            }
            else throw new ArgumentException();
        }

        public bool IsPreferredExists
        {
            get
            {
                Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
                substitute.LoadByUserId();
                DalPreferred.Query.ClearAll();
                DalPreferred.Where.SubstituteId.Operator = WhereParameter.Operand.Equal;
                DalPreferred.Where.SubstituteId.Value = substitute.SubstituteId;
                return DalPreferred.Query.Load();
            }
        }

        #endregion
    }
}