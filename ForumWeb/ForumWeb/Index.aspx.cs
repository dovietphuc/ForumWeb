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

            int categoryid = Int32.Parse(Request.QueryString["categoryid"] != null ? Request.QueryString["categoryid"] : "-1" );

            LoadDataRptrBlog(categoryid);
        }
        private void LoadDataRptrCategories()
        {
            try
            {
                SqlDataAdapter sda = new SqlDataAdapter("select * from BlogType WHERE iParentBlogTypeId IS NULL", con);
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
        private void LoadDataRptrBlog(int categoryid = -1)
        {
            try
            {
                SqlCommand cmd = new SqlCommand();
                string sql = "select * from Blog";
                cmd = con.CreateCommand();
                if (categoryid != -1)
                {
                    List<int> childs = getSubTypesForParent(categoryid);
                    sql += " WHERE iBlogTypeId = @categoryid";
                    if (childs != null)
                    {
                        foreach (int child in childs)
                        {
                            sql += " OR iBlogTypeId = " + child;
                        }
                    }
                    cmd.Parameters.AddWithValue("@categoryid", categoryid);
                }
                cmd.CommandText = sql;
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

        private List<int> getSubTypesForParent(int parentId)
        {
            try
            {
                string query = "select * from BlogType WHERE iParentBlogTypeId = @parentid";
                SqlCommand cmd = con.CreateCommand();
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@parentid", parentId);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                int i = sda.Fill(dt);
                if(i > 0)
                {
                    List<int> childs = new List<int>();
                    foreach(DataRow row in dt.Rows)
                    {
                        childs.Add(Int32.Parse(row["iId"].ToString()));
                    }
                    return childs;
                } else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
                return null;
            }
        }

        protected void RptCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater childRepeater = (Repeater)e.Item.FindControl("RptSubCategory");
                int parentCategoryid = (int)((DataRowView)e.Item.DataItem)["iId"];

                try
                {
                    string query = "select * from BlogType WHERE iParentBlogTypeId = @parentid";
                    SqlCommand cmd = con.CreateCommand();
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@parentid", parentCategoryid);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    childRepeater.DataSource = dt;
                    childRepeater.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
        }
    }
}