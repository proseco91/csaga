<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="tu-van-truc-tuyen.aspx.cs" Inherits="admin_tu_van_truc_tuyen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="../Styles/style_chat.css" rel="stylesheet" />

    <style type="text/css">
        #crazylady_chat
        {
            position: fixed;
            height: calc(100% - 20px);
            width: calc(100% - 550px);
            top: 10px;
            left: 270px;
            box-shadow: 0px 0px 3px rgba(0,0,0,0.5);
        }

            #crazylady_chat .crazylady_chat_windown
            {
                position: relative;
                top: 5px;
                width: calc(100% - 10px);
                height: calc(100% - 10px);
                left: 5px;
                border: 1px solid #DDD;
                box-shadow: none;
            }

                #crazylady_chat .crazylady_chat_windown .crazylady_chat_windown_title
                {
                    border-radius: 0px;
                }

                

        #crazylady_chat_list
        {
            position: fixed;
            height: calc(100% - 20px);
            width: calc(550px - 300px);
            top: 10px;
            right: 10px;
            box-shadow: 0px 0px 3px rgba(0,0,0,0.5);
            overflow-x: hidden;
            overflow-y: auto;
        }

            #crazylady_chat_list [item-windown]
            {
                display: block;
                padding: 9px 10px;
                margin: 3px;
                word-wrap: break-word;
                font-size: 12px;
                border: 1px solid #DDD;
                cursor: pointer;
            }

                #crazylady_chat_list [item-windown]:hover
                {
                    background-color: #a32db7;
                    color: #FFF;
                    border: 1px solid #a32db7;
                }

                #crazylady_chat_list [item-windown][show]
                {
                    background-color: #76008a;
                    color: #FFF;
                    border: 1px solid #76008a;
                }
                #crazylady_chat_list [item-windown][number]:after
                {
                    content: attr(number);
                    margin-left: 10px;
                    background-color: #76008a;
                    color: #FFF;
                    padding: 3px 10px;
                    border-radius: 3px;
                    font-weight: 700;
                }
                #crazylady_chat_list [item-windown][show][number]:after
                {
                    content: attr(number);
                    margin-left: 10px;
                    background-color: #FFF;
                    color: red;
                    padding: 3px 10px;
                    border-radius: 3px;
                    font-weight: 700;
                }
        #crazylady_chat .crazylady_chat_windown[valIsStart="false"] .crazylady_chat_windown_content
        {
            display:none;
        }
    </style>
    <script src="<%=Lib.urlhome %>/create-signal-chat.js"></script>
    <script src="<%=Lib.hostchat %>/linktam/hubs"></script>
    <script src="<%=Lib.urlhome %>/Scripts/chat.js"></script>
    <script type="text/javascript">
        var idUser = 'admin';
        var idSendMessage = '<%=admin_login.ID%>';
        $(document).ready(function () {
            $('.htm_loading_page').css({ 'display': 'block' });
            $.chat.init('<%=Lib.urlhome%>', '<%=Lib.hostchat%>', '<%=keyDangKy%>',
                function () {
                    $.chat.libserver.server.getThreadChatWaint('<%=_admin_login.ID%>');
                    
                },
                function () {
                    
                    $.chat.libserver.client.doneketThucTuvan = function (id) {
                        $('.htm_loading_page').css({ 'display': 'none' });
                        chatLinkTamFun.message(true, 'Cuộc tư vấn đã được kết thúc');
                        $('#crazylady_chat_list [item-windown="' + id + '"]').remove();
                        $('#crazylady_chat .crazylady_chat_windown[valid="' + id + '"]').remove();

                    }
                    $.chat.libserver.client.getThreadChatWaint = function (data) {
                        $.each(data, function (index, item) {
                            var element = $($.chat.createWindowRightAdmin(item)).appendTo('#crazylady_chat_list');
                            element.create_Event_ListWindown_Admin();

                            var windown = $($.chat.createWindowLeftAdmin(element)).appendTo('#crazylady_chat');
                            windown.create_Event_Windown();
                            $('.htm_loading_page').css({ 'display': 'none' });
                        });
                    }
                    $.chat.libserver.client.addWindowTuvan = function (data) {
                        var element = $($.chat.createWindowRightAdmin(data)).appendTo('#crazylady_chat_list');
                        element.create_Event_ListWindown_Admin();
                        var windown = $($.chat.createWindowLeftAdmin(element)).appendTo('#crazylady_chat');
                        windown.create_Event_Windown();
                    }
                    $.chat.libserver.client.removeCuocTuvan = function (ID, message) {
                        if (message != null && message.length > 0)
                            chatLinkTamFun.message(false, message);
                        $('.crazylady_chat_windown[valid="' + ID + '"]').remove();
                        $('[item-windown="' + ID + '"]').remove();
                        $('.htm_loading_page').css({ 'display': 'none' });
                    }
                    $.chat.libserver.client.doneNhanCuocTuVan = function (thread) {
                        $('[item-windown="' + thread.ID + '"]').attr('valIsStart', true);
                        $('.crazylady_chat_windown[valid="' + thread.ID + '"]').attr('valIsStart', true);
                        $('.htm_loading_page').css({ 'display': 'none' });
                    }
                }
            );
            $('div[menu-tuvan]').addClass('page-menu-group-item-active');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="position: relative;">
        <div id="crazylady_chat">
        </div>
        <div id="crazylady_chat_list">
        </div>
    </div>

</asp:Content>

