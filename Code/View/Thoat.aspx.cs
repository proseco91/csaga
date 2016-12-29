using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_Thoat : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Home_Login"] = null;
        Response.Cookies["cusLogin_home"].Expires = DateTime.Now.AddYears(-10);

        if (Request.QueryString["url"] != null)
            Response.Redirect(Request.QueryString["url"]);
        else
            Response.Redirect(Lib.urlhome);
    }
}