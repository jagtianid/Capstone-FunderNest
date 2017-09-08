using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Capstone_Project_Prototype.Controllers
{
    public class DementiaHackathonController : Controller
    {
        public RedirectResult auction()
        {
            return Redirect("~/Auctions.aspx");
        }

        public RedirectResult addAuction()
        {
            return Redirect("~/AddAuction.aspx");
        }


        public ActionResult Auctions()
        {
            return View();
        }

    }
}