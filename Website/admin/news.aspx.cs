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

public partial class admin_mat_hang : BasePage
{
    TinTuc _data;
    public int Type = -1;
    public string menuActive = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Type = Convert.ToInt32(Request.QueryString["Type"]);
        menuActive = Type.ToString();

        if (TypeAction == 0)
        {
            this.Title = "Quản lý tin tức";
            index.Visible = true;
        }
        else if (TypeAction == 1 || TypeAction == 2)
        {
            this.Title = "Thêm mới tin tức";
            add.Visible = true;
            if (!IsPostBack)
            {

            }
            if (TypeAction == 2)
            {
                _data = sql.TinTucs.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                if (_data == null)
                {
                    CreateMessage("Không tìm thấy tin tức cần cập nhật", false);
                    Response.Redirect("mat-hang.htm");
                }
                else
                {
                    this.Title = "Chỉnh sửa '" + _data.TieuDe_Vn + "'";
                    if (!IsPostBack)
                    {
                        txtTitle.Text = _data.TieuDe_Vn;
                        txtChiTiet.Text = _data.NoiDung_Vn;
                        txtDes.Text = _data.Des_Vn;


                        Response.Write("<script type=\"text/javascript\">var ListImgOld = " + JsonConvert.SerializeObject(_data.Img.Split(',').Where(d => !string.IsNullOrEmpty(d))) + ";</script>");
                    }
                }

                Action_AddNew.Text = "Cập nhật";
            }
        }
        else if (TypeAction == 3)
        {
            _data = sql.TinTucs.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (_data == null)
            {
                CreateMessage("Không tìm thấy tin tức cần xóa", false);
            }
            else
            {
                _data.Status = -1;
                sql.SubmitChanges();
                CreateMessage("Xóa '" + _data.TieuDe_Vn + "' thành công", true);
                Response.Redirect("mat-hang.htm");
            }
            Response.Redirect(Request.UrlReferrer.ToString());
        }
        else if (TypeAction == 4)
        {
            _data = sql.TinTucs.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (_data == null)
            {
                CreateMessage("Không tìm thấy tin tức cần cập nhật", false);
            }
            else
            {
                _data.Status = _data.Status == 1 ? 0 : 1;
                sql.SubmitChanges();
                CreateMessage("cập nhật trạng thái '" + _data.TieuDe_Vn + "' thành công", true);
            }
            Response.Redirect(Request.UrlReferrer.ToString());
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
                Lib.ResizeByWidth(new MemoryStream(Convert.FromBase64String(Regex.Replace(base64.Replace("-->end<--,", "").Replace("-->end<--", ""), "data:image/.*?;base64,", ""))), 800).Save(serverMap + fileName, ImageFormat.Png);
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
        if (TypeAction == 1)
        {
            string htmlBody = Lib.convertNoiDungHTML(txtChiTiet.Text, Server.MapPath("~/images/imageUpload/"));


            //_data = new TinTuc()
            //{
            //    Content = txtChiTiet.Text,
            //    CreateDate = DateTime.Now,
            //    Des = txtDes.Text,
            //    ID = Lib.CreateGuid(),
            //    Status = 1,
            //    TieuDe = txtTitle.Text,
            //    Type = Type,
            //    Img = getListImg(new List<string>())
            //};
            //sql.TinTucs.InsertOnSubmit(_data);
            //sql.SubmitChanges();
            CreateMessage("Thêm mới tin tức thành công", true);
        }
        else
        {
            //_data.Content = txtChiTiet.Text;
            //_data.Des = txtDes.Text;
            //_data.TieuDe = txtTitle.Text;
            //_data.Img = getListImg(_data.Img.Split(',').ToList());
            //sql.SubmitChanges();
            //CreateMessage("Cập nhật " + _data.TieuDe + " thành công", true);
        }
        Response.Redirect(Request.RawUrl);
    }
    public List<TinTuc> getTinTuc(int pageSize, out int totalRowCount, out int pageSelect)
    {
        int idWeb = Convert.ToInt32(Session["websiteID"]);
        int pageNum = 1;
        if (Request.QueryString["page"] != null)
            pageNum = Convert.ToInt32(Request.QueryString["page"]);
        if (pageNum < 1)
            pageNum = 1;
        pageSelect = pageNum;

        string seach = Request.QueryString["seach"];
        var query = sql.TinTucs.Where(d => d.Type == Type && d.Status != -1);


        //if (!string.IsNullOrEmpty(seach))
        //{
        //    query = (from T in query where Convert.ToBoolean(sql.sosanhstring(T.TieuDe, seach)) select T);
        //}
        query = query.OrderByDescending(d => d.CreateDate);
        totalRowCount = query.Count();
        return query.Skip(pageSize * (pageNum - 1)).Take(pageSize).ToList();
    }
}