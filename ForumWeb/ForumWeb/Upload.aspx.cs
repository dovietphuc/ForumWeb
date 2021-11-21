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
                               + " ,[bIsPinned]"
                               + " ,[iStatusId])"
                         + " VALUES"
                               + " (@sName"
                               + " , @sContent"
                               + (ListBoxCategories.SelectedItem != null ? " , @iBlogTypeId" : "")
                               + " , @iUserId"
                               + " , @iViewCount"
                               + " , @bIsPinned"
                               + ", @statusId)";
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
            command.Parameters.AddWithValue("@statusId", getDefaultStatusId());
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
                        string fileName = "Image/" + user.Username + "_" + (DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond) + postedFile.FileName.Replace(" ", "");
                        string filepath = MapPath("~/" + fileName);
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
                        string fileName = "file/" + user.Username + "_" + (DateTime.Now.Ticks / TimeSpan.TicksPerMillisecond) + postedFile.FileName.Replace(" ", "");
                        string filepath = MapPath("~/" + fileName);
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

        public int getDefaultStatusId()
        {
            string query = "SELECT [iId],[sName],[sDescription] FROM [dbo].[Status] WHERE sName like N'Chưa duyệt'";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand sqlCommand = connection.CreateCommand();
            sqlCommand.CommandText = query;
            DataTable tb = new DataTable();
            int i = new SqlDataAdapter(sqlCommand).Fill(tb);
            if (i > 0)
            {
                return Int32.Parse(tb.Rows[0]["iId"].ToString());
            }
            return -1;
        }
    }
}