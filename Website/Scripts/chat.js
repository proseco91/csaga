(function ($) {
    $.extend({
        chat: {
            maxHeightTextbox :79,
            libserver: null,
            connectId: null,
            user: null,
            timeReadloadConnect: null,
            isConnect: false,
            init: function (urlhostchat,user,callback) {
                this.user = user;
                $.connection.hub.url = urlhostchat+'/linktam';
                $.connection.hub.qs = { 'user': user };
                $.connection.hub.logging = false;
                this.libserver = $.connection.chatHub;
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
                $.chat.libserver.client.showErr = function (err) {
                    console.log(err);
                }
                
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
                windown.attr('show', '');
                var _content = windown.children('.crazylady_chat_windown_content');
                var _parent_textarea = windown.children('.crazylady_chat_windown_input');
                var _textarea = _parent_textarea.children('textarea');
                _textarea.keyup();
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