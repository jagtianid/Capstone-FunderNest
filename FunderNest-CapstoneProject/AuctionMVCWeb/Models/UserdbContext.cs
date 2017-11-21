using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace AuctionMVCWeb.Models
{
    public class UserdbContext :DbContext
    {
        public UserdbContext() : base("name=auction") { }

        public DbSet<UserInfo> userInfo { get; set; }
        public DbSet<AdminInfo> adminInfo { get; set; }

    }
}