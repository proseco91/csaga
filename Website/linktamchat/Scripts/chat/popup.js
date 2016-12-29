(function ($) {
    $.confirmLinkTam = {
        callbacks: null,
        _confirm: function (title, msg, ok, canel, callback, width) {
            if (callback) {
                $.confirmLinkTam._show(title, msg, ok, canel, width, function (result) {
                    if (callback) callback(result);
                });
            } else {
                $.confirmLinkTam._show(title, msg, ok, canel, width);
            }
        },
        _execute: function (status) {
            $.confirmLinkTam._remove(status);
        },
        _remove: function (status) {
            if (callbacks) {
                if (callbacks(status) == 1) {
                    return;
                }
            }
        },
        _showloading: function (status) {
            if (status)
                $('#confirmLinkTam .confirm_content .confirm_content_loading').css('display', 'block');
            else
                $('#confirmLinkTam .confirm_content .confirm_content_loading').css('display', 'none');
        },
        _close: function () {
            if ($('#confirmLinkTam').size() > 0) {
                $('#confirmLinkTam').remove();
            }
        },
        _show: function (title, msg, ok, canel, width, callback) {
            if ($('#confirmLinkTam').size() > 0)
                $('#confirmLinkTam').remove();

            if (callback) {
                callbacks = callback;
                $('body:first').append('<div id="confirmLinkTam" valclick="0"><div class="confirm_content" style="width:' + width + 'px;" valwidth="' + width + '"><div class="confirm_content_loading"><span></span></div><div class="confirm-Close" onclick="$.confirmLinkTam._close();"></div><div class="confirm-Title">' + title + '</div><div class="confirm-Body">' + msg + '</div><div class="confirm-Btn"><span onclick="$.confirmLinkTam._execute(true);">' + ok + '</span><span onclick="$.confirmLinkTam._execute(false);">' + canel + '</span></div></div></div>');
            } else {
                $('body:first').append('<div id="confirmLinkTam" valclick="0"><div class="confirm_content" style="width:' + width + 'px;" valwidth="' + width + '"><div class="confirm_content_loading"><span></span></div><div class="confirm-Close" onclick="$.confirmLinkTam._close();"></div><div class="confirm-Title">' + title + '</div><div class="confirm-Body">' + msg + '</div></div></div>');
            }
            $('.confirm_content').click(function () {
                $('#confirmLinkTam').attr('valclick', 1);
            });
            $('#confirmLinkTam').click(function () {
                setTimeout(function () {
                    if (parseInt($('#confirmLinkTam').attr('valclick')) == 0)
                        $.confirmLinkTam._close();
                    else
                        $('#confirmLinkTam').attr('valclick', 0);
                }, 10);
            });
            $.confirmLinkTam._resize();
        },
        _resize: function () {
            var docWidth = $(window).width();
            var docHeight = $(window).height();
            if ($('#confirmLinkTam').size() > 0) {
                if (docHeight <= $('#confirmLinkTam').children('.confirm_content').outerHeight(true)) {
                    $('#confirmLinkTam').css({ 'height': ($(document).height()) + 'px' }).addClass('confirmLinkTamAbsolute').children('.confirm_content').css({
                        left: (docWidth / 2) - ($('#confirmLinkTam').children('.confirm_content').outerWidth(true) / 2) +100
                    });
                } else {
                    $('#confirmLinkTam').removeAttr('style').removeClass('confirmLinkTamAbsolute').children('.confirm_content').css({
                        top: (docHeight / 2) - ($('#confirmLinkTam').children('.confirm_content').outerHeight(true) / 2),
                        left: (docWidth / 2) - ($('#confirmLinkTam').children('.confirm_content').outerWidth(true) / 2) + 100
                    });
                }
            }
        }
    }
    jConfirmLinkTam = function (title, msg, btnOk, btnCanel, width, callback) {
        $.confirmLinkTam._confirm(title, msg, btnOk, btnCanel, callback, width);
    };
})(jQuery);

$(window).resize(function () {
    $.confirmLinkTam._resize();
});