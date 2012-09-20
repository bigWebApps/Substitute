using System;
using System.Data.Common;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;

namespace Miami.Substitute.Dal
{
    public class Location : Miami.Substitute.Dal.Generated.Location
    {
        public Location()
        {
            this.ConnectionString = ConnectionStringProvider.ConnectionString;
        }

        public virtual bool LoadByRegionId(int regionId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadLocations";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "RegionId", DbType.Int32, regionId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool LoadLocationForSearch(int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadLocationsForSearch";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetLocationsByRegion(int regionId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetLocationByRegion";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "RegionId", DbType.Int32, regionId);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetPreferredLocationsByRegion(int regionId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetPreferredLocationsByRegion";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "RegionId", DbType.Int32, regionId);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetRegionByLocation(int locationId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetRegionByLocation";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetUserLocations(int LocationId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadLocationUser";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetDefaultLocations()
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadDefaultLocationUser";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetPreferredLocationsByCurrentLocation(int locationId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetPreferredLocationsByCurrentLocation";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetLocationsByCurrentLocation(int locationId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetLocationByCurrentLocation";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool LoadLocationForSearchAll()
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadLocationsForSearchAll";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            return base.LoadFromSql(dbCommand);
        }
    }
}
