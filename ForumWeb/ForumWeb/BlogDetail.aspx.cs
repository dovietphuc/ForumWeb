using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ForumWeb
{
    public partial class BlogDetail : System.Web.UI.Page
    {
        SqlConnection con = DBConnection.getConnection();
        SqlCommand cmd = new SqlCommand();
        SqlDataAdapter sda = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (IsPostBack) return;
            LoadDataRptrBlog();
            LoadDataBlogFile();
            LoadDataRptrUser();
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
                        + ds.Tables[0].Rows[i]["surl"].ToString().Remove(0,5) 
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
    }
}