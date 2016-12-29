using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.IO;
using System.Text.RegularExpressions;
using System.Net;
using System.Text;
using System.Threading;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Xml;
using System.Data;
using System.ComponentModel;
using Newtonsoft.Json;
using System.Dynamic;

public static class CacheCus
{


    private static List<Category> _Category = new List<Category>();
    private static List<tblEmailTemplate> _EmailTemplate = null;
    public static Setting setting = null;


    public static List<tblEmailTemplate> EmailTemplate(this LinqDataContext sql)
    {
        if (_EmailTemplate == null)
            UpdateEmailTemplate(sql);
        return _EmailTemplate;
    }
    public static void UpdateEmailTemplate(this LinqDataContext sql)
    {
        _EmailTemplate = sql.tblEmailTemplates.ToList();
    }

    public static Setting GetSetting(this LinqDataContext sql)
    {
        if (setting == null)
            UpdateSetting(sql, sql.Settings.Where(d => d.ID == 1).FirstOrDefault());

        return setting;
    }
    public static void UpdateSetting(this LinqDataContext sql, Setting _setting)
    {
        setting = _setting;
        setting.EmailSend = setting.AccountEmailSend.Split(';').Where(d => !string.IsNullOrEmpty(d)).Select(d => new StrucEmail(d)).ToList();
        dynamic pay = JsonConvert.DeserializeObject<ExpandoObject>(setting.PaySetting);
        setting.clientId = pay.clientId;
        setting.clientSecret = pay.clientSecret;
        setting.shipping = Convert.ToInt32(pay.shipping);
        setting.tax = Convert.ToInt32(pay.tax);
    }
    public static List<Category> Category(this LinqDataContext sql)
    {
        if (_Category.Count == 0)
            UpdateCategory(sql);
        return _Category;
    }
    public static void UpdateCategory(this LinqDataContext sql)
    {
        _Category = sql.Categories.ToList();
    }


}