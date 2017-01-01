<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="View_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.10.2.js"></script>

</head>
<body>
    <%
        List<string> a = new List<string>();
        for (int i = 0; i <= 10; i++)
        {
            a.Add("markers=color:orange%7Clabel:2%7C" + LibCache.cache_thanhpho[i]);
        }

        
    %>
    <div style="text-align:left;overflow:hidden;width:370px;">
        <img src="https://maps.googleapis.com/maps/api/staticmap?<%=(string.Join("&", a)) + (a.Count > 0 ? "&" : "") %>scale=0&center=Huế,Việt+Nam&zoom=6&size=460x800&key=AIzaSyBTwFsp9CfUVh-a_B7ql4J0A6NtLqjBHI8">
    </div>
</body>
</html>
