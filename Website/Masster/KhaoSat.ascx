<%@ Control Language="C#" AutoEventWireup="true" CodeFile="KhaoSat.ascx.cs" Inherits="Masster_KhaoSat" %>
<span content-khaosat>
    <div class="item-home flip-container" style="cursor: pointer;" btn-click-khaosat>
        <div class="item-home-hover flipper">
            <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/imageUpload/<%=sql.getCategory().FirstOrDefault(d=>d.ID==1034).Img %>');"></div>
            <div class="item-home-icon back" style="background-image: url('<%=Lib.urlhome%>/Images/imageUpload/<%=sql.getCategory().FirstOrDefault(d=>d.ID==1034).Img %>');">
            </div>
        </div>

        <div class="item-home-name">Khảo sát</div>

    </div>
    <%if (khaosat != null)
        {

    %>
    <div iframe-khaosat="">
        <span iframe-btn-dong="">Đóng</span>
        <iframe src="<%=khaosat.Link %>"></iframe>
    </div>
    <div id="khao-sat" valnow="-1" valmax="-1">
        <div class="khao-sat-panel">
            <div class="khao-sat-panel-content">
                <div class="khao-sat-item">
                    <div style="font-size: 18px; font-weight: bold; color: #333; text-align: center; text-transform: uppercase;"><%=khaosat.TitleVn %></div>
                    <div style="font-size: 15px; font-weight: 700; color: #555; text-align: justify; margin-top: 10px;"><%=khaosat.DesVn.Replace("\n","</br>") %></div>
                </div>
                <div class="khao-sat-item" thanhcong="false">
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
            $('[iframe-khaosat] [iframe-btn-dong]').click(function () {
                $('[iframe-khaosat]').css('display', 'none');
                getKhaoSat();
            });
            $('[btn-click-khaosat]').click(function () {
                _khaosat.attr('show', '');
                setTimeout(function () {
                    showKhaoSat(0);
                    _khaosat.attr('showeff', '');
                }, 100);
            });

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
                    $('.khao-sat-panel-btn-left,.khao-sat-panel-btn-right').removeAttr('show');
                    $('.khao-sat-panel-btn').attr('loading', '');
                    $.ajax({
                        type: "POST",
                        url: "/service/service.asmx/doneKhaoSat",
                        data: "{'ID':'<%=khaosat.ID%>',array:" + JSON.stringify(JSON.stringify(arrarTL)) + ",fullname:'" + fullname + "',email:'" + email + "',phone:'" + phone + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {

                    },
                    success: function (message) {
                        _khaosat.removeAttr('show');
                        $('[iframe-khaosat]').css('display', 'block');
                    },
                    error: function (errormessage) {

                    }
                });
                } else if (_max - 1 == indexNe) {
                    $(this).text('Làm khảo sát');
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
        function getKhaoSat() {
            $.ajax({
                type: "GET",
                url: '/service/service.asmx/GetKhaoSat',
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                },
                success: function (message) {
                    //$('#khao-sat').remove();
                    $('[content-khaosat]').replaceWith(message.d);
                },
                error: function (errormessage) {
                }
            });
        }
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
    <%}
        else
        {%>
    <script type="text/javascript">
        $(document).ready(function () {

            $('[btn-click-khaosat]').click(function () {
                alert('Bạn đã thực hiện hết khảo sát.');
            });

        });
    </script>
    <%}%>
</span>