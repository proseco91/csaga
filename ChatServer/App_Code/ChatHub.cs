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
            Clients.Caller.test("OnConnected");
            


            return base.OnConnected();
        }
        public override Task OnReconnected()
        {
            Clients.Caller.test("OnReconnected");
            return base.OnReconnected();
        }
        public override Task OnDisconnected(bool stopCalled = false)
        {
            Clients.Caller.test("OnDisconnected");
            return base.OnDisconnected(false);
        }
    }

}