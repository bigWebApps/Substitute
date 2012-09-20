using System;
using System.Data.Common;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Miami.Substitute.Dal.Generated;

namespace Miami.Substitute.Dal
{
    public class Template : Miami.Substitute.Dal.Generated.Template
    {
        public Template()
        {
            this.ConnectionString = ConnectionStringProvider.ConnectionString;
        }

        public virtual DataView LoadAllTemplates()
        {
            if (base.LoadAll())
                return base.DefaultView;
            else
                return new DataView();
        }

        public DataRowView LoadTemplateByName(string templateName)
        {
            Database db = GetDatabase();
            string sqlCommand = this.SchemaStoredProcedureWithSeparator + "LoadTemplateByName";
            DbCommand dbCommand = db.GetStoredProcCommand(sqlCommand);
            db.AddInParameter(dbCommand, "TemplateName", DbType.String, templateName);
            base.LoadFromSql(dbCommand);
            if (base.DefaultView.Count > 0)
                return base.DefaultView[0];
            else
                return null;
        }
    }
}
