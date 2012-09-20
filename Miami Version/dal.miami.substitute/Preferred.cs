using System;
using System.Data.Common;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;

namespace Miami.Substitute.Dal
{
    public class Preferred : Miami.Substitute.Dal.Generated.Preferred
    {
        public Preferred()
        {
            this.ConnectionString = ConnectionStringProvider.ConnectionString;
        }

        public virtual void DeleteByRegion(int regionId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "DeleteFromPreferred";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "regionId", DbType.Int32, regionId);
            db.AddInParameter(dbCommand, "substituteId", DbType.Int32, substituteId);

            base.LoadFromSqlNoExec(dbCommand);
        }

        public virtual void DeletePreferredBySubstitute(int locationId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_DeletePreferredBySubstitute";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "locationId", DbType.Int32, locationId);
            db.AddInParameter(dbCommand, "substituteId", DbType.Int32, substituteId);

            base.LoadFromSqlNoExec(dbCommand);
        }

        public virtual void DeleteClerkPreferredBySubstitute(int locationId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_DeleteClerkPreferredBySubstitute";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "locationId", DbType.Int32, locationId);
            db.AddInParameter(dbCommand, "substituteId", DbType.Int32, substituteId);

            base.LoadFromSqlNoExec(dbCommand);
        }

        public bool IsExistPreferred(int locationId, int substituteId)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "IsExistPreferred";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            base.LoadFromSql(dbCommand);
            if (base.DefaultView == null || base.DefaultView.Count == 0)
                return false;
            else 
                return true;
        }

        public bool IsExistPreferredClerk(int locationId, int substituteId)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "IsExistPreferredClerk";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            base.LoadFromSql(dbCommand);
            if (base.DefaultView == null || base.DefaultView.Count == 0)
                return false;
            else
                return true;
        }    

        public virtual void ClerkInsert(int locationId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_InsertClerkPreferred";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "locationId", DbType.Int32, locationId);
            db.AddInParameter(dbCommand, "substituteId", DbType.Int32, substituteId);

            base.LoadFromSqlNoExec(dbCommand);
        }
    }
}
