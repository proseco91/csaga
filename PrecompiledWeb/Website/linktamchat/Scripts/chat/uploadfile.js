(function ($) {
    $.fn.uploadFile = function (options) {
        var settings = $.extend({
            el:null,
            array: new Array(),
            convertbase64: function (url, callback) {
                var FR = new FileReader();
                FR.onload = function (e) {
                    callback.call(this, e.target.result, settings.el);
                };
                FR.readAsDataURL(url);
            },
            bytetostring: function (size) {
                var i = -1;
                var byteUnits = [" kB", " MB", " GB", " TB", " PB", " EB", " ZB", " YB"];
                do {
                    size = size / 1024;
                    i++;
                } while (size > 1024);

                return Math.max(size, 0.1).toFixed(1) + byteUnits[i];
            },
            getExtension: function (file) {
                return (/[.]/.exec(file.name)) ? /[^.]+$/.exec(file.name) : "";
            },
            checkExtension: function (file) {
                //var file_extension = file.type != "" ? file.type.split('/').length >= 1 ? file.type.split('/')[1].toLowerCase() : "" : (/[.]/.exec(file.name)) ? /[^.]+$/.exec(file.name) : "";
                var file_extension = (/[.]/.exec(file.name)) ? /[^.]+$/.exec(file.name) : "";
                return !(new RegExp('(' + settings.extension.join('|').toLowerCase() + ')$')).test(file_extension);
            },
            next_upload: function () {
                if (settings.delaynextupload) {
                    setTimeout(function () {
                        if (settings.eventnextupload)
                            settings.eventnextupload();
                        settings.array.splice(0, 1);
                        settings.loopupload();
                    }, settings.delaynextupload);
                } else {
                    if (settings.eventnextupload)
                        settings.eventnextupload();
                    settings.array.splice(0, 1);
                    settings.loopupload();
                }
            },
            loopupload: function () {
                if (settings.array.length > 0) {
                    var fileupnow = settings.array[0];
                    $.ajax({
                        url: settings.querystring && settings.querystring.length>0 ? settings.url + "?name=" + fileupnow.name + '&' + settings.querystring.join("&") : settings.url + "?name=" + fileupnow.name,
                        type: "POST",
                        data: fileupnow.data,
                        processData: false, //Work around #1
                        contentType: fileupnow.type, //Work around #2
                        success: function (response) {
                            if (settings.successfile)
                                settings.successfile(response, settings.array[0]);
                            settings.next_upload();
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            if (settings.error && $.trim(thrownError).length > 0) {
                                settings.error(settings.array[0], thrownError);
                            }
                            settings.next_upload();
                        },
                        xhr: function () {
                            myXhr = $.ajaxSettings.xhr();
                            if (myXhr.upload) {
                                myXhr.upload.addEventListener('progress', function (evt) {
                                    if (settings.progress)
                                        settings.progress((evt.loaded / evt.total) * 100, settings.array[0]);
                                }, false);
                            } else {
                                if (settings.error) {
                                    settings.error(settings.array[0], "Uploadress is not supported.");
                                }
                                settings.next_upload();
                            }
                            return myXhr;
                        }
                    });
                } else {
                    if (settings.successall)
                        settings.successall();
                }
            }
        }, options);
        this.change(function () {
            var _file = this.files;
            settings.array = new Array();
            for (var i = 0; i < _file.length; i++) {
                var file = _file[i];
                var file_obj = {
                    name: file.name,
                    size: file.size,
                    size_text: settings.bytetostring(file.size),
                    type: file.type,
                    data: file
                };
                var isAddfile = true;
                if (settings.extension && !settings.checkExtension(file)) {
                    isAddfile = false;
                    if (settings.error)
                        settings.error(file, file.name + ' không đúng định dạng.<br/>Không chấp nhận file có định dạng ' + settings.extension.join(", "));
                }
                if (isAddfile && settings.size && file.size > settings.size) {
                    isAddfile = false;
                    if (settings.error)
                        settings.error(file, file.name + ' - ' + settings.bytetostring(file.size) + '.<br/>Chỉ chấp nhận file có kích thước ' + settings.bytetostring(settings.size));
                }
                if (isAddfile) {
                    settings.array[i] = file_obj;
                    if (settings.base64)
                        settings.convertbase64(file, settings.base64);
                }
            }
            if (settings.change && settings.array.length > 0)
                settings.change(settings.array);
            if (settings.autostart && settings.array.length > 0)
                settings.loopupload();
        });
        //////////////////////////////////////////////////
        settings.el = this;
        if (settings.onready)
            settings.onready.call(this, settings.el);
        //////////////////////////////////////////////////
    };
}(jQuery));