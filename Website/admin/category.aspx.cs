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

public partial class admin_category : BasePage
{
    Category _data;
    public int Type = -1;
    public string menuActive = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Type = Convert.ToInt32(Request.QueryString["Type"]);
        menuActive = Type.ToString();

        if (TypeAction == 0)
        {
            this.Title = "Quản lý " + Enums.MucLucDesc((Enums.LoaiTinTuc)Type);
            index.Visible = true;
        }
        else if (TypeAction == 1 || TypeAction == 2)
        {
            this.Title = "Thêm mới " + Enums.MucLucDesc((Enums.LoaiTinTuc)Type);
            add.Visible = true;
            if (Type == (int)Enums.LoaiTinTuc.CacNhomNuyeuNu)
                panelNhom.Visible = true;
            if (!IsPostBack)
            {

            }
            if (TypeAction == 2)
            {
                _data = sql.getCategory().Where(d => d.ID.Equals(Convert.ToInt32(Request.QueryString["ID"]))).FirstOrDefault();
                if (_data == null)
                {
                    CreateMessage("Không tìm thấy " + Enums.MucLucDesc((Enums.LoaiTinTuc)Type) + " cần cập nhật", false);
                    Response.Redirect(Enums.MucLucUrlDanhSach((Enums.LoaiTinTuc)Type));
                }
                else
                {
                    this.Title = "Chỉnh sửa '" + _data.TieuDe_Vn + "'";
                    if (!IsPostBack)
                    {
                        txtTitle.Text = _data.TieuDe_Vn;
                        txtTitleEn.Text = _data.TieuDe_En;
                        txtTruongNhom.Text = _data.TruongNhom;
                        txtDiaChi.Text = _data.DiaChi;
                        txtEmail.Text = _data.Email;
                        txtDienThoai.Text = _data.DienThoai;
                        Response.Write("<script type=\"text/javascript\">var ListImgOld = " + JsonConvert.SerializeObject(_data.Img.Split(',').Where(d => !string.IsNullOrEmpty(d))) + ";</script>");
                    }
                }

                Action_AddNew.Text = "Cập nhật";
            }
        }
        else if (TypeAction == 3)
        {
            _data = sql.getCategory().Where(d => d.ID.Equals(Convert.ToInt32(Request.QueryString["ID"]))).FirstOrDefault();
            if (_data == null)
            {
                CreateMessage("Không tìm thấy " + Enums.MucLucDesc((Enums.LoaiTinTuc)Type) + " cần xóa", false);
            }
            else
            {
                _data = sql.Categories.Where(d => d.ID.Equals(Convert.ToInt32(Request.QueryString["ID"]))).FirstOrDefault();
                _data.Status = (int)Enums.Status.delete;
                sql.SubmitChanges();
                CreateMessage("Xóa '" + _data.TieuDe_Vn + "' thành công", true);
                _data.AddOrUpdateCache(sql);
                Response.Redirect(Enums.MucLucUrlDanhSach((Enums.LoaiTinTuc)Type));
            }
            Response.Redirect(Request.UrlReferrer.ToString());
        }
        else if (TypeAction == 4)
        {
            _data = sql.getCategory().Where(d => d.ID.Equals(Convert.ToInt32(Request.QueryString["ID"]))).FirstOrDefault();
            if (_data == null)
            {
                CreateMessage("Không tìm thấy " + Enums.MucLucDesc((Enums.LoaiTinTuc)Type) + " cần cập nhật", false);
            }
            else
            {
                _data = sql.Categories.Where(d => d.ID.Equals(Convert.ToInt32(Request.QueryString["ID"]))).FirstOrDefault();
                _data.Status = _data.Status == (int)Enums.Status.active ? (int)Enums.Status.deactive : (int)Enums.Status.active;
                sql.SubmitChanges();
                _data.AddOrUpdateCache(sql);
                CreateMessage("cập nhật trạng thái '" + _data.TieuDe_Vn + "' thành công", true);
            }
            Response.Redirect(Request.UrlReferrer.ToString());
        }
    }


    protected void Action_AddNew_Click(object sender, EventArgs e)
    {
        if (TypeAction == 1)
        {

            _data = new Category()
            {

                CreateBy = admin_login.ID,
                CreateDate = DateTime.Now,
                ModifyBy = admin_login.ID,
                ModifyDate = DateTime.Now,
                Status = (int)Enums.Status.active,
                TieuDe_En = txtTitleEn.Text,
                TieuDe_Vn = txtTitle.Text,
                Type = Type,
                DiaChi = txtDiaChi.Text,
                DienThoai = txtDienThoai.Text,
                Email = txtEmail.Text,
                TruongNhom = txtTruongNhom.Text,
            };
            if(Type==(int)Enums.LoaiTinTuc.CacNhomNuyeuNu){
                _data.Img = Lib.saveImgFromBase64(Regex.Split(Request.Form["img_upload"], "-->end<--,")[0].Replace("-->end<--,", "").Replace("-->end<--", ""), Server.MapPath("~/images/imageUpload/"));
            }
            sql.Categories.InsertOnSubmit(_data);
            sql.SubmitChanges();
            _data.AddOrUpdateCache(sql);
            CreateMessage("Thêm mới " + Enums.MucLucDesc((Enums.LoaiTinTuc)Type) + " thành công", true);
        }
        else if (TypeAction == 2)
        {

            _data = sql.Categories.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            _data.ModifyBy = admin_login.ID;
            _data.ModifyDate = DateTime.Now;
            _data.TieuDe_En = txtTitleEn.Text;
            _data.TieuDe_Vn = txtTitle.Text;
            _data.DiaChi = txtDiaChi.Text;
            _data.DienThoai = txtDienThoai.Text;
            _data.Email = txtEmail.Text;
            _data.TruongNhom = txtTruongNhom.Text;
            if (Request.Form["img_upload"] != null)
            {
                _data.Img = Lib.saveImgFromBase64(Regex.Split(Request.Form["img_upload"], "-->end<--,")[0].Replace("-->end<--,", "").Replace("-->end<--", ""), Server.MapPath("~/images/imageUpload/"));
            }
            sql.SubmitChanges();
            _data.AddOrUpdateCache(sql);
            CreateMessage("Cập nhật " + _data.TieuDe_Vn + " thành công", true);
        }
        Response.Redirect(Request.RawUrl);
    }
    public List<Category> getTinTuc(int pageSize, out int totalRowCount, out int pageSelect)
    {
        int idWeb = Convert.ToInt32(Session["websiteID"]);
        int pageNum = 1;
        if (Request.QueryString["page"] != null)
            pageNum = Convert.ToInt32(Request.QueryString["page"]);
        if (pageNum < 1)
            pageNum = 1;
        pageSelect = pageNum;

        string seach = Request.QueryString["seach"];
        var query = sql.getCategory().Where(d => d.Type == Type && d.Status != -1);


        if (!string.IsNullOrEmpty(seach))
        {
            query = (from T in query where Convert.ToBoolean(sql.sosanhstring(T.TieuDe_Vn, seach)) || Convert.ToBoolean(sql.sosanhstring(T.TieuDe_En, seach)) select T);
        }
        query = query.OrderByDescending(d => d.CreateDate);
        totalRowCount = query.Count();
        return query.Skip(pageSize * (pageNum - 1)).Take(pageSize).ToList();
    }
}