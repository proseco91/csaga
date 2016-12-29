using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_SanPhamDanhMuc : BasePageHome
{
    public Category _cate;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        _cate = getCateByName(Request.QueryString["CateName"]);
        if (_cate == null)
            Response.Redirect(Lib.urlhome, true);
        setTitle(_cate.Name);
    }
    
    public List<MatHang> getMatHangByCate()
    {
        var query = sql.MatHangs.Where(d => d.Category.IndexOf(_cate.ID) > -1 && d.Status == 1 && d.ParentID == null);
        switch (sort)
        {
            case "title-ascending":
                query.OrderBy(d => d.Title);
                break;
            case "title-descending":
                query.OrderByDescending(d => d.Title);
                break;
            case "price-ascending":
                query.OrderBy(d => (d.GiamGia.HasValue?d.GiaBan-d.GiamGia.Value:d.GiaBan));
                break;
            case "price-descending":
                query.OrderByDescending(d => (d.GiamGia.HasValue ? d.GiaBan - d.GiamGia.Value : d.GiaBan));
                break;
            case "created-descending":
                query.OrderByDescending(d => d.CreateDate);
                break;
            case "created-ascending":
                query.OrderBy(d => d.CreateDate);
                break;
        }
        return query.ToList();
    }
}