using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Net;
using Newtonsoft.Json;
using System.Threading;

/// <summary>
/// Summary description for SendMail
/// </summary>
/// 
public class StrucEmail
{
    public StrucEmail(string data)
    {
        string[] split = data.Split('|');
        account = split[0];
        password = split[1];
    }
    public string account;
    public string password;
};
public static class SendMail
{
    private static StrucEmail infoMail = null;
    
    private static void NextEmail(){
        if (infoMail == null)
            infoMail = CacheCus.setting.EmailSend[0];
        else {
            int index = CacheCus.setting.EmailSend.IndexOf(infoMail);
            if(index+1==CacheCus.setting.EmailSend.Count)
                infoMail = CacheCus.setting.EmailSend[0];
            else
                infoMail = CacheCus.setting.EmailSend[index + 1];
        }
    }

    public static void SendOneMail(this LinqDataContext sql, string mailto, int emailtype, Dictionary<string, object> arrContent, string[] strBCC = null)
    {
        strBCC = strBCC == null ? new string[] { } : strBCC;
        bool sendSuc = false;
        while (!sendSuc)
        {
            try
            {

                if (infoMail == null)
                    NextEmail();
                tblEmailTemplate _email = sql.EmailTemplate().Where(d => d.ID == emailtype).FirstOrDefault();

                if (_email != null)
                {
                    List<Dictionary<string, object>> _dataDes = JsonConvert.DeserializeObject<List<Dictionary<string, object>>>(_email.Des);


                    string title = "[" + sql.GetSetting().WebName.ToUpper() + "] " + _email.EmailTitle;
                    string content = _email.EmailContent;
                    foreach (var item in _dataDes)
                    {
                        string key = item["content"].ToString();
                        content = content.Replace(key, arrContent[key].ToString());
                    }


                    MailAddress from = new MailAddress(infoMail.account, sql.GetSetting().WebName.ToUpper().ToUpper(), System.Text.Encoding.UTF8);
                    MailAddress to = new MailAddress(mailto);
                    MailMessage objMailMessage = new MailMessage(from, to);
                    foreach (var emailBCC in strBCC)
                    {
                        objMailMessage.Bcc.Add(emailBCC);
                    }

                    objMailMessage.Subject = title;
                    objMailMessage.BodyEncoding = System.Text.Encoding.UTF8;
                    objMailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
                    objMailMessage.IsBodyHtml = true;
                    objMailMessage.Priority = MailPriority.High;
                    objMailMessage.Body = content;
                    NetworkCredential mailAuthentication = new NetworkCredential(infoMail.account, infoMail.password);
                    SmtpClient objSmtpClient = new SmtpClient("smtp.gmail.com", 25);
                    objSmtpClient.UseDefaultCredentials = true;
                    objSmtpClient.Credentials = mailAuthentication;
                    objSmtpClient.EnableSsl = true;
                    objSmtpClient.Send(objMailMessage);

                    sendSuc = true;

                }else{
                    sendSuc = true;
                }
            }
            catch (Exception)
            {
                NextEmail();
                Thread.Sleep(2000);
            }
        }

    }

    //public static bool SendOneMail(string mailto, string[] strBCC, string subject, string content)
    //{
    //    try
    //    {
    //        MailAddress from = new MailAddress(emailAccount, emailTitle, System.Text.Encoding.UTF8);
    //        MailAddress to = new MailAddress(mailto);
    //        MailMessage objMailMessage = new MailMessage(from, to);
    //        foreach (string str in strBCC)
    //        {
    //            objMailMessage.Bcc.Add(str);
    //        }
    //        objMailMessage.Subject = subject;
    //        objMailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        objMailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        objMailMessage.IsBodyHtml = true;
    //        objMailMessage.Priority = MailPriority.High;
    //        objMailMessage.Body = content;
    //        NetworkCredential mailAuthentication = new NetworkCredential(emailAccount, emailPass);
    //        SmtpClient objSmtpClient = new SmtpClient("smtp.gmail.com", 25);
    //        objSmtpClient.UseDefaultCredentials = true;
    //        objSmtpClient.Credentials = mailAuthentication;

    //        objSmtpClient.EnableSsl = true;
    //        objSmtpClient.Send(objMailMessage);
    //        return true;
    //    }
    //    catch (Exception ex)
    //    {
    //        return false;
    //    }
    //}
    //public static bool SendMailBCC(string info, int received_id, int email_id, string mailto, string[] strBCC, string subject, string content)
    //{
    //    try
    //    {
    //        MailAddress from = new MailAddress(emailAccount, emailTitle, System.Text.Encoding.UTF8);
    //        MailAddress to = new MailAddress(mailto);
    //        MailMessage objMailMessage = new MailMessage(from, to);
    //        foreach (string str in strBCC)
    //        {
    //            objMailMessage.Bcc.Add(str);
    //        }

    //        objMailMessage.Subject = subject;
    //        objMailMessage.BodyEncoding = System.Text.Encoding.UTF8;
    //        objMailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
    //        objMailMessage.IsBodyHtml = true;
    //        objMailMessage.Priority = MailPriority.High;
    //        objMailMessage.Body = content;
    //        NetworkCredential mailAuthentication = new NetworkCredential(emailAccount, emailPass);
    //        SmtpClient objSmtpClient = new SmtpClient("smtp.gmail.com", 25);
    //        objSmtpClient.UseDefaultCredentials = true;
    //        objSmtpClient.Credentials = mailAuthentication;

    //        objSmtpClient.EnableSsl = true;
    //        objSmtpClient.Send(objMailMessage);

    //        //LinqDataContext sql = new LinqDataContext();
    //        //tblHistorySendMail _send = new tblHistorySendMail();
    //        //_send.content = content;
    //        //_send.CreateDate = DateTime.Now;
    //        //_send.emailID = email_id;
    //        //_send.emailTo = mailto;
    //        //_send.info = info;
    //        //_send.received_id = received_id;
    //        //_send.subject = subject;
    //        //sql.tblHistorySendMails.InsertOnSubmit(_send);
    //        //sql.SubmitChanges();
    //        return true;
    //    }
    //    catch (Exception ex)
    //    {
    //        return false;
    //    }
    //}
}