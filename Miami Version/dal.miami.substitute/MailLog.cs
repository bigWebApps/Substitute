using System;
using System.Data.Common;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Miami.Substitute.Dal.Generated;

namespace Miami.Substitute.Dal
{
    public class MailLog : Miami.Substitute.Dal.Generated.MailLog
    {
        public MailLog()
        {
            this.ConnectionString = ConnectionStringProvider.ConnectionString;
        }

        public void DeleteMailLog(int locationId, int count)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "DeleteMailLog";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);
            db.AddInParameter(dbCommand, "Count", DbType.Int32, count);
            base.LoadFromSql(dbCommand);
        }

        public DataView GetAllMailLogByLocationId(int locationId)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetAllMailLogByLocationId";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }    
    }
}
