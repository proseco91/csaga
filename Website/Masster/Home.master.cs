using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class Masster_Home : System.Web.UI.MasterPage
{
    public LinqDataContext sql = new LinqDataContext(System.Configuration.ConfigurationManager.ConnectionStrings["Connection"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
    }
}
