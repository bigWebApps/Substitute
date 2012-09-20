using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Miami.Substitute.Web.Master
{
    public partial class Locations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Miami.Substitute.Bll.Location location = new Miami.Substitute.Bll.Location();
            DataView dv = location.GetUserLocations();
            DataTable result = dv.Table.Clone();
            result.Clear();

            if (dv != null)
            {
                string LocationName = string.Empty;
                foreach (DataRow dr in dv.Table.Rows)
                {
                    if (dr["LName"].ToString() != LocationName)
                    {
                        result.Rows.Add(dr.ItemArray);
                    }
                    else
                    {
                        result.Rows[result.Rows.Count - 1]["UName"] += "<br>" + dr["UName"].ToString();
                        result.Rows[result.Rows.Count - 1]["Email"] += "<br>" + dr["Email"].ToString();
                    }

                    LocationName = dr["LName"].ToString();
                }
            }
            LocationsList.DataSource = result.DefaultView;
            LocationsList.DataBind();
        }
    }
}