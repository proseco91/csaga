Number.prototype.formatMoney = function (c, d, t) {
    var n = this, c = isNaN(c = Math.abs(c)) ? 2 : c, d = d == undefined ? "," : d, t = t == undefined ? "." : t, s = n < 0 ? "-" : "", i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};

$(document).ready(function () {
    $(window).scroll(function () {
        var _parenmenu_new = $('.parenmenu_new');
        var _height = _parenmenu_new.height();
        if ($(this).scrollTop() >= _height) {
            _parenmenu_new.attr('eff-new-parenmenu-new', '');
        } else {
            _parenmenu_new.removeAttr('eff-new-parenmenu-new');
        }
    }).scroll();
    $(document).click(function () {
        $('.htm_err_respon').html('');
    });
    $('.panel_from > .panel_from_row_input > span:last-child > input:text[valtype="date"]').datetimepicker({
        format: 'Y/m/d H:i',
        timepicker: true,
        onChangeDateTime: function (dp, $input) {
            $input.keyup();
        }
    });
    $('.panel_from > .panel_from_row_radio_btn > input:button').click(function () {
        if ($(this).parent('.panel_from_row_radio_btn[disabled]').size() == 0) {
            var arr_item_radio = $(this).parent('.panel_from_row_radio_btn').children('input:button');
            arr_item_radio.removeClass('select');
            $(this).addClass('select');
        }
    });
    $('.panel_from > .panel_from_row_radio_img > span').click(function () {
        var arr_item_radio = $(this).parent('.panel_from_row_radio_img').children('span');
        arr_item_radio.removeClass('select');
        $(this).addClass('select');
    });

    $('.panel_from > .panel_from_row_input_color > span:last-child > span').colpick({
        layout: 'hex',
        submit: 0,
        onChange: function (hsb, hex, rgb, el, bySetColor) {
            $(el).prev('input:text').val('#' + hex);
            $(el).children('span').css({ 'background-color': '#' + hex });
            if ($(el).parents('.panel_from_row_input_color[disabled]').size() > 0) {
                $(el).prev('input:text').attr('disabled', 'disabled');
            }
        },
        onBeforeShow: function () {
            var _this = $(this);
            if (_this.parents('.panel_from_row_input_color[disabled]').size() > 0) {
                setTimeout(function () { _this.colpickHide(); }, 0);
            }
        }
    });
    $('.panel_from > .panel_from_row_input_color > span:last-child > input:text').keyup(function (event) {
        if ($(this).parents('.panel_from_row_input_color[disabled]').size() <= 0) {
            if ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || (event.keyCode >= 65 && event.keyCode <= 90)) {
                $(this).next('span').colpickSetColor($(this).val());
            }
        }
    });
    $('.panel_from .panel_from_row_number_up_down > span:last-child > span').each(function () {
        var filter_number = /^[0-9]{1,}$/;
        var value = $(this).text();
        if (filter_number.test(value))
            $(this).attr('valdefault', value);
        else
            $(this).attr('valdefault', 0).text('0');
    });
    $('.panel_from .panel_from_row_number_up_down > span:last-child > label[up]').mousedown(function () {
        var _this = $(this);
        var ele = $(this).parent('span').children('span');
        ele.text(parseInt(ele.text()) + 1);
        var interval_panel_from_row_number_up_down;
        var timeout_panel_from_row_number_up_down = setTimeout(function () {
            interval_panel_from_row_number_up_down = setInterval(function () {
                ele.text(parseInt(ele.text()) + 1);
            }, 50);
            _this.mouseleave(function () {
                clearInterval(interval_panel_from_row_number_up_down);
            });
        }, 300);
        $(this).mouseup(function () {
            if (timeout_panel_from_row_number_up_down)
                clearTimeout(timeout_panel_from_row_number_up_down);
            if (interval_panel_from_row_number_up_down)
                clearInterval(interval_panel_from_row_number_up_down);
        });
    });
    $('.panel_from .panel_from_row_number_up_down > span:last-child > label[down]').mousedown(function () {
        var _this = $(this);
        var ele = $(this).parent('span').children('span');
        if (parseInt(ele.text()) > parseInt(ele.attr('valdefault')))
            ele.text(parseInt(ele.text()) - 1);

        var interval_panel_from_row_number_up_down;
        var timeout_panel_from_row_number_up_down = setTimeout(function () {
            interval_panel_from_row_number_up_down = setInterval(function () {
                if (parseInt(ele.text()) > parseInt(ele.attr('valdefault')))
                    ele.text(parseInt(ele.text()) - 1);
                else {
                    clearInterval(interval_panel_from_row_number_up_down);
                    _this.unbind("mouseleave");
                }
            }, 50);
            _this.mouseleave(function () {
                clearInterval(interval_panel_from_row_number_up_down);
                _this.unbind("mouseleave");
            });
        }, 300);
        $(this).mouseup(function () {
            if (timeout_panel_from_row_number_up_down)
                clearTimeout(timeout_panel_from_row_number_up_down);
            if (interval_panel_from_row_number_up_down)
                clearInterval(interval_panel_from_row_number_up_down);
            _this.unbind("mouseup");
        });
    });

    $('.panel_from > .panel_from_row_input > span:last-child > input:text[valtype="number"]').keypress(function (e) {
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
            // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.which < 48 || e.which > 57))) {
            e.preventDefault();
        }
    });
    $('.panel_from > .panel_from_row_input > span:last-child > input:text[valtype="money"]').keypress(function (e) {
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
            // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.which < 48 || e.which > 57))) {
            e.preventDefault();
        }
    });
    $('.panel_from > .panel_from_row_input > span:last-child > input:text[valtype="money"]').keyup(function (e) {
        var number = $(this).val().replace(/,/g, '');
        $(this).val(parseInt(number).formatMoney(0, '.', ','));
    });
    $('.panel_from > .panel_from_row_select > span:last-child > select').change(function (event) {
        $(this).next('span').text($(this).children('option:selected').text());
    }).change();
    $('.panel_from .panel_from_row_file').each(function () {
        var _this = $(this).find('input:file');
        _this.uploadFile({
            size: 10097152,
            autostart: false,
            base64: function (base, el) {
                _this.val('').clone(true);
                //$(el).attr('valdata', base).parent('span').prev('span').css('background-image', 'url(\'' + base + '\')');
                //$(el).attr('valdata', base).parent('span').prev('span').append('<span style="background-image:url(\'' + base + '\');url(\'' + base + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_upload" value="' + base + '-->end<--"/></span>');
                if (typeof $(el).attr('multiple') != 'undefined') {
                    var elClick = $('<span title="Xóa" style="background-image:url(\'' + base + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_upload" value="' + base + '-->end<--"/></span>').appendTo($(el).attr('valdata', base).parent('span').prev('span'));
                    elClick.click(function () {
                        elClick.remove();
                    });
                } else {
                    var elClick = $(el).attr('valdata', base).parent('span').prev('span').html('<span title="Xóa" style="background-image:url(\'' + base + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_upload" value="' + base + '-->end<--"/></span>').children('span');
                    elClick.click(function () {
                        $(el).attr('valdata', '')
                        elClick.remove();
                    });
                }
            },
            error: function (file, thrownError) {
                chatLinkTamFun.message(false, thrownError);
            }
        });
    });


    $('.panel_from > .panel_from_row_file > span + span > input:file:disabled').each(function () {
        $(this).parent('span').css({ 'display': 'none' });
    });

    $('.panel_from > .panel_from_row_array > span > .panel_from_row_array_btn').click(function () {
        var _this = $(this);
        var _parent = _this.parent('span');
        var _element_copy = _parent.children('.panel_from_row_array_item[data-struc]');
        var _element_copy_new = _element_copy.clone().removeAttr('data-struc');
        _element_copy_new.insertBefore(_element_copy);
    });


    /*Table*/
    $('.style_table > table > tbody > tr > .row_checkbox > span').click(function () {
        var _parent = $(this).parent('.row_checkbox');
        if (_parent.parent('tr').index() == 0) {
            if ($(this).parent('.row_checkbox_check').size() > 0) {
                _parent.parents('tbody').find('tr > .row_checkbox').removeClass('row_checkbox_check');
            } else {
                _parent.parents('tbody').find('tr > .row_checkbox').addClass('row_checkbox_check');
            }
        } else {
            if ($(this).parent('.row_checkbox_check').size() > 0) {
                _parent.removeClass('row_checkbox_check');
                var index_select = _parent.parents('tbody').find('tr > .row_checkbox_check').size() - _parent.parents('tbody').find('tr:first-child > .row_checkbox_check').size()
                if (index_select != _parent.parents('tbody').find('tr').size() - 1)
                    _parent.parents('tbody').find('tr:first-child > .row_checkbox').removeClass('row_checkbox_check');
            } else {
                _parent.addClass('row_checkbox_check');
                var index_select = _parent.parents('tbody').find('tr > .row_checkbox_check').size() - _parent.parents('tbody').find('tr:first-child > .row_checkbox_check').size()
                if (index_select == _parent.parents('tbody').find('tr').size() - 1)
                    _parent.parents('tbody').find('tr:first-child > .row_checkbox').addClass('row_checkbox_check');
            }
        }
    });
    $('.style_table > table > tbody > tr:first-child > [enabled-sort]').click(function () {
        var _index = $(this).index();
        var _parent = $(this).parents('tbody');
        var data = _parent.find('tr').find('td:eq(' + _index + ')').map(function () { return { data: $(this).attr('valdata'), element: $(this).parent('tr') }; }).get();
        var element_sort = typeof $(this).attr('sorted') != 'undefined' ? $(this).attr('sorted') == "desc" ? "asc" : "desc" : "desc";
        var type_sort = typeof $(this).attr('valsort') != 'undefined' ? $(this).attr('valsort') : 'string';
        if (element_sort == "asc") {
            if (type_sort == 'number')
                data.sort(function (a, b) { return parseFloat(a.data) > parseFloat(b.data) });
            else if (type_sort == 'string')
                data.sort(function (a, b) { return a.data.localeCompare(b.data) });
        }
        else {
            if (type_sort == 'number')
                data.sort(function (a, b) { return parseFloat(b.data) > parseFloat(a.data) });
            else if (type_sort == 'string')
                data.sort(function (a, b) { return b.data.localeCompare(a.data) });
        }
        $.each(data, function (i, item) {
            i++;
            var itemAfter = _parent.find('tr:eq(' + i + ')')
            if (itemAfter != item.element) {
                itemAfter.after(item.element);
            }
        });
        _parent.find('tr:first-child > [enabled-sort]').removeAttr('sorted')
        $(this).attr('sorted', element_sort);
    });
    $('.style_table > .panel_search[action-default] > span[attr-close]').click(function () {
        $(this).parent('.panel_search[action-default]').children('input:text').val('').keypress();
    });
    $('.style_table > .panel_search[action-default] > input:text').keypress(function (event) {
        if (typeof event.which == 'undefined' || event.which == 13) {
            var text_now = $.trim($(this).val()).toLowerCase();
            var text_old = typeof $(this).attr('valdata') != 'undefined' ? $(this).attr('valdata') : "";
            if (text_now != text_old) {
                var _parent = $(this).parents('.style_table').find('table > tbody');
                var data = _parent.find('tr > td[valdata]').map(function () { return { data: $(this).attr('valdata'), element: $(this).parent('tr') }; }).get().filter(function (x) { return x.data.toLowerCase() == text_now || x.data.toLowerCase().indexOf(text_now) > -1 });
                _parent.find('tr').css({ 'display': 'none' }).eq(0).css({ 'display': 'block' });
                $.each(data, function (i, item) {
                    item.element.css({ 'display': 'block' });
                });
                $(this).attr('valdata', text_now);
            }
            event.preventDefault();
        }
    });
    $('.style_table > .panel_search_select > span[attr-select] > select').change(function (event) {
        $(this).parent('span[attr-select]').attr('title', $(this).children('option:selected').text());
        $(this).next('span').textautonew($(this).children('option:selected').text(), { width: $(this).next('span').outerWidth() });
    }).change();
    $('.style_table > table > tbody > tr > .row_checkbox > span,.style_table > table > tbody > tr:first-child > [enabled-sort],.panel_from .panel_from_row_number_up_down > span:last-child > label').mousedown(function (event) {
        event.preventDefault();
    });
});

(function ($) {
    $.fn.validate = function () {
        var checkRe = true;
        var _this = this;
        var filter_email = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var filter_number = /^[0-9]{1,}$/;
        var eroTxt = "";
        _this.find('.panel_from').each(function () {
            $(this).find('.panel_from_row_input > span > input:text[no-empty],.panel_from_row_input > span > input:password[no-empty],.panel_from_row_input > span > textarea[no-empty]').each(function () {
                var _input = $(this);
                var valtype = typeof _input.attr('valtype') != 'undefined' ? _input.attr('valtype') : "";
                var value = $.trim(_input.val());
                if (_input.is(":visible")) {
                    var err = false;
                    if (value.length <= 0)
                        err = true;
                    if (!err && valtype == "email" && !filter_email.test(value))
                        err = true;
                    if (!err && valtype == "number" && !filter_number.test(value))
                        err = true;
                    if (!err) {
                        _input.parents('.panel_from_row').removeClass('panel_from_row_err');
                    }
                    else {
                        _input.parents('.panel_from_row').addClass('panel_from_row_err');
                        checkRe = false;
                        if (eroTxt.length == 0)
                            eroTxt = _input.parents('.panel_from_row').children('lable').text() + " phải có.";
                    }
                }
            });
            $(this).find('.panel_from_row_file > span + span > input:file[no-empty]').each(function () {
                var _input = $(this);
                var value = $.trim(_input.attr('valdata'));
                var err = false;
                if (value.length <= 0)
                    err = true;
                if (!err) {
                    _input.parents('.panel_from_row').removeClass('panel_from_row_err');
                }
                else {
                    _input.parents('.panel_from_row').addClass('panel_from_row_err');
                    checkRe = false;
                    if (eroTxt.length == 0)
                        eroTxt = _input.parents('.panel_from_row').children('lable').text() + " phải có.";
                }
            });
        });
        if (!checkRe)
            chatLinkTamFun.message(false, eroTxt);
        return checkRe;
    };
    $.fn.loadfrom = function (data) {
        var _this = this;
        var keyload = Object.keys(data);
        $.each(keyload, function (index, item) {
            var _value = data[item];
            var _text = _this.find('.panel_from_row_input > span > input:text[valname="' + item + '"], .panel_from_row_input > span > input:password[valname="' + item + '"], .panel_from_row_input > span > textarea[valname="' + item + '"]');
            var _radio_btn = _this.find('.panel_from_row_radio_btn > input:button[valname="' + item + '"][valdata="' + _value + '"]');
            var _radio_img = _this.find('.panel_from_row_radio_img > span[valname="' + item + '"][valdata="' + _value + '"]');
            var _radio_file = _this.find('.panel_from_row_file > span + span > input:file[valname="' + item + '"]');
            var _select = _this.find('.panel_from_row_select > span > select[valname="' + item + '"]');
            var _array = _this.find('.panel_from_row_array[valname="' + item + '"]');
            var _checkbox = _this.find('.panel_from_row_checkbox[valname="' + item + '"]');
            if (_text.size() > 0) {
                _text.val(_value).keyup();
                if (_text.parent('span').parent('.panel_from_row_input_color').size() > 0)
                    _text.next('span').colpickSetColor(_value);
            } else if (_radio_btn.size() > 0) {
                _radio_btn.click();
            } else if (_radio_img.size() > 0) {
                _radio_img.click();
            } else if (_radio_file.size() > 0) {
                _radio_file.attr('valdata', _value).parent('span').prev('span').css('background-image', 'url(\'' + _value + '\')');
            } else if (_select.size() > 0) {
                _select.children('option[value="' + _value + '"]').prop('selected', true);
                _select.change();
            } else if (_array.size() > 0) {
                var _parent = _array.children('span');
                $.each(_value, function (_index, item_array) {
                    var _element_copy = _parent.children('.panel_from_row_array_item[data-struc]');
                    var _element_copy_new = _element_copy.clone().removeAttr('data-struc').attr('valdata', item_array.id);
                    _element_copy_new.insertBefore(_element_copy);
                    var keyload_array = Object.keys(item_array);
                    $.each(keyload_array, function (_index_chi, itemKey) {
                        _element_copy_new.find('input:text[valname="' + itemKey + '"],textarea[valname="' + itemKey + '"]').val(item_array[itemKey]);
                    });
                });
            } else if (_checkbox.size() > 0) {
                _checkbox.find('input:checkbox').prop('checked', false);
                $.each(_value, function (_index, item_array) {
                    _checkbox.find('input:checkbox[value="' + item_array + '"]').prop('checked', true);
                });
            }
        });
    };
    $.fn.getdatafrom = function (data_add) {
        var _this = this;
        var data = data_add ? data_add : {};
        _this.find('.panel_from').each(function () {
            $(this).find('.panel_from_row_input > span > input:text,.panel_from_row_input > span > input:password,.panel_from_row_input > span > textarea').each(function () {
                var _value = $.trim($(this).val());
                data[$(this).attr('valname')] = isNaN(_value) || _value.length <= 0 ? _value : parseFloat(_value);
            });
            $(this).find('.panel_from_row_radio_btn > input:button.select').each(function () {
                var _value = $.trim($(this).attr('valdata'));
                data[$(this).attr('valname')] = isNaN(_value) || _value.length <= 0 ? _value : parseFloat(_value);
            });
            $(this).find('.panel_from_row_radio_img > span.select').each(function () {
                var _value = $.trim($(this).attr('valdata'));
                data[$(this).attr('valname')] = isNaN(_value) || _value.length <= 0 ? _value : parseFloat(_value);
            });
            $(this).find('.panel_from_row_file > span + span > input:file').each(function () {
                var _value = $.trim($(this).attr('valdata'));
                data[$(this).attr('valname')] = _value;
            });
            $(this).find('.panel_from_row_select > span > select').each(function () {
                var _value = $.trim($(this).val());
                data[$(this).attr('valname')] = isNaN(_value) || _value.length <= 0 ? _value : parseFloat(_value);
            });
            $(this).children('.panel_from_row_array').each(function () {
                var valname = $(this).attr('valname');
                data[valname] = new Array();
                $(this).find('span > .panel_from_row_array_item').each(function () {
                    if (typeof $(this).attr('data-struc') == 'undefined') {
                        var obj_array = {};
                        obj_array["id"] = typeof $(this).attr('valdata') != 'undefined' ? $(this).attr('valdata') : "-1";
                        $(this).find('.panel_from_row_array_item_row > input:text,.panel_from_row_array_item_row > textarea').each(function () {
                            var _value = $.trim($(this).val());
                            obj_array[$(this).attr('valname')] = isNaN(_value) || _value.length <= 0 ? _value : parseFloat(_value);
                        });
                        data[valname].push(obj_array);
                    }
                });
            });
            $(this).children('.panel_from_row_checkbox').each(function () {
                var valname = $(this).attr('valname');
                data[valname] = $(this).find('input:checkbox:checked').map(function () { return $(this).val() }).get();
            });
        });
        return data;
    };
}(jQuery));


function show_panel(index) {
    $('.panel_from_item').removeClass('panel_from_item_show');
    $('.panel_from_item').eq(index).addClass('panel_from_item_show');
}
function lable_trai_phai(text) {
    $('lable[lable_trai_phai]').text(text);
}
function lable_text(element, text) {
    $('lable[' + element + ']').text(text);
}

function dis_panel_input(element, status) {
    if (status)
        $('.panel_from[' + element + ']').addClass('panel_from_dis');
    else
        $('.panel_from[' + element + ']').removeClass('panel_from_dis');
}
function event_panel_support(status) {
    if (status) {
        $('.panel_from[panel-input-arr-tu-van]').addClass('panel_from_dis');
        $('*[title-nut-tin-nhan] span').text('Nút tin nhắn thu nhỏ - để lại tin nhắn khi offline');
        $('.panel_from[panel-nut-tin-nhan] [azxcsa-aaaaaa]').css({ 'display': 'block' }).next('div').css({ 'display': 'block' });
    } else {
        $('.panel_from[panel-input-arr-tu-van]').removeClass('panel_from_dis');
        $('*[title-nut-tin-nhan] span').text('Để lại tin nhắn khi offline');
        $('.panel_from[panel-nut-tin-nhan] [azxcsa-aaaaaa]').css({ 'display': 'none' }).next('div').css({ 'display': 'none' });
    }
}
var chatLinkTamFun = new ChatLinkTamFun();
function ChatLinkTamFun() {
    this.message = function (status, info) {
        setTimeout(function () {
            $('body > .htm_err_respon').html('<div class="alertmessage-lintam ' + (status ? 'bg-success-lintam' : 'bg-danger-lintam') + '">' + info + '</div>');
        });
    }
    this.new_guid = function () {
        var d = new Date().getTime();
        var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = (d + Math.random() * 16) % 16 | 0;
            d = Math.floor(d / 16);
            return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
        });
        return uuid;
    }
}