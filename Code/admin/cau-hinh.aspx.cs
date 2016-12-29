using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Dynamic;

public partial class admin_mat_hang : BasePage
{
    Setting _data;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Cấu hình website";
        _data = sql.Settings.Where(d => d.ID == 1).FirstOrDefault();
        if (!IsPostBack)
        {
            txtName.Text = _data.WebName;
            txtEmail.Text = _data.Email;
            txtKeyWord.Text = _data.KeyWord;
            txtDestination.Text = _data.Destination;
            txtEmailSend.Text = _data.AccountEmailSend;

            dynamic pay = JsonConvert.DeserializeObject<ExpandoObject>(_data.PaySetting);

            payClientId.Text = pay.clientId;
            payClientSecret.Text = pay.clientSecret;
            payShipping.Text = pay.shipping+"";
            payTax.Text = pay.tax + "";
            Response.Write("<script type=\"text/javascript\">var ListImgOld = " + JsonConvert.SerializeObject(_data.Slider.Split(',').Where(d => !string.IsNullOrEmpty(d))) + ";</script>");
        }
    }
    public string getListImg(List<string> imgOld)
    {
        string serverMap = Server.MapPath("~/images/imageUpload/");
        List<string> arrayImgNew = new List<string>();
        if (Request.Form["img_upload"] != null)
        {
            foreach (var base64 in Regex.Split(Request.Form["img_upload"], "-->end<--,"))
            {
                string fileName = Lib.CreateGuid() + ".png";
                Lib.ResizeImage(new MemoryStream(Convert.FromBase64String(Regex.Replace(base64.Replace("-->end<--,", "").Replace("-->end<--", ""), "data:image/.*?;base64,", ""))), 1000, 313).Save(serverMap + fileName, ImageFormat.Png);
                arrayImgNew.Add(fileName);
            }
        }
        if (Request.Form["img_old"] != null)
        {
            foreach (var urlOld in Request.Form["img_old"].Split(',').Where(d => !string.IsNullOrEmpty(d)))
            {
                arrayImgNew.Add(urlOld);
            }
        }
        foreach (var imgDelete in imgOld.Where(d => !arrayImgNew.Contains(d)))
        {
            try
            {
                File.Delete(serverMap + imgDelete);
            }
            catch
            {
            }
        }
        return string.Join(",", arrayImgNew);
    }
    protected void Action_AddNew_Click(object sender, EventArgs e)
    {

        _data.Email = txtEmail.Text;
        _data.WebName = txtName.Text;
        _data.Slider = getListImg(_data.Slider.Split(',').ToList());
        _data.Destination = txtDestination.Text;
        _data.KeyWord = txtKeyWord.Text;
        _data.AccountEmailSend = txtEmailSend.Text.Trim();

        dynamic pay = new ExpandoObject();
        pay.clientId = payClientId.Text.Trim();
        pay.clientSecret = payClientSecret.Text.Trim();
        pay.shipping = Convert.ToInt32(payShipping.Text.Trim());
        pay.tax = Convert.ToInt32(payTax.Text.Trim());
        _data.PaySetting = JsonConvert.SerializeObject(pay);
        sql.SubmitChanges();
        CreateMessage("Cập nhật cấu hình thành công", true);
        sql.UpdateSetting(_data);
        Response.Redirect(Request.RawUrl);
    }

}