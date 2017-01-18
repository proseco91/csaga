using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class View_newsDetail : BaseHome
{
    public TinTuc tintuc = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        tintuc = sql.TinTucs.Where(d => d.ID == Request.QueryString["id"] && d.Status == (int)Enums.Status.active).FirstOrDefault();
        if (tintuc == null)
            Response.Redirect(Lib.urlhome, true);

        string lang = Lib.getLag();
        if (lang != "vi-VN")
        {
            tintuc.Des_Vn = tintuc.Des_En;
            tintuc.TieuDe_Vn = tintuc.TieuDe_En;
            tintuc.NoiDung_Vn = tintuc.NoiDung_En;
        }
        this.Title = tintuc.TieuDe_Vn;
    }
    public List<TinTuc> getTinTucKhac() {
        List<TinTuc> customers = sql.ExecuteQuery<TinTuc>(@"SELECT top 7 * from [TinTuc] where Type="+tintuc.Type+" and ID<>'"+tintuc.ID+"' order by newid()").ToList();
        string lang = Lib.getLag();
        customers.ForEach(d =>
        {
            if (lang != "vi-VN")
            {
                d.Des_Vn = d.Des_En;
                d.TieuDe_Vn = d.TieuDe_En;
            }
        });
        return customers;
    }
}