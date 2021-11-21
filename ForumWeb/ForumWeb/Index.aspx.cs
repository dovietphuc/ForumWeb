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
            User user = (User)Application["user"];
            forAdmin.Visible = isAdmin(user);

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
            SqlCommand cmd = new SqlCommand();
            int top = itemPerPage * page;
            cmd = con.CreateCommand();
            User user = (User)Application["user"];

            if (txtSearch != null)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = isAdmin(user) ? "search_text_blog_for_admin" : "search_text_blog";
                cmd.Parameters.AddWithValue("@text", txtSearch);
                cmd.Parameters.AddWithValue("@top", top);
            }
            else
            {
                string forAdmin = " JOIN[Status] ON[Status].iId = [Blog].iStatusId WHERE[Status].sName like N'Đã duyệt'";
                string sql = "select TOP(" + top + ") * from Blog" + (!isAdmin(user) ? forAdmin : " WHERE 1=1");

                if (categoryid != -1)
                {
                    List<int> childs = getSubTypesForParent(categoryid);
                    sql += " AND (iBlogTypeId = @categoryid";
                    if (childs != null)
                    {
                        foreach (int child in childs)
                        {
                            sql += " OR iBlogTypeId = " + child;
                        }
                    }
                    sql += ")";
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
                string blogTypeId = ((DataRowView)e.Item.DataItem)["iBlogTypeId"].ToString();
                int blogtypeid = (int)(string.IsNullOrEmpty(blogTypeId) ? -1 : Int32.Parse(blogTypeId));
                initSubLink(subLink, getBlogType(blogtypeid));

                int blogId = (int)((DataRowView)e.Item.DataItem)["iId"];
                initCmtCount((HtmlGenericControl)e.Item.FindControl("cmtCount"), blogId);

                string userId = ((DataRowView)e.Item.DataItem)["iUserId"].ToString();
                initNguoiDang((int)(string.IsNullOrEmpty(userId) ? -1 : Int32.Parse(userId)), e);

                User user = (User)Application["user"];
                HtmlGenericControl txtIsAprovide = (HtmlGenericControl)e.Item.FindControl("txtIsAprovide");
                if (isAdmin(user))
                {
                    txtIsAprovide.Visible = true;
                    if (isAprovide(blogId))
                    {
                        
                        txtIsAprovide.InnerText = "Đã duyệt";
                    }
                    else
                    {
                        txtIsAprovide.InnerText = "Chưa duyệt";
                    }
                }
                else
                {
                    txtIsAprovide.Visible = false;
                }
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
                imgAvatar.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["sAvatarUrl"].ToString()) ?
                                                                        "UserAvt/default_avt.svg"
                                                                        : dt.Rows[0]["sAvatarUrl"].ToString();
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

        private int LoadDataRptrBlog_Aprovide()
        {
            SqlCommand cmd = new SqlCommand();
            int top = itemPerPage * page;
            cmd = con.CreateCommand();
            User user = (User)Application["user"];
            if (!isAdmin(user)) return -1;

            string forAdmin = " JOIN[Status] ON[Status].iId = [Blog].iStatusId WHERE[Status].sName like N'Đã duyệt'";
            string sql = "select TOP(" + top + ") * from Blog" + forAdmin;
            sql += " ORDER BY dCreatedDate DESC";
            cmd.CommandText = sql;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            int i = sda.Fill(dt);
            RptBlog.DataSource = dt;
            RptBlog.DataBind();
            return i;
        }

        private int LoadDataRptrBlog_NotAprovide()
        {
            SqlCommand cmd = new SqlCommand();
            int top = itemPerPage * page;
            cmd = con.CreateCommand();
            User user = (User)Application["user"];
            if (!isAdmin(user)) return -1;

            string forAdmin = " JOIN[Status] ON[Status].iId = [Blog].iStatusId WHERE[Status].sName like N'Chưa duyệt'";
            string sql = "select TOP(" + top + ") * from Blog" + forAdmin;
            sql += " ORDER BY dCreatedDate DESC";
            cmd.CommandText = sql;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            int i = sda.Fill(dt);
            RptBlog.DataSource = dt;
            RptBlog.DataBind();
            return i;
        }

        protected void aprovide_Click(object sender, EventArgs e)
        {
            page = 1;
            btnLoadMore.CommandArgument = page.ToString();
            int i = LoadDataRptrBlog_Aprovide();
            if (i % itemPerPage != 0 || i < itemPerPage * page)
            {
                btnLoadMore.Visible = false;
            }
        }

        protected void notaprovide_Click(object sender, EventArgs e)
        {
            page = 1;
            btnLoadMore.CommandArgument = page.ToString();
            int i = LoadDataRptrBlog_NotAprovide();
            if (i % itemPerPage != 0 || i < itemPerPage * page)
            {
                btnLoadMore.Visible = false;
            }
        }

        public bool isAprovide(int blogid)
        {
            string query = "SELECT * FROM [dbo].[Blog] JOIN [Status] ON [Blog].iStatusId = [Status].iId" +
                " WHERE [Status].sName = N'Đã duyệt'";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand sqlCommand = connection.CreateCommand();
            sqlCommand.CommandText = query;
            DataTable tb = new DataTable();
            int i = new SqlDataAdapter(sqlCommand).Fill(tb);
            return i > 0;
        }
    }
}