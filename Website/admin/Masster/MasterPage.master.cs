using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class admin_Masster_MasterPage : System.Web.UI.MasterPage
{
    public Admin admin = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Admin_Login"] != null)
            admin = ((Entity.Admin)Session["Admin_Login"]);
        
    }
}
