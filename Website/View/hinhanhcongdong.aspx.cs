using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class View_hinhanhcongdong : BaseHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Tôi là nữ yêu nữ";
    }
    public string getThanhPhoSoLuong()
    {
        var array = sql.getThanhPho();
        var query = sql.TinTucs.Where(d => d.Status == (int)Enums.Status.active && d.Type == (int)Enums.LoaiTinTuc.HinhAnhCongDongYeuNu && d.ThanhPho.HasValue && (!d.ShowDate.HasValue || (d.ShowDate.HasValue && d.ShowDate.Value <= DateTime.Today)));
        array.ForEach(d =>
        {
            d.SoLuongBai = query.Where(c => c.ThanhPho.Value == d.region_id).Select(c => c.ID).Count();

        });
        return Newtonsoft.Json.JsonConvert.SerializeObject(array.Where(d => d.SoLuongBai > 0).Select(d => new
        {
            lat = d.lat,
            lng = d.lng,
            count = d.SoLuongBai,
            name = d.region_name
        }));
    }
    public List<TinTuc> getHinhAnh(int pageSize, out int totalRowCount, out int pageSelect)
    {
        int pageNum = 1;
        if (Request.QueryString["page"] != null)
            pageNum = Convert.ToInt32(Request.QueryString["page"]);
        if (pageNum < 1)
            pageNum = 1;
        pageSelect = pageNum;

        var query = sql.TinTucs.Where(d => d.Type == (int)Enums.LoaiTinTuc.HinhAnhCongDongYeuNu && d.Status == (int)Enums.Status.active && (!d.ShowDate.HasValue || (d.ShowDate.HasValue && d.ShowDate.Value <= DateTime.Today)));
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