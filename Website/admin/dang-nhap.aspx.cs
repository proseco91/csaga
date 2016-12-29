using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class admin_dang_nhap : BasePage
{
    LinqDataContext sql = new LinqDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Đăng nhập";
        if (admin_login != null)
        {
            if (Request.QueryString["url"] != null)
                Response.Redirect(Request.QueryString["url"]);
            else
                Response.Redirect("mat-hang.htm");
        }
    }
    protected void btnInsert_Click(object sender, EventArgs e)
    {
        if (admin_login != null)
        {
            if (Request.QueryString["url"] != null)
                Response.Redirect(Request.QueryString["url"]);
            else
                Response.Redirect("mat-hang.htm");
        }
        else
        {
            string txtLogin = txtEmailLogin.Text.Trim().ToLower();
            Admin _adminLogin = sql.getAdmin().Where(d => (d.UserName.ToLower().Equals(txtLogin) || d.Email.ToLower().Equals(txtLogin)) && d.Password.Equals(Lib.createMd5(txtPass.Text))).FirstOrDefault();
            if (_adminLogin == null)
            {
                ltStatus.Text = Lib.createInfo("Url hoặc mật khẩu không đúng</br>Xin vui lòng thử lại", false);
            }
            else
            {
                Session["Admin_Login"] = _adminLogin;
                if (cbCookie.Checked)
                {
                    HttpCookie userInfo = new HttpCookie("cusLogin_admin");
                    userInfo["UserID"] = Lib.Encrypt(_adminLogin.ID, "crazylady9x@gmail.com");
                    userInfo.Expires = DateTime.Now.AddYears(10);
                    Response.Cookies.Add(userInfo);
                }

                if (Request.QueryString["url"] != null)
                    Response.Redirect(Request.QueryString["url"]);
                else
                    Response.Redirect("mat-hang.htm");
            }
        }



        //string url = txtUrl.Text.Replace("http://", "").Replace("https://", "").Replace("www.", "");
        //string url1 = "http://" + url;
        //string url2 = "https://" + url;

        //tblWebsite _web = (from p in sql.tblWebsites where (p.urlHome.Equals(url) || p.urlHome.Equals(url1) || p.urlHome.Equals(url2)) && p.Password.Equals(Lib.createMd5(txtPass.Text.Trim())) select p).FirstOrDefault<tblWebsite>();
        //if (_web == null)
        //{
        //    ltStatus.Text = Lib.createInfo("Url hoặc mật khẩu không đúng</br>Xin vui lòng thử lại", false);
        //}
        //else {
        //    if (_web.Status== 1)
        //    {
        //        Session["websiteID"] = _web.ID;
        //        Session["websiteAdmin"] = _web;
        //        Session["websiteName"] = _web.TenDonVi;
        //        if (cbCookie.Checked)
        //        {
        //            HttpCookie userInfo = new HttpCookie("cusLogin_admin");
        //            userInfo["UserID"] = Lib.Encrypt(_web.ID.ToString(), "nguyenthang@linktam.vn");
        //            userInfo.Expires = DateTime.Now.AddYears(10);
        //            Response.Cookies.Add(userInfo);
        //        }
        //        if (Request.QueryString["url"] != null)
        //            Response.Redirect(Request.QueryString["url"]);
        //        else
        //            Response.Redirect("analytics.htm");
        //    }
        //    else {
        //        ltStatus.Text = Lib.createInfo("Trang web của bạn đã bị khóa", false);
        //    }

        //}

    }
}