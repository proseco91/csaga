using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Settings
/// </summary>
public partial class Setting
{
    public List<StrucEmail> EmailSend = new List<StrucEmail>();
    public string clientId = "";
    public string clientSecret = "";
    public int shipping = 0;
    public int tax = 0;
}