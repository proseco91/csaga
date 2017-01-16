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
using System.Web.UI;

/// <summary>
/// Summary description for Lib
/// </summary>
/// 


public static class Lib
{


    public static string urlhome;
    public static string hostchat = "http://localhost:1230";


    public static string CreateGuid()
    {
        return Guid.NewGuid().ToString().Trim();
    }
    
    public static bool propertyExist(object obj, string propertyName)
    {
        IDictionary<string, object> propertyValues = (IDictionary<string, object>)obj;
        object value;
        return propertyValues.TryGetValue(propertyName, out value);
    }




    static Lib()
    {
        HttpRequest req = HttpContext.Current.Request;
        urlhome = req.Url.GetLeftPart(UriPartial.Authority);
        if (urlhome.IndexOf("http://localhost") > -1)
            urlhome += req.ApplicationPath;
    }

    public static string formatTime(object _date, string format)
    {
        try
        {
            return Convert.ToDateTime(_date).ToString(format);
        }
        catch
        {

            return "?";
        }
    }
    
    public static string TimeAgo(DateTime date)
    {
        TimeSpan timeSince = DateTime.Now.Subtract(date);
        if (timeSince.TotalMinutes < 1)
            return string.Format("{0} giây trước", timeSince.Seconds);
        if (timeSince.TotalMinutes < 2)
            return "1 phút trước";
        if (timeSince.TotalMinutes < 60)
            return string.Format("{0} phút trước", timeSince.Minutes);
        if (timeSince.TotalMinutes < 120)
            return "1 giờ trước";
        if (timeSince.TotalHours < 24)
            return string.Format("{0} giờ trước", timeSince.Hours);
        if (timeSince.TotalDays == 1)
            return "hôm qua";
        if (timeSince.TotalDays < 7)
            return string.Format("{0} ngày trước", timeSince.Days);
        if (timeSince.TotalDays < 14)
            return "tuần trước";
        if (timeSince.TotalDays < 21)
            return "2 tuần trước";
        if (timeSince.TotalDays < 28)
            return "3 tuần trước";
        if (timeSince.TotalDays < 60)
            return "tháng trước";
        if (timeSince.TotalDays < 365)
            return string.Format("{0} tháng trước", Math.Round(timeSince.TotalDays / 30));
        if (timeSince.TotalDays < 730)
            return "năm ngoái";
        return string.Format("{0} năm trước", Math.Round(timeSince.TotalDays / 365));
    }

    private static byte[] Encrypt(byte[] clearText, byte[] Key, byte[] IV)
    {
        MemoryStream ms = new MemoryStream();
        Rijndael alg = Rijndael.Create();
        alg.Key = Key;
        alg.IV = IV;
        CryptoStream cs = new CryptoStream(ms, alg.CreateEncryptor(), CryptoStreamMode.Write);
        cs.Write(clearText, 0, clearText.Length);
        cs.Close();
        byte[] encryptedData = ms.ToArray();
        return encryptedData;
    }

    public static string Encrypt(string clearText, string Password)
    {
        byte[] clearBytes = System.Text.Encoding.Unicode.GetBytes(clearText);
        PasswordDeriveBytes pdb = new PasswordDeriveBytes(Password, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
        byte[] encryptedData = Encrypt(clearBytes, pdb.GetBytes(32), pdb.GetBytes(16));
        return Convert.ToBase64String(encryptedData);
    }

    private static byte[] Decrypt(byte[] cipherData, byte[] Key, byte[] IV)
    {
        MemoryStream ms = new MemoryStream();
        Rijndael alg = Rijndael.Create();
        alg.Key = Key;
        alg.IV = IV;
        CryptoStream cs = new CryptoStream(ms, alg.CreateDecryptor(), CryptoStreamMode.Write);
        cs.Write(cipherData, 0, cipherData.Length);
        cs.Close();
        byte[] decryptedData = ms.ToArray();
        return decryptedData;
    }

    public static string Decrypt(string cipherText, string Password)
    {
        byte[] cipherBytes = Convert.FromBase64String(cipherText);
        PasswordDeriveBytes pdb = new PasswordDeriveBytes(Password, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
        byte[] decryptedData = Decrypt(cipherBytes, pdb.GetBytes(32), pdb.GetBytes(16));
        return System.Text.Encoding.Unicode.GetString(decryptedData);
    }
    
    public static string formatMoney(object money)
    {
        return String.Format("{0:#,##0}", money);
    }
    public static bool isNumber(object number)
    {
        return new Regex("^[0-9]+$").IsMatch(number.ToString());
    }
    public static string createMd5(string data)
    {
        return BitConverter.ToString(encryptData(data)).Replace("-", "").ToLower();
    }
    public static byte[] encryptData(string data)
    {
        System.Security.Cryptography.MD5CryptoServiceProvider md5Hasher = new System.Security.Cryptography.MD5CryptoServiceProvider();
        byte[] hashedBytes;
        System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
        hashedBytes = md5Hasher.ComputeHash(encoder.GetBytes(data));
        return hashedBytes;
    }




    public static long ToJavaScriptMilliseconds(DateTime dt)
    {
        System.TimeSpan span = new System.TimeSpan(System.DateTime.Parse("1/1/1970").Ticks);
        System.DateTime time = dt.Subtract(span);
        return (long)(time.Ticks / 10000);
    }

    
}