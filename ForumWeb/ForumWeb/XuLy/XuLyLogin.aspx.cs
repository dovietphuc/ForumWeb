using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ForumWeb.XuLy
{
    public partial class XuLyLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Request.Form["username"];
            string pwd = Request.Form["pwd"];

            if (username != null && pwd != null)
            {
                User user = tryLogin(username, pwd);
                if (user != null)
                {
                    Application["user"] = user;
                    Session["user"] = user;
                    Response.Redirect("../Index.aspx");
                    return;
                }
                else
                {
                    Response.Redirect("../Login.aspx?err=1");
                    return;
                }
            }

            Response.Redirect("../Login.aspx");
        }

        private User tryLogin(string ussername, string pwd)
        {

            string query = "SELECT * FROM [dbo].[User] WHERE [sUserName] like @username AND [sHashedPassword] like @pwd";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand sqlCommand = connection.CreateCommand();
            sqlCommand.CommandText = query;
            sqlCommand.Parameters.AddWithValue("@username", ussername);
            sqlCommand.Parameters.AddWithValue("@pwd", pwd.GetHashCode());
            SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlCommand);
            DataTable dataTable = new DataTable();
            int i = dataAdapter.Fill(dataTable);
            if(i == 1)
            {
                User user = new User();
                user.Id = Int32.Parse(dataTable.Rows[0]["iId"].ToString());
                user.Username = dataTable.Rows[0]["sUserName"].ToString();
                user.Fullname = dataTable.Rows[0]["sName"].ToString();
                user.Email = dataTable.Rows[0]["sEmail"].ToString();
                user.Phone = dataTable.Rows[0]["sPhone"].ToString();
                user.CreateTime = (DateTime)dataTable.Rows[0]["dCreatedDate"];
                user.Avatar = dataTable.Rows[0]["sAvatarUrl"].ToString();
                return user;
            }
            return null;
        }
    }
}