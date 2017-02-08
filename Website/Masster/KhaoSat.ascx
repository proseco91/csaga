<%@ Control Language="C#" AutoEventWireup="true" CodeFile="KhaoSat.ascx.cs" Inherits="Masster_KhaoSat" %>



<%if (khaosat != null)
  { 
          
%>
<div id="khao-sat" valnow="-1" valmax="-1">
    <div class="khao-sat-panel">
        <div class="khao-sat-panel-content">
            <div class="khao-sat-item">
                <div style="font-size: 18px; font-weight: bold; color: #333; text-align: center; text-transform: uppercase;"><%=khaosat.TitleVn %></div>
                <div style="font-size: 15px; font-weight: 700; color: #555; text-align: justify; margin-top: 10px;"><%=khaosat.DesVn.Replace("\n","</br>") %></div>
            </div>
            <%foreach (var item in khaosat.arrayCauHoi)
              {%>
            <div class="khao-sat-item" valid="<%=item.id %>">
                <div style="font-size: 18px; font-weight: bold; color: #333; text-align: center; text-transform: uppercase;"><%=item.title %></div>
                <%foreach (var cauhoi in item.array)
                  {%>
                <div item-khaosat-check="<%=cauhoi.id %>">
                    <input type="checkbox" value="<%=cauhoi.id %>" groupcheckbox="<%=item.id %>" />
                    <%=cauhoi.text %>
                </div>
                <%}%>
                <script type="text/javascript">
                    $(document).ready(function () {
                        $('[groupcheckbox="<%=item.id %>"]').change(function () {
                            $('[groupcheckbox="<%=item.id %>"]').prop('checked', false);
                            $(this).prop('checked', true);
                        }).eq(0).change();
                    });
                </script>
            </div>
            <%}%>
            <div class="khao-sat-item" thanhcong="false">
                <div panelthanhcong>
                    Gửi khảo sát thành công.
                </div>
                <div panelinfo>
                    <div style="font-size: 18px; font-weight: bold; color: #333; text-align: center; text-transform: uppercase;">Thông tin</div>
                    <div class="khao-sat-item_updateinfo">
                        <div class="khao-sat-item_updateinfo_input" title="<%=Lib.ContentLag("Tên đầy đủ","Full Name") %>">
                            <input type="text" placeholder="<%=Lib.ContentLag("Tên đầy đủ","Full Name") %>" name="fullname" maxlength="100" />
                        </div>
                        <div class="khao-sat-item_updateinfo_input" title="<%=Lib.ContentLag("Email","Email") %>">
                            <input type="text" placeholder="<%=Lib.ContentLag("Email","Email") %>" name="email" maxlength="100" />
                        </div>
                        <div class="khao-sat-item_updateinfo_input" title="<%=Lib.ContentLag("Điện thoại","Phone number") %>">
                            <input type="text" placeholder="<%=Lib.ContentLag("Điện thoại","Phone number") %>" name="phone" maxlength="100" />
                        </div>
                        <div class="khao-sat-item_updateinfo_err">
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="khao-sat-panel-btn">
            <span class="khao-sat-panel-btn-left">Quay lại</span>
            <span class="khao-sat-panel-btn-right">Tiếp</span>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        var _khaosat = $('#khao-sat');
        var _max = _khaosat.find('.khao-sat-item').size();
        _khaosat.attr('valmax', _khaosat.find('.khao-sat-item').size());
        var khaosat_info = _khaosat.find('.khao-sat-item_updateinfo');
        $('.khao-sat-panel-btn-right,.khao-sat-panel-btn-left').mousedown(function (event) {
            event.preventDefault();
        });
        $('.khao-sat-panel-btn-right').click(function () {

            var indexNe = parseInt(_khaosat.attr('valnow')) + 1;
            if (_max == indexNe) {
                var fullname = $.trim(khaosat_info.find('input[name="fullname"]').val());
                var email = $.trim(khaosat_info.find('input[name="email"]').val());
                var phone = $.trim(khaosat_info.find('input[name="phone"]').val());
                if (fullname.length == 0) {
                    khaosat_info.children('.khao-sat-item_updateinfo_err').html('<%=Lib.ContentLag("Tên đầy đủ phải có.","Full names must have.") %>');
                    showKhaoSat(indexNe - 1);
                    return false;
                }
                if (!lib.isEmail(email)) {
                    khaosat_info.children('.khao-sat-item_updateinfo_err').html('<%=Lib.ContentLag("Email phải có.","Email must have.") %>');
                    showKhaoSat(indexNe - 1);
                    return false;
                }
                if (phone.length == 0) {
                    khaosat_info.children('.khao-sat-item_updateinfo_err').html('<%=Lib.ContentLag("Điện thoại phải có.","Phone number must have.") %>');
                    showKhaoSat(indexNe - 1);
                    return false;
                }
                khaosat_info.children('.khao-sat-item_updateinfo_err').html('');
                showKhaoSat(indexNe - 1);
                var arrarTL = [];
                $('[khao-sat-item][valid]').each(function () {
                    arrarTL.push({
                        id: $(this).attr('valid'),
                        idtraloi: $('[groupcheckbox="' + $(this).attr('valid') + '"]:checked').val()
                    });
                });

                $('.khao-sat-panel-btn-left,.khao-sat-panel-btn-right').removeAttr('show');
                $('.khao-sat-panel-btn').attr('loading', '');
                $.ajax({
                    type: "POST",
                    url: $.chat.urlWeb + "/service/service.asmx/doneKhaoSat",
                    data: "{'ID':'<%=khaosat.ID%>',array:" + JSON.stringify(JSON.stringify(arrarTL)) + ",fullname:'" + fullname + "',email:'" + email + "',phone:'" + phone + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {

                    },
                    success: function (message) {
                        $('.khao-sat-panel-btn').removeAttr('loading');
                        $('[thanhcong]').attr('thanhcong', 'true');
                        showKhaoSat(indexNe - 1);
                        setTimeout(function () {
                            $('#khao-sat').remove();
                        }, 3000);
                    },
                    error: function (errormessage) {

                    }
                });
            } else if (_max - 1 == indexNe) {
                $(this).text('Gửi khảo sát');
                showKhaoSat(indexNe);
            }
            else {
                showKhaoSat(indexNe);
            }
            $('.khao-sat-panel-btn-left,.khao-sat-panel-btn-right').removeAttr('show');
        });
        $('.khao-sat-panel-btn-left').click(function () {
            var indexNe = parseInt(_khaosat.attr('valnow')) - 1;
            showKhaoSat(indexNe);
            $('.khao-sat-panel-btn-right').text('Tiếp');
            $('.khao-sat-panel-btn-left,.khao-sat-panel-btn-right').removeAttr('show');
        });
        showKhaoSat(0);
    });
    function showKhaoSat(index) {
        if (parseInt($('#khao-sat').attr('valnow')) == index) {
            var ara = $('#khao-sat .khao-sat-item');
            var el = ara.eq(index);
            var height = (el.outerHeight(true) + 100);
            $('#khao-sat .khao-sat-panel').css('height', height + 'px');

        } else {
            $('#khao-sat').attr('valnow', index);
            $('#khao-sat .khao-sat-panel .khao-sat-panel-content').removeAttr('overflow');
            var ara = $('#khao-sat .khao-sat-item');
            ara.removeAttr('show').removeAttr('showeff');
            var el = ara.eq(index).attr('show', '');
            setTimeout(function () {
                var height = (el.outerHeight(true) + 100);
                $('#khao-sat .khao-sat-panel').css('height', height + 'px');
                setTimeout(function () {
                    el.attr('showeff', '');
                    $('#khao-sat .khao-sat-panel .khao-sat-panel-content').attr('overflow', '');
                }, 1);

                if (index == 0)
                    $('.khao-sat-panel-btn-left').removeAttr('show');
                else
                    $('.khao-sat-panel-btn-left').attr('show', '');

                $('.khao-sat-panel-btn-right').attr('show', '');
            }, 500);
        }
    }
</script>
<%}%>
