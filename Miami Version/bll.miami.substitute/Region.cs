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
    public class Region : DataObject
    {
        #region Members

        private Miami.Substitute.Dal.Region m_DalRegion;
        private int m_RegionId;

        #endregion

        #region Constructors

        public Region()
        {
        }

        #endregion

        #region Private Properties

        private Miami.Substitute.Dal.Region DalRegion
        {
            get
            {
                if (m_DalRegion == null) m_DalRegion = new Miami.Substitute.Dal.Region();
                return m_DalRegion;
            }
        }

        #endregion

        #region Overriden Methods

        protected override void RefreshObject()
        {
            throw new System.NotImplementedException();
        }

        protected override bool CanRefresh()
        {
            return (m_RegionId > 0);
        }

        protected override void UpdateObject()
        { 
        }

        #endregion

        #region Public Methods

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAllRegion()
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            if (DalRegion.LoadBySubstituteId(substitute.SubstituteId))
            {
                return DalRegion.DefaultView;
            }
            else throw new ArgumentException();
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAllRegionForCombo()
        {
            if (DalRegion.LoadRegionsForCombo())
            {
                return DalRegion.DefaultView;
            }
            else 
                return null;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadPreferredRegionsForCombo()
        {
            if (DalRegion.LoadPreferredRegionsForCombo(Micajah.Common.Security.UserContext.Current.UserId))
            {
                return DalRegion.DefaultView;
            }
            else
                return null;
        }

        #endregion
    }
}