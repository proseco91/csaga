using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Threading;
using System.Globalization;


/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
    public LinqDataContext sql = new LinqDataContext();
    public Admin admin_login = null;
    public int TypeAction = 0;
    protected override void InitializeCulture()
    {
        TypeAction = Convert.ToInt32(Request.QueryString["TypeAction"]);
        HttpCookie userInfoCookie = Request.Cookies["cusLogin_admin"];
        if (Session["Admin_Login"] == null && userInfoCookie != null)
        {
            string idCookie = Lib.Decrypt(userInfoCookie["UserID"], "crazylady9x@gmail.com");

            Admin _adminLogin = sql.Admins.Where(d => d.ID.Equals(idCookie)).FirstOrDefault();
            if (_adminLogin != null)
                Session["Admin_Login"] = _adminLogin;
        }
        if (Session["Admin_Login"] != null)
        {
            admin_login = (Admin)Session["Admin_Login"];
            Response.Write("<script type=\"text/javascript\">var TypeAction = " + TypeAction + ";</script>");
        }
        else if (Session["Admin_Login"] == null && Request.RawUrl.IndexOf("dang-nhap.htm") == -1)
        {

            Response.Redirect("dang-nhap.htm?url=" + Request.RawUrl, true);
        }
        base.InitializeCulture();
    }
    public void CreateMessage(string message, bool status)
    {
        Session["Message_Popup"] = Lib.createInfoLinkTam(message, status);
    }
}