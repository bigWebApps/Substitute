using System;
using System.Data.Common;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;

namespace Miami.Substitute.Dal
{
    public class SubstituteExceptions : Miami.Substitute.Dal.Generated.SubstituteExceptions
    {
        public SubstituteExceptions() 
        {
            this.ConnectionString = ConnectionStringProvider.ConnectionString;
        }

        public virtual bool LoadAllByUserId(int userId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadSubstituteExceptionsByUserId";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "UserId", DbType.Int32, userId);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool IsOverlapped(int userId, DateTime start, DateTime end)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "SubstituteExceptionsIsOverlapped";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "UserId", DbType.Int32, userId);
            db.AddInParameter(dbCommand, "from", DbType.DateTime, start);
            db.AddInParameter(dbCommand, "to", DbType.DateTime, end);

            base.LoadFromSql(dbCommand);
            return Convert.ToBoolean(DefaultView.Table.Rows[0][0]);
        }
    }
}
