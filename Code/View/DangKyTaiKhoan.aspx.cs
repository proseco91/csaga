using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class View_DangKyTaiKhoan : BasePageHome
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (user != null)
        {
            if (Request.QueryString["url"] != null)
                Response.Redirect(Request.QueryString["url"]);
            else
                Response.Redirect(Lib.urlhome);
        }
        setTitle("Create Account");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string emailtxt = txtEmail.Text.Trim().ToLower();
        string fullnametxt = txtFullName.Text.Trim();
        string error = "";
        if (fullnametxt.Length == 0)
            error += "The full name can't be blank";
        if (!Lib.emailcheck(emailtxt))
            error += (error.Length == 0 ? "" : "<br/>") + "Email incorrect formats";

        if (string.IsNullOrEmpty(error) && sql.Users.Any(d => d.Email == emailtxt))
            error += (error.Length == 0 ? "" : "<br/>") + "Email already exists";

        if (!string.IsNullOrEmpty(error))
        {
            labErr.Text = Lib.createInfoLinkTam(error, false) + "<br/>";
        }
        else
        {
            string pass = Lib.RandomPassword();

            User _user = new User()
            {
                CreateDate = DateTime.Now,
                Email = emailtxt,
                FullName = fullnametxt,
                ID = Lib.CreateGuid(),
                Password = Lib.createMd5(pass)
            };
            sql.Users.InsertOnSubmit(_user);
            sql.SubmitChanges();
            Dictionary<string, object> arrContent = new Dictionary<string, object>();
            arrContent.Add("{name-user}", fullnametxt);
            arrContent.Add("{email-user}", emailtxt);
            arrContent.Add("{password-user}", pass);
            arrContent.Add("{name-web}", sql.GetSetting().WebName);

            sql.SendOneMail(emailtxt, 4, arrContent);
            labErr.Text = Lib.createInfoLinkTam("Create account success.<br/>Please check the mail for login information.", true);
            txtEmail.Text = "";
            txtFullName.Text = "";
        }
    }
}