<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master"
    AutoEventWireup="true" CodeFile="dang-nhap.aspx.cs" Inherits="admin_dang_nhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        body, #page-wrapper
        {
            background-color: #EEE;
        }

        .panel_from .panel_from_row > lable:first-child
        {
            color: #555;
            display: inline-table;
            font-size: 15px;
            letter-spacing: 0;
            padding: 0 10px 0 0;
            text-transform: uppercase;
            width: 100px;
        }

        .panel_from .panel_from_row_input > span:last-child input[type="text"], .panel_from .panel_from_row_input > span:last-child input[type="password"], .panel_from .panel_from_row_input > span:last-child textarea
        {
            width: 250px;
        }
        .alert
        {
            border-radius:0px;
            text-transform: uppercase;
        }
        .close
        {
            display:none;
        }
        #page-menu
        {
            display:none;
        }
        #page-wrapper
        {
            margin: 0 !important;
        }
        .panel_from .panel_from_row {
            padding:0px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.btn-login-new[aaa-step0]').click(function () {
                if (!$('.body-panel-login').validate())
                    return false;
            });
            $('.btn-quen-pass').click(function () {
                $('.body-panel-status').html('');
                var parent = $(this).parents('.body-login');
                var type = parseInt(parent.attr('valtype'));
                parent.attr('valtype', type == 0 ? 1 : 0);
                $('.panel_from_row_err').removeClass('panel_from_row_err');
                $('input:text[valname="login_url"]').removeAttr('disabled');
            });
            $('.btn-login-new[aaa-step1]').click(function () {
                if (!$('.body-panel-login').validate())
                    return false;
                var parent = $(this).parents('.body-login');
                var data = $('.body-panel-login').getdatafrom();
                $.ajax({
                    type: "POST",
                    url: "../service/service.asmx/check_url_email",
                    data: "{'data':" + JSONfn.stringify(JSONfn.stringify(data)) + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $('.body-login').attr('loading', '');
                    },
                    success: function (message) {
                        var eReturn = JSONfn.parse(message.d);

                        if (!eReturn[0]) {
                            $('.body-panel-status').html(eReturn[1]);
                        } else {
                            parent.attr('valtype', 2);
                            $('input:text[valname="login_email_rep"]').val(eReturn[1]);
                            $('input:text[valname="login_url"]').attr('disabled', 'disabled');
                        }

                        $('.body-login').removeAttr('loading');
                    },
                    error: function (errormessage) {
                        $('.body-login').removeAttr('loading');
                    }
                });
            });
            $('.btn-login-new[aaa-step2]').click(function () {
                if (!$('.body-panel-login').validate())
                    return false;
                var parent = $(this).parents('.body-login');
                var data = $('.body-panel-login').getdatafrom();
                $.ajax({
                    type: "POST",
                    url: "../service/service.asmx/send_email_get_pass",
                    data: "{'data':" + JSONfn.stringify(JSONfn.stringify(data)) + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $('.body-login').attr('loading', '');
                    },
                    success: function (message) {
                        var eReturn = JSONfn.parse(message.d);
                        if (!eReturn[0]) {
                            $('.body-panel-status').html(eReturn[1]);
                        } else {
                            $('.body-panel-status').html(eReturn[1]);
                            parent.attr('valtype', 0);
                            $('.panel_from_row_err').removeClass('panel_from_row_err');
                            $('input:text[valname="login_url"]').removeAttr('disabled');
                        }

                        $('.body-login').removeAttr('loading');
                    },
                    error: function (errormessage) {
                        $('.body-login').removeAttr('loading');
                    }
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="head-login">
        <div class="head-login-content"></div>
    </div>
    <div style="clear: both; height: 70px;"></div>
    <div class="body-login" valtype="0">
        <div class="body-panel-head">
        </div>
        <div class="body-panel-login">
            <div class="panel_from">
                <div class="panel_from_row panel_from_row_input">
                    <lable>Email</lable>
                    <span>
                        <asp:TextBox ID="txtEmailLogin" runat="server" valname="login_url" no-empty></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;" aaa-step2></div>
                <div class="panel_from_row panel_from_row_input" aaa-step2>
                    <lable>Email</lable>
                    <span>
                        <asp:TextBox ID="txtEmail_XacNhan" runat="server" valname="login_email_rep" Enabled="false"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;" aaa-step2></div>
                <div class="panel_from_row panel_from_row_input" aaa-step2>
                    <lable>Xác nhận</lable>
                    <span>
                        <asp:TextBox ID="txtEmail" runat="server" valname="login_email" valtype="email" no-empty></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;" aaa-step0></div>
                <div class="panel_from_row panel_from_row_input" aaa-step0>
                    <lable>Mật khẩu</lable>
                    <span>
                        <asp:TextBox ID="txtPass" TextMode="Password" runat="server" valname="login_password" no-empty></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 10px;" aaa-step0></div>
                <div class="panel_from_row panel_from_row_checkbox" valname="login_cookie" aaa-step0>
                    <lable style="font-size:12px;">Ghi nhớ</lable>
                    <span style="display: inline-block;position: relative;top: -3px;">
                        <span style="">
                            <asp:CheckBox ID="cbCookie" runat="server" />
                        </span>
                    </span>
                </div>
            </div>
            <asp:Button ID="btnInsert" runat="server" Text="Đăng nhập" CssClass="btn-login-new" OnClick="btnInsert_Click"  aaa-step0/>
            <input type="button" value="Kiểm tra" class="btn-login-new" aaa-step1 />
            <input type="button" value="Gửi email" class="btn-login-new" aaa-step2 />
            <div class="btn-quen-pass" valdata="Đăng nhập"></div>
            <div style="clear: both; height: 20px;"></div>
        </div>
        <div style="clear: both; height: 20px;"></div>
        <div class="body-panel-status">
            <asp:Literal ID="ltStatus" runat="server"></asp:Literal>
        </div>
    </div>
    <%--<div class="row">
        <ol class="breadcrumb">
            <li class="active"><i class="fa fa-table"></i>Đăng nhập vào hệ thống</li>
        </ol>
        <asp:Literal ID="ltStatus" runat="server"></asp:Literal>
    </div>
    <div class="row" style="width: 300px; margin: 0px auto; display: none;">
        <div class="form-group">
            <label for="exampleInputEmail1">Url</label>
            <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control noEmpty" placeholder="Url"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1">Mật khẩu</label>
            <asp:TextBox ID="txtPass" TextMode="Password" runat="server" CssClass="form-control noEmpty" placeholder="Mật khẩu"></asp:TextBox>
        </div>
        <div style="float: right;">
            <asp:Button ID="btnInsert" runat="server" Text="Đăng nhập"
                CssClass="btn btn-primary" OnClick="btnInsert_Click" />
        </div>

    </div>--%>
</asp:Content>
