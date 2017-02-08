<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChatHome.ascx.cs" Inherits="Masster_ChatHome" %>


<script src="<%=Lib.urlhome %>/create-signal-chat.js"></script>
<script src="<%=Lib.hostchat %>/linktam/hubs"></script>
<script src="<%=Lib.urlhome %>/Scripts/chat.js"></script>


<script type="text/ecmascript">
    var idUser = 'home';
    var idSendMessage = '<%=userChat.ID%>';
    $(document).ready(function () {
        var windownchat = $('.crazylady_chat_windown[valid="<%=userChat.ID %>"]');
        var windown_updateinfo = windownchat.children('.crazylady_chat_windown_updateinfo');
        $.chat.init('<%=Lib.urlhome%>', '<%=Lib.hostchat%>', '<%=keyDangKy%>',
            function () {
                //$('.bottom_btn_tuvan').attr('title', 'Tư vấn qua chát').click(function () {
                //    windownchat.attr('show', '');
                //    $('.bottom_btn_tuvan').attr('none', '');
                //});
                windownchat.attr('show', '');
                windownchat.children('.crazylady_chat_windown_title').click(function () {
                    if (windownchat.attr('valhidden') == 'false')
                        windownchat.attr('valhidden', 'true');
                    else
                        windownchat.attr('valhidden', 'false');
                });
                windownchat.create_Event_Windown();
                windown_updateinfo.children('.crazylady_chat_windown_updateinfo_btn').children('input').click(function () {
                    var fullname = $.trim(windown_updateinfo.find('input[name="fullname"]').val());
                    var email = $.trim(windown_updateinfo.find('input[name="email"]').val());
                    var phone = $.trim(windown_updateinfo.find('input[name="phone"]').val());
                    if (fullname.length == 0) {
                        windown_updateinfo.children('.crazylady_chat_windown_updateinfo_err').html('<%=Lib.ContentLag("Tên đầy đủ phải có.","Full names must have.") %>');
                        return false;
                    }
                    if (!lib.isEmail(email)) {
                        windown_updateinfo.children('.crazylady_chat_windown_updateinfo_err').html('<%=Lib.ContentLag("Email phải có.","Email must have.") %>');
                        return false;
                    }
                    if (phone.length == 0) {
                        windown_updateinfo.children('.crazylady_chat_windown_updateinfo_err').html('<%=Lib.ContentLag("Điện thoại phải có.","Phone number must have.") %>');
                        return false;
                    }
                    windown_updateinfo.css({ 'pointer-events': 'none', 'opacity': '0.5' });
                    $.chat.libserver.server.startChat(fullname, email, phone);
                });
            },
            function () {
                $.chat.libserver.client.doneketThucTuvan = function (id) {
                    $.chat.createWindowRownInfo(id, 'Cuộc tư vấn đã kết thúc');
                    windownchat.children('.crazylady_chat_windown_input').children('textarea').attr('disabled', 'disabled');
                    $.ajax({
                        type: "POST",
                        url: $.chat.urlWeb + "/service/service.asmx/doneketThucTuvan",
                        data: "{'id':'"+id+"'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function () {

                        },
                        success: function (message) {
                        },
                        error: function (errormessage) {

                        }
                    });
                }
                $.chat.libserver.client.startChatRespon = function (data) {
                    $.ajax({
                        type: "POST",
                        url: $.chat.urlWeb + "/service/service.asmx/editClientThread",
                        data: "{'data':" + JSON.stringify(JSON.stringify(data)) + "}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function () {

                        },
                        success: function (message) {
                            $('.crazylady_chat_windown[valid="' + data.ID + '"] .crazylady_chat_windown_updateinfo').remove();
                            $('.crazylady_chat_windown[valid="' + data.ID + '"] .crazylady_chat_windown_title').attr('valname', 'Đang đợi tư vấn viên');
                        },
                        error: function (errormessage) {

                        }
                    });
                }
                $.chat.libserver.client.tuVanDaNhan = function (thread,admin) {
                    $('.crazylady_chat_windown[valid="' + thread.ID + '"] .crazylady_chat_windown_title').attr('valname', admin.FullName);
                    
                }
            }
        );

    });
</script>
<div id="crazylady_chat">
    <div class="crazylady_chat_windown" valid="<%=userChat.ID %>" valhidden="false">

        <div class="crazylady_chat_windown_title" valname="<%=userChat.getName() %>">
        </div>
        <%if (!userChat.isRegister())
          { %>
        <div class="crazylady_chat_windown_updateinfo">
            <div style="text-align:center;margin-bottom:10px;padding-bottom:5px;border-bottom:1px dashed #DDD;margin-top: 8px;font-size: 13px;font-weight: 700;">Xin chào, Bạn cần trợ giúp gì không?</div>
            <div class="crazylady_chat_windown_updateinfo_input" title="<%=Lib.ContentLag("Tên đầy đủ","Full Name") %>">
                <input type="text" placeholder="<%=Lib.ContentLag("Tên đầy đủ","Full Name") %>" name="fullname" maxlength="100" value="<%=Lib.GetIPAddress() %>"/>
            </div>
            <div class="crazylady_chat_windown_updateinfo_input" title="<%=Lib.ContentLag("Email","Email") %>">
                <input type="text" placeholder="<%=Lib.ContentLag("Email","Email") %>" name="email" maxlength="100" value="<%=Lib.GetIPAddress() %>@gmail.com"/>
            </div>
            <div class="crazylady_chat_windown_updateinfo_input" title="<%=Lib.ContentLag("Điện thoại","Phone number") %>">
                <input type="text" placeholder="<%=Lib.ContentLag("Điện thoại","Phone number") %>" name="phone" maxlength="100" value="<%=Lib.GetIPAddress() %>"/>
            </div>
            <div class="crazylady_chat_windown_updateinfo_btn">
                <input type="button" value="<%=Lib.ContentLag("Chat","Chat") %>" />
            </div>
            <div class="crazylady_chat_windown_updateinfo_err">
            </div>
        </div>
        <%}%>
        <div class="crazylady_chat_windown_content" valloadmessage="true">
            <div class="crazylady_chat_windown_content_loadtinhan"></div>
            <%--
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
            </div>--%>
        </div>
        <div class="crazylady_chat_windown_input">
            <textarea placeholder="Nhập tin nhắn ..." maxlength="500"></textarea>
        </div>
        <div class="crazylady_chat_windown_input_height"></div>
    </div>
</div>
