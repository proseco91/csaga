<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="View_test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.10.2.js"></script>
    <script src="<%=Lib.urlhome %>/create-signal-chat.js"></script>
    <script src="<%=Lib.hostchat %>/linktam/hubs"></script>
    <script src="<%=Lib.urlhome %>/Scripts/chat.js"></script>

    <script>


        $(document).ready(function () {
            //$.chat.init();

            console.log('<%=Lib.create_codeChat("-1",Enums.LoaiAccount.KhachHang)%>');
            $('.crazylady_chat_windown').create_Event_Windown();

        });
    </script>
    <link href="../Styles/fonts.css" rel="stylesheet" />
    <link href="../Styles/style_chat.css" rel="stylesheet" />
    <style type="text/css">
    </style>
</head>
<body>
    <div class="test">
    </div>
    <div id="crazylady_chat">

        <div class="crazylady_chat_windown" valid="Thắng">
            <div class="crazylady_chat_windown_title" valname="Nguyễn Văn Thắng">
            </div>
            <div class="crazylady_chat_windown_content">
                <div class="crazylady_rowchat left">
                    <a href="javascript:;">
                        <img src="https://scontent.fhan3-1.fna.fbcdn.net/v/t1.0-1/c15.105.576.576/s24x24/15134724_923291264467558_8862329354434493752_n.jpg?oh=84c78a7721a14ac8a0a9d7266291ba67&oe=591C872F" class="crazylady_rowchat_avarta" />
                    </a>
                    <div class="crazylady_rowchat_text">
                        <div class="crazylady_rowchat_text_content_parent">
                            <span class="crazylady_rowchat_text_content">Thắng chat</span>
                        </div>
                        <div class="crazylady_rowchat_text_content_parent">
                            <span class="crazylady_rowchat_text_content">Thắng chat nhiều hơn Thắng chat nhiều hơn Thắng chat nhiều hơn v Thắng chat nhiều hơn</span>
                        </div>
                        <div class="crazylady_rowchat_text_content_parent">
                            <span class="crazylady_rowchat_text_content">Thắng chat nhiều hơn</span>
                        </div>
                    </div>
                    <div class="crazylady_rowchat_clear"></div>
                </div>
                <div class="crazylady_rowchat right">
                    <a href="javascript:;">
                        <img src="https://scontent.fhan3-1.fna.fbcdn.net/v/t1.0-1/c15.105.576.576/s24x24/15134724_923291264467558_8862329354434493752_n.jpg?oh=84c78a7721a14ac8a0a9d7266291ba67&oe=591C872F" class="crazylady_rowchat_avarta" />
                    </a>
                    <div class="crazylady_rowchat_text">
                        <div class="crazylady_rowchat_text_content_parent">
                            <span class="crazylady_rowchat_text_content">Thắng chat</span>
                        </div>
                        <div class="crazylady_rowchat_text_content_parent">
                            <span class="crazylady_rowchat_text_content">Thắng chat nhiều hơn Thắng chat nhiều hơn Thắng chat nhiều hơn v Thắng chat nhiều hơn</span>
                        </div>
                        <div class="crazylady_rowchat_text_content_parent">
                            <span class="crazylady_rowchat_text_content">Thắng chat nhiều hơn</span>
                        </div>
                    </div>
                    <div class="crazylady_rowchat_clear"></div>
                </div>
                <div class="crazylady_rowchat left">
                    <a href="javascript:;">
                        <img src="https://scontent.fhan3-1.fna.fbcdn.net/v/t1.0-1/c15.105.576.576/s24x24/15134724_923291264467558_8862329354434493752_n.jpg?oh=84c78a7721a14ac8a0a9d7266291ba67&oe=591C872F" class="crazylady_rowchat_avarta" />
                    </a>
                    <div class="crazylady_rowchat_text">
                        <div class="crazylady_rowchat_text_content_parent">
                            <span class="crazylady_rowchat_text_content">Thắng chat</span>
                        </div>
                        <div class="crazylady_rowchat_text_content_parent">
                            <span class="crazylady_rowchat_text_content">Thắng chat nhiều hơn Thắng chat nhiều hơn Thắng chat nhiều hơn v Thắng chat nhiều hơn</span>
                        </div>
                        <div class="crazylady_rowchat_text_content_parent">
                            <span class="crazylady_rowchat_text_content">Thắng chat nhiều hơn</span>
                        </div>
                    </div>
                    <div class="crazylady_rowchat_clear"></div>
                </div>
            </div>
            <div class="crazylady_chat_windown_input">
                <textarea placeholder="Nhập tin nhắn ..." maxlength="500"></textarea>
            </div>
            <div class="crazylady_chat_windown_input_height"></div>
        </div>
    </div>



















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
