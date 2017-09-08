using SoftwareSolutions;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;


namespace AuctionMVCWeb.CharityAuction
{
	/// <summary>
	/// Summary description for pgAddAuction.
	/// </summary>
    public partial class AddAuction : System.Web.UI.Page
    {

        protected void Page_Load(object sender, System.EventArgs e)
        {

            //string userid = Request.ServerVariables["AUTH_USER"].ToLower().Replace("ghl\\","");

            //switch(userid)
            //{
            //    case "6004003":
            //    case "w20830":
            //    case "tsutton":
            //    case "w22915":
            //    case "gdouglass":
            //    case "w92957":
            //        //you have access well done
            //        //Response.Write("Permission granted");
            //        break;
            //    default:
            //        Response.Redirect("index.htm");
            //        break;
            //}

            if (!IsPostBack)
            {
                // Put user code to initialize the page here
                Calendar1.SelectedDate = DateTime.Now;
                Calendar1.VisibleDate = DateTime.Now;
                
                using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
                {

                    // create and open a connection object
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("spListAllCategory", conn))
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {

                            while (rdr.Read())
                            {
                                DropDownList1.Items.Add(new ListItem(rdr["cat_name"].ToString(), rdr["cat_id"].ToString()));
                            }

                        }
                    }

                }
            }
        }

        protected void Button1_Click(object sender, System.EventArgs e)
        {

            string filename = "";
            
            if (FileUpload1.HasFile)
            {
                filename = Guid.NewGuid() + FileUpload1.FileName.Substring(FileUpload1.FileName.LastIndexOf("."));
                FileUpload1.SaveAs(Server.MapPath("~/auction_pictures/"+filename));
            }
            
            using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
            {

                // create and open a connection object
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("spAddAuction", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@name", txtName.Text));
                    cmd.Parameters.Add(new SqlParameter("@description", txtDescription.Text));
                    cmd.Parameters.Add(new SqlParameter("@closedate", Calendar1.SelectedDate.ToLongDateString() + " " + txtTime.Text));
                    cmd.Parameters.Add(new SqlParameter("@seller", txtSeller.Text));
                    cmd.Parameters.Add(new SqlParameter("@location", txtLocation.Text));
                    cmd.Parameters.Add(new SqlParameter("@cat", DropDownList1.SelectedValue.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@img", filename));

                    cmd.ExecuteNonQuery();
                }
            }

            litHeader.Text = 
                "<h1>Auction added</h1><p><a href='AddAuction.aspx'>Click here to add another item</a></p>";

            txtDescription.Enabled = false;
            txtName.Enabled = false;
            txtLocation.Enabled = false;
            txtSeller.Enabled = false;
            txtTime.Enabled = false;
            Calendar1.Enabled = false;
            FileUpload1.Enabled = false;
            Button1.Enabled = false;
        }

    }
}
