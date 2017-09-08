using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AuctionMVCWeb
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string constring = "Data Source=MSSQLLocaldb;Initial Catalog=AspNetUsers;Integrated Security=True";
            string Query = "insert into AspNetUsers (FName, LName, Email, Password) values('" + this.fnameTB.Text + "','" + this.lnameTB.Text + "','" + this.emailTB.Text + "','" + this.passwordTB.Text + "');";
            SqlConnection conDataBase = new SqlConnection(constring);
            SqlCommand cmdDataBase = new SqlCommand(Query, conDataBase);
            SqlDataReader myReader;
            try
            {
                conDataBase.Open();
                myReader = cmdDataBase.ExecuteReader();
                while (myReader.Read())
                {
                    
                }
            } catch (Exception ex)
            {
              
            }

            }
        }
    }


    
