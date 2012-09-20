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
    public class User
    {
        private Miami.Substitute.Dal.User m_DalUser;
        private Miami.Substitute.Dal.User DalUser
        {
            get
            {
                if (m_DalUser == null) m_DalUser = new Miami.Substitute.Dal.User();
                return m_DalUser;
            }
        }

        #region Public Methods

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAllPreferredSubstitutes(int locationId)
        {
            if (DalUser.LoadAllPreferredSubstitutes(locationId).Count>0)
            {
                int substituteId = 0;
                Job job = new Job();
                DataRowView drv;
                DalUser.DefaultView.Table.Columns.Add("Teacher");
                DalUser.DefaultView.Table.Columns.Add("DatetimeStart");
                foreach (DataRow dr in DalUser.DefaultView.Table.Rows)
                {
                    if (dr["SubstituteId"] != null && dr["SubstituteId"] != DBNull.Value)
                    {
                        substituteId = Convert.ToInt32(dr["SubstituteId"]);
                        drv = job.LoadLastJobBySubstitute(substituteId);
                        if (drv!=null)
                        {
                            if (drv["Name"] != null)
                                dr["Teacher"] = drv["Name"];
                            else
                                dr["Teacher"] = "&nbsp;";
                            if (drv["DatetimeStart"] != null)
                                dr["DatetimeStart"] = drv["DatetimeStart"];
                        }
                    }
                }
                return DalUser.DefaultView;
            }
            else
                return null;
        }

        [DataObjectMethod(DataObjectMethodType.Update)]
        public void UpdateUser(int userId, bool preferred, string altPhone, string note)
        {

        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public DataView LoadAllUserByFilter()
        {
            DalUser.Query.ClearAll();
            DalUser.Query.AddResultColumn(UserSchema.UserId);
            DalUser.Query.AddResultColumn(UserSchema.FirstName);
            DalUser.Query.AddResultColumn(UserSchema.LastName);
            DalUser.Where.Deleted.Value = true;
            if (DalUser.Query.Load())
            {
                DataTable dtUsers = DalUser.DefaultView.Table;
                dtUsers.Columns.Add("UserName", typeof(string));
                foreach (DataRow row in dtUsers.Rows)
                {
                    row["UserName"] = (string)row["LastName"] + ", " + (string)row["FirstName"];
                }
                DataRow newrow = dtUsers.NewRow();
                newrow["UserName"] = string.Empty;
                newrow["UserId"] = 0;
                dtUsers.Rows.Add(newrow);
                dtUsers.DefaultView.Sort = "UserName ASC";
                return dtUsers.DefaultView;
            }
            else throw new ArgumentException();
        }


        #endregion
    }
}
