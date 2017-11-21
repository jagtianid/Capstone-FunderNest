using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AuctionMVCWeb.Models;
using System.DirectoryServices;
using System.Data.SqlClient;
using SoftwareSolutions;
using System.Web.Security;

namespace AuctionMVCWeb.Controllers
{
    public class UserController : Controller
    {

        private UserdbContext db = new UserdbContext();
        // GET: User
        public ActionResult Index()
        {
            using (UserdbContext db = new UserdbContext())
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
                using (UserdbContext db = new UserdbContext())
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
            using (UserdbContext db = new UserdbContext())
            {
                var usr = db.userInfo.Where(u => u.Email == user.Email && u.Password == user.Password).FirstOrDefault();
                if (usr != null)
                {
                    Session["ID"] = user.ID.ToString();
                    Session["FName"] = usr.FName.ToString();
                    Session["LName"] = usr.LName.ToString();
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

        public ActionResult LoginAdmin()
        {

            return View();

        }
        [HttpPost]
        public ActionResult LoginAdmin(UserInfo admin)
        {
            using (UserdbContext db = new UserdbContext())
            {
                var adm = db.userInfo.Where(a => a.Email == admin.Email && a.Password == admin.Password && a.AdminKey == admin.AdminKey).FirstOrDefault();
                if (adm != null)
                {
                    Session["ID"] = admin.ID.ToString();
                    Session["Email"] = admin.Email.ToString();
                    Session["Password"] = admin.Password.ToString();
                    Session["AdminKey"] = admin.AdminKey.ToString();

                    return RedirectToAction("AdminLoggedIn");


                }
                else
                {
                    ModelState.AddModelError("", "The username, password  or admin key is incorrect.");
                }

            }
            return View();
        }

        public ActionResult AdminLoggedIn()
        {
            if (Session["Id"] != null)
            {
                return Redirect("~/EndedBids.aspx");
            }
            else
            {
                return RedirectToAction("LoginAdmin");
            }


        }

        public ActionResult Logout()
        {
            Session.Clear();
            FormsAuthentication.SignOut();
            return Redirect("/Home/Index");
        }
    }
}