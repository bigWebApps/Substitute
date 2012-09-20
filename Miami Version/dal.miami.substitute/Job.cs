using System;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Collections;
using System.Collections.Specialized;
using System.Data.Common;
using System.Data;
using System.Xml;

namespace Miami.Substitute.Dal
{
    public class Job : Miami.Substitute.Dal.Generated.Job
    {
        public Job() 
        {
            this.ConnectionString = ConnectionStringProvider.ConnectionString;
        }

        public virtual bool GetSubTypes()
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetSubTypes";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetSubTypesForReport()
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetSubTypesForReport";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);

            return base.LoadFromSql(dbCommand);
        }


        public virtual bool GetGrades()
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_GetAllGrade";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetTimes()
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "GetTimes";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);

            return base.LoadFromSql(dbCommand);
        }

        public virtual DataView GetEmployee(int locationId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_GetEmployee";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.String, locationId.ToString());
            base.LoadFromSql(dbCommand);
            return base.DefaultView;
        }
        
        public virtual bool LoadAll(int locationId, int statusId, string selectedDate, string selectedDateTo)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_GetAllJob";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "LocationId", DbType.Int32, locationId);
            db.AddInParameter(dbCommand, "StatusId", DbType.Int32, statusId);
            DateTime dateto;
            DateTime datefrom;
            if (string.IsNullOrEmpty(selectedDate))
                datefrom = DateTime.Today;
            else
                datefrom = Convert.ToDateTime(selectedDate);

            if (string.IsNullOrEmpty(selectedDateTo))
                dateto = DateTime.Today.AddYears(10);
            else
                dateto = Convert.ToDateTime(selectedDateTo);


            db.AddInParameter(dbCommand, "DateSelected", DbType.DateTime, datefrom);
            db.AddInParameter(dbCommand, "DateSelectedTo", DbType.DateTime, dateto);

            return base.LoadFromSql(dbCommand);
        }

        public virtual bool LoadLastJobBySubstitute(int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadLastJobBySubstitute";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            return base.LoadFromSql(dbCommand);
        }


        public virtual bool LoadOpenJobs()
        {
            switch (this.DefaultCommandType)
            {
                case CommandType.StoredProcedure:
                    return base.LoadFromSql(this.SchemaStoredProcedureWithSeparator + "daab_GetAllJobOpened", null, CommandType.StoredProcedure);

                case CommandType.Text:
                    this.Query.ClearAll();
                    this.Where.WhereClauseReset();
                    return this.Query.Load();

                default:
                    throw new ArgumentException("Invalid CommandType", "commandType");
            }
        }

        public virtual bool SearchOpenJobs(DateTime from, DateTime to, string locName, int substituteId, int userId)
        {
            bool isRegion = false;
            if (locName.Length > 0 && locName[0] == 'r')
            {
                isRegion = true;
                locName = locName.Remove(0, 1);
            }

            ListDictionary ld = new ListDictionary();
            ld.Add("jfrom", from);
            ld.Add("jto", to);
            ld.Add("locName", Convert.ToInt32(locName));
            ld.Add("SubstituteId", substituteId);
            ld.Add("UserId", userId);
            switch (this.DefaultCommandType)
            {
                case CommandType.StoredProcedure:
                    if (!isRegion)
                        return base.LoadFromSql(this.SchemaStoredProcedureWithSeparator + "daab_SearchJobOpened", ld, CommandType.StoredProcedure);
                    else
                        return base.LoadFromSql(this.SchemaStoredProcedureWithSeparator + "daab_SearchJobOpenedByRegion", ld, CommandType.StoredProcedure);
                default:
                    throw new ArgumentException("Invalid CommandType", "commandType");
            }
        }

        public virtual bool SearchOpenJobs(DateTime from, DateTime to, int substituteId, int status)
        {
            ListDictionary ld = new ListDictionary();
            ld.Add("jfrom", from);
            ld.Add("jto", to);
            ld.Add("SubstituteId", substituteId);
            ld.Add("Status", status);
            return base.LoadFromSql(this.SchemaStoredProcedureWithSeparator + "daab_SearchJobAccepted", ld, CommandType.StoredProcedure);
        }

        public virtual void SetSubstitute(int jobId, int substituteId, int status)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "SetSubstitute";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "JobId", DbType.Int32, jobId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            db.AddInParameter(dbCommand, "Status", DbType.Int32, status);
            base.LoadFromSqlNoExec(dbCommand);
        }

        public virtual void ConfirmJob(int jobId, int substituteId, int status, string confirmNote)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "SetConfirmJob";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "JobId", DbType.Int32, jobId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            db.AddInParameter(dbCommand, "Status", DbType.Int32, status);
            db.AddInParameter(dbCommand, "ConfirmNote", DbType.String, confirmNote);
            base.LoadFromSqlNoExec(dbCommand);
        }

        public virtual void AddSubstituteToJob(int jobId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_AddJobSubstitute";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "JobId", DbType.Int32, jobId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            base.LoadFromSqlNoExec(dbCommand);
        }

        public virtual void DeleteSubstituteFromJob(int jobId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_DeleteJobSubstitute";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "JobId", DbType.Int32, jobId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            base.LoadFromSqlNoExec(dbCommand);
        }

        public virtual void DeleteJob(int jobId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_DeleteJob";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "JobId", DbType.Int32, jobId);
            base.LoadFromSqlNoExec(dbCommand);
        }

        public virtual bool LoadJobSubstitute(int jobId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_LoadJobSubstitute";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "JobId", DbType.Int32, jobId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetOverlap(int jobId, int substituteId)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_IsOverlap";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "JobId", DbType.Int32, jobId);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            return base.LoadFromSql(dbCommand);
        }

        public virtual bool GetOverlap(int substituteId, DateTime day)
        {
            Database db = GetDatabase();

            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "daab_IsOverlapDay";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "SubstituteId", DbType.Int32, substituteId);
            db.AddInParameter(dbCommand, "Day", DbType.DateTime, day);
            return base.LoadFromSql(dbCommand);
        }    
    }
}
