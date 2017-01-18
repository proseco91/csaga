using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Threading;
using System.Globalization;
using Entity;


/// <summary>
/// Summary description for BasePage
/// </summary>
public class BaseHome : System.Web.UI.Page
{
    public LinqDataContext sql = new LinqDataContext();
    protected override void InitializeCulture()
    {
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(Lib.getLag());
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(Lib.getLag());

        base.InitializeCulture();
    }
}