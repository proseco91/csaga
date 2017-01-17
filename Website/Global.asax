<%@ Application Language="C#" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started
        //try
        //{
        //    HttpCookie userInfoCookie = Request.Cookies["cusLogin_admin"];
        //    if (userInfoCookie != null)
        //    {
        //        int idCookie = Convert.ToInt32(Lib.Decrypt(userInfoCookie["UserID"], "nguyenthang@linktam.vn"));
        //        LinqDataContext sql = new LinqDataContext();
        //        tblWebsite _web = (from p in sql.tblWebsites where p.ID == idCookie select p).FirstOrDefault<tblWebsite>();
        //        if (_web != null)
        //        {
        //            Session["websiteID"] = _web.ID;
        //            Session["websiteAdmin"] = _web;
        //            Session["websiteName"] = _web.TenDonVi;
        //        }
        //    }
        //}
        //catch
        //{

        //}

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
    protected void Application_BeginRequest(object sender, EventArgs e)
    {
        string aa = Request.Url.AbsolutePath.ToLower();

        if (Request.Url.Host.StartsWith("www") && !Request.Url.IsLoopback)
        {
            Response.Redirect(Lib.urlhome.Replace("www.", "") + HttpContext.Current.Request.RawUrl.ToString(), true);
        }
        else if (Request.Url.AbsolutePath.ToLower().IndexOf("default.aspx") > -1)
        {
            string[] arrayLang = { "vi", "en" };
            if (Request.QueryString["lang"] == null || !arrayLang.Contains(Request.QueryString["lang"]))
            {
                Entity.ip2location_db1 _ip = Lib.getInfoFromIp(Lib.GetIPAddress(true));
                if (_ip == null || _ip.country_code.ToLower().Equals("vn") || _ip.country_code.ToLower().Equals("-"))
                {
                    Response.Redirect(Lib.urlhome + "/lang-vi",true);
                }
                else
                {
                    Response.Redirect(Lib.urlhome + "/lang-en", true);
                }
            }
        }
    }
       
</script>
