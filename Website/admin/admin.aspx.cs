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

public partial class admin_admin : BasePage
{
    Admin _data;
    public int Type = -1;
    public string menuActive = "";
    public bool isChuyenTrang = true;
    protected void Page_Load(object sender, EventArgs e)
    {


        if (TypeAction == 0)
        {
            this.Title = "Quản lý tài khoản quản trị";
            index.Visible = true;
        }
        else if (TypeAction == 1 || TypeAction == 2)
        {
            if (Type == (int)Enums.LoaiTinTuc.TinTucSuKien || Type == (int)Enums.LoaiTinTuc.HinhAnhCongDongYeuNu || Type == (int)Enums.LoaiTinTuc.CacNhomNuyeuNu || Type == (int)Enums.LoaiTinTuc.Event)
            {
                PanelMucLuc.Visible = false;
            }
            this.Title = "Thêm mới " + Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type);
            add.Visible = true;
            if (!IsPostBack)
            {

                for (int i = 1; i <= 9; i++)
                {
                    cbCate.Items.Add(new ListItem(Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)i), i.ToString()));
                }

            }
            if (TypeAction == 2)
            {
                _data = sql.getAdmin().Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                if (_data == null)
                {
                    CreateMessage("Không tìm thấy " + Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type) + " cần cập nhật", false);
                    Response.Redirect(Enums.LoaiTinTucUrlDanhSach((Enums.LoaiTinTuc)Type));
                }
                else
                {
                    this.Title = "Chỉnh sửa '" + _data.Email + "'";
                    if (!IsPostBack)
                    {
                        txtEmail.Enabled = false;
                        txtEmail.Text = _data.Email;
                        txtFullName.Text = _data.FullName;

                        List<string> cate = _data.Quyen.Split(',').ToList();
                        foreach (ListItem li in cbCate.Items)
                        {
                            li.Selected = cate.Contains(li.Value);
                        }
                    }
                }

                Action_AddNew.Text = "Cập nhật";
            }
        }
        else if (TypeAction == 3)
        {
            _data = sql.getAdmin().Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (_data == null)
            {
                CreateMessage("Không tìm thấy tài khoản cần xóa", false);
            }
            else
            {
                _data = sql.Admins.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                _data.Status = (int)Enums.Status.delete;
                sql.SubmitChanges();
                CreateMessage("Xóa '" + _data.Email + "' thành công", true);
                _data.AddOrUpdateCache(sql);
                Response.Redirect(Enums.LoaiTinTucUrlDanhSach((Enums.LoaiTinTuc)Type));
            }
            Response.Redirect(Request.UrlReferrer.ToString());
        }
        else if (TypeAction == 4)
        {
            _data = sql.getAdmin().Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (_data == null)
            {
                CreateMessage("Không tìm thấy tài khoản cần cập nhật", false);
            }
            else
            {
                _data = sql.Admins.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                _data.Status = _data.Status == (int)Enums.Status.active ? (int)Enums.Status.deactive : (int)Enums.Status.active;
                sql.SubmitChanges();
                _data.AddOrUpdateCache(sql);
                CreateMessage("cập nhật trạng thái '" + _data.Email + "' thành công", true);
            }
            Response.Redirect(Request.UrlReferrer.ToString());
        }
    }


    protected void Action_AddNew_Click(object sender, EventArgs e)
    {
        if (TypeAction == 1)
        {

            if (sql.getAdmin().Where(d => d.Email == txtEmail.Text.Trim().ToLower()).Count() > 0)
            {
                CreateMessage("Email '" + txtEmail.Text.Trim().ToLower() + "' đã tồn tại.", false);
                isChuyenTrang = false;
            }
            else
            {
                _data = new Admin()
                {
                    CreateBy = admin_login.ID,
                    CreateDate = DateTime.Now,
                    Email = txtEmail.Text.Trim().ToLower(),
                    FullName = txtFullName.Text.Trim(),
                    ID = Lib.CreateGuid(),
                    IsSuperAdmin = false,
                    Password = Lib.createMd5(txtPassword.Text.Trim()),
                    Quyen = string.Join(",", cbCate.Items.Cast<ListItem>().Where(x => x.Selected).Select(d => d.Value)),
                    Status = (int)Enums.Status.active,
                    UserName = txtEmail.Text.Trim().ToLower()
                };

                sql.Admins.InsertOnSubmit(_data);
                sql.SubmitChanges();
                _data.AddOrUpdateCache(sql);
                CreateMessage("Thêm mới " + _data.Email + " thành công", true);
            }


        }
        else if (TypeAction == 2)
        {
            _data = sql.Admins.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            _data.FullName = txtFullName.Text.Trim();
            if (!string.IsNullOrEmpty(txtPassword.Text.Trim()))
                _data.Password = Lib.createMd5(txtPassword.Text.Trim());
            _data.Quyen = string.Join(",", cbCate.Items.Cast<ListItem>().Where(x => x.Selected).Select(d => d.Value));
            sql.SubmitChanges();
            _data.AddOrUpdateCache(sql);
            CreateMessage("Cập nhật " + _data.Email + " thành công", true);
        }
        if (isChuyenTrang)
            Response.Redirect(Request.RawUrl);
    }
    public List<Admin> getTinTuc(int pageSize, out int totalRowCount, out int pageSelect)
    {
        int idWeb = Convert.ToInt32(Session["websiteID"]);
        int pageNum = 1;
        if (Request.QueryString["page"] != null)
            pageNum = Convert.ToInt32(Request.QueryString["page"]);
        if (pageNum < 1)
            pageNum = 1;
        pageSelect = pageNum;

        string seach = Request.QueryString["seach"];
        var query = sql.getAdmin().Where(d => d.Status != -1 && !d.IsSuperAdmin);


        if (!string.IsNullOrEmpty(seach))
        {
            query = (from T in query where Convert.ToBoolean(sql.sosanhstring(T.Email, seach)) || Convert.ToBoolean(sql.sosanhstring(T.FullName, seach)) select T);
        }
        query = query.OrderByDescending(d => d.CreateDate);
        totalRowCount = query.Count();
        return query.Skip(pageSize * (pageNum - 1)).Take(pageSize).ToList();
    }
}