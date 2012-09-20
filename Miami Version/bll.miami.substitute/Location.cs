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
    public class Location : DataObject
    {
        #region Members

        private Miami.Substitute.Dal.Location m_DalLocation;
        private int m_LocationId;

        #endregion

        #region Constructors

        public Location()
        {
        }

        #endregion

        #region Private Properties

        private Miami.Substitute.Dal.Location DalLocation
        {
            get
            {
                if (m_DalLocation == null) m_DalLocation = new Miami.Substitute.Dal.Location();
                return m_DalLocation;
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
            return (m_LocationId > 0);
        }

        protected override void UpdateObject()
        {
        }

        #endregion

        #region Public Methods

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAllLocation()
        {
            if (DalLocation.LoadAll())
            {
                return DalLocation.DefaultView;
            }
            else throw new ArgumentException();
        }

        public DataView GetUserLocations()
        {
            if (DalLocation.GetUserLocations(0))
            {
                return DalLocation.DefaultView;
            }
            else
                return null;
        }

        public DataView GetDefaultLocations()
        {
            if (DalLocation.GetDefaultLocations())
            {
                return DalLocation.DefaultView;
            }
            else
                return null;
        }

        public DataView GetUserLocations(int locationId)
        {
            if (DalLocation.GetUserLocations(locationId))
            {
                return DalLocation.DefaultView;
            }
            else
                return null;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadLocationForSearch()
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            if (DalLocation.LoadLocationForSearch(substitute.SubstituteId))
            {                
                return DalLocation.DefaultView;
            }
            else
                return null;
        }

        public DataView GetLocationsByRegion(int regionId)
        {
            if (DalLocation.GetLocationsByRegion(regionId))
            {
                return DalLocation.DefaultView;
            }
            else
                return null;
        }

        public DataView GetPreferredLocationsByRegion(int regionId)
        {
            if (DalLocation.GetPreferredLocationsByRegion(regionId))
            {
                return DalLocation.DefaultView;
            }
            else
                return null;
        }

        public DataView GetLocationsByCurrentLocation(int locationId)
        {
            if (DalLocation.GetLocationsByCurrentLocation(locationId))
            {
                return DalLocation.DefaultView;
            }
            else
                return null;
        }

        public DataView GetPreferredLocationsByCurrentLocation(int locationId, int substituteId)
        {
            if (DalLocation.GetPreferredLocationsByCurrentLocation(locationId, substituteId))
            {
                return DalLocation.DefaultView;
            }
            else
                return null;
        }

        public int GetRegionByLocation(int locationId)
        {
            if (DalLocation.GetRegionByLocation(locationId))
            {
                return Convert.ToInt32(DalLocation.DefaultView[0][0]);
            }
            else
                return 0;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAllLocation(int regionId)
        {
            Miami.Substitute.Bll.Substitute substitute = new Miami.Substitute.Bll.Substitute();
            substitute.LoadByUserId();
            if (DalLocation.LoadByRegionId(regionId, substitute.SubstituteId))
            {
                return DalLocation.DefaultView;
            }
            else 
                return null;
        }

        #endregion
    }
}