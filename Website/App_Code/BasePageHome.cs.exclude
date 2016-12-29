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
public class BasePageHome : System.Web.UI.Page
{
    public User user = null;
    public LinqDataContext sql = new LinqDataContext();
    public List<strucItemCart> arrayCart = new List<strucItemCart>();
    public string sort
    {
        get
        {
            string _sort = Request.QueryString["sort"] == null ? "" : Request.QueryString["sort"];
            switch (_sort)
            {
                case "title-ascending":
                    return "title-ascending";
                case "title-descending":
                    return "title-descending";
                case "price-ascending":
                    return "price-ascending";
                case "price-descending":
                    return "price-descending";
                case "created-descending":
                    return "created-descending";
                case "created-ascending":
                    return "created-ascending";
                default:
                    return "created-descending";
            }
        }
    }
    protected override void InitializeCulture()
    {
        if (Session["Home_Login"] == null)
        {
            HttpCookie userInfoCookie = Request.Cookies["cusLogin_home"];
            if (userInfoCookie != null)
            {
                string idCookie = Lib.Decrypt(userInfoCookie["UserID"], "kzdt4500KZ");
                User _homeLogin = sql.Users.Where(d => d.ID.Equals(idCookie)).FirstOrDefault();
                if (_homeLogin != null)
                    Session["Home_Login"] = _homeLogin;
            }

        }
        else
            user = (User)Session["Home_Login"];

        HttpCookie CartCookie = Request.Cookies["Cart"];
        if (CartCookie != null) {
            try
            {
                arrayCart = Newtonsoft.Json.JsonConvert.DeserializeObject<List<strucItemCart>>(Lib.Decrypt(CartCookie.Value, "cart_aaxcdq"));
                
            }
            catch
            {
                arrayCart = new List<strucItemCart>();
                Response.Cookies.Remove("Cart");
            }
        }
        Response.Write("<script type=\"text/javascript\">var NumberItemCart = " + arrayCart.Count + ";</script>");
        base.InitializeCulture();
    }
    public void setTitle(string Title)
    {
        this.Title = Title.Length == 0 ? sql.GetSetting().WebName : Title + " - " + sql.GetSetting().WebName;
    }

    public Category getCateByName(string Name)
    {
        return sql.Category().Where(d => d.Name == Name || Lib.LocDau(d.Name) == Name).FirstOrDefault();
    }

}