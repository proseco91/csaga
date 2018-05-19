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
    LinqDataContext sql = Lib.createSQL();
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
    public string GetKhaoSat()
    {
        var fullPath = "~/Masster/KhaoSat.ascx";
        System.Web.UI.Page page = new System.Web.UI.Page();

        System.Web.UI.Control control = page.LoadControl(fullPath);
        var html = control.RenderHtml();

        return html;


    }
          

    [WebMethod(EnableSession = true)]
    public void doneKhaoSat(string ID, string array, string fullname, string email, string phone)
    {
        KhaoSat khaosat = sql.getKhaoSat().Where(d => d.ID == ID).FirstOrDefault();
        if (khaosat != null)
        {
            KhaoSat_TraLoi traloi = new KhaoSat_TraLoi()
            {
                CreateDate = DateTime.Now,
                Email = email,
                FullName = fullname,
                ID = Lib.CreateGuid(),
                IDKhaoSat = ID,
                NoiDung = array,
                PhoneNumber = phone
            };
            sql.KhaoSat_TraLois.InsertOnSubmit(traloi);
            sql.SubmitChanges();
            khaosat.arrayCauTraLoi.Add(traloi);
            List<string> arrayTraLoi = new List<string>();
            arrayTraLoi.Add(khaosat.ID);

            HttpCookie userKhaoSat = Context.Request.Cookies["guid_khao_sat"];
            if (userKhaoSat != null) {
                arrayTraLoi.AddRange(JsonConvert.DeserializeObject<List<string>>(userKhaoSat["ArrayID"]));
            }
            userKhaoSat = new HttpCookie("guid_khao_sat");
            userKhaoSat["ArrayID"] = JsonConvert.SerializeObject(arrayTraLoi);
            userKhaoSat.Expires = DateTime.Now.AddYears(10);
            Context.Response.Cookies.Add(userKhaoSat);

        }
        
        

        //ThreadChat thread = Newtonsoft.Json.JsonConvert.DeserializeObject<ThreadChat>(data);
        //Context.Response.Cookies["guid_Chat"].Expires = DateTime.Now.AddYears(-10);
        //HttpCookie userInfoCookie = new HttpCookie("guid_Chat");
        //userInfoCookie["UserID"] = Lib.Encrypt(JsonConvert.SerializeObject(thread), "crazylady9x@gmail.com-csaga");
        //userInfoCookie.Expires = DateTime.Now.AddYears(10);
        //Context.Response.Cookies.Add(userInfoCookie);
        //Session["ThreadChat"] = thread;
        //return JsonConvert.SerializeObject(thread);


    }
    [WebMethod(EnableSession = true)]
    public void doneketThucTuvan(string id)
    {
        Session["ThreadChat"] = null;
        Context.Response.Cookies["guid_Chat"].Expires = DateTime.Now.AddYears(-11);
        ThreadChat thread = sql.ThreadChats.Where(d => d.ID == id).FirstOrDefault();
        thread.ClientEnd = true;
        sql.SubmitChanges();



    }
    [WebMethod(EnableSession = true)]
    public string editClientThread(string data)
    {
        ThreadChat thread = Newtonsoft.Json.JsonConvert.DeserializeObject<ThreadChat>(data);
        Context.Response.Cookies["guid_Chat"].Expires = DateTime.Now.AddYears(-10);
        HttpCookie userInfoCookie = new HttpCookie("guid_Chat");
        userInfoCookie["UserID"] = Lib.Encrypt(JsonConvert.SerializeObject(thread), "crazylady9x@gmail.com-csaga");
        userInfoCookie.Expires = DateTime.Now.AddYears(10);
        Context.Response.Cookies.Add(userInfoCookie);
        Session["ThreadChat"] = thread;
        return JsonConvert.SerializeObject(thread);


    }

    [WebMethod]
    public string addCommnet(string idTin, string comment)
    {
        Comment com = new Comment()
        {
            Comment1 = comment,
            CreateBy = "",
            CreateDate = DateTime.Now,
            ID = Lib.CreateGuid(),
            IsAnonymous = true,
            TinTucID = idTin
        };
        sql.Comments.InsertOnSubmit(com);
        sql.SubmitChanges();

        return JsonConvert.SerializeObject(com);


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
