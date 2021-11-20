using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ForumWeb
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection con = DBConnection.getConnection();
        int page;
        int categoryid;
        int itemPerPage = 10;
        string search = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            categoryid = Int32.Parse(Request.QueryString["categoryid"] != null ? Request.QueryString["categoryid"] : "-1");
            search = Request.QueryString["search"];

            if (IsPostBack) return;

            LoadDataRptrCategories();

            initSubLink(headerLink, getBlogType(categoryid));
            headerLink.InnerHtml = " / <a href='Index.aspx'>Trang chủ</a>" + headerLink.InnerHtml;

            page = 1;


            LoadDataRptrBlog(categoryid, search);

            btnLoadMore.CommandArgument = page.ToString();
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

        private int LoadDataRptrBlog(int categoryid = -1, string txtSearch = null)
        {
            try
            {
                SqlCommand cmd = new SqlCommand();
                int top = itemPerPage * page;
                cmd = con.CreateCommand();

                if (txtSearch != null)
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "search_text_blog";
                    cmd.Parameters.AddWithValue("@text", txtSearch);
                    cmd.Parameters.AddWithValue("@top", top);
                }
                else
                {
                    string sql = "select TOP(" + top + ") * from Blog";

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

                    sql += " ORDER BY dCreatedDate DESC";
                    cmd.CommandText = sql;
                }

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                int i = sda.Fill(dt);
                RptBlog.DataSource = dt;
                RptBlog.DataBind();
                return i;
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            return 0;
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
                if (i > 0)
                {
                    List<int> childs = new List<int>();
                    foreach (DataRow row in dt.Rows)
                    {
                        childs.Add(Int32.Parse(row["iId"].ToString()));
                    }
                    return childs;
                }
                else
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

        private BlogType getBlogType(int id)
        {
            string query = "SELECT [iId]"
                               + " ,[sName]"
                               + " ,[sDescription]"
                               + " ,[iParentBlogTypeId]"
                               + " FROM[dbo].[BlogType] WHERE iId = @id";

            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = query;
            cmd.Parameters.AddWithValue("@id", id);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            int i = sda.Fill(dt);
            if (i > 0)
            {
                BlogType blogType = new BlogType();
                blogType.Id = id;
                blogType.Name = dt.Rows[0]["sName"].ToString();
                blogType.Description = dt.Rows[0]["sDescription"].ToString();
                string strParentId = dt.Rows[0]["iParentBlogTypeId"].ToString();
                if (!string.IsNullOrEmpty(strParentId))
                {
                    blogType.Parent = getBlogType(Int32.Parse(strParentId));
                }
                return blogType;
            }
            return null;
        }

        private void initSubLink(HtmlGenericControl html, BlogType blogType)
        {
            if (blogType == null)
            {
                return;
            }
            html.InnerHtml = @" / <a href='Index.aspx?categoryid=" + blogType.Id + "'>" + blogType.Name + "</a>" + html.InnerHtml;
            if (blogType.Parent != null)
            {
                initSubLink(html, blogType.Parent);
            }
        }

        protected void RptBlog_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HtmlGenericControl subLink = (HtmlGenericControl)e.Item.FindControl("blogTypeLink");
                int blogtypeid = (int)((DataRowView)e.Item.DataItem)["iBlogTypeId"];

                initSubLink(subLink, getBlogType(blogtypeid));

                initCmtCount((HtmlGenericControl)e.Item.FindControl("cmtCount"), (int)((DataRowView)e.Item.DataItem)["iId"]);

                initNguoiDang((int)((DataRowView)e.Item.DataItem)["iUserId"], e);
            }
        }

        private void initCmtCount(HtmlGenericControl cmtCount, int blogid)
        {
            string query = "select count(iId) as count from Comment WHERE iBlogId = @blogId";
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = query;
            cmd.Parameters.AddWithValue("@blogId", blogid);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            int i = sda.Fill(dt);
            if (i > 0)
            {
                cmtCount.InnerText = dt.Rows[0]["count"].ToString() + " bình luận";
            }
        }

        private void initNguoiDang(int userid, RepeaterItemEventArgs e)
        {
            string query = "SELECT [sUserName], [sAvatarUrl] FROM [User] WHERE iId = @userid";
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandText = query;
            cmd.Parameters.AddWithValue("@userid", userid);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            int i = sda.Fill(dt);
            if (i > 0)
            {
                HtmlAnchor txtNguoiDang = (HtmlAnchor)e.Item.FindControl("txtNguoiDang");
                txtNguoiDang.InnerText = dt.Rows[0]["sUserName"].ToString();
                Image imgAvatar = (Image)e.Item.FindControl("imgAvatar");
                imgAvatar.ImageUrl = dt.Rows[0]["sAvatarUrl"].ToString();
            }
        }

        protected void btnLoadMore_Click(object sender, EventArgs e)
        {
            page = Int32.Parse(((Button)sender).CommandArgument) + 1;
            ((Button)sender).CommandArgument = page.ToString();
            int i = LoadDataRptrBlog(categoryid, search);
            if (i % itemPerPage != 0 || i < itemPerPage * page)
            {
                ((Button)sender).Visible = false;
            }
        }
    }
}