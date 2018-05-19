<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="setting.aspx.cs" Inherits="admin_setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('div[menu-cauhinh]').addClass('page-menu-group-item-active');
            $.each(settings.Banner.split(","), function (i, item) {
                var elClick = $('<span title="Xóa" style="background-image:url(\'<%=Lib.urlhome+"/Images/imageUpload/"%>' + item + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_old_banner" value="' + item + '"/></span>').appendTo($('[img-oldaaa]'));
                elClick.click(function () {
                    elClick.remove();
                });
            });

            $('<span title="Xóa" style="background-image:url(\'<%=Lib.urlhome+"/Images/imageUpload/"%>' + settings.Img_Background + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" value="' + settings.Img_Background + '"/></span>').appendTo($('[img-backgroundweb]')).click(function () {
                elClick.remove();
            });
            $('[valname="windown_background_web"][valdata="' + settings.Use_ImgBackground + '"]').click();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="parenmenu_new">
        <div class="panel_from">
            <div class="panel_from_row panel_from_row_radio_btn">
                <input type="button" value="Cấu hình liên hệ" class="select" onclick="show_panel(0);" />
                <input type="button" value="Photo Banner" onclick="show_panel(1);" />
                <input type="button" value="Background Website" onclick="show_panel(2);" />
                <input type="button" value="Hotline" onclick="show_panel(3);" />
            </div>
        </div>
        <div class="htm_err_respon"></div>
    </div>
    <div style="clear: both; height: 50px;"></div>
    <div>
        <div class="panel_from_item panel_from_item_show">
            <div class="panel_from_title"><span>Cấu hình liên hệ</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Email</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtEmail" runat="server" no-empty Width="100%" MaxLength="200" valtype="email"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Địa chỉ</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtDiaChi" runat="server" no-empty Width="100%" MaxLength="400"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Điện thoại</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtDienThoai" runat="server" no-empty Width="100%" MaxLength="200"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Fax</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtFax" runat="server" no-empty Width="100%" MaxLength="200"></asp:TextBox>
                    </span>
                </div>

            </div>
        </div>
        <div class="panel_from_item">
            <div class="panel_from_title"><span>Photo Banner</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_file">
                    <lable>Images (1200 x 444 px)</lable>
                    <span img-oldaaa></span>
                    <span>Tải hình ảnh lên
                        <asp:FileUpload ID="fileUpload" ClientIDMode="Static" runat="server" dataImg AllowMultiple="true" />
                    </span>
                </div>
            </div>
        </div>
        <div class="panel_from_item">
            <div class="panel_from_title"><span>Background Website</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from">
                    <div class="panel_from_row panel_from_row_radio_btn">
                        <lable>Loại hiển thị</lable>
                        <input type="button" value="Ảnh nền" valdata="0" valname="windown_background_web" class="select" style="border-left: 1px solid #d9d9d9; border-radius: 3px 0 0 3px;" />
                        <input type="button" value="Màu nền" valdata="1" valname="windown_background_web" />
                        <input type="button" value="Cả 2" valdata="2" valname="windown_background_web" />
                        <asp:HiddenField ID="windown_background_web" runat="server" ClientIDMode="Static" />
                    </div>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_file">
                    <lable>Ảnh nền</lable>
                    <span img-backgroundweb></span>
                    <span>Tải hình ảnh lên
                        <asp:FileUpload ID="imageBackgroundweb" ClientIDMode="Static" runat="server" dataImg />
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input panel_from_row_input_color">
                    <lable>Màu nền</lable>
                    <span>
                        <asp:TextBox ID="txtColor" runat="server" Width="100%" MaxLength="200"></asp:TextBox>
                        <span><span></span></span>
                    </span>
                </div>
            </div>
        </div>
        <div class="panel_from_item">
            <div class="panel_from_title"><span>Điện thoại</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Số điện thoại</lable>
                    <span style="width: 400px;">
                        <input type="text" data="phone" />
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input panel_from_row_input_color">
                    <lable>Màu nền</lable>
                    <span>
                        <input type="text" background="phone" />
                        <span><span></span></span>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input panel_from_row_input_color">
                    <lable>Màu icon</lable>
                    <span>
                        <input type="text" color="phone" />
                        <span><span></span></span>
                    </span>
                </div>
            </div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from_title"><span>Email</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Email</lable>
                    <span style="width: 400px;">
                        <input type="text" data="email" />
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input panel_from_row_input_color">
                    <lable>Màu nền</lable>
                    <span>
                        <input type="text" background="email" />
                        <span><span></span></span>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input panel_from_row_input_color">
                    <lable>Màu icon</lable>
                    <span>
                        <input type="text" color="email" />
                        <span><span></span></span>
                    </span>
                </div>
            </div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from_title"><span>Facebook</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Link</lable>
                    <span style="width: 400px;">
                        <input type="text" data="facebook" />
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input panel_from_row_input_color">
                    <lable>Màu nền</lable>
                    <span>
                        <input type="text" background="facebook" />
                        <span><span></span></span>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input panel_from_row_input_color">
                    <lable>Màu icon</lable>
                    <span>
                        <input type="text" color="facebook" />
                        <span><span></span></span>
                    </span>
                </div>
            </div>
            <asp:HiddenField ID="dataHotline" runat="server" ClientIDMode="Static" />
        </div>
        <div style="clear: both; height: 50px;"></div>
        <div class="panel_from">
            <div class="panel_from_dis_panel"></div>
            <div class="panel_from_row panel_from_row_btn_submit">
                <asp:Button ID="Action_AddNew" runat="server" Text="Chỉnh sửa" ClientIDMode="Static" CssClass="submit" OnClick="Action_AddNew_Click" />
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            var hottline = JSON.parse(settings.Hotline);
            if (hottline != null) {
                debugger;
                $('[data="phone"]').val(hottline.phone.data);
                $('[background="phone"]').val(hottline.phone.background).next('span').colpickSetColor(hottline.phone.background);
                $('[color="phone"]').val(hottline.phone.color).next('span').colpickSetColor(hottline.phone.color);

                $('[data="email"]').val(hottline.email.data);
                $('[background="email"]').val(hottline.email.background).next('span').colpickSetColor(hottline.email.background);
                $('[color="email"]').val(hottline.email.color).next('span').colpickSetColor(hottline.email.color);

                $('[data="facebook"]').val(hottline.facebook.data);
                $('[background="facebook"]').val(hottline.facebook.background).next('span').colpickSetColor(hottline.facebook.background);
                $('[color="facebook"]').val(hottline.facebook.color).next('span').colpickSetColor(hottline.facebook.color);
            }
            $('#Action_AddNew').click(function () {
                var data = {
                    phone: {
                        data: $('[data="phone"]').val(),
                        background: $('[background="phone"]').val(),
                        color: $('[color="phone"]').val(),
                    },
                    email: {
                        data: $('[data="email"]').val(),
                        background: $('[background="email"]').val(),
                        color: $('[color="email"]').val(),
                    },
                    facebook: {
                        data: $('[data="facebook"]').val(),
                        background: $('[background="facebook"]').val(),
                        color: $('[color="facebook"]').val(),
                    }
                };
                $('#dataHotline').val(JSON.stringify(data));
            });
        });
    </script>
</asp:Content>

