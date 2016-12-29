using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing.Imaging;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using Newtonsoft.Json;
using PPNetLib;
using DateCalculator;
using System.Net;
using System.Web.Script.Services;
using Entity;


public class strucItemCart
{
    public string ID { get; set; }
    public string Name { get; set; }
    public string Img { get; set; }
    public string ColorAndSize { get; set; }
    public int Number { get; set; }
    public long Money { get; set; }
    public string Category { get; set; }
}

/// <summary>
/// Summary description for service
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class service : System.Web.Services.WebService
{

    public service()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    private string RenderControl(System.Web.UI.Control control)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        StringWriter sw = new StringWriter(sb);
        System.Web.UI.HtmlTextWriter writer = new System.Web.UI.HtmlTextWriter(sw);

        control.RenderControl(writer);
        return sb.ToString();
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true)]
    public string GetCart()
    {
        var fullPath = "~/View/CartDetail.ascx";
        System.Web.UI.Page page = new System.Web.UI.Page();

        System.Web.UI.Control control = page.LoadControl(fullPath);
        var html = control.RenderHtml();

        return html;


    }

    //[WebMethod]
    //public object[] AddCart(string ID, int Number)
    //{

    //    HttpRequest Request = System.Web.HttpContext.Current.Request;
    //    HttpResponse Response = System.Web.HttpContext.Current.Response;

    //    HttpCookie CartCookie = Request.Cookies["Cart"];
    //    if (CartCookie == null)
    //    {
    //        CartCookie = new HttpCookie("Cart", Lib.Encrypt(JsonConvert.SerializeObject(new List<strucItemCart>()), "cart_aaxcdq"));
    //        CartCookie.Expires = DateTime.Now.AddDays(1);
    //        Response.Cookies.Add(CartCookie);
    //    }

    //    List<strucItemCart> arrayItem = JsonConvert.DeserializeObject<List<strucItemCart>>(Lib.Decrypt(CartCookie.Value, "cart_aaxcdq"));
    //    bool isRemove = false;
    //    strucItemCart item = arrayItem.Where(d => d.ID == ID).FirstOrDefault();
    //    if (item == null)
    //    {
    //        LinqDataContext sql = new LinqDataContext();
    //        item = sql.MatHangs.Where(d => d.ID == ID).ToList().Select(d => new strucItemCart()
    //        {
    //            ID = d.ID,
    //            ColorAndSize = d.ColorAndSize,
    //            Money = d.MatHang1 == null ? d.Money() : d.MatHang1.Money(),
    //            Name = d.MatHang1 == null ? d.Title : d.MatHang1.Title,
    //            Number = 1,
    //            Img = d.Img,
    //            Category = sql.Category().Where(c => c.ID == (d.MatHang1 == null ? d.Category : d.MatHang1.Category).Split(',')[0]).FirstOrDefault().Name
    //        }).FirstOrDefault();
    //        arrayItem.Add(item);
    //    }
    //    else
    //    {
    //        if (Number <= -1)
    //            item.Number += 1;
    //        else if (Number == 0)
    //        {
    //            isRemove = true;
    //            arrayItem.Remove(item);
    //        }
    //        else
    //            item.Number = Number;
    //    }
    //    Response.Cookies["Cart"].Value = Lib.Encrypt(JsonConvert.SerializeObject(arrayItem), "cart_aaxcdq");
    //    return new object[] { arrayItem.Count, arrayItem.Select(d => d.Number * d.Money).Sum(), isRemove };
    //}

}
