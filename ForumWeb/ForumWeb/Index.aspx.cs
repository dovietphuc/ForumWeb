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
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection con = DBConnection.getConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            LoadDataRptrCategories();
            LoadDataRptrBlog();
        }
        private void LoadDataRptrCategories()
        {
            try
            {
                SqlDataAdapter sda = new SqlDataAdapter("select * from BlogType", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                RptCategory.DataSource = dt;
                RptCategory.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

        }
        private void LoadDataRptrBlog()
        {


            //string sql = "exec select_news_child @CategoryID";
            //cmd = new SqlCommand(sql, con);
            //cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(hdfCategoryID.Value));

            //sda = new SqlDataAdapter(cmd);
            //ds = new DataSet();
            //sda.Fill(ds);

            try
            {
                SqlCommand cmd = new SqlCommand();
                string sql = "select * from Blog where istatusid = 1";
                cmd = new SqlCommand(sql, con);
                //cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(hdfCategoryID.Value));

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
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
    }
}