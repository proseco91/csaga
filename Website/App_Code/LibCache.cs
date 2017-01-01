using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Entity;


/// <summary>
/// Summary description for LibCeach
/// </summary>
public static class LibCache
{
    
    private static List<Admin> cache_admin { get; set; }

    public static void AddOrUpdateCache(this Admin dataUpdate)
    {
        var admin = cache_admin.Where(d => d.ID == dataUpdate.ID).FirstOrDefault();
        if (admin == null)
            cache_admin.Add(dataUpdate);
        else
        {
            cache_admin.Remove(admin);
            if (dataUpdate.Status != (int)Enums.Status.delete)
                cache_admin.Add(dataUpdate);
        }
            
    }
    public static List<Admin> getAdmin(this LinqDataContext sql)
    {
        if (cache_admin == null)
            cache_admin = sql.Admins.Where(d => d.Status != (int)Enums.Status.delete).ToList();
        return cache_admin;
    }


    private static List<Category> cache_category { get; set; }

    public static void AddOrUpdateCache(this Category dataUpdate)
    {
        var admin = cache_category.Where(d => d.ID == dataUpdate.ID).FirstOrDefault();
        if (admin == null)
            cache_category.Add(dataUpdate);
        else {
            cache_category.Remove(admin);
            if (dataUpdate.Status != (int)Enums.Status.delete)
                cache_category.Add(dataUpdate);
        }
    }
    public static List<Category> getCategory(this LinqDataContext sql)
    {
        if (cache_category == null)
            cache_category = sql.Categories.Where(d=>d.Status!=(int)Enums.Status.delete).ToList();
        return cache_category;
    }

    public static List<ip2location_db1> cache_iplocation { get; set; }

    public static List<ip2location_db1> getIpLocation(this LinqDataContext sql)
    {
        if (cache_iplocation == null)
            cache_iplocation = sql.ip2location_db1s.ToList();
        return cache_iplocation;
    }



    public static List<string> cache_thanhpho = new List<string>() { "An Giang", "Bà Rịa - Vũng Tàu", "Bắc Giang", "Bắc Kạn", "Bạc Liêu", "Bắc Ninh", "Bến Tre", "Bình Định", "Bình Dương", "Bình Phước", "Bình Thuận", "Cà Mau", "Cao Bằng", "Đắk Lắk", "Đắk Nông", "Điện Biên", "Đồng Nai", "Đồng Tháp", "Gia Lai", "Hà Giang", "Hà Nam", "Hà Tĩnh", "Hải Dương", "Hậu Giang", "Hòa Bình", "Hưng Yên", "Khánh Hòa", "Kiên Giang", "Kon Tum", "Lai Châu", "Lâm Đồng", "Lạng Sơn", "Lào Cai", "Long An", "Nam Định", "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ", "Quảng Bình", "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng", "Sơn La", "Tây Ninh", "Thái Bình", "Thái Nguyên", "Thanh Hóa", "Thừa Thiên Huế", "Tiền Giang", "Trà Vinh", "Tuyên Quang", "Vĩnh Long", "Vĩnh Phúc", "Yên Bái", "Phú Yên", "Cần Thơ", "Đà Nẵng", "Hải Phòng", "Hà Nội", "TP HCM" };

}