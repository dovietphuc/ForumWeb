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
                bool isSuccess = registerUser(username, pwd);
                if (isSuccess)
                {
                    Response.Redirect("../Login.aspx?registSuccess=1");
                    return;
                } else
                {
                    Response.Redirect("../SignUp.aspx?err=1");
                    return;
                }
            }

            Response.Redirect("../Login.aspx");
        }

        private bool registerUser(string username, string pwd)
        {
            if (isExistUsername(username)) return false;

            string query = "INSERT INTO [dbo].[User]"
            + " ([sUserName]"
            + " ,[sHashedPassword]"
            + " ,[iPermissionId])"
            + " VALUES"
            + " (@sUserName"
            + " , @sHashedPassword, " + getNormalPermissionId() + ")";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand sqlCommand = connection.CreateCommand();
            sqlCommand.CommandText = query;
            sqlCommand.Parameters.AddWithValue("@sUserName", username);
            sqlCommand.Parameters.AddWithValue("@sHashedPassword", pwd.GetHashCode());
            connection.Open();
            int i = sqlCommand.ExecuteNonQuery();
            connection.Close();
            return i > 0;
        }

        public bool isExistUsername(string username)
        {
            string query = "SELECT sUserName FROM [dbo].[User] WHERE sUserName like @username";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand sqlCommand = connection.CreateCommand();
            sqlCommand.CommandText = query;
            sqlCommand.Parameters.AddWithValue("@username", username);
            int i = new SqlDataAdapter(sqlCommand).Fill(new DataSet());
            return i > 0;
        }

        public int getNormalPermissionId()
        {
            string query = "SELECT [iId],[sName],[sDescription] FROM [dbo].[Permission] WHERE sName like N'Normal'";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand sqlCommand = connection.CreateCommand();
            sqlCommand.CommandText = query;
            DataTable tb = new DataTable();
            int i = new SqlDataAdapter(sqlCommand).Fill(tb);
            if(i > 0)
            {
                return Int32.Parse(tb.Rows[0]["iId"].ToString());
            }
            return -1;
        }
    }
}