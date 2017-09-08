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
using System.Data.SqlClient;

namespace SoftwareSolutions
{
    public partial class Category : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                PopulateCategoryList();
            }
        }

        private void PopulateCategoryList()
        {

            using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("spListCategory", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    dlCategorys.DataSource = cmd.ExecuteReader();
                    dlCategorys.DataBind();
                }
            }
        }
    }
}
