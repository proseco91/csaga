using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_Pay : BasePageHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        setTitle("Pay bills");
        if(user==null)
            Response.Redirect(Lib.urlhome + "/account/login?url="+HttpUtility.UrlEncode(Request.RawUrl.ToString()),true);

        if (arrayCart.Count <= 0)
        {
            labErr.Text = Lib.createInfoLinkTam("<div style='font-size: 15px;padding: 10px 20px;text-align: center;'>Cart is empty!</div>", false) + "<br/>";
        }
        else { 
            string status = Request.QueryString["status"];
            if (status == null || string.IsNullOrEmpty(status))
            {
                Response.Redirect(TransactionLib.CreateTransaction(arrayCart, user), true);
            }else{
                if (status == "cancel")
                {
                    labErr.Text = Lib.createInfoLinkTam("<div style='font-size: 15px;padding: 10px 20px;text-align: center;'>Payment canceled!</div>", false) + "<br/>";
                }
                else {
                    string id = TransactionLib.ExecuteTransaction(sql, (Request.QueryString["paymentId"] as string).Trim(), (Request.QueryString["PayerID"] as string).Trim(), Response);
                    if (string.IsNullOrEmpty(id))
                    {
                        labErr.Text = Lib.createInfoLinkTam("<div style='font-size: 15px;padding: 10px 20px;text-align: center;'>Payment failed!</div>", false) + "<br/>";
                    }
                    else {
                        Response.Redirect(Lib.urlhome + "/bill-" + id, true);
                    }
                }
            }
        }
    }
}