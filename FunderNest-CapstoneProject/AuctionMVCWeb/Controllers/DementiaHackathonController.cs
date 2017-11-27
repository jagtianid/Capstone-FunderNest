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

        public RedirectResult RedirectToAspx()
        {
            return Redirect("/pages/index.aspx");
        }

        [HttpPost]
        public ActionResult SendEmailView()
        {
            //call SendEmailView view to invoke webmail  
            return View();
        }

    }
}