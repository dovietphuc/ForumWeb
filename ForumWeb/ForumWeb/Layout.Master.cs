using ForumWeb.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ForumWeb
{
    public partial class Layout : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User user = (User)Application["user"];
            login.InnerText = user != null ? "Đăng xuất" : "Đăng nhập";
            profile.Visible = user != null;
        }
    }
}