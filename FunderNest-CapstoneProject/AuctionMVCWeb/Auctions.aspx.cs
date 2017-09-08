using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace SoftwareSolutions.CharityAuction
{
	/// <summary>
	/// Summary description for WebForm1.
	/// </summary>
	public partial class Auctions : System.Web.UI.Page
	{
        public int iCategory
        {
            get
            {
                if (Request.QueryString["c"] != null)
                {
                    Response.Cookies["c"].Value = Request.QueryString["c"].ToString();
                    return int.Parse(Request.QueryString["c"].ToString());
                }
                else if (Request.Cookies["c"] != null)
                {
                    return int.Parse(Request.Cookies["c"].Value.ToString());
                }
                else
                {
                    return 0;
                }
            }
        }

		protected void Page_Load(object sender, System.EventArgs e)
		{
           
            //use qstring for sorting?
            if (Request.QueryString["s"] == null)
            {
                getListings("DateClose",iCategory);
            }
            else
            {
                getListings(Request.QueryString["s"],iCategory);
            }

            litTotal.Text = getTotalRaised();
		}
		public string FormatDescription (string x)
		{
			if(x.Length<130)
				return x;
			else
				return x.Substring(0,130)+"<span title='..."+x.Substring(130)+"'>...</span>";
		}

        public string FormatAmount(string s)
        {
            if (s.Equals(string.Empty))
                return "No bids";
            else
            {
                return "$ " + String.Format("{0:F2}", decimal.Parse(s)); // "54.97"
            }
        }
        public string FormatAmount(decimal d)
        {
            if (d.Equals(0))
                return "No bids";
            else
            {
                return "$ " + String.Format("{0:F2}", d); // "54.97"
            }
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

                if ((dtCount.AddTicks(-DateTime.Now.Ticks).Month - 1) > 0)
                {
                    returnvalue = dtCount.ToString("dd-MMM-yyyy HH:mm");
                }
                else
                {
                    if ((dtCount.AddTicks(-DateTime.Now.Ticks).Day - 1) > 0) returnvalue += (dtCount.AddTicks(-DateTime.Now.Ticks).Day - 1) + "d ";
                    if (dtCount.AddTicks(-DateTime.Now.Ticks).Hour > 0) returnvalue += dtCount.AddTicks(-DateTime.Now.Ticks).Hour + "h ";

                    if (dtCount.AddTicks(-DateTime.Now.Ticks).Minute > 0)
                    {
                        returnvalue += dtCount.AddTicks(-DateTime.Now.Ticks).Minute + "m ";
                    }

                    if (!((dtCount.AddTicks(-DateTime.Now.Ticks).Day - 1) > 0) &
                        (!(dtCount.AddTicks(-DateTime.Now.Ticks).Hour > 0)) &
                        (!(dtCount.AddTicks(-DateTime.Now.Ticks).Minute > 5)))
                        returnvalue += dtCount.AddTicks(-DateTime.Now.Ticks).Second + "s";
                }
			}
			else
			{
				//auction closed
				returnvalue = "<font color=red>Ended</font>";
			}
			
			return returnvalue;
		}

        private string getTotalRaised()
        {
            using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("spTotalRaised", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    decimal returnvalue;
                    if (decimal.TryParse(cmd.ExecuteScalar().ToString(), out returnvalue))
                    {
                        return returnvalue.ToString("0.00");
                    }
                    else
                    {
                        return "0.00";
                    }                  
                    
                }
            }
        }
        private string getCategoryName(int intCatId)
        {
            if (intCatId.Equals(0))
            {
                return "All";
            }
            else
            {
                using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("spCatName", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@cat_id", intCatId));
                        return cmd.ExecuteScalar().ToString();
                    }
                }
            }
        }

		private void getListings(string sSort, int iCategory)
        {
            AuctionItems auctionItems = new AuctionItems();

			using (SqlConnection conn = new SqlConnection(Common.ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("spListings", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (iCategory.Equals(0))
                    {
                        cmd.Parameters.Add(new SqlParameter("@cat_id", DBNull.Value));
                    }
                    else
                    {
                        cmd.Parameters.Add(new SqlParameter("@cat_id", iCategory));
                    }
                    
                    conn.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            AuctionItem item = new AuctionItem();

                            item.Id = dr["item_id"].ToString();
                            item.Name = dr["item_name"].ToString();
                            item.Description = dr["item_description"].ToString();
                            item.DateOpen = DateTime.Parse(dr["item_date_open"].ToString());
                            item.DateClose = DateTime.Parse(dr["item_date_close"].ToString());
                            item.Seller = dr["item_seller"].ToString();
                            item.Location = dr["item_location"].ToString();
                            if(dr["item_amount"].ToString().Equals(string.Empty))
                                item.BidAmount = 0;
                            else
                                item.BidAmount = decimal.Parse(dr["item_amount"].ToString());
                            item.Buyer = dr["item_bidder"].ToString();
                            item.BidNumber = int.Parse(dr["item_bids"].ToString());
                            //item.Category = dr["cat_name"].ToString();
                            auctionItems.Add(item);
                        }
                    }
                }
            }

            if (auctionItems.Count == 0)
            {
                AuctionItem item = new AuctionItem();
                item.Description = "No items listed.";
                auctionItems.Add(item);
                //Response.Write("No items listed.");
            }
            //else
            //{
                //Sort
                if (sSort.Equals("DateClose") ||
                    sSort.Equals("Name") ||
                    sSort.Equals("Buyer") ||
                    sSort.Equals("BidAmount") ||
                    sSort.Equals("Category") )
                {
                    auctionItems.Sort(sSort, SortOrderEnum.Ascending);
                }
                else
                {
                    auctionItems.Sort(sSort, SortOrderEnum.Descending);
                }

                dlListings.DataSource = auctionItems;
                dlListings.DataBind();		
            //}
		}
            	
	}
}
