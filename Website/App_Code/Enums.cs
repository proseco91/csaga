using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Enums
/// </summary>
public static class Enums
{
    public enum LoaiTinTuc : byte
    {
        TinVeLGBT = 1,
        ThuVien = 2,
        HinhAnhCongDongYeuNu = 3,
        CacNhomNuyeuNu = 4,
        GiaiTri = 5,
        ViecLam = 6,
        Event = 7
    }
    public static string LoaiTinTucDesc(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "Tin về LGBT+";

            case LoaiTinTuc.ThuVien:
                return "Thư viện";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "Hình ảnh cộng đồng nữ yêu nữ";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "Các nhóm nữ yêu nữ";

            case LoaiTinTuc.GiaiTri:
                return "Giải trí";

            case LoaiTinTuc.ViecLam:
                return "Việc làm";

            case LoaiTinTuc.Event:
                return "Sự kiện";
            default:
                return "";
        }
    }
    public static string LoaiTinTucUrlDanhSach(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "tin-ve-lgbt.htm";

            case LoaiTinTuc.ThuVien:
                return "Thư viện";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "Hình ảnh cộng đồng nữ yêu nữ";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "Các nhóm nữ yêu nữ";

            case LoaiTinTuc.GiaiTri:
                return "Giải trí";

            case LoaiTinTuc.ViecLam:
                return "Việc làm";

            case LoaiTinTuc.Event:
                return "Sự kiện";
            default:
                return "";
        }
    }
    public static string LoaiTinTucUrlThemMoi(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "them-moi-tin-ve-lgbt.htm";

            case LoaiTinTuc.ThuVien:
                return "Thư viện";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "Hình ảnh cộng đồng nữ yêu nữ";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "Các nhóm nữ yêu nữ";

            case LoaiTinTuc.GiaiTri:
                return "Giải trí";

            case LoaiTinTuc.ViecLam:
                return "Việc làm";

            case LoaiTinTuc.Event:
                return "Sự kiện";
            default:
                return "";
        }
    }
}