using System;
using System.Configuration;

using System.Collections.Specialized;
using System.Reflection;
using System.DirectoryServices;

namespace SoftwareSolutions
{
    public class Common
    {

        public static string ConnectionString
        {
            get
            {
                return GetValueFromWebConfig("DatabaseConnection");
            }
        }

        public static string GetValueFromWebConfig(string key)
        {
            // Get the AppSettings collection.
            NameValueCollection appSettings = ConfigurationManager.AppSettings;

            return appSettings[key];
        }

        public static string GetApplicationVersion()
        {
            Assembly objAssembly = Assembly.GetExecutingAssembly();
            Version AppVersion = objAssembly.GetName().Version;

            return AppVersion.Major.ToString() + "." + AppVersion.Minor.ToString() + "." + AppVersion.Build.ToString();
        }

        public static string GetFullName(string strLogin)
        {
            string str = "";
            string strDomain;
            string strName;

            // Parse the string to check if domain name is present.
            int idx = strLogin.IndexOf('\\');
            if (idx == -1)
            {
                idx = strLogin.IndexOf('@');
            }

            if (idx != -1)
            {
                strDomain = strLogin.Substring(0, idx);
                strName = strLogin.Substring(idx + 1);
            }
            else
            {
                strDomain = Environment.MachineName;
                strName = strLogin;
            }

            DirectoryEntry obDirEntry = null;
            try
            {
                obDirEntry = new DirectoryEntry("WinNT://" + strDomain + "/" + strName);
                System.DirectoryServices.PropertyCollection coll = obDirEntry.Properties;
                object obVal = coll["FullName"].Value;
                str = obVal.ToString();
            }
            catch //(Exception ex)
            {
                str = strLogin;// ex.Message;
            }
            return str;
        }
    }
}
