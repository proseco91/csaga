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

public partial class admin_danh_muc : BasePage
{
    Category _cateUpdate;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (TypeAction == 0)
        {
            this.Title = "Quản lý danh mục sản phẩm";
            index.Visible = true;
        }
        else if (TypeAction == 1 || TypeAction == 2)
        {
            this.Title = "Thêm mới danh mục sản phẩm";
            add.Visible = true;
            
            if (TypeAction == 2)
            {
                _cateUpdate = sql.Categories.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                if (_cateUpdate == null)
                {
                    CreateMessage("Không tìm thấy danh mục cần cập nhật", false);
                    Response.Redirect("danh-muc.htm");
                }
                else
                {
                    this.Title = "Chỉnh sửa danh mục '" + _cateUpdate.Name + "'";
                    if (!IsPostBack)
                    {
                        
                        txtName.Text = _cateUpdate.Name;
                        Response.Write("<script type=\"text/javascript\">var ListImgOld = " + JsonConvert.SerializeObject(_cateUpdate.Img.Split(',').Where(d => !string.IsNullOrEmpty(d))) + ";</script>");
                    }
                }
                Action_AddNew.Text = "Cập nhật";
            }
        }
        else if (TypeAction == 3)
        {
            _cateUpdate = sql.Categories.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (_cateUpdate == null)
            {
                CreateMessage("Không tìm thấy danh mục cần xóa", false);
            }
            else {
                sql.Categories.DeleteOnSubmit(_cateUpdate);
                sql.SubmitChanges();
                sql.UpdateCategory();
                CreateMessage("Xóa danh mục '"+_cateUpdate.Name+"' thành công", true);
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
                Lib.ResizeByWidth(new MemoryStream(Convert.FromBase64String(Regex.Replace(base64.Replace("-->end<--,", "").Replace("-->end<--", ""), "data:image/.*?;base64,", ""))), 400).Save(serverMap + fileName, ImageFormat.Png);
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
            Category _cate = new Category()
            {
                CreateDate = DateTime.Now,
                ID = Lib.CreateGuid(),
                Name = txtName.Text,
                ParentID = "0",
                Img = getListImg(new List<string>())
            };
            sql.Categories.InsertOnSubmit(_cate);
            sql.SubmitChanges();
            sql.UpdateCategory();
            CreateMessage("Thêm mới danh mục sản phẩm thành công", true);
        }
        else {
            _cateUpdate.Name = txtName.Text;
            _cateUpdate.Img = getListImg(_cateUpdate.Img.Split(',').ToList());
            sql.SubmitChanges();
            sql.UpdateCategory();
            CreateMessage("Cập nhật danh mục sản phẩm thành công", true);
        }
        Response.Redirect(Request.RawUrl);
    }
    public List<Category> getCategory()
    {
        return sql.Categories.OrderByDescending(d => d.CreateDate).ToList();
    }
}