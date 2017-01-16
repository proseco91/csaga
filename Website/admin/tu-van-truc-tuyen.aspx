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
                display: none;
                border: 1px solid #DDD;
                box-shadow:none;
            }
                #crazylady_chat .crazylady_chat_windown .crazylady_chat_windown_title
                {
                    border-radius:0px;
                }
                #crazylady_chat .crazylady_chat_windown[show]
                {
                    display: block;
                }

        #crazylady_chat_list
        {
            position: fixed;
            height: calc(100% - 20px);
            width: calc(550px - 300px);
            top: 10px;
            left: 950px;
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
    </style>
    <script src="<%=Lib.urlhome %>/create-signal-chat.js"></script>
    <script src="<%=Lib.hostchat %>/linktam/hubs"></script>
    <script src="<%=Lib.urlhome %>/Scripts/chat.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.chat.init('<%=Lib.hostchat%>', '<%=keyDangKy%>');
            $('div[menu-tuvan]').addClass('page-menu-group-item-active');
            $('.crazylady_chat_windown').create_Event_Windown();
            $('[item-windown]').create_Event_ListWindown_Admin();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="position: relative;">
        <div id="crazylady_chat">
            <div class="crazylady_chat_windown" valid="a1">
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
            <div class="crazylady_chat_windown" valid="a2">
                <div class="crazylady_chat_windown_title" valname="Nguyễn Văn Thắng2">
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
        <div id="crazylady_chat_list">
            <span item-windown="a1">Nguyễn Văn Thắng
            </span>
            <span item-windown="a2">Nguyễn Văn Thắng 2
            </span>
        </div>
    </div>

</asp:Content>

