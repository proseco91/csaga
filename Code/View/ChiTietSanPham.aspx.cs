using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_ChiTietSanPham : BasePageHome
{
    public MatHang data;
    public Category _cate;
    protected void Page_Load(object sender, EventArgs e)
    {
        data = sql.MatHangs.Where(d => d.ID == Request.QueryString["ID"] && d.Status == 1).FirstOrDefault();
        if (data == null)
            Response.Redirect(Lib.urlhome, true);
        data = data.MatHang1 == null ? data : data.MatHang1;
        _cate = getCateByName(Request.QueryString["CateName"]);
        if (_cate == null)
            Response.Redirect(Lib.urlhome, true);
        setTitle(data.Title);
    }
    public List<MatHang> getMatHangKhac()
    {
        return sql.MatHangs.Where(d => d.Category.IndexOf(_cate.ID) > -1 && d.ParentID == null && d.Status == 1 && d.ID != data.ID).OrderBy(d => Guid.NewGuid()).Take(5).ToList();
    }
}