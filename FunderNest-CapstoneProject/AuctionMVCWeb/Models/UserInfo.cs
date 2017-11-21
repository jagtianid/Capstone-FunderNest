using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AuctionMVCWeb.Models
{
    public class UserInfo
    {

        //Model for a regular and admin user 
        [Key]
        public int ID { get; set; }

        [Required(ErrorMessage = "First Name is required.")]
        public string FName { get; set; }

        [Required(ErrorMessage = "Last Name is required.")]
        public string LName { get; set; }

        [Required(ErrorMessage = "Email is required.")]
        [RegularExpression(@"^([\w-\.]+)@((\[[0-9]{1,3]\.)|(([\w-]+\.)+))([a-zA-Z{2,4}|[0-9]{1,3})(\]?)$", ErrorMessage = "Please enter valid email.")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Password is required.")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Compare("Password", ErrorMessage = "Please re-type your password.")]
        [DataType(DataType.Password)]
        public string ConfirmPassword { get; set; }


        public string AdminKey { get; set; }

    }

}




