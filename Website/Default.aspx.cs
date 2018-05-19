using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class _Default : BaseHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Thông tin kiến thức, tài liệu về cộng đồng nữ yêu nữ tại Việt Nam";
    }
    public List<TinTuc> getTinTuc(Enums.LoaiTinTuc loai)
    {
        var array = sql.TinTucs.Where(d => d.Type == (int)loai && d.Status == (int)Enums.Status.active && (!d.ShowDate.HasValue || (d.ShowDate.HasValue && d.ShowDate.Value <= DateTime.Today))).OrderByDescending(d => d.CreateDate).Take(4).ToList();
        string lang = Lib.getLag();
        array.ForEach(d =>
        {
            if (lang != "vi-VN")
            {
                d.Des_Vn = d.Des_En;
                d.TieuDe_Vn = d.TieuDe_En;
            }
        });
        return array;
    }
    public List<TinTuc> getHinhAnh()
    {
        
        var query = sql.TinTucs.Where(d => d.Type == (int)Enums.LoaiTinTuc.HinhAnhCongDongYeuNu && d.Status == (int)Enums.Status.active && (!d.ShowDate.HasValue || (d.ShowDate.HasValue && d.ShowDate.Value <= DateTime.Today))).OrderByDescending(d => d.CreateDate);
        List<TinTuc> arrayData = query.Take(6).ToList();
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