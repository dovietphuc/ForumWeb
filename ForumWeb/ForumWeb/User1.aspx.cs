using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ForumWeb
{
    public partial class User1 : System.Web.UI.Page
    {
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection();
        SqlDataAdapter sda = new SqlDataAdapter();
        DataSet ds = new DataSet();
        String connectionString = ConfigurationManager.ConnectionStrings["dbconnect"].ConnectionString;
        String hashKey = ConfigurationManager.AppSettings["PrivateKey"];
        User user = new User();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            user = (User)Application["user"];
            if(user == null)
            {
                messageID.InnerHtml = "<h3>Bạn không có quyền truy cập vào trang này</h3>";
                return;
            }
            if(user.role != 1 )
            {
                messageID.InnerHtml = "<h3>Bạn không có quyền truy cập vào trang này</h3>";

                return;
            }
            con.ConnectionString = connectionString;
            con.Open();
            LoadDataRptrUser();
        }
        private void LoadDataRptrUser()
        {

            try
            {
                SqlDataAdapter sda = new SqlDataAdapter("select * from [User]", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                rptrUser.DataSource = dt;
                rptrUser.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

        }
        protected void cbAproved_Command(object sender, CommandEventArgs e)
        {
            con.ConnectionString = connectionString;
            con.Open();
            LinkButton linkButton = (LinkButton)sender;
            var id = linkButton.Attributes["Tagkey"];
            var status = linkButton.Text == "Khóa" ? 0 : 1;

            SqlCommand cmd = new SqlCommand("Update_Status_User", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@id", Convert.ToInt32(id));
            if (status == 1)
            {
                linkButton.Text = "Khóa";
                cmd.Parameters.AddWithValue("@Status", 0);
            }
            else
            {
                linkButton.Text = "Đang hoạt động";
                cmd.Parameters.AddWithValue("@Status", 1);

            }
            cmd.ExecuteNonQuery();
        }
    }
}