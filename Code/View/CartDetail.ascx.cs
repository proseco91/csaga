using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_CartDetail : System.Web.UI.UserControl
{
    public List<strucItemCart> arrayCart = new List<strucItemCart>();
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie CartCookie = Request.Cookies["Cart"];
        if (CartCookie != null)
        {
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
        
    }
}