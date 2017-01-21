using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class View_nhomyeunu : BaseHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Nhóm nữ yêu nữ";
    }
    public List<Category> getNhom()
    {
        var arrayNhom = sql.getCategory().Where(d => d.Type == (int)Enums.LoaiTinTuc.CacNhomNuyeuNu && d.Status == 1).OrderByDescending(d => d.CreateDate).ToList();
        string lang = Lib.getLag();
        arrayNhom.ForEach(d =>
        {
            if (lang != "vi-VN")
            {
                d.TieuDe_Vn = d.TieuDe_En;
            }
        });
        return arrayNhom;
    }
    public List<TinTuc> getTinNhom(int cate)
    {


        var query = sql.TinTucs.Where(d => d.Type == (int)Enums.LoaiTinTuc.CacNhomNuyeuNu && d.Status == (int)Enums.Status.active && d.Category.Equals(cate.ToString()));
        query = query.OrderByDescending(d => d.CreateDate);
        List<TinTuc> arrayData = query.Take(3).ToList();
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