using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ForumWeb.Model
{
    public class DBConnection
    {
        public static string strCon = ConfigurationManager.ConnectionStrings["dbconnect"].ConnectionString;

        public static SqlConnection getConnection()
        {
            return new SqlConnection(strCon);
        }
    }
}