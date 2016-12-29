using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_Search : BasePageHome
{
    public string q = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        q = Request.QueryString["q"];
        q = q == null ? "" : q;
        setTitle(q);
    }
    public List<MatHang> getMatHangSearch() {
        var query = sql.MatHangs.Where(d => d.Status == 1 && d.ParentID == null && sql.sosanhstring(d.Title, q)==true).OrderByDescending(d=>d.CreateDate);
        return query.ToList();
    }
}