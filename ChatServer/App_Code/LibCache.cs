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

    private static Dictionary<string, strucUser> dataConnect = new Dictionary<string, strucUser>();
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
    public static void AddAndUpdate(this User user, string ConnectionId)
    {
        if (!dataConnect.ContainsKey(user.ID))
            dataConnect.Add(user.ID, new strucUser()
            {
                User = user
            });
        if (!dataConnect[user.ID].LstConnectionId.Any(d => d.Equals(ConnectionId)))
            dataConnect[user.ID].LstConnectionId.Add(ConnectionId);
    }

    public static void RemoveConnection(this Admin admin, string ConnectionId)
    {
        if (dataConnect.ContainsKey(admin.ID))
            dataConnect[admin.ID].LstConnectionId.Remove(ConnectionId);

    }
    public static void RemoveConnection(this User user, string ConnectionId)
    {
        if (dataConnect.ContainsKey(user.ID))
            dataConnect[user.ID].LstConnectionId.Remove(ConnectionId);
    }

}
public class strucUser
{

    public Admin Admin { get; set; }
    public User User { get; set; }
    public List<string> LstConnectionId = new List<string>();
}