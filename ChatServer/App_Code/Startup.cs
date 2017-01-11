using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.Owin;
using Microsoft.Owin.Cors;
using Owin;

/// <summary>
/// Summary description for Startup
/// </summary>
/// 
[assembly: OwinStartup(typeof(Startup))]
public class Startup
{
    public void Configuration(IAppBuilder app)
    {
        app.Map("/linktam", map =>
        {
            
            map.UseCors(CorsOptions.AllowAll);
            var hubConfiguration = new HubConfiguration
            {
                EnableJSONP = true
            };
            map.RunSignalR(hubConfiguration);
        });
    }
}