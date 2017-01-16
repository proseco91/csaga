using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net.Mime;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;
using Newtonsoft.Json;

public partial class admin_tu_van_truc_tuyen : BasePage
{
    public string keyDangKy = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (admin_login != null)
            keyDangKy = Lib.create_codeChat(JsonConvert.SerializeObject(admin_login), Enums.LoaiAccount.QuanTri);
    }


}