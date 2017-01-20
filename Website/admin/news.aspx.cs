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
    TinTuc _data;
    public int Type = -1;
    public string menuActive = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Type = Convert.ToInt32(Request.QueryString["Type"]);
        menuActive = Type.ToString();

        if (TypeAction == 0)
        {
            this.Title = "Quản lý " + Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type);
            index.Visible = true;
        }
        else if (TypeAction == 1 || TypeAction == 2)
        {
            if (Type == (int)Enums.LoaiTinTuc.TinTucSuKien || Type == (int)Enums.LoaiTinTuc.HinhAnhCongDongYeuNu  || Type == (int)Enums.LoaiTinTuc.Event || Type == (int)Enums.LoaiTinTuc.ThuVien)
            {
                PanelMucLuc.Visible = false;
            }
            this.Title = "Thêm mới " + Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type);
            add.Visible = true;
            if (!IsPostBack)
            {
                var lisCb = sql.getCategory().Where(d=>d.Type==Type);
                foreach (var parent in lisCb.OrderBy(d => d.TieuDe_Vn))
                {
                    cbCate.Items.Add(new ListItem(parent.TieuDe_Vn, parent.ID.ToString()));
                    
                }
            }
            if (TypeAction == 2)
            {
                _data = sql.TinTucs.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                if (_data == null)
                {
                    CreateMessage("Không tìm thấy "+Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type)+" cần cập nhật", false);
                    Response.Redirect(Enums.LoaiTinTucUrlDanhSach((Enums.LoaiTinTuc)Type));
                }
                else
                {
                    this.Title = "Chỉnh sửa '" + _data.TieuDe_Vn + "'";
                    if (!IsPostBack)
                    {
                        txtTitle.Text = _data.TieuDe_Vn;
                        txtTitleEn.Text = _data.TieuDe_En;

                        txtDes.Text = _data.Des_Vn;
                        txtDesEn.Text = _data.Des_En;

                        txtChiTiet.Text = _data.NoiDung_Vn;
                        txtChiTietEn.Text = _data.NoiDung_En;

                        List<string> cate = _data.Category.Split(',').ToList();
                        foreach (ListItem li in cbCate.Items)
                        {
                            li.Selected = cate.Contains(li.Value);
                        }

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
                _data.Status = (int)Enums.Status.delete;
                sql.SubmitChanges();
                CreateMessage("Xóa '" + _data.TieuDe_Vn + "' thành công", true);
                Response.Redirect(Enums.LoaiTinTucUrlDanhSach((Enums.LoaiTinTuc)Type));
            }
            Response.Redirect(Request.UrlReferrer.ToString());
        }
        else if (TypeAction == 4)
        {
            _data = sql.TinTucs.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (_data == null)
            {
                CreateMessage("Không tìm thấy " + Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type) + " cần cập nhật", false);
            }
            else
            {
                _data.Status = _data.Status == (int)Enums.Status.active ? (int)Enums.Status.deactive : (int)Enums.Status.active;
                sql.SubmitChanges();
                CreateMessage("cập nhật trạng thái '" + _data.TieuDe_Vn + "' thành công", true);
            }
            Response.Redirect(Request.UrlReferrer.ToString());
        }
    }


    protected void Action_AddNew_Click(object sender, EventArgs e)
    {
        if (TypeAction == 1)
        {



            _data = new TinTuc()
            {
                Category = string.Join(",", cbCate.Items.Cast<ListItem>().Where(x => x.Selected).Select(d => d.Value)),
                CreateBy = admin_login.ID,
                CreateDate = DateTime.Now,
                Des_En = txtDesEn.Text,
                Des_Vn = txtDes.Text,
                ID = Lib.CreateGuid(),
                Img = Lib.saveImgFromBase64(Regex.Split(Request.Form["img_upload"], "-->end<--,")[0].Replace("-->end<--,", "").Replace("-->end<--", ""), Server.MapPath("~/images/imageUpload/")),
                ModifyBy = admin_login.ID,
                ModifyDate = DateTime.Now,
                NoiDung_En = Lib.convertNoiDungHTML(txtChiTietEn.Text, Server.MapPath("~/images/imageUpload/")),
                NoiDung_Vn = Lib.convertNoiDungHTML(txtChiTiet.Text, Server.MapPath("~/images/imageUpload/")),
                Status = (int)Enums.Status.active,
                TieuDe_En = txtTitleEn.Text,
                TieuDe_Vn = txtTitle.Text,
                Type = Type
            };
            sql.TinTucs.InsertOnSubmit(_data);
            sql.SubmitChanges();
            CreateMessage("Thêm mới " + Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type) + " thành công", true);
        }
        else if (TypeAction == 2)
        {

            _data.Category = string.Join(",", cbCate.Items.Cast<ListItem>().Where(x => x.Selected).Select(d => d.Value));
            _data.Des_En = txtDesEn.Text;
            _data.Des_Vn = txtDes.Text;
            if (Request.Form["img_upload"] != null)
            {
                _data.Img = Lib.saveImgFromBase64(Regex.Split(Request.Form["img_upload"], "-->end<--,")[0].Replace("-->end<--,", "").Replace("-->end<--", ""), Server.MapPath("~/images/imageUpload/"));
            }
            _data.ModifyBy = admin_login.ID;
            _data.ModifyDate = DateTime.Now;
            _data.NoiDung_En = Lib.convertNoiDungHTML(txtChiTietEn.Text, Server.MapPath("~/images/imageUpload/"));
            _data.NoiDung_Vn = Lib.convertNoiDungHTML(txtChiTiet.Text, Server.MapPath("~/images/imageUpload/"));
            _data.TieuDe_En = txtTitleEn.Text;
            _data.TieuDe_Vn = txtTitle.Text;
            sql.SubmitChanges();
            CreateMessage("Cập nhật " + _data.TieuDe_Vn + " thành công", true);
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


        if (!string.IsNullOrEmpty(seach))
        {
            query = (from T in query where Convert.ToBoolean(sql.sosanhstring(T.TieuDe_Vn, seach)) || Convert.ToBoolean(sql.sosanhstring(T.TieuDe_En, seach)) || Convert.ToBoolean(sql.sosanhstring(T.Des_Vn, seach)) || Convert.ToBoolean(sql.sosanhstring(T.Des_En, seach)) select T);
        }
        query = query.OrderByDescending(d => d.CreateDate);
        totalRowCount = query.Count();
        return query.Skip(pageSize * (pageNum - 1)).Take(pageSize).ToList();
    }
}