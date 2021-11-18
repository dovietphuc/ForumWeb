using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ForumWeb
{
    public partial class Profile : System.Web.UI.Page
    {
        User user;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = (User)Application["user"];
            if(user == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            else
            {
                errSaiPWD.Visible = false;
                errSaiCfPWD.Visible = false;
                errPWDRong.Visible = false;
                changePwdSuccess.Visible = false;
                updateProfileSuccess.Visible = false;
                updateProfileFail.Visible = false;

                if (IsPostBack) return;

                txtUsername.Value = user.Username;
                txtFullname.Text = user.Fullname;
                txtEmail.Text = user.Email;
                txtPhone.Text = user.Phone;
                txtTimeCreate.Value = user.CreateTime.ToString("dd/MM/yyyy");
                if (!String.IsNullOrEmpty(user.Avatar))
                {
                    imageAvt.Src = user.Avatar;
                }

            }
        }

        public bool updateProfile(User user)
        {
            string query = "UPDATE [dbo].[User]"
                                + " SET [sName] = @sName"
                                + " ,[sEmail] = @sEmail"
                                + " ,[sPhone] = @sPhone"
                                + " WHERE iId = @id";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = query;
            cmd.Parameters.AddWithValue("@sName", user.Fullname != null ? user.Fullname : "");
            cmd.Parameters.AddWithValue("@sEmail", user.Email != null ? user.Email : "");
            cmd.Parameters.AddWithValue("@sPhone", user.Phone != null ? user.Phone : "");
            cmd.Parameters.AddWithValue("@id", user.Id);
            connection.Open();
            int i = cmd.ExecuteNonQuery();
            connection.Close();
            return i > 0;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            user.Fullname = txtFullname.Text;
            user.Email = txtEmail.Text;
            user.Phone = txtPhone.Text;
            if (updateProfile(user))
            {
                updateProfileSuccess.Visible = true;
            }
            else
            {
                updateProfileFail.Visible = true;
            }
        }

        protected void btnChangePWD_Click(object sender, EventArgs e)
        {
            string oldPwd = txtOldPWD.Text;
            string newPwd = txtNewPwd.Text;
            string cfPwd = txtCfPWD.Text;
            if (string.IsNullOrWhiteSpace(newPwd))
            {
                errPWDRong.Visible = true;
            } else if (!newPwd.Equals(cfPwd))
            {
                errSaiCfPWD.Visible = true;
            } else if(!changePwd(user, oldPwd, newPwd))
            {
                errSaiPWD.Visible = true;
            } else
            {
                changePwdSuccess.Visible = true;
            }
        }

        public bool changePwd(User user, string oldPwd, string newPwd)
        {
            string query = "UPDATE [dbo].[User]"
                                + " SET [sHashedPassword] = @newpwd"
                                + " WHERE iId = @id AND [sHashedPassword] like @oldpwd";
            SqlConnection connection = DBConnection.getConnection();
            SqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = query;
            cmd.Parameters.AddWithValue("@newpwd", newPwd.GetHashCode());
            cmd.Parameters.AddWithValue("@oldpwd", oldPwd.GetHashCode());
            cmd.Parameters.AddWithValue("@id", user.Id);
            connection.Open();
            int i = cmd.ExecuteNonQuery();
            connection.Close();
            return i > 0;
        }

        protected void btnLoadImage_Click(object sender, EventArgs e)
        {
            updateAvatar();
        }

        public bool updateAvatar()
        {
            if (fileAvt.HasFile)
            {
                string fileName = "UserAvt/" + user.Username + "_avt" + fileAvt.FileName.Replace(" ", "");
                string filepath = MapPath("~/" + fileName);
                fileAvt.SaveAs(filepath);

                string query = "UPDATE [dbo].[User]"
                                    + " SET [sAvatarUrl] = @path"
                                    + " WHERE iId = @id";
                SqlConnection connection = DBConnection.getConnection();
                SqlCommand cmd = connection.CreateCommand();
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@path", fileName);
                cmd.Parameters.AddWithValue("@id", user.Id);
                connection.Open();
                int i = cmd.ExecuteNonQuery();
                connection.Close();
                if(i > 0)
                {
                    imageAvt.Src = fileName;
                    user.Avatar = fileName;
                    return true;
                }
            }
            return false;
        }
    }
}