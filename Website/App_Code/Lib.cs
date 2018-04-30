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
using System.Configuration;

/// <summary>
/// Summary description for Lib
/// </summary>
/// 


public static class Lib
{


    public static string urlhome;
    //public static string hostchat = "http://localhost:1230";
    public static string hostchat = "http://chat.nuyeunu.vn";

    public static Entity.LinqDataContext createSQL()
    {
        return new Entity.LinqDataContext(System.Configuration.ConfigurationManager.ConnectionStrings["Connection"].ToString());
    }

    public static string ToString(this DateTime? datetime,string format)
    {
        if (datetime.HasValue)
            datetime.Value.ToString(format);
        return string.Empty;
    }
    public static string urlChiTiet(Enums.LoaiTinTuc _type)
    {
        switch (_type)
        {
            case Enums.LoaiTinTuc.TinTucSuKien:
                return "tintuc-sukien";

            case Enums.LoaiTinTuc.ThuVien:
                return "thuvien";

            case Enums.LoaiTinTuc.HinhAnhCongDongYeuNu:
                return "chitiet-hinh-anh-cong-dong";

            case Enums.LoaiTinTuc.CacNhomNuyeuNu:
                return "nhom-nu-yeu-nu";

            case Enums.LoaiTinTuc.HoTro:
                return "hotro";
            default:
                return "";
        }
    }

    public static string ContentLag(string Vi, string En)
    {
        if (Lib.getLag().Equals("vi-VN"))
            return Vi;
        return En;
    }
    public static string create_codeChat(string infoLogin, Enums.LoaiAccount loaiaccount)
    {
        dynamic data = new ExpandoObject();
        data.data = infoLogin;
        data.type = (int)loaiaccount;
        data.time = DateTime.Now.Ticks;
        return Lib.Encrypt(JsonConvert.SerializeObject(data), "crazylady9x@gmail.com-csaga");

    }

    public static string getLag()
    {
        string lang = HttpContext.Current.Request.QueryString["lang"] == null ? "vi" : HttpContext.Current.Request.QueryString["lang"];
        if (lang.Equals("en"))
            return "en-US";
        return "vi-VN";
    }

    public static Entity.ip2location_db1 getInfoFromIp(string ip)
    {
        var listIP = LibCache.cache_iplocation;
        if (listIP == null)
            listIP = new Entity.LinqDataContext(ConfigurationManager.ConnectionStrings["Connection"].ToString()).getIpLocation();

        ip = ip.Split('.').Length < 4 ? "127.0.0.1" : ip;
        int[] ipArray = ip.Split('.').Where(d => !string.IsNullOrEmpty(d)).Select(d => Convert.ToInt32(d)).ToArray();
        int numberIp = 16777216 * ipArray[0] + 65536 * ipArray[1] + 256 * ipArray[2] + ipArray[3];
        return (from p in listIP where p.ip_to >= numberIp && p.ip_from <= numberIp select p).FirstOrDefault();
    }
    public static string GetIPAddress(bool GetLan = false)
    {
        string visitorIPAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (String.IsNullOrEmpty(visitorIPAddress))
            visitorIPAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

        if (string.IsNullOrEmpty(visitorIPAddress))
            visitorIPAddress = HttpContext.Current.Request.UserHostAddress;

        if (string.IsNullOrEmpty(visitorIPAddress) || visitorIPAddress.Trim() == "::1")
        {
            GetLan = true;
            visitorIPAddress = string.Empty;
        }

        if (GetLan && string.IsNullOrEmpty(visitorIPAddress))
        {
            //This is for Local(LAN) Connected ID Address
            string stringHostName = Dns.GetHostName();
            //Get Ip Host Entry
            IPHostEntry ipHostEntries = Dns.GetHostEntry(stringHostName);
            //Get Ip Address From The Ip Host Entry Address List
            IPAddress[] arrIpAddress = ipHostEntries.AddressList;

            try
            {
                visitorIPAddress = arrIpAddress[arrIpAddress.Length - 2].ToString();
            }
            catch
            {
                try
                {
                    visitorIPAddress = arrIpAddress[0].ToString();
                }
                catch
                {
                    try
                    {
                        arrIpAddress = Dns.GetHostAddresses(stringHostName);
                        visitorIPAddress = arrIpAddress[0].ToString();
                    }
                    catch
                    {
                        visitorIPAddress = "127.0.0.1";
                    }
                }
            }

        }
        if (visitorIPAddress.IndexOf("::") > -1)
            visitorIPAddress = "127.0.0.1";

        return visitorIPAddress;
    }

    public static string CreateMenu(Entity.Admin admin)
    {
        string htmlMenu = "";
        if (admin != null)
        {
            for (int i = 1; i <= 7; i++)
            {
                if (admin.IsSuperAdmin || admin.getQuyen.Contains(i))
                {
                    if (!string.IsNullOrEmpty(Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)i)))
                    {
                        string html = "<div class=\"page-menu-group\">";
                        html += "         <div class=\"page-menu-group-title\">" + Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)i) + "</div>";
                        if (i != (int)Enums.LoaiTinTuc.HinhAnhCongDongYeuNu)
                        {
                            html += "         <a href=\"" + Enums.MucLucUrlDanhSach((Enums.LoaiTinTuc)i) + "\">";
                            html += "             <div class=\"page-menu-group-item\" menu-category=\"" + i + "\"><span class=\"fa fa-th\"></span>" + Enums.MucLucDesc((Enums.LoaiTinTuc)i) + "</div>";
                            html += "         </a>";
                        }
                        html += "         <a href=\"" + Enums.LoaiTinTucUrlDanhSach((Enums.LoaiTinTuc)i) + "\">";
                        html += "             <div class=\"page-menu-group-item\" menu-tintuc=\"" + i + "\"><span class=\"fa fa-th\"></span>" + Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)i) + "</div>";
                        html += "         </a>";
                        html += "     </div>";
                        htmlMenu += html;
                    }
                }

            }


            if (admin.IsSuperAdmin || admin.getQuyen.Contains(8) || admin.getQuyen.Contains(9) || admin.getQuyen.Contains(10) || admin.getQuyen.Contains(11))
            {
                htmlMenu += "<div class=\"page-menu-group\">";
                htmlMenu += "   <div class=\"page-menu-group-title\">Khác</div>";
                if (admin.IsSuperAdmin || admin.getQuyen.Contains(9))
                {
                    htmlMenu += "   <a href=\"khao-sat.htm\">";
                    htmlMenu += "       <div class=\"page-menu-group-item\" menu-khaosat=\"\"><span class=\"fa fa-th\"></span>" + Enums.LoaiTinTucDesc(Enums.LoaiTinTuc.KhaoSat) + "</div>";
                    htmlMenu += "   </a>";
                }
                //if (admin.IsSuperAdmin || admin.getQuyen.Contains(9))
                //{
                //    htmlMenu += "   <a href=\"tu-van-truc-tuyen.htm\">";
                //    htmlMenu += "       <div class=\"page-menu-group-item\" menu-tuvan=\"\"><span class=\"fa fa-th\"></span>" + Enums.LoaiTinTucDesc(Enums.LoaiTinTuc.TuVan) + "</div>";
                //    htmlMenu += "   </a>";
                //}
                if (admin.IsSuperAdmin || admin.getQuyen.Contains(8))
                {
                    htmlMenu += "   <a href=\"tai-khoan-quan-tri.htm\">";
                    htmlMenu += "       <div class=\"page-menu-group-item\" menu-account=\"\"><span class=\"fa fa-th\"></span>" + Enums.LoaiTinTucDesc(Enums.LoaiTinTuc.Account) + "</div>";
                    htmlMenu += "   </a>";
                }
                if (admin.IsSuperAdmin || admin.getQuyen.Contains(10))
                {
                    htmlMenu += "   <a href=\"danh-muc.htm\">";
                    htmlMenu += "       <div class=\"page-menu-group-item\" menu-danh-muc=\"\"><span class=\"fa fa-th\"></span>Danh Mục</div>";
                    htmlMenu += "   </a>";

                    htmlMenu += "   <a href=\"cau-hinh.htm\">";
                    htmlMenu += "       <div class=\"page-menu-group-item\" menu-cauhinh=\"\"><span class=\"fa fa-th\"></span>" + Enums.LoaiTinTucDesc(Enums.LoaiTinTuc.CauHinh) + "</div>";
                    htmlMenu += "   </a>";
                }

                htmlMenu += "</div>";
            }

        }




        return htmlMenu;
    }

    public static string saveImgFromBase64(string base64, string serverMap,bool isResize = true)
    {
        string fileName = Lib.CreateGuid() + ".png";
        var imageData = Convert.FromBase64String(Regex.Replace(base64, "data:image/.*?;base64,", ""));
        if (isResize)
        {
            Lib.ResizeByWidth(new MemoryStream(imageData), 800).Save(serverMap + fileName);
        }
        else
        {
            new Bitmap(new MemoryStream(imageData)).Save(serverMap + fileName);
        }
        return fileName;
    }

    public static string convertNoiDungHTML(string noidung, string serverMap)
    {


        string regexImgSrc = @"<img[^>]*?src\s*=\s*[""']?([^'"" >]+?)[ '""][^>]*?>";
        MatchCollection matchesImgSrc = Regex.Matches(noidung, regexImgSrc, RegexOptions.IgnoreCase | RegexOptions.Singleline);
        foreach (Match m in matchesImgSrc)
        {
            string href = m.Groups[1].Value;
            if (href.IndexOf("data:image") > -1)
            {
                noidung = noidung.Replace(href, Lib.urlhome + "/Images/imageUpload/" + Lib.saveImgFromBase64(href, serverMap));
            }
        }
        return noidung;
    }

    public static string RenderHtml(this Control control)
    {
        using (var sw = new StringWriter())
        {
            var page = new Page();
            page.Controls.Add(control);
            HttpContext.Current.Server.Execute(page, sw, false);
            return sw.ToString();
        }
    }



    public static string CreateGuid()
    {
        return Guid.NewGuid().ToString().Trim();
    }
    public static string LocDauFileName(string txt)
    {
        txt = txt.ToLower();
        txt = HttpUtility.HtmlDecode(txt);
        const string FindText = "áàảãạâấầẩẫậăắằẳẵặđéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵÁÀẢÃẠÂẤẦẨẪẬĂẮẰẲẴẶĐÉÈẺẼẸÊẾỀỂỄỆÍÌỈĨỊÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÚÙỦŨỤƯỨỪỬỮỰÝỲỶỸỴ";
        const string ReplText = "aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyAAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYY";
        int index = -1;
        char[] arrChar = FindText.ToCharArray();
        while ((index = txt.IndexOfAny(arrChar)) != -1)
        {
            int index2 = FindText.IndexOf(txt[index]);
            txt = txt.Replace(txt[index], ReplText[index2]);
        }
        txt = txt.Replace(" ", "-");
        txt = txt.Replace("|", "");
        txt = txt.Replace("?", "");
        txt = txt.Replace("'", "");
        txt = txt.Replace("\"", "");
        txt = txt.Replace(":", "");
        txt = txt.Replace(";", "");
        txt = txt.Replace(",", "");
        txt = txt.Replace("&", "");
        txt = txt.Replace("=", "");
        txt = txt.Replace("/-+-/g", "");
        txt = txt.Replace(@"/^\-+|\-+$/g", "");
        txt = txt.Replace(@"/ \ ?", "");
        txt = txt.Replace("(", "");
        txt = txt.Replace(")", "");
        txt = txt.Replace("%", "");
        txt = txt.Replace("\"", "");
        return txt;
    }

    public static string urlImgtoBase64(string url)
    {
        try
        {
            return "data:image/png;base64," + Convert.ToBase64String(new WebClient().DownloadData(url));
        }
        catch (Exception)
        {

            return "";
        }
    }


    public static bool isNumber(string number)
    {
        int num;
        if (int.TryParse(number, out num))
            return true;
        return false;
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


    public static string replaceMess(string message)
    {
        message = message.Replace("\r\n", "<br/>").Replace("\n", "<br/>");
        Regex urlRx = new Regex(@"(?<url>(http:[/][/]|https:[/][/]|fpt:|www.)([a-z]|[A-Z]|[0-9]|[/.]|[~])*)", RegexOptions.IgnoreCase);
        MatchCollection matches = urlRx.Matches(message);

        foreach (Match match in matches)
        {
            var url = match.Groups["url"].Value;
            message = message.Replace(url, string.Format("<a href=\"{0}\">{0}</a>", url));
        }
        List<string[]> arrEmo = new List<string[]>();
        arrEmo.Add(new string[] { "emoticon_smile", " :) " });
        arrEmo.Add(new string[] { "emoticon_frown", " :( " });
        arrEmo.Add(new string[] { "emoticon_tongue", " :P " });
        arrEmo.Add(new string[] { "emoticon_grin", " =D " });
        arrEmo.Add(new string[] { "emoticon_gasp", " :o " });
        arrEmo.Add(new string[] { "emoticon_wink", " ;) " });
        arrEmo.Add(new string[] { "emoticon_glasses", " 8) " });
        arrEmo.Add(new string[] { "emoticon_sunglasses", " B| " });
        arrEmo.Add(new string[] { "emoticon_grumpy", " >:( " });
        arrEmo.Add(new string[] { "emoticon_unsure", " :/ " });
        arrEmo.Add(new string[] { "emoticon_cry", " :'( " });
        arrEmo.Add(new string[] { "emoticon_devil", " 3:) " });
        arrEmo.Add(new string[] { "emoticon_angel", " O:) " });
        arrEmo.Add(new string[] { "emoticon_kiss", " :-*" });
        arrEmo.Add(new string[] { "emoticon_heart", " <3 " });
        arrEmo.Add(new string[] { "emoticon_kiki", " ^_^ " });
        arrEmo.Add(new string[] { "emoticon_squint", " -_- " });
        arrEmo.Add(new string[] { "emoticon_confused", " o.O " });
        arrEmo.Add(new string[] { "emoticon_confused_rev", " O.o " });
        arrEmo.Add(new string[] { "emoticon_upset", " >:o " });
        arrEmo.Add(new string[] { "emoticon_pacman", " :v " });
        arrEmo.Add(new string[] { "emoticon_colonthree", " :3 " });
        foreach (string[] item in arrEmo)
        {
            message = message.Replace(item[1], "<span class='emoticonNew " + item[0] + "'></span>");
        }

        foreach (string[] item in arrEmo)
        {
            message = message.Replace(item[1].TrimEnd(), "<span class='emoticonNew " + item[0] + "'></span>");
        }
        foreach (string[] item in arrEmo)
        {
            message = message.Replace(item[1].TrimStart(), "<span class='emoticonNew " + item[0] + "'></span>");
        }

        foreach (string[] item in arrEmo)
        {
            message = message.Replace(item[1].Trim(), "<span class='emoticonNew " + item[0] + "'></span>");
        }

        return message;
    }
    public static string subString(string txtSub, int maxLeng)
    {
        txtSub = txtSub == null ? "" : txtSub;
        txtSub = HttpUtility.HtmlDecode(txtSub);
        if (txtSub.Length > maxLeng)
        {
            string[] txtSplit = txtSub.Split(' ');
            if (txtSplit.Length > 1)
            {
                string txtReturn = "";
                for (int i = 0; i < txtSplit.Length; i++)
                {
                    if (txtReturn.Length + 4 < maxLeng)
                    {
                        txtReturn += txtSplit[i] + " ";
                        if (txtReturn.Length + 4 + txtSplit[i + 1].Length > maxLeng)
                        {
                            txtReturn += "...";
                            break;
                        }
                    }
                }
                return txtReturn;
            }
            else
            {
                return txtSub.Substring(0, maxLeng - 4) + " ...";
            }

        }
        else
        {
            return txtSub;
        }
    }
    public static Regex regexEmail = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
    public static bool emailcheck(string email)
    {
        return regexEmail.IsMatch(email);
    }
    public static DataTable ConvertToDataTable<T>(IList<T> data)
    {
        PropertyDescriptorCollection properties =
           TypeDescriptor.GetProperties(typeof(T));
        DataTable table = new DataTable();
        foreach (PropertyDescriptor prop in properties)
            table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
        foreach (T item in data)
        {
            DataRow row = table.NewRow();
            foreach (PropertyDescriptor prop in properties)
                row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
            table.Rows.Add(row);
        }
        return table;

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
    public static bool urlFromUrl(string urlCheck, string url)
    {
        string _url = new Uri(url).Authority;
        return Regex.Match(urlCheck, @"^(https?://)?([\w\-\._]+\.)?" + _url + "(/\\S*)?$").Success;
    }
    public static Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
    public static string activeLocDau(string[] pram, string content)
    {
        string txtReturn = "";
        foreach (string txt in content.Split(' '))
        {
            if (!txt.Trim().Equals(""))
            {
                bool checkRep = false;
                Match match = regex.Match(txt);
                if (match.Success)
                    checkRep = true;
                if (!checkRep)
                {
                    foreach (string item in pram)
                    {
                        if (!item.Trim().Equals(""))
                        {
                            if (txt.IndexOf(item) > -1)
                            {
                                checkRep = true;
                                break;
                            }
                        }
                    }
                }
                if (checkRep)
                {
                    for (int i = 0; i < txt.Length; i++)
                    {
                        txtReturn += "*";
                    }
                    txtReturn += " ";
                }
                else
                {
                    txtReturn += txt + " ";
                }
            }
            else
            {
                txtReturn += "  ";
            }
        }
        foreach (string item in pram)
        {
            if (!item.Trim().Equals(""))
            {
                txtReturn = txtReturn.Replace(item, "***");
            }
        }
        return txtReturn;
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
    public static string LocDau(string txt)
    {
        txt = txt.ToLower();
        txt = HttpUtility.HtmlDecode(txt);
        const string FindText = "áàảãạâấầẩẫậăắằẳẵặđéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵÁÀẢÃẠÂẤẦẨẪẬĂẮẰẲẴẶĐÉÈẺẼẸÊẾỀỂỄỆÍÌỈĨỊÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÚÙỦŨỤƯỨỪỬỮỰÝỲỶỸỴ";
        const string ReplText = "aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyAAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYY";
        int index = -1;
        char[] arrChar = FindText.ToCharArray();
        while ((index = txt.IndexOfAny(arrChar)) != -1)
        {
            int index2 = FindText.IndexOf(txt[index]);
            txt = txt.Replace(txt[index], ReplText[index2]);
        }
        txt = txt.Replace(" ", "-");
        txt = Regex.Replace(txt, "[’,‘]", "-");
        txt = txt.Replace("|", "");
        txt = txt.Replace("?", "");
        txt = txt.Replace("'", "");
        txt = txt.Replace("\"", "");
        txt = txt.Replace(":", "");
        txt = txt.Replace(";", "");
        txt = txt.Replace(",", "");
        txt = txt.Replace(".", "");
        txt = txt.Replace("&", "");
        txt = txt.Replace("=", "");
        txt = txt.Replace("/-+-/g", ""); //thay thế 2- thành 1- 
        txt = txt.Replace(@"/^\-+|\-+$/g", "");
        txt = txt.Replace(@"/ \ ?", "");
        txt = txt.Replace("(", "");
        txt = txt.Replace(")", "");
        txt = txt.Replace("%", "");
        txt = txt.Replace("\"", "");
        txt = txt.Replace("“", "");
        txt = txt.Replace("”", "");
        txt = txt.Replace("+", "");
        while (txt.IndexOf("--") > -1)
        {
            txt = txt.Replace("--", "-");
        }
        return txt;
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
    public static string GetHtmlFromUrl(string url)
    {
        string html = "";
        HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
        request.Method = "GET";
        request.ContentType = "application/x-www-form-urlencoded";
        request.UserAgent = "Mozilla/5.0 (Windows NT 5.1; rv:22.0) Gecko/20100101 Firefox/22.0";
        request.Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
        request.Timeout = Timeout.Infinite;
        request.KeepAlive = true;
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
        html = reader.ReadToEnd();
        reader.Close();
        response.Close();
        return html;
    }


    public static Bitmap ResizeImage(Stream img, int maxWidth, int maxHeight)
    {
        Bitmap imgNew = new Bitmap(img);
        Bitmap imgRes = null;
        int originalWidth = imgNew.Width;
        int originalHeight = imgNew.Height;
        int widthMax = maxWidth;
        float ratioX = (float)widthMax / (float)originalWidth;

        int newWidth = (int)widthMax;
        int newHeight = (int)(originalHeight * ratioX);

        bool checkExit = false;
        do
        {
            if (widthMax >= maxWidth && newHeight >= maxHeight)
            {
                checkExit = true;
            }
            else
            {
                widthMax = widthMax + 1;
                ratioX = (float)widthMax / (float)originalWidth;
                newWidth = (int)widthMax;
                newHeight = (int)(originalHeight * ratioX);
            }
        } while (!checkExit);
        Bitmap newImage = new Bitmap(newWidth, newHeight, PixelFormat.Format32bppArgb);
        using (Graphics graphics = Graphics.FromImage(newImage))
        {
            graphics.CompositingQuality = CompositingQuality.HighQuality;
            graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphics.SmoothingMode = SmoothingMode.HighQuality;
            graphics.DrawImage(imgNew, 0, 0, newWidth, newHeight);

        }
        if (newImage.Height > maxHeight || newImage.Width > maxWidth)
        {
            int x = 0;
            int y = 0;
            if (newImage.Width > maxWidth)
            {
                x = (newImage.Width / 2) - (maxWidth / 2);
            }
            if (newImage.Height > maxHeight)
            {
                y = (newImage.Height / 2) - (maxHeight / 2);
            }
            System.IO.Stream stream = new MemoryStream();
            newImage.Save(stream, ImageFormat.Png);
            var bytes = ((MemoryStream)stream).ToArray();
            System.IO.Stream inputStream = new MemoryStream(bytes);
            Bitmap newImageNew = new Bitmap(maxWidth, maxHeight, PixelFormat.Format32bppArgb);
            Graphics g = Graphics.FromImage(newImageNew);
            g.CompositingQuality = CompositingQuality.HighQuality;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
            g.SmoothingMode = SmoothingMode.HighQuality;
            g.DrawImage(new Bitmap(inputStream), new Rectangle(0, 0, maxWidth, maxHeight), new Rectangle(x, y, maxWidth, maxHeight), GraphicsUnit.Pixel);
            imgRes = newImageNew;
        }
        else
        {
            imgRes = newImage;
        }
        return imgRes;
    }
    public static Image[] GetFramesFromAnimatedGIF(Image IMG)
    {
        List<Image> IMGs = new List<Image>();
        int Length = IMG.GetFrameCount(FrameDimension.Time);

        for (int i = 0; i < Length; i++)
        {
            IMG.SelectActiveFrame(FrameDimension.Time, i);
            IMGs.Add(new Bitmap(IMG));
        }

        return IMGs.ToArray();
    }
    private static Image _ResizeByWidth(Image img, int resizedW, int resizedH)
    {
        Bitmap bmp = new Bitmap(resizedW, resizedH, PixelFormat.Format32bppArgb);

        using (Graphics graphics = Graphics.FromImage(bmp))
        {
            graphics.CompositingQuality = CompositingQuality.HighQuality;
            graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphics.SmoothingMode = SmoothingMode.HighQuality;
            graphics.DrawImage(img, 0, 0, resizedW, resizedH);

        }
        return bmp;
    }
    public static Bitmap ResizeByWidth(Stream img, int width)
    {
        // lấy chiều rộng và chiều cao ban đầu của ảnh
        Bitmap imgNew = new Bitmap(img);
        try
        {
            if (imgNew.GetFrameCount(FrameDimension.Time) > 1)
            {
                return imgNew;
            }
        }
        catch (Exception)
        {
                      
        }

        int originalW = imgNew.Width;
        int originalH = imgNew.Height;

        // lấy chiều rộng và chiều cao mới tương ứng với chiều rộng truyền vào của ảnh (nó sẽ giúp ảnh của chúng ta sau khi resize vần giứ được độ cân đối của tấm ảnh
        int resizedW = width;
        int resizedH = (originalH * resizedW) / originalW;
        if (originalW < width)
        {
            resizedW = originalW;
            resizedH = (originalH * resizedW) / originalW;
        }
        //tạo một Bitmap có kích thước tương ứng với chiều rộng và chiều cao mới
        Bitmap bmp = new Bitmap(resizedW, resizedH, PixelFormat.Format32bppArgb);

        using (Graphics graphics = Graphics.FromImage(bmp))
        {
            graphics.CompositingQuality = CompositingQuality.HighQuality;
            graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphics.SmoothingMode = SmoothingMode.HighQuality;
            graphics.DrawImage(imgNew, 0, 0, resizedW, resizedH);

        }
        return bmp;

    }
    public static Bitmap ImageColor(Bitmap original, string color)
    {
        Color c = Color.FromArgb(255, Color.FromArgb(int.Parse(color, System.Globalization.NumberStyles.HexNumber)));
        //create a blank bitmap the same size as original
        Bitmap newBitmap = new Bitmap(original.Width, original.Height);

        //get a graphics object from the new image
        Graphics g = Graphics.FromImage(newBitmap);

        //create the grayscale ColorMatrix

        ColorMatrix colorMatrix = new ColorMatrix(
           new float[][] 
      {
         new float[] {0, 0, 0, 0, 0},
                    new float[] {0, 0, 0, 0, 0},
                    new float[] {0, 0, 0, 0, 0},
                    new float[] {0, 0, 0, 1, 0},
                    new float[] {c.R / 255.0f,
                                 c.G / 255.0f,
                                 c.B / 255.0f,
                                 0, 1}
      });

        //create some image attributes
        ImageAttributes attributes = new ImageAttributes();

        //set the color matrix attribute
        attributes.SetColorMatrix(colorMatrix);

        //draw the original image on the new image
        //using the grayscale color matrix
        g.DrawImage(original, new Rectangle(0, 0, original.Width, original.Height),
           0, 0, original.Width, original.Height, GraphicsUnit.Pixel, attributes);

        //dispose the Graphics object
        g.Dispose();
        return newBitmap;
    }
    public static Bitmap ImageDenTrang(Bitmap original)
    {
        //create a blank bitmap the same size as original
        Bitmap newBitmap = new Bitmap(original.Width, original.Height);

        //get a graphics object from the new image
        Graphics g = Graphics.FromImage(newBitmap);

        //create the grayscale ColorMatrix
        ColorMatrix colorMatrix = new ColorMatrix(
           new float[][] 
      {
         new float[] {.3f, .3f, .3f, 0, 0},
         new float[] {.59f, .59f, .59f, 0, 0},
         new float[] {.11f, .11f, .11f, 0, 0},
         new float[] {0, 0, 0, 1, 0},
         new float[] {0, 0, 0, 0, 1}
      });

        //create some image attributes
        ImageAttributes attributes = new ImageAttributes();

        //set the color matrix attribute
        attributes.SetColorMatrix(colorMatrix);

        //draw the original image on the new image
        //using the grayscale color matrix
        g.DrawImage(original, new Rectangle(0, 0, original.Width, original.Height),
           0, 0, original.Width, original.Height, GraphicsUnit.Pixel, attributes);

        //dispose the Graphics object
        g.Dispose();
        return newBitmap;
    }
    public static string createInfo(string info, bool status)
    {
        if (status)
            return "<div class='alert bg-success'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>" + info + "</div>";
        else
            return "<div class='alert bg-danger'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>" + info + "</div>";
    }
    public static long ToJavaScriptMilliseconds(DateTime dt)
    {
        System.TimeSpan span = new System.TimeSpan(System.DateTime.Parse("1/1/1970").Ticks);
        System.DateTime time = dt.Subtract(span);
        return (long)(time.Ticks / 10000);
    }
    public static string RandomPassword()
    {
        StringBuilder builder = new StringBuilder();
        builder.Append(RandomString(4, true));
        builder.Append(RandomNumber(1000, 9999));
        builder.Append(RandomString(2, false));
        return builder.ToString();
    }
    public static int RandomNumber(int min, int max)
    {
        Random random = new Random();
        return random.Next(min, max);
    }
    public static string RandomString(int size, bool lowerCase)
    {
        StringBuilder builder = new StringBuilder();
        Random random = new Random();
        char ch;
        for (int i = 0; i < size; i++)
        {
            ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
            builder.Append(ch);
        }
        if (lowerCase)
            return builder.ToString().ToLower();
        return builder.ToString();
    }
    public static int getUSD()
    {
        try
        {
            XmlDocument document = new XmlDocument();
            document.Load("http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx");
            XmlNodeList xnList = document.SelectNodes("/ExrateList/Exrate[@CurrencyCode='USD']");
            foreach (XmlNode xn in xnList)
            {
                int money = Convert.ToInt32(xn.Attributes["Sell"].Value);
                return money;
            }
        }
        catch (Exception)
        {
        }
        return 22000;
    }
    public static string getErrNapThe(string error_code)
    {
        if (error_code.Trim() == "01")
        {
            return "Lỗi, địa chỉ IP truy cập API của NganLuogn.vn bị từ chối";
        }
        else if (error_code.Trim() == "02")
        {
            return "Lỗi, tham số gửi từ merchent tới NganLuong.vn chưa chính xác";
        }
        else if (error_code.Trim() == "03")
        {
            return "Lỗi, mã Merchent không tồn tại hoặc merchent đang bị khóa kết nối tới NganLuong.vn";
        }
        else if (error_code.Trim() == "04")
        {
            return "Lỗi, Mã checksum không chính xác (lỗi này thường xảy ra khi mật khẩu giao tiếp giữa merchant và NgânLượng.vn không chính xác, hoặc cách sắp xếp các tham số trong biến params không đúng) ";
        }
        else if (error_code.Trim() == "05")
        {
            return "Tài khoản nhận tiền nạp của merchant không tồn tại ";
        }
        else if (error_code.Trim() == "06")
        {
            return "Tài khoản nhận tiền nạp của merchant đang bị khóa hoặc bị phong tỏa, không thể thực hiện được giao dịch nạp tiền";
        }
        else if (error_code.Trim() == "07")
        {
            return "Thẻ đã được sử dụng ";
        }
        else if (error_code.Trim() == "08")
        {
            return "Thẻ bị khóa ";
        }
        else if (error_code.Trim() == "09")
        {
            return "Thẻ hết hạn sử dụng";
        }
        else if (error_code.Trim() == "10")
        {
            return "Thẻ chưa được kích hoạt hoặc không tồn tại";
        }
        else if (error_code.Trim() == "11")
        {
            return "Mã thẻ sai định dạng ";
        }
        else if (error_code.Trim() == "12")
        {
            return "Sai số serial của thẻ ";
        }
        else if (error_code.Trim() == "13")
        {
            return "Mã thẻ và số serial không khớp";
        }
        else if (error_code.Trim() == "14")
        {
            return "Thẻ không tồn tại";
        }
        else if (error_code.Trim() == "15")
        {
            return "Thẻ không sử dụng được";
        }
        else if (error_code.Trim() == "16")
        {
            return "Số lần thử (nhập sai liên tiếp) của thẻ vượt quá giới hạn cho phép ";
        }
        else if (error_code.Trim() == "17")
        {
            return "Hệ thống Telco bị lỗi hoặc quá tải, thẻ chưa bị trừ";
        }
        else if (error_code.Trim() == "18")
        {
            return "Hệ thống Telco  bị lỗi hoặc quá tải, thẻ có thể bị trừ, cần phối hợp với NgânLượng để đối soát";
        }
        else if (error_code.Trim() == "19")
        {
            return "Kết nối NgânLượng với Telco bị lỗi, thẻ chưa bị trừ.";
        }
        else if (error_code.Trim() == "20")
        {
            return "Kết nối tới Telco thành công, thẻ bị trừ nhưng chưa cộng tiền trên NgânLượng.vn";
        }
        else if (error_code.Trim() == "99")
        {
            return "Lỗi tuy nhiên lỗi chưa được định nghĩa hoặc chưa xác định được nguyên nhân";
        }
        return "";
    }


    public static string createInfoLinkTam(string info, bool status)
    {
        if (status)
            return "<div class='alertmessage-lintam bg-success-lintam'>" + info + "</div>";
        else
            return "<div class='alertmessage-lintam bg-danger-lintam'>" + info + "</div>";
    }
    public static string createPhanTrang(int totalRow, int numInPage, int pageSelect, int numberPageShow, string scrollview = "", string nameQueryString = "page")
    {
        int maxPage = totalRow > numInPage && totalRow % numInPage != 0 ? totalRow / numInPage + 1 : totalRow / numInPage;
        string html = "<div class=\"pagePhanTrang\">";
        html += pageSelect > 1 ? "<a href=\"" + createLinkPhanTrang(pageSelect - 1, scrollview, nameQueryString) + "\" class=\"btnPhanTrangLeft\"></a>" : "";
        int numPageFor = pageSelect + numberPageShow;
        int pageStart = pageSelect < numberPageShow ? 1 : (pageSelect) % numberPageShow == 0 ? (pageSelect) : pageSelect - ((pageSelect) % numberPageShow);
        int pageEnd = pageSelect < numberPageShow ? numberPageShow : (pageStart + numberPageShow);
        pageEnd = pageEnd > maxPage ? maxPage : pageEnd;

        for (int i = pageStart; i <= pageEnd; i++)
        {
            html += i == pageSelect ? "<span class=\"btnPhanTrangItem\">" + i + "</span>" : "<a href=\"" + createLinkPhanTrang(i, scrollview, nameQueryString) + "\" class=\"btnPhanTrangItem\">" + i + "</a>";
        }

        html += pageSelect < maxPage ? "<a href=\"" + createLinkPhanTrang(pageSelect + 1, scrollview, nameQueryString) + "\" class=\"btnPhanTrangRight\"></a>" : "";
        html += "</div>";
        return html;
    }
    private static string createLinkPhanTrang(int page, string scrollview, string nameQueryString)
    {
        string url = HttpContext.Current.Request.RawUrl;
        if (url.IndexOf("?") <= -1)
        {
            url += "?" + nameQueryString + "=" + page;
        }
        else
        {
            string pageOld;
            if (HttpContext.Current.Request.QueryString[nameQueryString] != null)
                url = url.Replace(nameQueryString + "=" + HttpContext.Current.Request.QueryString[nameQueryString], nameQueryString + "=" + page);
            else if (url.LastIndexOf("&") != url.Length)
                url = url + "&" + nameQueryString + "=" + page;
            else
                url = url.IndexOf("&") <= -1 ? url + "&" + nameQueryString + "=" + page : url + nameQueryString + "=" + page;
        }
        if (url.IndexOf("#") > -1)
        {
            url = url.Split('#')[0];
        }
        if (url.IndexOf("#" + scrollview) == -1)
            url += "#" + scrollview;
        return url;
    }
    public static string removeHTMLAll(string source)
    {
        return Regex.Replace(source, "<.*?>", string.Empty);
    }

    public static void waitSaveFileUpload(Stream buffupload, string pathsave)
    {
        using (FileStream fs = File.Create(pathsave))
        {
            Byte[] buffer = new Byte[32 * 1024];
            int read = buffupload.Read(buffer, 0, buffer.Length);
            while (read > 0)
            {
                fs.Write(buffer, 0, read);
                read = buffupload.Read(buffer, 0, buffer.Length);
            }
        }
    }
    public static MemoryStream waitgetStreamFileUpload(Stream buffupload)
    {
        MemoryStream fs = new MemoryStream();
        Byte[] buffer = new Byte[32 * 1024];
        int read = buffupload.Read(buffer, 0, buffer.Length);
        while (read > 0)
        {
            fs.Write(buffer, 0, read);
            read = buffupload.Read(buffer, 0, buffer.Length);
        }
        return fs;
    }
}