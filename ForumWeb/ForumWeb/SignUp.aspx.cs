using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ForumWeb
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isErr = Request.QueryString["err"] != null ? Request.QueryString["err"].Equals("1") : false;
            err.Visible = isErr;
        }
    }
}