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
using Entity;

public partial class admin_setting : BasePage
{
    public SettingWeb setting;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Cấu hình";
        if (!IsPostBack)
        {
            setting = sql.getSettingWeb();
            txtEmail.Text = setting.Email;
            txtDiaChi.Text = setting.DiaChi;
            txtDienThoai.Text = setting.DienThoai;
            txtFax.Text = setting.Fax;
            txtColor.Text = setting.Color_Background;
            Response.Write("<script type=\"text/javascript\">var settings = " + JsonConvert.SerializeObject(setting) + ";</script>");
        }
    }

    public string getListImg(List<string> imgOld)
    {
        string serverMap = Server.MapPath("~/images/imageUpload/");
        List<string> arrayImgNew = new List<string>();
        if (Request.Form["fileUpload"] != null)
        {
            foreach (var base64 in Regex.Split(Request.Form["fileUpload"], "-->end<--,"))
            {
                string fileName = Lib.CreateGuid() + ".png";
                Lib.ResizeByWidth(new MemoryStream(Convert.FromBase64String(Regex.Replace(base64.Replace("-->end<--,", "").Replace("-->end<--", ""), "data:image/.*?;base64,", ""))), 1200).Save(serverMap + fileName);
                arrayImgNew.Add(fileName);
            }
        }
        if (Request.Form["img_old_banner"] != null)
        {
            foreach (var urlOld in Request.Form["img_old_banner"].Split(',').Where(d => !string.IsNullOrEmpty(d)))
            {
                arrayImgNew.Add(urlOld);
            }
        }
        //foreach (var imgDelete in imgOld.Where(d => !arrayImgNew.Contains(d)))
        //{
        //    try
        //    {
        //        File.Delete(serverMap + imgDelete);
        //    }
        //    catch
        //    {
        //    }
        //}
        return string.Join(",", arrayImgNew);
    }
    protected void Action_AddNew_Click(object sender, EventArgs e)
    {
        setting = sql.SettingWebs.FirstOrDefault();

        setting.DiaChi = txtDiaChi.Text;
        setting.DienThoai = txtDienThoai.Text;
        setting.Email = txtEmail.Text;
        setting.Fax = txtFax.Text;
        setting.Banner = getListImg(setting.Banner.Split(',').ToList());
        setting.Use_ImgBackground = Convert.ToInt32(windown_background_web.Value);
        setting.Hotline = dataHotline.Value;
        if (Request.Form["imageBackgroundweb"] != null)
        {
            setting.Img_Background = Lib.saveImgFromBase64(Regex.Split(Request.Form["imageBackgroundweb"], "-->end<--,")[0].Replace("-->end<--,", "").Replace("-->end<--", ""), Server.MapPath("~/images/imageUpload/"), false);
        }
        setting.Color_Background = txtColor.Text;
        sql.SubmitChanges();
        setting.AddOrUpdateCache();

        CreateMessage("Cập nhật cấu hình thành công.", true);
        Response.Redirect(Request.RawUrl);
    }
}