using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Data.SqlClient;
using System.Web.SessionState;
using System.Web.UI;
using SoftwareSolutions;

namespace AuctionMVCWeb.CharityAuction
{
	/// <summary>
	/// Summary description for pgItem.
	/// </summary>
	public partial class Item : System.Web.UI.Page
	{

        protected void Page_Load(object sender, System.EventArgs e)
        {
            // Put user code to initialize the page here
            if (!IsPostBack)
            {
                lbItemId.Text = Request.QueryString["i"].ToString();
                getItem();

                DateTime dtStartDate = DateTime.Parse(Common.GetValueFromWebConfig("LockBidDate"));
                if (dtStartDate.Ticks > DateTime.Now.Ticks)
                {
                    ClientScript.RegisterStartupScript(typeof(Page), "alert", "alert('Bidding on this item will start at " + dtStartDate.ToString() + ".');", true);
                    btnBid.Enabled = false;
                    txtBid.Enabled = false;
                }

                if (lblEndTime.Text.Contains("Ended"))
                {
                    litUpdate.Text = "<p>Bidding on this item has finished.  I'm sorry you was too late!</p>";
                }
                else
                {
                    if (lblCurrentBid.Text.Equals("<b>No bids</b>"))
                    {
                        litUpdate.Text = "<p>Bidding on this item start at 1p, <b>Good luck!</b></p>";
                    }
                    else
                    {
                        double newvalue = double.Parse(lblCurrentBid.Text.Replace("<b>$ ", "").Replace("</b>", "")) + 0.10;
                        litUpdate.Text = "<p>Minimum bid for this item is $ " + newvalue.ToString("0.00") + ", <b>Bid now!<b/></p>";
                    }
                }
            }
        }

        public string FormatAmount (string x)
		{
			if(x=="")
				return "No bids";
			else
			{
			
				decimal d = (decimal)Convert.ToDecimal(x);
				string s =String.Format("{0:F2}", d); // "54.97"
				return "$ "+s;}
		}

		public string FormatCountdown(string dtIn)
		{
			string returnvalue="";
			//change end date to count down (disable all buttons if finished)
			DateTime dtCount = new DateTime();
			dtCount = (DateTime)Convert.ToDateTime(dtIn);
			// int ticker = DateTime.Now.Ticks - dtCount.Ticks;
			//Response.Write(ticker.ToString());

			if (dtCount.Ticks>DateTime.Now.Ticks)
			{
                if ((dtCount.AddTicks(-DateTime.Now.Ticks).Month - 1) > 0) returnvalue += (dtCount.AddTicks(-DateTime.Now.Ticks).Month - 1) + "month(s) ";
				
				if((dtCount.AddTicks(-DateTime.Now.Ticks).Day-1)>0) returnvalue+=(dtCount.AddTicks(-DateTime.Now.Ticks).Day-1)+ "d ";
				if(dtCount.AddTicks(-DateTime.Now.Ticks).Hour>0) returnvalue+=dtCount.AddTicks(-DateTime.Now.Ticks).Hour+ "h ";
			
				if(dtCount.AddTicks(-DateTime.Now.Ticks).Minute>0) 
				{
					returnvalue+=(dtCount.AddTicks(-DateTime.Now.Ticks).Minute)+ "m ";
				}

				if  (!((dtCount.AddTicks(-DateTime.Now.Ticks).Day-1)>0) &
					(!(dtCount.AddTicks(-DateTime.Now.Ticks).Hour>0)) &
					(!(dtCount.AddTicks(-DateTime.Now.Ticks).Minute>5)))
					returnvalue+=dtCount.AddTicks(-DateTime.Now.Ticks).Second+ "s";
			}
			else
			{
				//auction closed
				returnvalue = "<font color=red>Ended</font>";
				btnBid.Enabled=false;
				txtBid.Enabled=false;
			}
			
			return returnvalue;
		}


		private void getItem()
		{

            using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("spItemDetails", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@item_id", lbItemId.Text));

                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {

                        while (rdr.Read())
                        {
                            lblCurrentBid.Text = "<b>" + FormatAmount(rdr["item_amount"].ToString()) + "</b>";
                            lblItemName.Text = rdr["item_name"].ToString();
                            lblDescription.Text = rdr["item_description"].ToString().Replace("\r\n", "<br>");
                            lblEndTime.Text = "<b>" + FormatCountdown(rdr["item_date_close"].ToString()) + "</b> (" + (Convert.ToDateTime(rdr["item_date_close"].ToString())).ToString("r") + ")";
                            lblSeller.Text = "<b>" + rdr["item_seller"].ToString() + "</b>";
                            lblHighBidder.Text = "<b>" + rdr["item_bidder"].ToString() + "</b>";
                            lnkBids.Text = "<b>" + rdr["item_bids"].ToString() + " bid(s)</b>";
                            if (lnkBids.Text != "<b>0 bid(s)</b>")
                                lnkBids.NavigateUrl = "History.aspx?i=" + lbItemId.Text;
                            if (lblHighBidder.Text == "<b></b>")
                                lblHighBidder.Text = "<b>None</b>";
                            lblLocation.Text = "<b>" + rdr["item_location"].ToString() + "</b>";
                            if (lblLocation.Text == "<b></b>") lblLocation.Text = "<b>Not specified</b>";
                            if (lblDescription.Text == "")
                                lblDescription.Text = "No description";

                            if (rdr["img"].ToString() != "")
                            {
                                lblDescription.Text = lblDescription.Text +
                                    "<div id='AuctionImageContainer'><img id='AuctionImage' src='auction_pictures/" + rdr["img"].ToString() + "'/></div>";
                            }
                        }

                    }
                }
            }


		}
		
		protected void btnBid_Click(object sender, System.EventArgs e)
		{
			string fullname = Common.GetFullName(Request.ServerVariables["AUTH_USER"].ToString());
            decimal bidamount = Convert.ToDecimal(txtBid.Text.ToString());

            if(bidamount>214500)
            {
                litUpdate.Text = @"
                                <p>
                                <b>Your bid was rejected,</b> <br>
                                Did you mean to bid $" +bidamount.ToString("0.00")+@" ?<br/>
                                If so you have too much money!";                

            }
            else
            {
            using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("spBid", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@item_id", lbItemId.Text));
                    cmd.Parameters.Add(new SqlParameter("@amount", bidamount));
                    cmd.Parameters.Add(new SqlParameter("@bidder", fullname));

                    if (cmd.ExecuteScalar().Equals(1))
                    {
                        //bid was a success
                        litUpdate.Text = "<p>You are currently the <b>highest bidder</b>, Good luck!</p>";
                    }
                    //was not a success    
                    else
                    {
                        //too late message.  ha to the last min snipper
                        if (lblEndTime.Text.Contains("Ended"))
                        { 
                            litUpdate.Text = "<p>Bidding on this item has finished.  I'm sorry you was too late!</p>";
                        }
                        //bid reject message
                        else
                        {
                            double newvalue = double.Parse(lblCurrentBid.Text.Replace("<b>$ ", "").Replace("</b>", "")) + 0.10;
                            litUpdate.Text = @"
                                <p><b>Your bid was rejected,</b> <br>
                                Bid amount was too low or someone else has out bid you.<br/>
                                <br/>
                                The minimum bid for this item is $ " +  newvalue.ToString("0.00") + ", Good luck!</p>";

                        }

                    }
                }
            }
            }
			getItem();
            txtBid.Text = "";
            
		}

        protected void LinkButton1_Click(object sender, System.EventArgs e)
        {
            getItem();

            if (lblEndTime.Text.Contains("Ended"))
            {

                litUpdate.Text = "<p>Bidding on this item has finished.  I'm sorry you was too late!</p>";
            }
            else
            {
                //auto populate next bid
                if (lblCurrentBid.Text.Equals("<b>No bids</b>"))
                {
                    litUpdate.Text = "<p>Bidding on this item start at 1p, <b>Good luck!</b></p>";
                }
                else
                {
                    double newvalue = double.Parse(lblCurrentBid.Text.Replace("<b>$ ", "").Replace("</b>", "")) + 0.10;
                    litUpdate.Text = "<p>Minimum bid for this item is $ " + newvalue.ToString("0.00") + ", <b>Bid now!<b/></p>";
                }
            }

            txtBid.Text = "";
        }      
	}
}
