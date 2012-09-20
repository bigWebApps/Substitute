using System;
using System.Data.Common;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;


namespace Miami.Substitute.Dal
{
    public class Substitute : Miami.Substitute.Dal.Generated.Substitute
	{		
		public Substitute() 
        {
            this.ConnectionString = ConnectionStringProvider.ConnectionString;
        }

        public virtual bool LoadByUserId(int userId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetAvailabilityForUser";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "UserId", DbType.Int32, userId);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool SearchSubstitute(int userId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "SearchSubstitute";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "id", DbType.Int32, userId);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool SearchSubstitute(string name)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "SearchSubstituteByName";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "name", DbType.String, name);

            return base.LoadFromSql(dbCommand);
        }    
        
        public virtual bool LoadLocationBySubstituteId(int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadLocationBySubstituteId";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool LoadAvailables(int jobId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadAvailableSubstitutes";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "JobId", DbType.Int32, jobId);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool LoadSubstituteListForReport(int subtype, string name, string partTime)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadSubstituteListForReport";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "Subtype", DbType.Int32, subtype);
            db.AddInParameter(dbCommand, "Name", DbType.String, name);
            db.AddInParameter(dbCommand, "PartTime", DbType.String, partTime);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool UpdateLocation(int substituteId, int locationId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "UpdateLocationBySubstituteId";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);

            db.ExecuteNonQuery(dbCommand);
            return true;
        }

        public virtual bool UpdateAltPhone(int substituteId, string altPhone)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "SubstituteUpdateAltPhone";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            db.AddInParameter(dbCommand, "AltPhone", DbType.String, altPhone);

            db.ExecuteNonQuery(dbCommand);
            return true;
        }

        public virtual bool AddSubstituteToList(int substituteId, int locationId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "AddSubstituteToList";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "substituteId", DbType.Int32, substituteId);
            db.AddInParameter(dbCommand, "locationId", DbType.Int32, locationId);

            db.ExecuteNonQuery(dbCommand);
            return true;
        }
	}
}
