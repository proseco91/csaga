using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class View_ThemCauChuyen : BaseHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            foreach (var item in sql.ThanhPhos)
            {
                lstThanhPho.Items.Add(new ListItem(item.region_name, item.region_id.ToString()));
            }
        }
    }
    protected void txtEmail_TextChanged(object sender, EventArgs e)
    {
        if (Lib.emailcheck(txtEmail.Text.Trim()))
        {
            User user = sql.getUser().Where(d => d.Email.ToLower().Equals(txtEmail.Text.ToLower())).FirstOrDefault();
            if (user == null)
            {
                txtDienThoai.Enabled = true;
                txtFullname.Enabled = true;
            }
            else
            {
                txtDienThoai.Text = user.PhoneNumber;
                txtFullname.Text = user.FullName;
            }
            if (txtEmail.Text.Trim().Length > 0 && txtFullname.Text.Trim().Length > 0 && txtDienThoai.Text.Trim().Length > 0)
            {
                panelCauChuyen.Enabled = true;
            }
            else
            {
                panelCauChuyen.Enabled = false;
            }
        }
        else
        {
            txtDienThoai.Enabled = false;
            txtFullname.Enabled = false;
            panelCauChuyen.Enabled = false;
        }

    }
    protected void txtDienThoai_TextChanged(object sender, EventArgs e)
    {
        if (txtEmail.Text.Trim().Length > 0 && txtFullname.Text.Trim().Length > 0 && txtDienThoai.Text.Trim().Length > 0)
        {
            panelCauChuyen.Enabled = true;
        }
        else
        {
            panelCauChuyen.Enabled = false;
        }
    }
    protected void txtFullname_TextChanged(object sender, EventArgs e)
    {
        if (txtEmail.Text.Trim().Length > 0 && txtFullname.Text.Trim().Length > 0 && txtDienThoai.Text.Trim().Length > 0)
        {
            panelCauChuyen.Enabled = true;
        }
        else
        {
            panelCauChuyen.Enabled = false;
        }
    }
    protected void Action_AddNew_Click(object sender, EventArgs e)
    {
        User user = sql.getUser().Where(d => d.Email.ToLower().Equals(txtEmail.Text.ToLower())).FirstOrDefault();
        bool isAddUser = false;
        if (user == null)
        {
            user = new User()
            {
                Avarta = "",
                CreateBy = "",
                CreateDate = DateTime.Now,
                Email = txtEmail.Text.Trim().ToLower(),
                FullName = txtFullname.Text.Trim(),
                ID = Lib.CreateGuid(),
                Password = Lib.createMd5("123456"),
                PhoneNumber = txtDienThoai.Text.Trim(),
                Status = (int)Enums.Status.active,
                UserName = txtEmail.Text.Trim().ToLower(),
            };
            sql.Users.InsertOnSubmit(user);
            isAddUser = true;
        }
        TinTuc _data = new TinTuc()
        {
            Category = "",
            CreateBy = "",
            CreateDate = DateTime.Now,
            Des_En = "",
            Des_Vn = txtDes.Text,
            ID = Lib.CreateGuid(),
            Img = Lib.saveImgFromBase64(Regex.Split(Request.Form["img_upload"], "-->end<--,")[0].Replace("-->end<--,", "").Replace("-->end<--", ""), Server.MapPath("~/images/imageUpload/")),
            NoiDung_Vn = Lib.convertNoiDungHTML(txtChiTiet.Text, Server.MapPath("~/images/imageUpload/")),
            NoiDung_En="",
            Status = (int)Enums.Status.pending,
            TieuDe_Vn = txtTitle.Text,
            TieuDe_En = "",
            Type = (int)Enums.LoaiTinTuc.HinhAnhCongDongYeuNu,
            UserCreate = user.ID,
            ThanhPho = Convert.ToInt32(lstThanhPho.SelectedItem.Value)
        };
        sql.TinTucs.InsertOnSubmit(_data);
        sql.SubmitChanges();
        if (isAddUser)
            user.AddOrUpdateCache(sql);
        Session["Message_Popup"] = Lib.createInfoLinkTam("Thêm mới câu chuyện thành công", true);
        Response.Write("<script type=\"text/javascript\">setTimeout(function () {parent.closeThemCauChuyen();}, 2500);</script>");
    }
}