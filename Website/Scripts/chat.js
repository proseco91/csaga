(function ($) {
    $.extend({
        chat: {
            maxHeightTextbox: 79,
            libserver: null,
            connectId: null,
            user: null,
            timeReadloadConnect: null,
            isConnect: false,
            urlWeb: null,
            urlhostchat: null,
            init: function (urlWeb, urlhostchat, user, callback, callbackevent) {
                this.urlWeb = urlWeb;
                this.urlhostchat = urlhostchat;
                this.user = user;
                $.connection.hub.url = urlhostchat + '/linktam';
                $.connection.hub.qs = { 'user': user };
                this.libserver = $.connection.chatHub;
                $.connection.hub.start().done(function () {
                    $.chat.connectId = $.connection.hub.id;
                    $.chat.isConnect = true;
                    callback.call(this);
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
                //$.connection.hub.reconnecting(function () {
                //    //console.log('reconnecting');
                //    console.log('reconnecting');
                //});

                //$.connection.hub.reconnected(function () {
                //    //console.log('reconnected');
                //});
                //$.connection.hub.connectionSlow(function () {
                //    //console.log('We are currently experiencing difficulties with the connection.')
                //});

                //tạo các sự kiện nhận từ server
                $.chat.libserver.client.showErr = function (err) {
                    console.log(err);
                }
                $.chat.libserver.client.doneSendSMS = function (data) {
                    $.chat.createWindowRownChat(data);
                }
                $.chat.libserver.client.doneGetSMS = function (idthread, rowchat, maxrow) {
                    var windown = $('.crazylady_chat_windown[valid="' + idthread + '"]');
                    var _content = windown.children('.crazylady_chat_windown_content');
                    if (rowchat.length < maxrow)
                        _content.attr('valloadmessage', false);
                    $.each(rowchat, function (index, item) {
                        $.chat.createWindowRownChat(item, false);
                    });
                    if (rowchat.length > 0) {
                        _content.find('[valid="' + rowchat[0].ID + '"]')[0].scrollIntoView(true);
                    }
                }


                if (callbackevent != null)
                    callbackevent.call(this);
                //
            },
            replace_message: function (message) {
                var txtSplit = message.split('\n');

                var messRe = '';
                $.each(txtSplit, function (index, value) {
                    messRe += value;
                    if (index == txtSplit.length - 2) {
                        if (txtSplit[txtSplit.length - 1].length == 0) {
                            messRe += '<div style="height:16px;"></div>';
                        }
                        else {
                            messRe += "<br/>";
                        }
                    } else if (index < txtSplit.length - 1) {
                        messRe += "<br/>";
                    }
                });
                return messRe;
            },
            createWindowRightAdmin: function (data) {
                return '<span item-windown="' + data.ID + '" valIsStart="' + (data.IdAdmin == null ? false : true) + '" title="' + data.FullName + ' - ' + data.Email + ' - ' + data.PhoneNumber + ' - ' + data.Ip + '">' + data.FullName + ' - ' + data.Email + '</span>';
            },
            createWindowLeftAdmin: function (data) {
                return '<div class="crazylady_chat_windown" valid="' + data.attr('item-windown') + '" valIsStart="' + data.attr('valIsStart') + '">\
                            <div class="crazylady_chat_windown_btnstart"><span>Nhấn vào đây để nhận cuộc tư vấn này.</span></div>\
                            <div class="crazylady_chat_windown_title" valname="' + data.text() + '" title="' + data.attr('title') + '">\
                            </div>\
                            <div class="crazylady_chat_windown_content" valloadmessage="true">\
                                <div class="crazylady_chat_windown_content_loadtinhan"></div>\
                            </div>\
                            <div class="crazylady_chat_windown_input">\
                                <div class="crazylady_chat_windown_btnend"><span>Kết thúc cuộc tư vấn.</span></div>\
                                <textarea placeholder="Nhập tin nhắn ..." maxlength="500"></textarea>\
                            </div>\
                            <div class="crazylady_chat_windown_input_height"></div>\
                        </div>';
            },
            checkNumberChuaView: function (windown_content) {
                var docViewTop = windown_content.scrollTop();
                var docViewBottom = docViewTop + windown_content.height();
                var count = 0;
                if (windown_content.is(':visible')) {
                    windown_content.find('.crazylady_rowchat_text_content[ischeckview="true"]').each(function () {
                        var elemTop = $(this).position().top;
                        if (elemTop + $(this).height() >= docViewBottom) {
                            count++;
                        } else {
                            $(this).attr('ischeckview', false);
                        }

                    });
                } else {
                    count = windown_content.find('.crazylady_rowchat_text_content[ischeckview="true"]').size();
                }

                return count;
            },
            createWindowRownInfo: function (IDThread, txt) {
                var windown_content = $('.crazylady_chat_windown[valid="' + IDThread + '"] .crazylady_chat_windown_content');
                windown_content.append('<div class="crazylady_rowchat info">\
                                                <div class="crazylady_rowchat_text">\
                                                    <div class="crazylady_rowchat_text_content_parent">\
                                                        <span class="crazylady_rowchat_text_contentinfo">' + txt + '</span>\
                                                    </div>\
                                                </div>\
                                            </div>');
            },
            createWindowRownChat: function (data, isnewsms) {
                isnewsms = isnewsms == null ? true : isnewsms;
                var htmlParent = '';
                var right_left = '';
                if (idUser == 'admin') {
                    if (data.IsAdminSend)
                        right_left = 'right';
                    else
                        right_left = 'left';
                } else {
                    if (data.IsAdminSend)
                        right_left = 'left';
                    else
                        right_left = 'right';
                }
                var windown_content = $('.crazylady_chat_windown[valid="' + data.IDThread + '"] .crazylady_chat_windown_content');
                if (isnewsms) {
                    var itemLast = windown_content.find('.crazylady_rowchat').last();
                    if (itemLast.size() > 0 && itemLast.attr('class').indexOf(right_left) > -1) {
                        itemLast.children('.crazylady_rowchat_text').append('<div class="crazylady_rowchat_text_content_parent">\
                                                                            <span class="crazylady_rowchat_text_content" valid="' + data.ID + '" valtime="' + data.CreateDate + '">' + data.Message + '</span>\
                                                                        </div>');
                    } else {
                        windown_content.append('<div class="crazylady_rowchat ' + right_left + '">\
                                                <a href="javascript:;">\
                                                    <img src="' + $.chat.urlWeb + '/Images/noavatar-2.gif" class="crazylady_rowchat_avarta" />\
                                                </a>\
                                                <div class="crazylady_rowchat_text">\
                                                    <div class="crazylady_rowchat_text_content_parent">\
                                                        <span class="crazylady_rowchat_text_content" valid="' + data.ID + '" valtime="' + data.CreateDate + '">' + data.Message + '</span>\
                                                    </div>\
                                                </div>\
                                                <div class="crazylady_rowchat_clear"></div>\
                                            </div>');
                    }
                } else {
                    var itemFirst = windown_content.find('.crazylady_rowchat').first();
                    if (itemFirst.size() > 0 && itemFirst.attr('class').indexOf(right_left) > -1) {
                        itemFirst.children('.crazylady_rowchat_text').prepend('<div class="crazylady_rowchat_text_content_parent">\
                                                                            <span class="crazylady_rowchat_text_content" valid="' + data.ID + '" valtime="' + data.CreateDate + '">' + data.Message + '</span>\
                                                                        </div>');
                    } else {
                        windown_content.prepend('<div class="crazylady_rowchat ' + right_left + '">\
                                                <a href="javascript:;">\
                                                    <img src="' + $.chat.urlWeb + '/Images/noavatar-2.gif" class="crazylady_rowchat_avarta" />\
                                                </a>\
                                                <div class="crazylady_rowchat_text">\
                                                    <div class="crazylady_rowchat_text_content_parent">\
                                                        <span class="crazylady_rowchat_text_content" valid="' + data.ID + '" valtime="' + data.CreateDate + '">' + data.Message + '</span>\
                                                    </div>\
                                                </div>\
                                                <div class="crazylady_rowchat_clear"></div>\
                                            </div>');
                    }
                }


                if ((data.IsAdminSend && idUser == 'admin') || (!data.IsAdminSend && idUser == 'home')) {
                    if (isnewsms) {
                        windown_content.find('[valid="' + data.ID + '"]').attr('ischeckview', 'false')[0].scrollIntoView(false);
                    }
                } else {
                    windown_content.find('[valid="' + data.ID + '"]').attr('ischeckview', 'true');
                }
                if (!isnewsms) {
                    windown_content.find('[valid="' + data.ID + '"]').attr('ischeckview', 'false');
                }

                if (isnewsms && ((data.IsAdminSend && idUser != 'admin') || (!data.IsAdminSend && idUser != 'home'))) {
                    var number = $.chat.checkNumberChuaView(windown_content);
                    if (idUser == 'admin') {
                        if (number == 0)
                            $('[item-windown="' + data.IDThread + '"]').removeAttr('number');
                        else
                            $('[item-windown="' + data.IDThread + '"]').attr('number', number)
                    } else {
                        if (number == 0)
                            $('.crazylady_chat_windown[valid="' + data.IDThread + '"]').children('.crazylady_chat_windown_title').removeAttr('number');
                        else
                            $('.crazylady_chat_windown[valid="' + data.IDThread + '"]').children('.crazylady_chat_windown_title').attr('number', number);

                    }
                }
            }
        }
    });
    $.fn.create_Event_Windown = function () {
        $(this).each(function () {

            var windown = $(this);
            var _content = windown.children('.crazylady_chat_windown_content');
            var _parent_textarea = windown.children('.crazylady_chat_windown_input');
            var _textarea = _parent_textarea.children('textarea');
            var _getHeight = windown.children('.crazylady_chat_windown_input_height');
            _getHeight.css(_textarea.getStyleObject());
            _textarea.keyup(function () {
                var height = _getHeight.html($.chat.replace_message(_textarea.val())).outerHeight();
                height = height <= 30 ? 30 : height + 1;
                if (height < $.chat.maxHeightTextbox) {
                    _parent_textarea.css({ 'min-height': height + 'px' });
                    _content.css({ 'height': 'calc(100% - 30px - ' + height + 'px)' });
                    _textarea.css('overflow', 'hidden');
                } else {
                    height = $.chat.maxHeightTextbox;
                    _parent_textarea.css({ 'min-height': height + 'px' });
                    _content.css({ 'height': 'calc(100% - 30px - ' + height + 'px)' });
                    _textarea.css('overflow', 'auto');
                }

            }).keyup();
            _textarea.keypress(function (event) {
                if (event.which == 13) {
                    var txt = $.trim($(this).val());
                    if (txt.length > 0) {
                        _textarea.val('').keyup();
                        $.chat.libserver.server.sendSMS(windown.attr('valid'), txt, idSendMessage);
                    }
                    event.preventDefault();
                }

            });
            windown.find('.crazylady_chat_windown_btnstart > span').click(function () {
                $('.htm_loading_page').css({ 'display': 'block' });
                $.chat.libserver.server.nhanCuocTuVan(windown.attr('valid'));
            });
            windown.find('.crazylady_chat_windown_btnend > span').click(function () {
                $('.htm_loading_page').css({ 'display': 'block' });
                $.chat.libserver.server.ketThucTuvan(windown.attr('valid'));
            });
            _content.scroll(function () {
                var number = $.chat.checkNumberChuaView(_content);
                if (idUser == 'admin') {
                    if (number == 0)
                        $('[item-windown="' + windown.attr('valid') + '"]').removeAttr('number');
                    else
                        $('[item-windown="' + windown.attr('valid') + '"]').attr('number', number)
                } else {
                    if (number == 0)
                        windown.children('.crazylady_chat_windown_title').removeAttr('number');
                    else
                        windown.children('.crazylady_chat_windown_title').attr('number', number);

                }
            });
            _content.children('.crazylady_chat_windown_content_loadtinhan').click(function () {
                var time = null;
                var first = _content.find('.crazylady_rowchat_text_content').first();
                if (first.size() > 0)
                    time = first.attr('valtime');
                $.chat.libserver.server.getSMS(windown.attr('valid'), time);
            });
        });

    }
    $.fn.create_Event_ListWindown_Admin = function () {
        $(this).each(function () {
            var btn = $(this);
            btn.click(function () {
                $('[item-windown][show]').removeAttr('show');
                $('.crazylady_chat_windown[show]').removeAttr('show');

                btn.attr('show', '');
                var windown = $('.crazylady_chat_windown[valid="' + btn.attr('item-windown') + '"]');
                if (windown.size() == 0) {
                    windown = $($.chat.createWindowLeftAdmin(btn)).appendTo('#crazylady_chat');
                    windown.create_Event_Windown();
                }
                windown.attr('show', '');
                var _content = windown.children('.crazylady_chat_windown_content');
                var _parent_textarea = windown.children('.crazylady_chat_windown_input');
                var _textarea = _parent_textarea.children('textarea');
                _textarea.keyup();
                _content.scroll();
            });
        });

    }
    $.fn.getStyleObject = function () {
        var dom = this.get(0);
        var style;
        var returns = {};
        if (window.getComputedStyle) {
            var camelize = function (a, b) {
                return b.toUpperCase();
            };
            style = window.getComputedStyle(dom, null);
            for (var i = 0, l = style.length; i < l; i++) {
                var prop = style[i];
                var camel = prop.replace(/\-([a-z])/g, camelize);
                var val = style.getPropertyValue(prop);
                returns[camel] = val;
            };
            return returns;
        };
        if (style = dom.currentStyle) {
            for (var prop in style) {
                returns[prop] = style[prop];
            };
            return returns;
        };
        return this.css();
    }
})(jQuery);