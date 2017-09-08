using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AuctionMVCWeb.Models;

namespace AuctionMVCWeb.Controllers
{
    public class UserController : Controller
    {
        // GET: User
        public ActionResult Index()
        {
            using (dbContext db = new dbContext())
            {
                return View(db.userInfo.ToList());
            }
        }

        //Register
        //Get
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(UserInfo info)
        {
           if (ModelState.IsValid)
            {
                using (dbContext db = new dbContext())
                {
                    db.userInfo.Add(info);
                    db.SaveChanges();
                }
                ModelState.Clear();
                ViewBag.Message = info.FName + " " + info.LName + " " + "has successfully registered.";
            }
            return View();
        }

        //Login 
        //Get
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(UserInfo user)
        {
            using (dbContext db = new dbContext())
            {
                var usr = db.userInfo.Where(u => u.Email == user.Email && u.Password == user.Password).FirstOrDefault();
                if (usr != null)
                {
                    Session["ID"] = user.ID.ToString();
                    Session["FName"] = usr.FName.ToString();
                    Session["Email"] = usr.Email.ToString();
                    return RedirectToAction("LoggedIn");
                }
                else
                {
                    ModelState.AddModelError("", "The username or password is incorrect.");
                }
            }
            return View();
        }
        public ActionResult LoggedIn()
        {
            if (Session["Id"] != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login");
            }
        }
    }
}