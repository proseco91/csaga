<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="View_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.10.2.js"></script>
    <script src="<%=Lib.urlhome %>/create-signal-chat.js"></script>
    <script src="<%=Lib.hostchat %>/linktam/hubs"></script>
    

    <script>
        (function ($) {
            $.extend({
                chat: {
                    server: null,
                    connectId: null,
                    user: null,
                    timeReadloadConnect: null,
                    isConnect : false,
                    init: function (user) {
                        this.user = user;
                        $.connection.hub.url = '<%=Lib.hostchat %>/linktam';
                        $.connection.hub.qs = { 'user': JSON.stringify(JSON.stringify(user)) };
                        $.connection.hub.logging = false;
                        this.server = $.connection.chatHub;
                        $.connection.hub.start().done(function () {
                            $.chat.connectId = $.connection.hub.id;
                            $.chat.isConnect = true;
                        });
                        $.connection.hub.disconnected(function () {
                            $.chat.isConnect = false;
                            setTimeout(function () {
                                $.connection.hub.start().done(function () {
                                    $.chat.connectId = $.connection.hub.id;
                                    $.chat.isConnect = true;
                                });
                            }, 5000);
                        });
                        $.connection.hub.reconnecting(function () {
                            //console.log('reconnecting');
                            console.log('reconnecting');
                        });

                        $.connection.hub.reconnected(function () {
                            //console.log('reconnected');
                        });
                        $.connection.hub.connectionSlow(function () {
                            //console.log('We are currently experiencing difficulties with the connection.')
                        });

                        //tạo các sự kiện nhận từ server
                        this.server.client.test = function (messs) {
                            alert(messs);
                        }
                        //
                    }
                }
            });
        })(jQuery);
        $(document).ready(function () {
            $.chat.init();
        });
    </script>

</head>
<body>
    <%--<%
        List<string> a = new List<string>();
        for (int i = 0; i <= 10; i++)
        {
            a.Add("markers=color:orange%7Clabel:2%7C" + LibCache.cache_thanhpho[i]);
        }

        
    %>
    <div style="text-align:left;overflow:hidden;width:370px;">
        <img src="https://maps.googleapis.com/maps/api/staticmap?<%=(string.Join("&", a)) + (a.Count > 0 ? "&" : "") %>scale=0&center=Huế,Việt+Nam&zoom=6&size=460x800&key=AIzaSyBTwFsp9CfUVh-a_B7ql4J0A6NtLqjBHI8">
    </div>--%>
</body>
</html>
