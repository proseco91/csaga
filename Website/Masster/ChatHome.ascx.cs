using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class Masster_ChatHome : System.Web.UI.UserControl
{
    public ThreadChat userChat;
    public string keyDangKy = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["ThreadChat"] != null)
        {
            userChat = (ThreadChat)Session["ThreadChat"];
        }
        else
        {
            HttpCookie userInfoCookie = Request.Cookies["guid_Chat"];
            if (Session["ThreadChat"] == null && (userInfoCookie == null || (userInfoCookie != null && userInfoCookie.Expires<=DateTime.Now)))
            {
                userChat = new Entity.ThreadChat();
                userChat.ID = Lib.CreateGuid();
                userChat.Ip = Lib.GetIPAddress();

                userInfoCookie = new HttpCookie("guid_Chat");
                userInfoCookie["UserID"] = Lib.Encrypt(Newtonsoft.Json.JsonConvert.SerializeObject(userChat), "crazylady9x@gmail.com-csaga");
                userInfoCookie.Expires = DateTime.Now.AddYears(10);
                Response.Cookies.Add(userInfoCookie);
            }
            else if (Session["ThreadChat"] == null && userInfoCookie != null)
            {
                userChat = Newtonsoft.Json.JsonConvert.DeserializeObject<ThreadChat>(Lib.Decrypt(userInfoCookie["UserID"], "crazylady9x@gmail.com-csaga"));
            }
        }
        if (userChat != null && (userChat.IdAdmin == null || userChat.Admin == null) && userChat.isRegister())
        {
            LinqDataContext sql = new LinqDataContext(System.Configuration.ConfigurationManager.ConnectionStrings["Connection"].ToString());
            if (userChat.IdAdmin == null)
                userChat = sql.ThreadChats.Where(d => d.ID == userChat.ID).FirstOrDefault();
            if (userChat.IdAdmin != null)
                userChat.Admin = sql.Admins.Where(d => d.ID == userChat.IdAdmin).FirstOrDefault();

            Context.Response.Cookies["guid_Chat"].Expires = DateTime.Now.AddYears(-10);
            HttpCookie userInfoCookie = new HttpCookie("guid_Chat");
            userInfoCookie["UserID"] = Lib.Encrypt(Newtonsoft.Json.JsonConvert.SerializeObject(userChat), "crazylady9x@gmail.com-csaga");
            userInfoCookie.Expires = DateTime.Now.AddYears(10);
            Context.Response.Cookies.Add(userInfoCookie);
        }
        Session["ThreadChat"] = userChat;
        if (userChat != null)
            keyDangKy = Lib.create_codeChat(Newtonsoft.Json.JsonConvert.SerializeObject(new ThreadChat()
            {
                ClientEnd = userChat.ClientEnd,
                CreateDate = userChat.CreateDate,
                Email = userChat.Email,
                EndDate = userChat.EndDate,
                FullName = userChat.FullName,
                ID = userChat.ID,
                IdAdmin = userChat.IdAdmin,
                Ip = userChat.Ip,
                PhoneNumber = userChat.PhoneNumber
            }), Enums.LoaiAccount.KhachHang);
    }
}