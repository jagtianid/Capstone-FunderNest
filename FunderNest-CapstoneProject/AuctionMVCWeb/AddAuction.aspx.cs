using SoftwareSolutions;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using AuctionMVCWeb.Models;
using AuctionMVCWeb.Controllers;
using System.Linq;


namespace AuctionMVCWeb.CharityAuction 
{
   
    public partial class AddAuction : System.Web.UI.Page
    {

        protected void Page_Load(object sender, System.EventArgs e)
        {
         
            if (!IsPostBack)
            {
                if (Session["Id"] != null)
                {
                    lbFName.Text = Session["FName"].ToString();
                    lbEmail.Text = Session["Email"].ToString();

                }

                Calendar1.SelectedDate = DateTime.Now;
                Calendar1.VisibleDate = DateTime.Now;

                using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
                {

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
                FileUpload1.SaveAs(Server.MapPath("~/auction_pictures/" + filename));
            }

            using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
            {

                conn.Open();
                using (SqlCommand cmd = new SqlCommand("spAddAuction", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@name", txtName1.Text));
                    cmd.Parameters.Add(new SqlParameter("@description", txtDescription.Text));
                    cmd.Parameters.Add(new SqlParameter("@closedate", Calendar1.SelectedDate.ToLongDateString() + " " + txtTime.Text));
                    cmd.Parameters.Add(new SqlParameter("@seller", lbFName.Text));
                    cmd.Parameters.Add(new SqlParameter("@cat", DropDownList1.SelectedValue.ToString()));
                    cmd.Parameters.Add(new SqlParameter("@img", filename));

                    cmd.ExecuteNonQuery();
                }
            }

            litHeader.Text =
                 "<h5>Auction added</h5>";

            txtDescription.Enabled = false;
            txtName1.Enabled = false;
            lbFName.Enabled = false;
            txtTime.Enabled = false;
            Calendar1.Enabled = false;
            FileUpload1.Enabled = false;
            Button1.Enabled = false;

        }

        protected void txtDescription_TextChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void txtSeller_TextChanged(object sender, EventArgs e)
        {
            
        }


       

    }
    }

