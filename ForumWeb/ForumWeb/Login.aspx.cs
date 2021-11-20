using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ForumWeb
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Application["user"] = null;
            bool isErr = Request.QueryString["err"] != null ? Request.QueryString["err"].Equals("1") : false;
            err.Visible = isErr;
            bool registSuccess = Request.QueryString["registSuccess"] != null ? Request.QueryString["registSuccess"].Equals("1") : false;
            success.Visible = registSuccess;
        }
    }
}