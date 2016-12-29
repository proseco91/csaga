using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Masster_MasterPage : System.Web.UI.MasterPage
{
    public LinqDataContext sql = new LinqDataContext();
    public User user = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Home_Login"] != null)
            user = (User)Session["Home_Login"];

        

    }
    public List<Category> Category
    {
        get
        {
            return sql.Category();
        }
    }
}
