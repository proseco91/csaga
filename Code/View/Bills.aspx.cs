using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_Bills : BasePageHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (user == null)
            Response.Redirect(Lib.urlhome, true);
        setTitle("Bills");
    }
    public List<DonHang> getDonHang() {
        return sql.DonHangs.Where(d => d.UserID == user.ID).OrderByDescending(d => d.CreateDate).ToList();
    }
}