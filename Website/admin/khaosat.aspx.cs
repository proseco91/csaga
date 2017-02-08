using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

public partial class admin_khaosat : BasePage
{
    KhaoSat khaosat;
    bool isChuyenTrang = true;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (TypeAction == 0)
        {
            this.Title = "Quản lý khảo sát";
            index.Visible = true;
        }
        else if (TypeAction == 1 || TypeAction == 2)
        {
            add.Visible = true;
            this.Title = "Thêm mới khảo sát";
            if (TypeAction == 2)
            {
                khaosat = sql.getKhaoSat().Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                if (khaosat == null)
                {
                    CreateMessage("Không tìm thấy khảo sát cần cập nhật", false);
                    Response.Redirect(Enums.LoaiTinTucUrlDanhSach((Enums.LoaiTinTuc.KhaoSat)));
                }
                else
                {
                    this.Title = "Chỉnh sửa '" + khaosat.TitleVn + "'";
                    if (!IsPostBack)
                    {
                        txtDateEnd.Text = khaosat.KhaoSatDenNgay.ToString("dd-MM-yyyy");
                        txtDateTo.Text = khaosat.KhaoSatTuNgay.ToString("dd-MM-yyyy");
                        txtDes.Text = khaosat.DesVn;
                        txtTitle.Text = khaosat.TitleVn;
                        dataContent.Value = khaosat.ContentKhaoSat;
                    }
                }

                Action_AddNew.Text = "Cập nhật";
            }
        }
        else if (TypeAction == 3)
        {
            khaosat = sql.getKhaoSat().Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (khaosat == null)
            {
                CreateMessage("Không tìm thấy khảo sát cần xóa", false);
            }
            else
            {
                khaosat = sql.KhaoSats.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                khaosat.Status = (int)Enums.Status.delete;
                sql.SubmitChanges();
                CreateMessage("Xóa '" + khaosat.TitleVn + "' thành công", true);
                khaosat.AddOrUpdateCache(sql);
            }
            Response.Redirect(Enums.LoaiTinTucUrlDanhSach((Enums.LoaiTinTuc.KhaoSat)), true);
        }
        else if (TypeAction == 4)
        {
            khaosat = sql.getKhaoSat().Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
            if (khaosat == null)
            {
                CreateMessage("Không tìm thấy khảo sát cần cập nhật", false);
            }
            else
            {
                khaosat = sql.KhaoSats.Where(d => d.ID.Equals(Request.QueryString["ID"])).FirstOrDefault();
                khaosat.Status = khaosat.Status == (int)Enums.Status.active ? (int)Enums.Status.deactive : (int)Enums.Status.active;
                sql.SubmitChanges();
                khaosat.AddOrUpdateCache(sql);
                CreateMessage("cập nhật trạng thái '" + khaosat.TitleVn + "' thành công", true);
            }
            Response.Redirect(Enums.LoaiTinTucUrlDanhSach((Enums.LoaiTinTuc.KhaoSat)),true);
        }
    }
    protected void Action_AddNew_Click(object sender, EventArgs e)
    {
        int[] start = txtDateTo.Text.Split('-').Select(d => Convert.ToInt32(d)).ToArray();
        DateTime dateStart = new DateTime(start[2], start[1], start[0]);

        int[] end = txtDateEnd.Text.Split('-').Select(d => Convert.ToInt32(d)).ToArray();
        DateTime dateEnd = new DateTime(end[2], end[1], end[0]);

        if (dateStart <= DateTime.Now)
        {
            CreateMessage("Thời gian bắt đầu phải lớn hơn ngày hiện tại", false);
            return;
        }
        if (dateEnd < dateStart)
        {
            CreateMessage("Thời gian kết thúc phải lớn hơn thời gian bắt đầu.", false);
            return;
        }

        if (TypeAction == 1)
        {
            khaosat = new KhaoSat()
            {
                ContentKhaoSat = dataContent.Value,
                CreateBy = admin_login.ID,
                CreateDate = DateTime.Now,
                DesVn = txtDes.Text,
                ID = Lib.CreateGuid(),
                KhaoSatTuNgay = dateStart,
                KhaoSatDenNgay = dateEnd.AddHours(23).AddMinutes(59),
                Status = (int)Enums.Status.active,
                TitleVn = txtTitle.Text
            };
            sql.KhaoSats.InsertOnSubmit(khaosat);
            sql.SubmitChanges();
            khaosat.AddOrUpdateCache(sql);
            CreateMessage("Thêm khảo sát thành công.", true);
        }
        else
        {

            khaosat = sql.KhaoSats.Where(d => d.ID == khaosat.ID).FirstOrDefault();
            khaosat.ContentKhaoSat = dataContent.Value;
            khaosat.DesVn = txtDes.Text;

            khaosat.KhaoSatTuNgay = dateStart;
            khaosat.KhaoSatDenNgay = dateEnd.AddHours(23).AddMinutes(59);

            khaosat.TitleVn = txtTitle.Text;
            sql.SubmitChanges();
            khaosat.AddOrUpdateCache(sql);
            CreateMessage("Cập nhật thành công.", true);
        }

        Response.Redirect(Request.RawUrl);
    }

    public List<KhaoSat> getData(int pageSize, out int totalRowCount, out int pageSelect)
    {
        int pageNum = 1;
        if (Request.QueryString["page"] != null)
            pageNum = Convert.ToInt32(Request.QueryString["page"]);
        if (pageNum < 1)
            pageNum = 1;
        pageSelect = pageNum;

        string seach = Request.QueryString["seach"];
        var query = sql.getKhaoSat().Where(d => d.Status != -1);


        if (!string.IsNullOrEmpty(seach))
        {
            query = (from T in query where Convert.ToBoolean(sql.sosanhstring(T.TitleVn, seach)) || Convert.ToBoolean(sql.sosanhstring(T.DesVn, seach)) select T);
        }
        query = query.OrderByDescending(d => d.CreateDate);
        totalRowCount = query.Count();
        return query.Skip(pageSize * (pageNum - 1)).Take(pageSize).ToList();
    }
}