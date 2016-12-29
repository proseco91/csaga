var filter_number = /^[0-9]{1,}$/;
var lib = new Lib();
function Lib() {
    this.isNumber = function (value) {
        return filter_number.test(value);
    }
    this.add_cart = function (id, number) {
        number = number == null ? -1 : number;
        $.ajax({
            type: "POST",
            url: url_home + '/service/service.asmx/AddCart',
            data: '{"ID":"' + id + '",Number:' + number + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () {
                $('#loading_masster').css({ 'display': 'block' });
            },
            success: function (message) {
                var message = message.d;
                if (message[0] > 0)
                    $('.cart-badge--desktop').text(message[0]);
                $('#loading_masster').css({ 'display': 'none' });
            },
            error: function (errormessage) {
                $('#loading_masster').css({ 'display': 'none' });
            }
        });
    }
}
Number.prototype.formatMoney = function (c, d, t) {
    var n = this, c = isNaN(c = Math.abs(c)) ? 2 : c, d = d == undefined ? "," : d, t = t == undefined ? "." : t, s = n < 0 ? "-" : "", i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};