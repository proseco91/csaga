using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using System.Data;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.IO;
using System.Text;
using System.Threading;
using System.Dynamic;
using Entity;



/// <summary>
/// Summary description for ChatHub
/// </summary>
/// 

namespace SignalRChat
{
    public class ChatHub : Hub
    {
        public override Task OnConnected()
        {
            try
            {
                dynamic userDynimic = JsonConvert.DeserializeObject<ExpandoObject>(Lib.Decrypt(Context.QueryString["user"], "crazylady9x@gmail.com-csaga"));
                if (((int)userDynimic.type) == (int)Enums.LoaiAccount.KhachHang)
                {
                    ThreadChat user = JsonConvert.DeserializeObject<ThreadChat>((string)userDynimic.data);
                    if (user.isRegister())
                    {
                        if (Lib.createSQL().ThreadChats.Any(d => d.ID == user.ID && d.EndDate.HasValue))
                        {
                            Clients.Caller.doneketThucTuvan(user.ID);
                        }
                        else {
                            user.AddAndUpdate(Context.ConnectionId);
                        }
                    }
                    else {
                        user.AddAndUpdate(Context.ConnectionId);
                    }
                }
                else
                {
                    Admin user = JsonConvert.DeserializeObject<Admin>((string)userDynimic.data);
                    user.AddAndUpdate(Context.ConnectionId);
                }
                return base.OnConnected();

            }
            catch (Exception)
            {

                throw;
            }

        }
        public override Task OnReconnected()
        {
            try
            {
                dynamic userDynimic = JsonConvert.DeserializeObject<ExpandoObject>(Lib.Decrypt(Context.QueryString["user"], "crazylady9x@gmail.com-csaga"));
                if (((int)userDynimic.type) == (int)Enums.LoaiAccount.KhachHang)
                {
                    ThreadChat user = JsonConvert.DeserializeObject<ThreadChat>((string)userDynimic.data);
                    user.AddAndUpdate(Context.ConnectionId);
                }
                else
                {
                    Admin user = JsonConvert.DeserializeObject<Admin>((string)userDynimic.data);
                    user.AddAndUpdate(Context.ConnectionId);
                }
            }
            catch (Exception)
            {

            }
            return base.OnReconnected();
        }
        public override Task OnDisconnected(bool stopCalled = false)
        {
            try
            {
                strucUser struc = Context.getStrucUser();
                if (struc != null)
                    Context.RemoveConnection(struc);
            }
            catch (Exception)
            {

            }
            return base.OnDisconnected(stopCalled);
        }


        #region Custumer
        public void ketThucTuvan(string IDThread)
        {
            LinqDataContext sql = Lib.createSQL();
            ThreadChat chat = sql.ThreadChats.Where(d => d.ID == IDThread).FirstOrDefault();
            chat.EndDate = DateTime.Now;
            sql.SubmitChanges();
            chat.AddAndUpdate();

            foreach (var item in LibCache.dataConnect.Where(d => d.Value.Admin != null && d.Value.Admin.ID == chat.IdAdmin).SelectMany(d => d.Value.LstConnectionId))
            {
                Clients.Client(item).doneketThucTuvan(IDThread);
            }

            foreach (var item in LibCache.dataConnect.Where(d => d.Value.ThreadChat != null && d.Value.ThreadChat.ID == IDThread).SelectMany(d => d.Value.LstConnectionId))
            {
                Clients.Client(item).doneketThucTuvan(IDThread);
            }
        }
        public void getSMS(string IDThread, Nullable<DateTime> dateget)
        {
            LinqDataContext sql = Lib.createSQL();
            var array = sql.ThreadChatContents.Where(d => d.IDThread == IDThread);
            if (dateget.HasValue)
                array = array.Where(d => d.CreateDate < dateget.Value);
            array = array.OrderByDescending(d => d.CreateDate).Take(20);

            Clients.Caller.doneGetSMS(IDThread, array.ToList(), 20);
        }
        public void sendSMS(string IDThread, string txt, string idSendMessage)
        {
            LinqDataContext sql = Lib.createSQL();
            ThreadChat thread = LibCache.getThreadChat().Where(d => d.ID == IDThread).FirstOrDefault();
            if (thread != null)
            {
                ThreadChatContent content = new ThreadChatContent()
                {
                    CreateDate = DateTime.Now,
                    ID = Lib.CreateGuid(),
                    IDSend = idSendMessage,
                    IDThread = IDThread,
                    IsAdminSend = IDThread != idSendMessage,
                    Message = txt
                };
                if (LibCache.dataConnect.ContainsKey(IDThread))
                {
                    foreach (var item in LibCache.dataConnect[IDThread].LstConnectionId)
                    {
                        Clients.Client(item).doneSendSMS(content);
                    }
                }
                if (thread.IdAdmin != null && LibCache.dataConnect.ContainsKey(thread.IdAdmin))
                {
                    foreach (var item in LibCache.dataConnect[thread.IdAdmin].LstConnectionId)
                    {
                        Clients.Client(item).doneSendSMS(content);
                    }
                }
                else
                {
                    foreach (var item in LibCache.getAllConnectIDAdmin())
                    {
                        Clients.Client(item).doneSendSMS(content);
                    }
                }

                sql.ThreadChatContents.InsertOnSubmit(content);
                sql.SubmitChanges();
            }

        }
        public void nhanCuocTuVan(string ID)
        {
            try
            {
                dynamic userDynimic = JsonConvert.DeserializeObject<ExpandoObject>(Lib.Decrypt(Context.QueryString["user"], "crazylady9x@gmail.com-csaga"));
                if (((int)userDynimic.type) == (int)Enums.LoaiAccount.KhachHang)
                {

                }
                else
                {
                    Admin user = JsonConvert.DeserializeObject<Admin>((string)userDynimic.data);
                    ThreadChat thread = LibCache.getThreadChat().Where(d => d.ID == ID && d.IdAdmin == null).FirstOrDefault();
                    if (thread != null)
                    {
                        LinqDataContext sql = Lib.createSQL();
                        thread = sql.ThreadChats.Where(d => d.ID == ID && d.IdAdmin == null).FirstOrDefault();
                        if (thread == null)
                        {
                            Clients.Caller.removeCuocTuvan(ID, "Cuộc tư vấn này đã được tư vấn viên khác đảm nhận");
                        }
                        else
                        {
                            thread.IdAdmin = user.ID;
                            thread.CreateDate = DateTime.Now;
                            sql.SubmitChanges();
                            thread.AddAndUpdate();
                            Clients.Caller.doneNhanCuocTuVan(thread);

                            if (LibCache.dataConnect.ContainsKey(thread.ID))
                            {
                                foreach (var item in LibCache.dataConnect[thread.ID].LstConnectionId)
                                {
                                    Clients.Client(item).tuVanDaNhan(thread, user);
                                }
                            }

                        }
                    }
                    else
                    {
                        Clients.Caller.removeCuocTuvan(ID, "Cuộc tư vấn này đã được tư vấn viên khác đảm nhận");
                    }
                }
            }
            catch (Exception)
            {

            }
        }
        public void getThreadChatWaint(string ID)
        {
            LinqDataContext sql = Lib.createSQL();
            var arrThread = LibCache.getThreadChat().Where(d => (d.IdAdmin != null && d.IdAdmin == ID) || string.IsNullOrEmpty(d.IdAdmin)).ToList();
            string[] arrayIDThread = arrThread.Select(d => d.ID).ToArray();
            arrThread.AddRange(sql.ThreadChats.Where(d => !arrayIDThread.Contains(d.ID) && (d.IdAdmin != null && d.IdAdmin == ID) && !d.EndDate.HasValue));
            arrThread = arrThread.OrderBy(d => d.IdAdmin == null ? 1 : 0).ThenByDescending(d => d.CreateDate).ToList();
            Clients.Caller.getThreadChatWaint(arrThread);
        }

        public void startChat(string fullname, string email, string phone)
        {
            ThreadChat thread = null;
            try
            {
                dynamic userDynimic = JsonConvert.DeserializeObject<ExpandoObject>(Lib.Decrypt(Context.QueryString["user"], "crazylady9x@gmail.com-csaga"));
                if (((int)userDynimic.type) == (int)Enums.LoaiAccount.KhachHang)
                {
                    thread = JsonConvert.DeserializeObject<ThreadChat>((string)userDynimic.data);
                    if (!thread.isRegister())
                    {
                        thread.FullName = fullname;
                        thread.PhoneNumber = phone;
                        thread.Email = email;
                        thread.CreateDate = DateTime.Now;
                        thread.ClientEnd = false;

                        LinqDataContext sql = Lib.createSQL();
                        if (sql.ThreadChats.Any(d => d.ID == thread.ID))
                        {
                            thread = sql.ThreadChats.Where(d => d.ID == thread.ID).FirstOrDefault();
                            thread.FullName = fullname;
                            thread.PhoneNumber = phone;
                            thread.Email = email;
                            thread.CreateDate = DateTime.Now;
                            thread.ClientEnd = false;
                            sql.SubmitChanges();
                        }
                        else
                        {
                            sql.ThreadChats.InsertOnSubmit(thread);
                            sql.SubmitChanges();
                        }
                        thread.AddAndUpdate();
                        Clients.Caller.startChatRespon(thread);
                        foreach (var item in LibCache.getAllConnectIDAdmin())
                        {
                            Clients.Client(item).addWindowTuvan(thread);
                        }
                    }
                }

            }
            catch (Exception ex)
            {
            }
        }

        #endregion


    }

}