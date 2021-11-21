using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ForumWeb
{
    public partial class BlogDetail : System.Web.UI.Page
    {
        SqlConnection con = DBConnection.getConnection();
        SqlCommand cmd = new SqlCommand();
        SqlDataAdapter sda = new SqlDataAdapter();
        DataSet ds = new DataSet();
        User user = new User();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["Id"]))
            {
                Response.Redirect("Index.aspx");
                return;
            }
            user = (User)Application["user"];
            bool isAd = isAdmin(user);
            forAdmin.Visible = isAd;
            bool isAp = isAprovide(Int32.Parse(Request.QueryString["Id"]));
            if (!isAp && !isAd)
            {
                Response.Redirect("Index.aspx");
                return;
            }

            if (IsPostBack) return;

            if (isAd)
            {
                if (isAp)
                {
                    aprovide.Visible = false;
                    notaprovide.Visible = true;
                }
                else
                {
                    aprovide.Visible = true;
                    notaprovide.Visible = false;
                }
            }

            if (user != null)
            {
                imgAvartar.ImageUrl = user.Avatar;
            }
            iViewCount();
            LoadDataRptrBlog();
            LoadDataBlogFile();
            LoadDataRptrUser();
            LoadDataRptrComment();
        }
        private void iViewCount()
        {
            var blogId = Request.QueryString["Id"];
            SqlCommand cmd = new SqlCommand("update_view_blog", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@blogId", Convert.ToInt32(blogId));
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        private void LoadDataRptrBlog()
        {

            var blogId = Request.QueryString["Id"];
            con.Open();
            try
            {
                string sql = "select * from Blog where iId = @id";
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", Convert.ToInt32(blogId));

                sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                RptBlog.DataSource = dt;
                RptBlog.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

        }
        private void LoadDataBlogFile()
        {

            var blogId = Request.QueryString["Id"];
            string sql = "select * from Fliles where iblogid = @iId";
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@iId", Convert.ToInt32(blogId));

            sda = new SqlDataAdapter(cmd);
            ds = new DataSet();
            try
            {
                sda.SelectCommand = cmd;
                sda.Fill(ds, "reg");
                var data = ds.Tables[0].Rows;
                for (int i = 0; i < data.Count; i++)
                {
                    contentFile.InnerHtml += @"<div><a href='/FileExplorer.aspx?txtFile="
                        + ds.Tables[0].Rows[i]["surl"].ToString().Remove(0, 5)
                        + "'>" + ds.Tables[0].Rows[i]["surl"].ToString().Remove(0, 5)
                        + @"</a></div>";
                }
            }
            catch (Exception e)
            {

                Console.Write(e);
            }
        }
        protected void RptBlog_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                // lấy thằng id category
                var hdfBlogID = (Label)e.Item.FindControl("hdfBlogID");
                var RptImages = (Repeater)e.Item.FindControl("RptImages");

                string sql = "select * from images where iblogid = @iId";
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@iId", Convert.ToInt32(hdfBlogID.Text));

                sda = new SqlDataAdapter(cmd);
                ds = new DataSet();
                sda.Fill(ds);

                RptImages.DataSource = ds;
                RptImages.DataBind();

                con.Close();
            }
        }
        private void LoadDataRptrUser()
        {

            var blogId = Request.QueryString["Id"];
            try
            {
                string sql = "exec select_user_by_idBlog @blogId";
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@blogId", Convert.ToInt32(blogId));

                sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                RptUser.DataSource = dt;
                RptUser.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

        }
        private void LoadDataRptrComment()
        {
            var blogId = Request.QueryString["Id"];
            try
            {
                string sql = "exec select_comment_by_idBlog @blogId";
                cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@blogId", Convert.ToInt32(blogId));

                sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                RptComment.DataSource = dt;
                RptComment.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var blogId = Request.QueryString["Id"];
            user = (User)Application["user"];
            if (user != null)
            {
                SqlCommand cmd = new SqlCommand("create_comment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                //string sql = "exec create_comment @blogId, @userId,@content";
                //cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@blogId", Convert.ToInt32(blogId));
                cmd.Parameters.AddWithValue("@userId", Convert.ToInt32(user.Id));
                cmd.Parameters.AddWithValue("@content", taComment.Value);

                con.Open();
                int res = cmd.ExecuteNonQuery();
                if (res > 0)
                {
                    LoadDataRptrComment();
                    taComment.Value = "";
                }
                else
                {

                }


            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            var a = button.Text;
            taComment.Value = "";
        }

        protected void RptCmt_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                try
                {
                    // lấy thằng id user
                    var cmtID = (Label)e.Item.FindControl("cmtID");
                    var RptChildComment = (Repeater)e.Item.FindControl("RptChildComment");

                    string sql = "exec select_comment_by_iParentcommentId  @iParentcommentId";
                    cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@iParentcommentId", Convert.ToInt32(cmtID.Text));

                    sda = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    sda.Fill(ds);

                    RptChildComment.DataSource = ds;
                    RptChildComment.DataBind();

                    con.Close();
                }
                catch (Exception)
                {


                }
            }
        }

        protected void cbAproved_Command_Rep(object sender, CommandEventArgs e)
        {
            LinkButton linkButton = (LinkButton)sender;
            var id = linkButton.Attributes["Tagkey"];
            string textareaValue = "";
            for (int i = 0; i < RptComment.Items.Count; i++)
            {
                HtmlTextArea currentTextArea = (HtmlTextArea)RptComment.Items[i].FindControl("taChildComment");
                if (currentTextArea.Value.Length > 0)
                {
                    textareaValue = currentTextArea.Value; //Get the textareavalue
                }
            }
            //HtmlTextArea currentTextArea = (HtmlTextArea)RptComment.Items[0].FindControl("taChildComment");

            //var blogId = Request.QueryString["Id"];
            user = (User)Application["user"];
            if (user != null)
            {
                SqlCommand cmd = new SqlCommand("create_child_comment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                //string sql = "exec create_comment @blogId, @userId,@content";
                //cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@blogId", Convert.ToInt32(id));
                cmd.Parameters.AddWithValue("@userId", Convert.ToInt32(user.Id));
                cmd.Parameters.AddWithValue("@content", textareaValue);

                con.Open();
                int res = cmd.ExecuteNonQuery();

                LoadDataRptrComment();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        private bool isAdmin(User user)
        {
            if (user == null) return false;

            string query = "SELECT * FROM [dbo].[User] JOIN [Permission] ON [User].iPermissionId = [Permission].iId" +
                " WHERE [Permission].sName like N'Admin' AND [User].iId = @userid";
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = query;
            cmd.Parameters.AddWithValue("@userid", user.Id);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            int i = sda.Fill(dt);
            return i > 0;
        }

        protected void aprovide_Click(object sender, EventArgs e)
        {
            user = (User)Application["user"];

            if (!isAdmin(user) || string.IsNullOrEmpty(Request.QueryString["Id"]))
            {
                return;
            }

            int blogId = Int32.Parse(Request.QueryString["Id"]);
            string query = "UPDATE [dbo].[Blog] SET [iStatusId] = " + getAprovideStatusId() + " WHERE iId = @id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@id", blogId);
            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();

            if(i > 0)
            {
                aprovide.Visible = false;
                notaprovide.Visible = true;
            }
        }

        protected void notaprovide_Click(object sender, EventArgs e)
        {
            user = (User)Application["user"];

            if (!isAdmin(user) || string.IsNullOrEmpty(Request.QueryString["Id"]))
            {
                return;
            }

            int blogId = Int32.Parse(Request.QueryString["Id"]);
            string query = "UPDATE [dbo].[Blog] SET [iStatusId] = " + getNotAprovideStatusId() + " WHERE iId = @id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@id", blogId);
            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();

            if (i > 0)
            {
                aprovide.Visible = true;
                notaprovide.Visible = false;
            }
        }

        public int getNotAprovideStatusId()
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

        public int getAprovideStatusId()
        {
            string query = "SELECT [iId],[sName],[sDescription] FROM [dbo].[Status] WHERE sName like N'Đã duyệt'";
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

        public bool isAprovide(int blogid)
        {
            string query = "SELECT * FROM [dbo].[Blog] JOIN [Status] ON [Blog].iStatusId = [Status].iId" +
                " WHERE [Status].sName like N'Đã duyệt' AND [Blog].iID = @blogId";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand sqlCommand = connection.CreateCommand();
            sqlCommand.CommandText = query;
            sqlCommand.Parameters.AddWithValue("@blogId", blogid);
            DataTable tb = new DataTable();
            int i = new SqlDataAdapter(sqlCommand).Fill(tb);
            return i > 0;
        }
    }
}