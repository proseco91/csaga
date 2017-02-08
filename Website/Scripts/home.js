var filter_number = /^[0-9]{1,}$/;
var filter_email = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var lib = new Lib();
function Lib() {
    this.isNumber = function (value) {
        return filter_number.test(value);
    }
    this.isEmail = function (value) {
        return filter_email.test(value);
    }
    this.message = function (status, info) {
        setTimeout(function () {
            $('body > .htm_err_respon').html('<div class="alertmessage-lintam ' + (status ? 'bg-success-lintam' : 'bg-danger-lintam') + '">' + info + '</div>');
        });
    }
}
Number.prototype.formatMoney = function (c, d, t) {
    var n = this, c = isNaN(c = Math.abs(c)) ? 2 : c, d = d == undefined ? "," : d, t = t == undefined ? "." : t, s = n < 0 ? "-" : "", i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};