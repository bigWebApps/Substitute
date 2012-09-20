using System;
using System.Data.Common;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;

namespace Miami.Substitute.Dal
{
    public class Region : Miami.Substitute.Dal.Generated.Region
    {
        public Region()
        {
            this.ConnectionString = ConnectionStringProvider.ConnectionString;
        }

        public virtual bool LoadBySubstituteId(int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadRegions";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "substituteId", DbType.Int32, substituteId);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool LoadRegionsForCombo()
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadRegionsForCombo";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool LoadPreferredRegionsForCombo(int userId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadPreferredRegionsForCombo";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "UserId", DbType.Int32, userId);
            return base.LoadFromSql(dbCommand);
        }
    }
}
