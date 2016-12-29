using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Dynamic;
using System.Net;
using Newtonsoft.Json;

public partial class admin_EmailTemplate : BasePage
{
    public tblEmailTemplate _dataSelect = null;
    public List<Dictionary<string, object>> _dataDes = new List<Dictionary<string, object>>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (TypeAction == 0)
        {
            this.Title = "Quản lý Email Template";
            index.Visible = true;
        }
        else {
            _dataSelect = sql.EmailTemplate().Where(d => d.ID == Convert.ToInt32(Request.QueryString["ID"])).FirstOrDefault();
            if (_dataSelect == null)
            {
                CreateMessage("Không tìm thấy email template cần cập nhật", false);
                Response.Redirect("email-template.htm");
            }
            else
            {
                _dataDes = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(_dataSelect.Des);
                add.Visible = true;
                this.Title = "Chỉnh sửa email '" + _dataSelect.EmailTitleGoc + "'";
                if (!IsPostBack)
                {
                    txtName.Text = _dataSelect.EmailTitle;
                    txtContent.Text = _dataSelect.EmailContent;
                    
                }
            }
        }
        if (Session["websiteID"] == null)
        {
            //Response.Redirect("dang-nhap.htm?url=" + HttpUtility.UrlEncode(Request.RawUrl));
        }
        else
        {

            //    int idWeb = Convert.ToInt32(Session["websiteID"]);
            //    _web = Lib.getWeb(idWeb);
            //    string keyGuid = Request.QueryString["keyguid"];
            //    if (!keyGuid.Equals("-1"))
            //    {
            //        _dataSelect = (from p in sql.tblEmailTemplates where p.ID_Web == idWeb && p.ID.Equals(keyGuid) select p).FirstOrDefault();

            //        if (_dataSelect == null)
            //        {
            //            Response.Redirect("email-template.htm");
            //        }
            //        else
            //        {
            //            if(_dataSelect.fromParent!=null){
            //                try
            //                {
            //                    _dataDes = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>((from p in sql.tblEmailTemplates where p.ID == _dataSelect.fromParent select p.Des).FirstOrDefault() ?? "");
            //                }
            //                catch (Exception)
            //                {
            //                    _dataDes = new List<Dictionary<string, object>>();
            //                    throw;
            //                }
            //            }

            //            dynamic struc_load_obj = new ExpandoObject();
            //            struc_load_obj.email_id = _dataSelect.ID;
            //            struc_load_obj.email_title = _dataSelect.EmailTitle;
            //            struc_load_obj.email_content = _dataSelect.EmailContent;


            //            struc_load = JsonConvert.SerializeObject(struc_load_obj);
            //            struc_load_obj.email_id = "";
            //            struc_load_obj.email_title = "";
            //            struc_load_obj.email_content = "";
            //            struc_load_emty = JsonConvert.SerializeObject(struc_load_obj);
            //        }
            //    }
        }
    }
    public List<tblEmailTemplate> getEmail()
    {
        return (from p in sql.tblEmailTemplates select p).OrderBy(d=>d.EmailTitleGoc).ToList<tblEmailTemplate>();
    }
    protected void Action_AddNew_Click(object sender, EventArgs e)
    {
        tblEmailTemplate _dbNew = sql.tblEmailTemplates.Where(d => d.ID == _dataSelect.ID).FirstOrDefault();
        _dbNew.EmailContent = txtContent.Text;
        _dbNew.EmailTitle = txtName.Text;
        sql.SubmitChanges();
        sql.UpdateEmailTemplate();
        CreateMessage("Cập nhật email '"+_dbNew.EmailTitleGoc+"' thành công", true);
        Response.Redirect(Request.RawUrl);
    }
}