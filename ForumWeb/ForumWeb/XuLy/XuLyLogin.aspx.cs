﻿using ForumWeb.Model;
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
                }
                else
                {
                    Response.Redirect("../Login.aspx");
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
            sqlCommand.Parameters.AddWithValue("@pwd", pwd);
            SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlCommand);
            DataTable dataTable = new DataTable();
            int i = dataAdapter.Fill(dataTable);
            if(i == 1)
            {
                User user = new User();
                user.Username = dataTable.Rows[0]["sUserName"].ToString();
                return user;
            }
            return null;
        }
    }
}