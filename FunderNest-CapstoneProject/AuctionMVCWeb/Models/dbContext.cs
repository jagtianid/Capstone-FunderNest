using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace AuctionMVCWeb.Models
{
    public class dbContext : DbContext
    {
        public DbSet<UserInfo> userInfo { get; set; }

    }
}