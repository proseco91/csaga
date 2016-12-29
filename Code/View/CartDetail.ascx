<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CartDetail.ascx.cs" Inherits="View_CartDetail" %>

<div class="cart-form">

    <h1 class="h2" item-title-cart>Shopping Cart</h1>

    <%foreach (var sp in arrayCart)
      {%>
    <div class="cart-row" valid="<%=sp.ID %>">
        <div class="grid">
            <div class="grid-item large--seven-twelfths">
                <div class="grid">

                    <div class="grid-item one-third large--one-quarter">
                        <a class="cart-image" href="<%=Lib.urlhome+"/collections/"+Lib.LocDau(sp.Category)+"/products/"+Lib.LocDau(sp.Name)+"/"+sp.ID%>">
                            <img alt="<%=sp.Name %>" src="<%=Lib.urlhome+"/images/imageupload/"+sp.Img %>">
                        </a>
                    </div>

                    <div class="grid-item two-thirds large--three-quarters">
                        <a href="<%=Lib.urlhome+"/collections/"+Lib.LocDau(sp.Category)+"/products/"+Lib.LocDau(sp.Name)+"/"+sp.ID%>"><%=sp.Name %></a>
                        <br>
                        <small><%=sp.ColorAndSize==null?"":sp.ColorAndSize%></small>
                    </div>

                </div>
            </div>
            <div class="grid-item large--five-twelfths medium--two-thirds push--medium--one-third">
                <div class="grid">

                    <div class="grid-item one-half medium-down--one-third text-right">


                        <div class="js-qty">
                            <input type="text" class="js--num" value="<%=sp.Number %>" valmoney="<%=sp.Money %>" autocomplete="off" valold="<%=sp.Number %>" valid="<%=sp.ID %>">
                            <span data-id="" class="js--qty-adjuster js--add">+</span>
                            <span data-id="" class="js--qty-adjuster js--minus">-</span>
                        </div>


                    </div>

                    <div class="grid-item one-third medium-down--one-third medium-down--text-left text-right">
                        <span class="h2">
                            <small>$<%=sp.Money %></small>

                        </span>
                    </div>

                    <div class="grid-item one-sixth medium-down--one-third text-right">
                        <a class="icon-fallback-text remove" href="javascript:;" icon-remove-sp>
                            <span aria-hidden="true" class="fa fa-times"></span>
                        </a>
                    </div>

                </div>
            </div>

        </div>
    </div>
    <%}%>
    <div class="cart-row" item-row-thanhtoan>
        <div class="grid">
            <div class="grid-item text-right ">

                <div class="cart-subtotal">
                    Subtotal
                    <span class="h1 cart-subtotal--price">
                        <small cart-subtotal--price></small>

                    </span>
                </div>
                <input type="button" value="Update cart" class="btn-secondary update-cart" name="update" style="display: none;">
                <a class="btn" href="<%=Lib.urlhome %>/pay" style="color:#FFF;">
                    <span class="fa fa-shopping-cart"></span>
                    Checkout
                </a>
                
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var moneyOld = null;

    $(document).ready(function () {
        $('.js-qty .js--add').click(function () {
            var _parent = $(this).parent('.js-qty');
            var _input = _parent.children('.js--num');
            var numNow = _input.val();
            numNow = !lib.isNumber(numNow) ? 0 : numNow;
            _input.val(parseInt(numNow) + 1);
            _input.change();
        });
        $('.js-qty .js--minus').click(function () {
            var _parent = $(this).parent('.js-qty');
            var _input = _parent.children('.js--num');
            var numNow = _input.val();
            numNow = !lib.isNumber(numNow) ? 0 : numNow;
            if (parseInt(numNow) > 0) {
                _input.val(parseInt(numNow) - 1);
                _input.change();
            }
        });
        $('.js-qty .js--num').on('keydown', function (e) { -1 !== $.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) || /65|67|86|88/.test(e.keyCode) && (!0 === e.ctrlKey || !0 === e.metaKey) || 35 <= e.keyCode && 40 >= e.keyCode || (e.shiftKey || 48 > e.keyCode || 57 < e.keyCode) && (96 > e.keyCode || 105 < e.keyCode) && e.preventDefault() }).change(function () {
            var _parent = $(this).parent('.js-qty');
            var _input = _parent.children('.js--num');
            var numNow = _input.val();
            if (!lib.isNumber(numNow)) {
                numNow = 0;
                _input.val(numNow);
            }
            readLoadMoneyCart();
        });
        $('[icon-remove-sp]').click(function () {
            $(this).parents('.grid').find('.js-qty .js--num').val('0').change();
        });
        $('.update-cart').click(function () {
            var arrayUpdate = [];
            $('.js-qty .js--num').each(function () {
                var numNow = parseInt($(this).val());
                var numOld = parseInt($(this).attr('valold'));
                if (numNow != numOld) {
                    arrayUpdate.push({
                        id: $(this).attr('valid'),
                        num: numNow
                    });
                }
            });
            if (arrayUpdate.length > 0) {
                $('.update-cart').css('display', 'none');
                $('#loading_masster').css({ 'display': 'block' });
                var funUpdate = function () {
                    var itemUp = arrayUpdate[0];
                    $.ajax({
                        type: "POST",
                        url: url_home + '/service/service.asmx/AddCart',
                        data: '{"ID":"' + itemUp.id + '",Number:' + itemUp.num + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function () {

                        },
                        success: function (message) {
                            var message = message.d;
                            if (message[0] > 0)
                                $('.cart-badge--desktop').text(message[0]);
                            else
                                $('.cart-badge--desktop').text('');
                            moneyOld = message[1];
                            if (message[2]) {
                                $('.cart-row[valid="' + itemUp.id + '"]').remove();
                            } else {
                                $('.js-qty .js--num[valid="' + itemUp.id + '"]').attr('valold', itemUp.num);
                            }
                            arrayUpdate.splice(0, 1);
                            if (arrayUpdate.length > 0) {
                                funUpdate.call();
                            }
                            else {
                                $('#loading_masster').css({ 'display': 'none' });
                                readLoadMoneyCart();
                            }
                        },
                        error: function (errormessage) {
                        }
                    });
                };
                funUpdate.call();
            }

        });
        readLoadMoneyCart();
    });
    function readLoadMoneyCart() {
        var moneyNow = 0;
        var updatestatus = false;
        $('.js-qty .js--num').each(function () {
            var _spMoney = parseInt($(this).attr('valmoney'));
            var numNow = parseInt($(this).val());
            var numOld = parseInt($(this).attr('valold'));
            moneyNow += numNow * _spMoney;
            if (numNow != numOld) {
                updatestatus = true;
            }
        });
        if (moneyOld == null) {
            moneyOld = moneyNow;
        }


        if (moneyOld != moneyNow || updatestatus)
        { $('.update-cart').css('display', 'inline-block'); }
        else if (moneyOld == moneyNow && !updatestatus)
        { $('.update-cart').css('display', 'none'); }

        $('[cart-subtotal--price]').html('$' + moneyNow.formatMoney(0, '.', ','));
        if (moneyOld == 0) {
            $('[item-title-cart]').text('Your cart is currently empty.');
            $('[item-row-thanhtoan]').remove();
        }
    }
</script>

