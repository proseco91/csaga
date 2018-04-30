using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using Entity;
using Newtonsoft.Json;
using System.Collections.Generic;

/// <summary>
/// Summary description for LibCeach
/// </summary>
public static class LibCache
{
    private static List<KhaoSat> cache_khaosat { get; set; }
    public static void convertCauHoi(this KhaoSat data)
    {
        data.arrayCauHoi = JsonConvert.DeserializeObject<List<Entity.KhaoSat.strucData>>(data.ContentKhaoSat);
    }
    public static List<KhaoSat> getKhaoSat(this LinqDataContext sql)
    {
        if (cache_khaosat == null) {
            cache_khaosat = sql.KhaoSats.Where(d => d.Status != (int)Enums.Status.delete).ToList();
            cache_khaosat.ForEach(d => {
                d.convertCauHoi();
                d.arrayCauTraLoi = sql.KhaoSat_TraLois.Where(c => c.IDKhaoSat == d.ID).ToList();
            });
        }
        return cache_khaosat;
    }
    public static void AddOrUpdateCache(this KhaoSat dataUpdate, LinqDataContext sql)
    {
        var admin = sql.getKhaoSat().Where(d => d.ID == dataUpdate.ID).FirstOrDefault();
        if (admin == null){
            dataUpdate.arrayCauTraLoi = new System.Collections.Generic.List<KhaoSat_TraLoi>();
            cache_khaosat.Add(dataUpdate);
        }
        else
        {
            dataUpdate.arrayCauTraLoi = admin.arrayCauTraLoi;
            cache_khaosat.Remove(admin);
            if (dataUpdate.Status != (int)Enums.Status.delete) {
                dataUpdate.convertCauHoi();
                cache_khaosat.Add(dataUpdate);
            }
        }

    }


    private static List<Admin> cache_admin { get; set; }

    public static void AddOrUpdateCache(this Admin dataUpdate, LinqDataContext sql)
    {
        var admin = sql.getAdmin().Where(d => d.ID == dataUpdate.ID).FirstOrDefault();
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

    public static void AddOrUpdateCache(this Category dataUpdate, LinqDataContext sql)
    {

        var admin = sql.getCategory().Where(d => d.ID == dataUpdate.ID).FirstOrDefault();
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
            cache_category = sql.Categories.Where(d=>d.Status!=(int)Enums.Status.delete).OrderBy(d=>d.Number).ToList();
        return cache_category;
    }

    public static List<ip2location_db1> cache_iplocation { get; set; }

    public static List<ip2location_db1> getIpLocation(this LinqDataContext sql)
    {
        if (cache_iplocation == null)
            cache_iplocation = sql.ip2location_db1s.ToList();
        return cache_iplocation;
    }

    public static List<ThanhPho> cache_thanhpho { get; set; }

    public static List<ThanhPho> getThanhPho(this LinqDataContext sql)
    {
        if (cache_thanhpho == null)
            cache_thanhpho = sql.ThanhPhos.ToList();
        return cache_thanhpho;
    }



    private static List<User> cache_user { get; set; }

    public static void AddOrUpdateCache(this User dataUpdate, LinqDataContext sql)
    {

        var admin = sql.getUser().Where(d => d.ID == dataUpdate.ID).FirstOrDefault();
        if (admin == null)
            cache_user.Add(dataUpdate);
        else
        {
            cache_user.Remove(admin);
            if (dataUpdate.Status != (int)Enums.Status.delete)
                cache_user.Add(dataUpdate);
        }
    }
    public static List<User> getUser(this LinqDataContext sql)
    {
        if (cache_user == null)
            cache_user = sql.Users.Where(d => d.Status != (int)Enums.Status.delete).ToList();
        return cache_user;
    }

    private static SettingWeb _settingWeb { get; set; }
    public static void AddOrUpdateCache(this SettingWeb dataUpdate)
    {

        _settingWeb = dataUpdate;
    }
    public static SettingWeb getSettingWeb(this LinqDataContext sql)
    {
        if (_settingWeb == null)
            _settingWeb = sql.SettingWebs.FirstOrDefault();
        return _settingWeb;
    }
}