using AuctionMVCWeb.com.paypal.sandbox.www;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;


namespace AuctionMVCWeb.API
{
    public class PayPalAPIUtil
    {
        public static string Version
        {
            get { return ConfigurationManager.AppSettings["APIVersion"]; }
        }

        public static PayPalAPIAASoapBinding BuildPayPalWebservice()
        {
            // more details on https://www.paypal.com/en_US/ebook/PP_APIReference/architecture.html
            UserIdPasswordType credentials = new UserIdPasswordType()
            {
                Username = ConfigurationManager.AppSettings["APIUsername"],
                Password = ConfigurationManager.AppSettings["APIPassword"],
                Signature = ConfigurationManager.AppSettings["APISignature"],
            };

            PayPalAPIAASoapBinding paypal = new PayPalAPIAASoapBinding();
            paypal.RequesterCredentials = new CustomSecurityHeaderType()
            {
                Credentials = credentials
            };

            return paypal;
        }

        internal static void HandleError(AbstractResponseType resp)
        {
            if (resp.Errors != null && resp.Errors.Length > 0)
            {
                // errors occured
                throw new Exception("Exception(s) occured when calling PayPal. First exception: " +
                    resp.Errors[0].LongMessage);
            }
        }
    }
}