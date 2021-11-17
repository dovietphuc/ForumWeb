using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace ForumWeb.XuLy
{
    public partial class XuLySignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Request.Form["username"];
            string pwd = Request.Form["pwd"];
            string repwd = Request.Form["re-pwd"];

            if (username != null && pwd != null && repwd != null && pwd.Equals(repwd))
            {
                registerUser(username, pwd);
            }

            Response.Redirect("../Login.aspx");
        }

        private bool registerUser(string ussername, string pwd)
        {

            string query = "INSERT INTO [dbo].[User]"
            + " ([sUserName]"
            + " ,[sHashedPassword])"
            + " VALUES"
            + " (@sUserName"
            + " , @sHashedPassword)";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand sqlCommand = connection.CreateCommand();
            sqlCommand.CommandText = query;
            sqlCommand.Parameters.AddWithValue("@sUserName", ussername);
            sqlCommand.Parameters.AddWithValue("@sHashedPassword", pwd.GetHashCode());
            connection.Open();
            int i = sqlCommand.ExecuteNonQuery();
            connection.Close();
            return i > 0;
        }
    }
}