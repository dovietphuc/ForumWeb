using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
        }
        private void LoadDataRptrBlog()
        {

            var blogId = Request.QueryString["Id"];
            //string sql = "exec select_news_child @CategoryID";
            //cmd = new SqlCommand(sql, con);
            //cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(hdfCategoryID.Value));

            //sda = new SqlDataAdapter(cmd);
            //ds = new DataSet();
            //sda.Fill(ds);
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
    }
}