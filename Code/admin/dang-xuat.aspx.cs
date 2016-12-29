using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_dang_xuat : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Admin_Login"] = null;
        Response.Cookies["cusLogin_admin"].Expires = DateTime.Now.AddYears(-10);
        Response.Redirect("dang-nhap.htm");
    }
}