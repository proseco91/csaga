using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Entity;


/// <summary>
/// Summary description for LibCeach
/// </summary>
public static class LibCache
{

    public static Dictionary<string, strucUser> dataConnect = new Dictionary<string, strucUser>();

    public static List<string> getAllConnectIDAdmin() {
        return LibCache.dataConnect.Values.Where(d => d.Admin != null).SelectMany(d => d.LstConnectionId).ToList();
    }

    public static void RemoveConnection(this Microsoft.AspNet.SignalR.Hubs.HubCallerContext data, strucUser struc)
    {
        if (dataConnect.ContainsKey(struc.Admin != null ? struc.Admin.ID : struc.ThreadChat.ID))
            dataConnect[struc.Admin != null ? struc.Admin.ID : struc.ThreadChat.ID].LstConnectionId.Remove(data.ConnectionId);
    }
    public static strucUser getStrucUser(this Microsoft.AspNet.SignalR.Hubs.HubCallerContext data) {
        return dataConnect.Values.Where(d => d.LstConnectionId.Any(c => c.Contains(data.ConnectionId))).FirstOrDefault();
    }
    
    public static void AddAndUpdate(this Admin admin, string ConnectionId)
    {
        if (!dataConnect.ContainsKey(admin.ID))
            dataConnect.Add(admin.ID, new strucUser()
            {
                Admin = admin
            });
        if (!dataConnect[admin.ID].LstConnectionId.Any(d => d.Equals(ConnectionId)))
            dataConnect[admin.ID].LstConnectionId.Add(ConnectionId);
    }
    public static void AddAndUpdate(this ThreadChat user, string ConnectionId)
    {
        if (!dataConnect.ContainsKey(user.ID))
            dataConnect.Add(user.ID, new strucUser()
            {
                ThreadChat = user
            });
        if (!dataConnect[user.ID].LstConnectionId.Any(d => d.Equals(ConnectionId)))
            dataConnect[user.ID].LstConnectionId.Add(ConnectionId);
    }

    public static void RemoveConnection(this Admin admin, string ConnectionId)
    {
        if (dataConnect.ContainsKey(admin.ID))
            dataConnect[admin.ID].LstConnectionId.Remove(ConnectionId);

    }
    public static void RemoveConnection(this ThreadChat user, string ConnectionId)
    {
        if (dataConnect.ContainsKey(user.ID))
            dataConnect[user.ID].LstConnectionId.Remove(ConnectionId);
    }


    private static List<ThreadChat> cache_threadchat { get; set; }
    public static List<ThreadChat> getThreadChat()
    {
        if (cache_threadchat == null)
            cache_threadchat = Lib.createSQL().ThreadChats.Where(d => !d.ClientEnd || !d.EndDate.HasValue).ToList();
        return cache_threadchat;
    }
    public static void AddAndUpdate(this ThreadChat data)
    {
        var _data = getThreadChat().Where(d => d.ID == data.ID).FirstOrDefault();
        if (_data == null)
            cache_threadchat.Add(data);
        else
        {
            cache_threadchat.Remove(_data);
            if (!data.EndDate.HasValue)
                cache_threadchat.Add(data);
        }
    }
}
public class strucUser
{

    public Admin Admin { get; set; }
    public ThreadChat ThreadChat { get; set; }
    public List<string> LstConnectionId = new List<string>();
}