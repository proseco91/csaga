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

        public ChatHub()
        {

        }
        public override Task OnConnected()
        {
            try
            {
                dynamic userDynimic = JsonConvert.DeserializeObject<ExpandoObject>(Lib.Decrypt(Context.QueryString["user"], "crazylady9x@gmail.com-csaga"));
                if (((int)userDynimic.type) == (int)Enums.LoaiAccount.KhachHang)
                {
                    User user = JsonConvert.DeserializeObject<User>((string)userDynimic.data);
                    user.AddAndUpdate(Context.ConnectionId);
                }
                else {
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
                    User user = JsonConvert.DeserializeObject<User>((string)userDynimic.data);
                    user.AddAndUpdate(Context.ConnectionId);
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
            return base.OnReconnected();
        }
        public override Task OnDisconnected(bool stopCalled = false)
        {
            try
            {
                dynamic userDynimic = JsonConvert.DeserializeObject<ExpandoObject>(Lib.Decrypt(Context.QueryString["user"], "crazylady9x@gmail.com-csaga"));
                if (((int)userDynimic.type) == (int)Enums.LoaiAccount.KhachHang)
                {
                    User user = JsonConvert.DeserializeObject<User>((string)userDynimic.data);
                    user.RemoveConnection(Context.ConnectionId);
                }
                else
                {
                    Admin user = JsonConvert.DeserializeObject<Admin>((string)userDynimic.data);
                    user.RemoveConnection(Context.ConnectionId);
                }


                return base.OnConnected();

            }
            catch (Exception)
            {

                throw;
            }
            return base.OnDisconnected(stopCalled);
        }

    }

}