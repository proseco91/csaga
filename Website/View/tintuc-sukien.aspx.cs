using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class View_tintuc_sukien : BaseHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Tin tức & sự kiện";
    }
    public List<TinTuc> getTinTuc(int pageSize,int cate, out int totalRowCount, out int pageSelect)
    {
        int pageNum = 1;
        if (Request.QueryString["page"+ cate] != null)
            pageNum = Convert.ToInt32(Request.QueryString["page" + cate]);
        if (pageNum < 1)
            pageNum = 1;
        pageSelect = pageNum;

        var query = sql.TinTucs.Where(d => d.Type == (int)Enums.LoaiTinTuc.TinTucSuKien && (d.Category.LastIndexOf(cate.ToString() + ",") > -1 || d.Category.LastIndexOf(cate.ToString()) > -1) && d.Status == (int)Enums.Status.active);
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