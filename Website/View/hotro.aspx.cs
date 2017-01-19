using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class View_hotro : BaseHome
{
    public int category = -1;
    public List<Category> arrcate = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Hỗ trợ";
        category = Convert.ToInt32(Request.QueryString["id"]);
        arrcate = getCate();
        if (category == -1)
            category = arrcate.FirstOrDefault().ID;

    }
    public List<Category> getCate()
    {
        return sql.getCategory().Where(d => d.Type == (int)Enums.LoaiTinTuc.HoTro).ToList();
    }
    public List<TinTuc> getHoTro(int pageSize, out int totalRowCount, out int pageSelect)
    {
        int pageNum = 1;
        if (Request.QueryString["page"] != null)
            pageNum = Convert.ToInt32(Request.QueryString["page"]);
        if (pageNum < 1)
            pageNum = 1;
        pageSelect = pageNum;

        var query = sql.TinTucs.Where(d => d.Type == (int)Enums.LoaiTinTuc.HoTro && (d.Category.LastIndexOf(category.ToString() + ",") > -1 || d.Category.LastIndexOf(category.ToString()) > -1) && d.Status == (int)Enums.Status.active);
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