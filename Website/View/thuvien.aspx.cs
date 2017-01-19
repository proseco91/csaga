using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class View_thuvien : BaseHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Thư viện";
    }
    public List<TinTuc> getThuVien(int pageSize, out int totalRowCount, out int pageSelect)
    {
        int pageNum = 1;
        if (Request.QueryString["page"] != null)
            pageNum = Convert.ToInt32(Request.QueryString["page"]);
        if (pageNum < 1)
            pageNum = 1;
        pageSelect = pageNum;

        var query = sql.TinTucs.Where(d => d.Type == (int)Enums.LoaiTinTuc.ThuVien && d.Status == (int)Enums.Status.active);
        query = query.OrderByDescending(d => d.CreateDate);
        totalRowCount = query.Count();
        List<TinTuc> arrayData = query.Skip(pageSize * (pageNum - 1)).Take(pageSize).ToList();
        string lang = Lib.getLag();
        arrayData.ForEach(d =>
        {
            if (lang != "vi-VN")
            {
                d.Des_Vn = d.Des_En;
                d.TieuDe_Vn = d.TieuDe_En;
            }
        });
        return arrayData;
    }
}