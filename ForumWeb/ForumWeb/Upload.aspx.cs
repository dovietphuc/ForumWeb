using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace ForumWeb
{
    public partial class Upload : System.Web.UI.Page
    {
        User user;

        protected void Page_Load(object sender, EventArgs e)
        {
            user = (User)Application["user"];

            if (user == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (IsPostBack) return;

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            btnSubmit.Enabled = false;
            string query = "INSERT INTO[dbo].[Blog]"
                               + " ([sName]"
                               + " ,[sContent]"
                               + (ListBoxCategories.SelectedItem != null ? " ,[iBlogTypeId]" : "")
                               + " ,[iUserId]"
                               + " ,[iViewCount]"
                               + " ,[bIsPinned])"
                         + " VALUES"
                               + " (@sName"
                               + " , @sContent"
                               + (ListBoxCategories.SelectedItem != null ? " , @iBlogTypeId" : "")
                               + " , @iUserId"
                               + " , @iViewCount"
                               + " , @bIsPinned)";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand command = connection.CreateCommand();
            command.CommandText = query;
            command.Parameters.AddWithValue("@sName", txtTitle.Value);
            command.Parameters.AddWithValue("@sContent", txtContent.Value);
            if (ListBoxCategories.SelectedItem != null)
            {
                command.Parameters.AddWithValue("@iBlogTypeId", Int32.Parse(ListBoxCategories.SelectedValue));
            }
            command.Parameters.AddWithValue("@iUserId", user.Id);
            command.Parameters.AddWithValue("@iViewCount", 0);
            command.Parameters.AddWithValue("@bIsPinned", false);
            connection.Open();
            int i = command.ExecuteNonQuery();
            command.CommandText = "Select @@Identity";
            int recID = Int32.Parse(command.ExecuteScalar().ToString());
            if (i > 0 && recID > 0)
            {
                if (iUpload.HasFiles) {
                    string queryAddImage = "INSERT INTO [dbo].[Images]"
                                                + " ([sUrl]"
                                                + " ,[iBlogId])"
                                                + " VALUES"
                                                + " (@sUrl"
                                                + " ,@iBlogId)";
                    
                    foreach (HttpPostedFile postedFile in iUpload.PostedFiles)
                    {
                        string fileName = "~/App_Data/Image/" + user.Username + "_" + (DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond);
                        string filepath = MapPath(fileName);
                        postedFile.SaveAs(filepath);
                        SqlCommand cmd = connection.CreateCommand();
                        cmd.CommandText = queryAddImage;
                        cmd.Parameters.AddWithValue("@sUrl", fileName);
                        cmd.Parameters.AddWithValue("@iBlogId", recID);
                        cmd.ExecuteNonQuery();
                    }
                }

                if (fUpload.HasFiles)
                {
                    string queryAddImage = "INSERT INTO [dbo].[Fliles]"
                                                + " ([sUrl]"
                                                + " ,[iBlogId])"
                                                + " VALUES"
                                                + " (@sUrl"
                                                + " ,@iBlogId)";

                    foreach (HttpPostedFile postedFile in fUpload.PostedFiles)
                    {
                        string fileName = "~/App_Data/File/" + user.Username + "_" + (DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond);
                        string filepath = MapPath(fileName);
                        postedFile.SaveAs(filepath);
                        SqlCommand cmd = connection.CreateCommand();
                        cmd.CommandText = queryAddImage;
                        cmd.Parameters.AddWithValue("@sUrl", fileName);
                        cmd.Parameters.AddWithValue("@iBlogId", recID);
                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect("Index.aspx");
            }
            else
            {
                btnSubmit.Enabled = true;
            }
            connection.Close();
        }
    }
}