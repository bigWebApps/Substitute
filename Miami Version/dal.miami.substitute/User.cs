using System;
using System.Data.Common;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Miami.Substitute.Dal.Generated;

namespace Miami.Substitute.Dal
{
    public class User : Miami.Substitute.Dal.Generated.User
    {
        public User()
        {
            this.ConnectionString = ConnectionStringProvider.ConnectionString;
        }

        public DataView SearchUserByName(string fullname)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "SearchUserByName";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "Fullname", DbType.String, fullname);
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }

        public void InsertUsage(int UsageType, int LocationId)
        {
            // 1: Logins Clerks
            // 2: Logins Substitutes
            // 3: Jobs Created
            // 4: Jobs Accepted
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "InsertUsage";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "UsageType", DbType.Int32, UsageType);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, LocationId);
            base.LoadFromSql(dbCommand);
        }

        public DataView GetEmployeeSegments(int UserId)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadEmployeeSegments";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "UserId", DbType.Int32, UserId);
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }
        
        public DataView GetUsageReport()
        {
            Database db = GetDatabase();
            string  sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetUsageReport";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }

        public DataView GetUsageReport(int Month, int Year)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetUsageReportByLocations";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "Month", DbType.Int32, Month);
            db.AddInParameter(dbCommand, "Year", DbType.Int32, Year);
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }

        public DataView LoadAllPreferredSubstitutes(int locationId)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadAllPreferredSubstitutes";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }

        public DataView LoadForMain(int userId)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetUserForMain";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, UserSchema.UserId.FieldName, DbType.Int32, userId);
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }

        public DataRowView LoadSubstituteForUpdate(int userId, int locationId)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetSubstituteForUpdate";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, UserSchema.UserId.FieldName, DbType.Int32, userId);
            db.AddInParameter(dbCommand, UserSchema.LocationId.FieldName, DbType.Int32, locationId);
            base.LoadFromSql(dbCommand);
            return base.DefaultView[0];
        }

        public void UpdateSubstitute(int locationId, int clerkId, int substituteId, bool isClerkPreferred, string altPhone, string note)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "SubstituteUpdate";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, UserSchema.LocationId.FieldName, DbType.Int32, locationId);
            db.AddInParameter(dbCommand, "ClerkId", DbType.Int32, clerkId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            db.AddInParameter(dbCommand, "IsClerkPreferred", DbType.Boolean, isClerkPreferred);
            db.AddInParameter(dbCommand, "AltPhone", DbType.String, altPhone);
            db.AddInParameter(dbCommand, "Note", DbType.String, note);
            base.LoadFromSql(dbCommand);
        }

        public DataView LoadCoverage(int userId)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetCoverage";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, UserSchema.UserId.FieldName, DbType.Int32, userId);
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }

        public DataView LoadAvailabilityWeekdays()
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetWeekdays";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }

        public bool UserIsSubstitute(string loginName)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "UserIsSubstitute";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, UserSchema.LoginName.FieldName, DbType.String, loginName);
            object obj = LoadFromSqlScalar(dbCommand);
            if (obj != null)
            {
                if (!obj.Equals(DBNull))
                    return true;
            }
            return false;
        }
    }
}
