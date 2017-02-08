using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;
using Newtonsoft.Json;
public partial class Masster_KhaoSat : System.Web.UI.UserControl
{
    public LinqDataContext sql = Lib.createSQL();
    public KhaoSat khaosat = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        List<string> arrayKhaoSat = new List<string>();
        HttpCookie userKhaoSat = Request.Cookies["guid_khao_sat"];
        if (userKhaoSat != null)
        {
            arrayKhaoSat = JsonConvert.DeserializeObject<List<string>>(userKhaoSat["ArrayID"]);
        }
        else {
            userKhaoSat = new HttpCookie("guid_khao_sat");
            userKhaoSat["ArrayID"] = "[]";
            userKhaoSat.Expires = DateTime.Now.AddYears(10);
            Context.Response.Cookies.Add(userKhaoSat);
        }
        khaosat = sql.getKhaoSat().Where(d => !arrayKhaoSat.Contains(d.ID) && d.Status == (int)Enums.Status.active && DateTime.Now >= d.KhaoSatTuNgay && DateTime.Now <= d.KhaoSatDenNgay).FirstOrDefault();
    }
}