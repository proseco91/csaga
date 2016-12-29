using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_DangNhap : BasePageHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (user != null) {
            if (Request.QueryString["url"] != null)
                Response.Redirect(Request.QueryString["url"]);
            else
                Response.Redirect(Lib.urlhome);
        }
        setTitle("Account");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string emailtxt = txtEmail.Text.Trim().ToLower();
        string error = "";
        if (!Lib.emailcheck(emailtxt))
            error += (error.Length == 0 ? "" : "<br/>") + "Email incorrect formats";

        if (!string.IsNullOrEmpty(error))
        {
            labErr.Text = Lib.createInfoLinkTam(error, false) + "<br/>";
        }
        else
        {

            if (typeLogin.Value == "1")
            {
                User user = sql.Users.Where(d => d.Email == emailtxt).FirstOrDefault();
                if (user == null)
                {
                    labErr.Text = Lib.createInfoLinkTam("Email do not exist", false) + "<br/>";
                }
                else
                {
                    string pass = Lib.RandomPassword();
                    user.Password = Lib.createMd5(pass);
                    sql.SubmitChanges();

                    Dictionary<string, object> arrContent = new Dictionary<string, object>();
                    arrContent.Add("{name-user}", user.FullName);
                    arrContent.Add("{email-user}", emailtxt);
                    arrContent.Add("{password-user}", pass);
                    arrContent.Add("{name-web}", sql.GetSetting().WebName);
                    sql.SendOneMail(emailtxt, 7, arrContent);
                    typeLogin.Value = "0";
                    labErr.Text = Lib.createInfoLinkTam("Check email to login", true) + "<br/>";
                }
            }
            else
            {
                User user = sql.Users.Where(d => d.Email == emailtxt && d.Password == Lib.createMd5(txtPass.Text)).FirstOrDefault();
                if (user==null)
                {
                    labErr.Text = Lib.createInfoLinkTam("Email do not exist", false) + "<br/>";
                }
                else {
                    Session["Home_Login"] = user;
                    HttpCookie userInfo = new HttpCookie("cusLogin_home");
                    userInfo["UserID"] = Lib.Encrypt(user.ID, "kzdt4500KZ");
                    userInfo.Expires = DateTime.Now.AddYears(10);
                    Response.Cookies.Add(userInfo);
                    if (Request.QueryString["url"] != null)
                        Response.Redirect(Request.QueryString["url"]);
                    else
                        Response.Redirect(Lib.urlhome);
                }
            }
        }
    }
}