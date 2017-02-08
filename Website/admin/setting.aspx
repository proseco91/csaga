<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="setting.aspx.cs" Inherits="admin_setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('div[menu-cauhinh]').addClass('page-menu-group-item-active');
            $.each(typeof ListImgOld == 'undefined' ? [] : ListImgOld, function (i, item) {
                var elClick = $('<span title="Xóa" style="background-image:url(\'<%=Lib.urlhome+"/Images/imageUpload/"%>' + item + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_old" value="' + item + '"/></span>').appendTo($('[img-oldaaa]'));
                elClick.click(function () {
                    elClick.remove();
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel_from_item panel_from_item_show">
        <div class="panel_from_title"><span>Cấu hình website</span></div>
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
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from_row panel_from_row_file">
                <lable>Banner (1200 x 360 px)</lable>
                <span img-oldaaa></span>
                <span>Tải hình ảnh lên
                        <asp:FileUpload ID="fileUpload" runat="server"  dataImg  AllowMultiple="true"/>
                </span>
            </div>
        </div>
        <div style="clear: both; height: 50px;"></div>
        <div class="panel_from">
            <div class="panel_from_dis_panel"></div>
            <div class="panel_from_row panel_from_row_btn_submit">
                <asp:Button ID="Action_AddNew" runat="server" Text="Chỉnh sửa" CssClass="submit" OnClick="Action_AddNew_Click" />
            </div>
        </div>
    </div>
</asp:Content>

