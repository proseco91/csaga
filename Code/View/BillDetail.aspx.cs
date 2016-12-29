using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PayPal.Api;

public partial class View_BillDetail : BasePageHome
{
    public DonHang bill;
    public List<strucItemCart> arrayCart = new List<strucItemCart>();
    protected void Page_Load(object sender, EventArgs e)
    {
        bill = sql.DonHangs.Where(d => d.ID == Request.QueryString["ID"]).FirstOrDefault();
        if (bill == null)
            Response.Redirect(Lib.urlhome + "/bills", true);

        var arrayItem = JsonFormatter.ConvertFromJson<List<Item>>(bill.DetailItems);
        string[] arrayId = arrayItem.Select(d => d.url).ToArray();
        var itemSql = sql.MatHangs.Where(d => arrayId.Contains(d.ID)).ToList() ;
        foreach (var item in arrayItem)
        {
            MatHang mathang = itemSql.Where(d => d.ID == item.url).FirstOrDefault();

            arrayCart.Add(new strucItemCart() {
                ID = mathang.ID,
                ColorAndSize = mathang.ColorAndSize,
                Money = Convert.ToInt64(decimal.Parse(item.price)),
                Name = mathang.MatHang1 == null ? mathang.Title : mathang.MatHang1.Title,
                Number = Convert.ToInt32(item.quantity),
                Img = mathang.Img,
                Category = sql.Category().Where(c => c.ID == (mathang.MatHang1 == null ? mathang.Category : mathang.MatHang1.Category).Split(',')[0]).FirstOrDefault().Name
            });
        }

        setTitle("Bill " + Lib.getShippingAddress(bill.Shipping_Address));
    }
}