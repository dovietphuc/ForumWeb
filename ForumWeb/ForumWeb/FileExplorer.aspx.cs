using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bai16
{
    public partial class FileExplorer : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            var txtFileName = Request.QueryString["txtFile"];
            if (txtFileName != null && txtFileName != "")
            {
                WebClient webClient = new WebClient();
                HttpResponse httpResponse = HttpContext.Current.Response;
                httpResponse.AddHeader("Content-Disposition", "attachment;filename=" + txtFileName);
                var downloadPath = "file/" + txtFileName;
                var data = webClient.DownloadData(Server.MapPath(downloadPath));
                httpResponse.BinaryWrite(data);
                httpResponse.End();
            }

            var filePaths = Directory.GetFiles(Request.PhysicalApplicationPath + "App_Data", "*", SearchOption.AllDirectories);

            foreach (var item in filePaths)
            {
                char[] spr = { '\\' };
                string[] split = item.Split(spr);


                var fileName = split[split.Length - 1];
                content.InnerHtml += @"<div><a href='/FileExplorer.aspx?txtFile=" + fileName + "'>" + item + @"</a></div>";
            }
        }
    }

}