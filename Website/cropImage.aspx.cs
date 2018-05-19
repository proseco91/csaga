using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Text.RegularExpressions;

public partial class cropImage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            this.returnImage(Request.QueryString["url"]);
        }
        catch
        {
            
            this.returnImage(Lib.urlhome+"/images/noavatar-2.gif");
        }
        
    }
    private void returnImage(string _url)
    {
        string url = _url;
        if (url.IndexOf("http://") <= -1 && url.IndexOf("https://") <= -1)
        {
            url = Regex.Split(Request.Url.ToString(), "cat-anh.htm")[0] + url;
        }
        WebClient wc = new WebClient();
        byte[] bytes = wc.DownloadData(url);
        MemoryStream ms2 = new MemoryStream(bytes);
        Bitmap image;
        if (Request.QueryString["height"] == null)
        {
            image = Lib.ResizeByWidth(ms2, Convert.ToInt32(Request.QueryString["width"]));
        }
        else {
            image = Lib.ResizeImage(ms2, Convert.ToInt32(Request.QueryString["width"]), Convert.ToInt32(Request.QueryString["height"]));
        }
        if (Request.QueryString["black"] != null && Convert.ToBoolean(Request.QueryString["black"]))
        {
            image = Lib.ImageDenTrang(image);
        }else if (Request.QueryString["color"] != null){
            image = Lib.ImageColor(Lib.ImageDenTrang(image), Request.QueryString["color"]);
        }
        MemoryStream stream = new MemoryStream();
        image.Save(stream, ImageFormat.Png);
        byte[] byteArray = stream.GetBuffer();
        Response.Clear();
        Response.Buffer = false;
        Response.ContentType = "Image/png";
        Response.OutputStream.Write(byteArray, 0, byteArray.Length);
        Response.End();
    }
}