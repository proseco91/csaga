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
            admin = dataUpdate;
    }
    public static List<Admin> getAdmin(this LinqDataContext sql)
    {
        if (cache_admin == null)
            cache_admin = sql.Admins.ToList();
        return cache_admin;
    }
}