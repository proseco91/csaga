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
        Event = 7,
        Account = 8,
        TuVan = 9
    }
    public enum Status : int
    {
        delete = -1,
        deactive = 0,
        active = 1
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
            case LoaiTinTuc.Account:
                return "Tài khoản quản trị";
            case LoaiTinTuc.TuVan:
                return "Tư vấn trực tuyến";
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
                return "thu-vien.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "hinh-anh-cong-dong-nu-yeu-nu.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "cac-nhom-nu-yeu-nu.htm";

            case LoaiTinTuc.GiaiTri:
                return "giai-tri.htm";

            case LoaiTinTuc.ViecLam:
                return "viec-lam.htm";

            case LoaiTinTuc.Event:
                return "event.htm";
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
                return "them-moi-thu-vien.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "them-moi-hinh-anh-cong-dong-nu-yeu-nu.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "them-moi-cac-nhom-nu-yeu-nu.htm";

            case LoaiTinTuc.GiaiTri:
                return "them-moi-giai-tri.htm";

            case LoaiTinTuc.ViecLam:
                return "them-moi-viec-lam.htm";

            case LoaiTinTuc.Event:
                return "them-moi-event.htm";
            default:
                return "";
        }
    }
    public static string LoaiTinTucUrlChinhSua(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "tin-ve-lgbt-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.ThuVien:
                return "thu-vien-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "hinh-anh-cong-dong-nu-yeu-nu-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "cac-nhom-nu-yeu-nu-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.GiaiTri:
                return "giai-tri-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.ViecLam:
                return "viec-lam-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.Event:
                return "event-chinh-sua-{0}-z-{1}.htm";
            case LoaiTinTuc.Account:
                return "tai-khoan-quan-tri-chinh-sua-{0}-z-{1}.htm";
            default:
                return "";
        }
    }
    public static string LoaiTinTucUrlTrangThai(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "tin-ve-lgbt-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.ThuVien:
                return "thu-vien-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "hinh-anh-cong-dong-nu-yeu-nu-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "cac-nhom-nu-yeu-nu-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.GiaiTri:
                return "giai-tri-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.ViecLam:
                return "viec-lam-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.Event:
                return "event-trangthai-{0}-z-{1}.htm";
            case LoaiTinTuc.Account:
                return "tai-khoan-quan-tri-trangthai-{0}-z-{1}.htm";
            default:
                return "";
        }
    }
    public static string LoaiTinTucUrlXoa(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "tin-ve-lgbt-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.ThuVien:
                return "thu-vien-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "hinh-anh-cong-dong-nu-yeu-nu-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "cac-nhom-nu-yeu-nu-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.GiaiTri:
                return "giai-tri-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.ViecLam:
                return "viec-lam-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.Event:
                return "event-xoa-{0}-z-{1}.htm";
            case LoaiTinTuc.Account:
                return "tai-khoan-quan-tri-xoa-{0}-z-{1}.htm";
            default:
                return "";
        }
    }



    // Muc Luc

    public static string MucLucDesc(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "Mục lục LGBT+";

            case LoaiTinTuc.ThuVien:
                return "Mục lục thư viện";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "Mục lục hình ảnh cộng đồng nữ yêu nữ";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "Mục lục các nhóm nữ yêu nữ";

            case LoaiTinTuc.GiaiTri:
                return "Mục lục giải trí";

            case LoaiTinTuc.ViecLam:
                return "Mục lục việc làm";

            case LoaiTinTuc.Event:
                return "Mục lục sự kiện";
            default:
                return "";
        }
    }
    public static string MucLucUrlDanhSach(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "muc-luc-lgbt.htm";

            case LoaiTinTuc.ThuVien:
                return "muc-luc-thu-vien.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "muc-luc-hinh-anh-cong-dong-nu-yeu-nu.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "muc-luc-cac-nhom-nu-yeu-nu.htm";

            case LoaiTinTuc.GiaiTri:
                return "muc-luc-giai-tri.htm";

            case LoaiTinTuc.ViecLam:
                return "muc-luc-viec-lam.htm";

            case LoaiTinTuc.Event:
                return "muc-luc-event.htm";
            default:
                return "";
        }
    }
    public static string MucLucUrlThemMoi(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "them-moi-muc-luc-lgbt.htm";

            case LoaiTinTuc.ThuVien:
                return "them-moi-muc-luc-thu-vien.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "them-moi-muc-luc-hinh-anh-cong-dong-nu-yeu-nu.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "them-moi-muc-luc-cac-nhom-nu-yeu-nu.htm";

            case LoaiTinTuc.GiaiTri:
                return "them-moi-muc-luc-giai-tri.htm";

            case LoaiTinTuc.ViecLam:
                return "them-moi-muc-luc-viec-lam.htm";

            case LoaiTinTuc.Event:
                return "them-moi-muc-luc-event.htm";
            default:
                return "";
        }
    }
    public static string MucLucUrlChinhSua(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "muc-luc-tin-ve-lgbt-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.ThuVien:
                return "muc-luc-thu-vien-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "muc-luc-hinh-anh-cong-dong-nu-yeu-nu-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "muc-luc-cac-nhom-nu-yeu-nu-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.GiaiTri:
                return "muc-luc-giai-tri-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.ViecLam:
                return "muc-luc-viec-lam-chinh-sua-{0}-z-{1}.htm";

            case LoaiTinTuc.Event:
                return "muc-luc-event-chinh-sua-{0}-z-{1}.htm";
            default:
                return "";
        }
    }
    public static string MucLucUrlTrangThai(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "muc-luc-tin-ve-lgbt-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.ThuVien:
                return "muc-luc-thu-vien-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "muc-luc-hinh-anh-cong-dong-nu-yeu-nu-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "muc-luc-ac-nhom-nu-yeu-nu-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.GiaiTri:
                return "muc-luc-giai-tri-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.ViecLam:
                return "muc-luc-viec-lam-trangthai-{0}-z-{1}.htm";

            case LoaiTinTuc.Event:
                return "muc-luc-event-trangthai-{0}-z-{1}.htm";
            default:
                return "";
        }
    }
    public static string MucLucUrlXoa(LoaiTinTuc _type)
    {
        switch (_type)
        {
            case LoaiTinTuc.TinVeLGBT:
                return "muc-luc-tin-ve-lgbt-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.ThuVien:
                return "muc-luc-thu-vien-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "muc-luc-hinh-anh-cong-dong-nu-yeu-nu-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.CacNhomNuyeuNu:
                return "muc-luc-cac-nhom-nu-yeu-nu-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.GiaiTri:
                return "muc-luc-giai-tri-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.ViecLam:
                return "muc-luc-viec-lam-xoa-{0}-z-{1}.htm";

            case LoaiTinTuc.Event:
                return "muc-luc-event-xoa-{0}-z-{1}.htm";
            default:
                return "";
        }
    }
    // End Muc Luc

}