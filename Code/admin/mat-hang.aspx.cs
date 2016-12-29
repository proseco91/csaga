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

public partial class admin_mat_hang : BasePage
{
    MatHang _mathang;

    protected void Page_Load(object sender, EventArgs e)
    {
        LabelTitle.Text = "Thông tin sản phẩm";
        if (TypeAction == 0)
        {
            this.Title = "Quản lý mặt hàng";
            index.Visible = true;
        }
        else if (TypeAction == 1 || TypeAction == 2 || TypeAction == 5)
        {
            this.Title = "Thêm mới mặt hàng";
            add.Visible = true;
            if (!IsPostBack)
            {
                var lisCb = sql.Categories.ToArray();
                foreach (var parent in lisCb.Where(d => d.ParentID.Equals("0")).OrderBy(d => d.Name))
                {
                    cbCate.Items.Add(new ListItem(parent.Name, parent.ID));
                    foreach (var item in lisCb.Where(d => d.ParentID.Equals(parent.ID)).OrderBy(d => d.Name))
                    {
                        cbCate.Items.Add(new ListItem(item.Name, item.ID));
                    }
                }
                foreach (ListItem li in cbCate.Items)
                {
                    var item = lisCb.Where(d => d.ID.Equals(li.Value)).FirstOrDefault();
                    li.Attributes.Add("valparent", item.ParentID);
                    li.Attributes.Add("valid", item.ID);
                    li.Attributes.Add("isParent", (item.ParentID.Equals("0") ? true : false).ToString());
                    li.Attributes.Add("style", "margin:2px 0px;");
                }
            }
            if (TypeAction == 2 || TypeAction == 5)
            {
                _mathang = sql.MatHangs.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                if (_mathang == null)
                {
                    CreateMessage(TypeAction == 2 ? "Không tìm thấy mặt hàng cần cập nhật" : "Không tìm thấy mặt hàng cần thêm color và size", false);
                    Response.Redirect("mat-hang.htm");
                }
                else
                {
                    Action_AddNew.Text = "Cập nhật";
                    if (TypeAction == 5 || _mathang.ParentID != null)
                    {
                        PanelThemSize1.Visible = false;
                        PanelThemSize2.Visible = false;
                        PanelThemSize3.Visible = false;
                        if (TypeAction == 5)
                            LabelTitle.Text = "Thông tin thêm color và size cho '" + _mathang.Title + "'";
                        Action_AddNew.Text = TypeAction == 5 ? "Thêm size và color" : "Chỉnh sửa mặt hàng";
                        txtColorAndSize.Attributes.Add("no-empty", "");
                    }
                    this.Title = (TypeAction == 2 ? "Chỉnh sửa mặt hàng '" : "Thêm color và size cho mặt hàng '") + _mathang.Title + "'";
                    if (!IsPostBack)
                    {
                        if (_mathang.ParentID == null)
                        {
                            txtTitle.Text = _mathang.Title;
                            txtMoney.Text = Lib.formatMoney(_mathang.GiaBan);
                            txtChiTiet.Text = _mathang.ChiTiet;
                            txtGiaGiam.Text = _mathang.GiamGia.HasValue ? Lib.formatMoney(_mathang.GiamGia) : "";
                            List<string> cate = _mathang.Category.Split(',').ToList();
                            foreach (ListItem li in cbCate.Items)
                            {
                                li.Selected = cate.Contains(li.Value);
                            }
                        }
                        if (TypeAction == 2)
                        {
                            txtColorAndSize.Text = _mathang.ColorAndSize;
                            Response.Write("<script type=\"text/javascript\">var ListImgOld = " + JsonConvert.SerializeObject(_mathang.Img.Split(',').Where(d => !string.IsNullOrEmpty(d))) + ";</script>");
                        }
                    }
                }

            }
        }
        else if (TypeAction == 3)
        {
            _mathang = sql.MatHangs.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (_mathang == null)
            {
                CreateMessage("Không tìm thấy mặt hàng cần xóa", false);
            }
            else
            {
                _mathang.Status = -1;
                sql.SubmitChanges();
                CreateMessage("Xóa mặt hàng thành công", true);
            }
            Response.Redirect(Request.UrlReferrer.ToString(), true);
        }
        else if (TypeAction == 4)
        {
            _mathang = sql.MatHangs.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (_mathang == null)
            {
                CreateMessage("Không tìm thấy mặt hàng cần cập nhật", false);
            }
            else
            {
                _mathang.Status = _mathang.Status == 1 ? 0 : 1;
                sql.SubmitChanges();
                CreateMessage("cập nhật trạng thái thành công", true);
            }
            Response.Redirect(Request.UrlReferrer.ToString(), true);
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


            _mathang = new MatHang()
            {
                Category = string.Join(",", cbCate.Items.Cast<ListItem>().Where(x => x.Selected).Select(d => d.Value)),
                ChiTiet = txtChiTiet.Text,
                CreateDate = DateTime.Now,
                GiaBan = Convert.ToInt32(txtMoney.Text.Replace(",", "")),
                ID = Lib.CreateGuid(),
                Img = getListImg(new List<string>()),
                Status = 1,
                Title = txtTitle.Text

            };
            if (txtColorAndSize.Text.Trim().Length > 0)
                _mathang.ColorAndSize = txtColorAndSize.Text.Trim();
            int giaGiam = 0;
            if (int.TryParse(txtGiaGiam.Text.Trim(), out giaGiam))
                _mathang.GiamGia = giaGiam;

            sql.MatHangs.InsertOnSubmit(_mathang);
            sql.SubmitChanges();
            CreateMessage("Thêm mới sản phẩm thành công", true);
        }
        else if (TypeAction == 2)
        {
            if (_mathang.ParentID == null)
            {
                _mathang.Category = string.Join(",", cbCate.Items.Cast<ListItem>().Where(x => x.Selected).Select(d => d.Value));
                _mathang.ChiTiet = txtChiTiet.Text;
                _mathang.GiaBan = Convert.ToInt32(txtMoney.Text.Replace(",", ""));
                _mathang.Title = txtTitle.Text;
                int giaGiam = 0;
                if (int.TryParse(txtGiaGiam.Text.Trim(), out giaGiam))
                    _mathang.GiamGia = giaGiam;
            }
            _mathang.Img = getListImg(_mathang.Img.Split(',').ToList());
            if (txtColorAndSize.Text.Trim().Length > 0)
                _mathang.ColorAndSize = txtColorAndSize.Text.Trim();



            sql.SubmitChanges();
            CreateMessage("Cập nhật mặt hàng " + _mathang.Title + " thành công", true);
        }
        else if (TypeAction == 5)
        {
            MatHang _mathang2 = new MatHang()
            {
                CreateDate = DateTime.Now,
                ID = Lib.CreateGuid(),
                Img = getListImg(new List<string>()),
                Status = 1,
                ParentID = _mathang.ID,
                ColorAndSize = txtColorAndSize.Text.Trim()
            };
            sql.MatHangs.InsertOnSubmit(_mathang2);
            sql.SubmitChanges();
            CreateMessage("Thêm size và color thành công", true);
        }
        Response.Redirect(Request.RawUrl);
    }
    public List<MatHang> getMatHang(int pageSize, out int totalRowCount, out int pageSelect)
    {
        int idWeb = Convert.ToInt32(Session["websiteID"]);
        int pageNum = 1;
        if (Request.QueryString["page"] != null)
            pageNum = Convert.ToInt32(Request.QueryString["page"]);
        if (pageNum < 1)
            pageNum = 1;
        pageSelect = pageNum;

        string seach = Request.QueryString["seach"];
        var query = sql.MatHangs.Where(d => d.Status != -1 && d.ParentID == null);


        if (!string.IsNullOrEmpty(seach))
        {
            query = (from T in query where Convert.ToBoolean(sql.sosanhstring(T.Title, seach)) select T);
        }
        query = query.OrderByDescending(d => d.CreateDate);
        totalRowCount = query.Count();
        return query.Skip(pageSize * (pageNum - 1)).Take(pageSize).ToList();
    }

}