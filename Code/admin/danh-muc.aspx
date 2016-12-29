<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="danh-muc.aspx.cs" Inherits="admin_danh_muc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('div[menu-category]').addClass('page-menu-group-item-active');
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="htm_loading_page"></div>
    <div class="parenmenu_new">
        <div class="panel_from">
            <div class="panel_from_row panel_from_row_radio_btn">
                <a href="danh-muc.htm">
                    <input typeaction="0" type="button" value="Danh sách danh mục sản phẩm" /></a>
                <a href="them-moi-danh-muc.htm">
                    <input typeaction="1" type="button" value="Thêm mới danh mục sản phẩm" /></a>
            </div>
        </div>
    </div>
    <div style="clear: both; height: 50px;"></div>
    <asp:Panel ID="index" runat="server" Visible="false">
        <div class="panel_from_item panel_from_item_show">
            <div class="style_table">
                <div class="panel_search" action-default>
                    <input type="text" placeholder="Tìm kiếm" />
                    <span attr-close></span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <table cellpadding="0" cellspacing="0">

                    <tr>
                        <th style="width: 50px; text-align: center;" enabled-sort>STT</th>
                        <th class="row_img"></th>
                        <th style="width: calc(100% - 376px);" enabled-sort>Tên danh mục</th>
                        <th style="width: 150px;" enabled-sort sorted="desc">Ngày tạo</th>
                        <th style="width: 100px;"></th>
                    </tr>
                    <%
                        List<Category> _cate = getCategory();
                        foreach (var item in _cate.Select((value, i) => new { i, value }))
                        {
                    %>
                    <tr>
                        <td style="width: 50px; text-align: center;" class="ellipsis"><%=item.i+1 %></td>
                        <td class="row_img" style="text-align:center;">
                            <span style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');"></span>
                        </td>
                        <td style="width: calc(100% - 376px);" class="ellipsis" valdata="<%=item.value.Name %>"><%=item.value.Name %></td>
                        <td style="width: 150px;" class="ellipsis" valdata="<%=item.value.CreateDate.Ticks %>"><%=item.value.CreateDate.ToString("dd/MM/yyyy, HH:mm") %></td>
                        <td style="width: 100px;text-align:center;" class="ellipsis">
                            <a href="danh-muc-chinh-sua-<%=Lib.LocDau(item.value.Name) %>-z-<%=item.value.ID %>.htm"><i class="fa fa-pencil" title="Chỉnh sửa"></i></a>
                            <a delete-link="Bạn chắc chắn muốn xóa <%=item.value.Name %>" href="danh-muc-xoa-<%=Lib.LocDau(item.value.Name) %>-z-<%=item.value.ID %>.htm"><i class="fa fa-times" title="Xóa"></i></a>
                        </td>
                    </tr>
                    <%}%>
                </table>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="add" runat="server" Visible="false">
        <div class="panel_from_item panel_from_item_show">
            <div class="panel_from_title"><span>Thông tin danh mục sản phẩm</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Tên danh mục</lable>
                    <span>
                        <asp:TextBox ID="txtName" runat="server" valname="email_title" no-empty Width="100%"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_file">
                    <lable>Ảnh</lable>
                    <span img-oldaaa></span>
                    <span>Tải hình ảnh lên
                    <asp:FileUpload ID="fileUpload" runat="server"/>
                    </span>
                </div>
            </div>
            <div style="clear: both; height: 50px;"></div>
            <div class="panel_from">
                <div class="panel_from_dis_panel"></div>
                <div class="panel_from_row panel_from_row_btn_submit">
                    <asp:Button ID="Action_AddNew" runat="server" Text="Thêm mới" CssClass="submit" OnClick="Action_AddNew_Click" />
                    <%--<span class="submit">Lưu thay đổi</span>--%>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $.each(typeof ListImgOld == 'undefined' ? [] : ListImgOld, function (i, item) {
                    var elClick = $('<span title="Xóa" style="background-image:url(\'<%=Lib.urlhome+"/Images/imageUpload/"%>' + item + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_old" value="' + item + '"/></span>').appendTo($('[img-oldaaa]'));
                    elClick.click(function () {
                        elClick.remove();
                    });
                });
            });
        </script>
    </asp:Panel>

    <asp:Panel ID="update" runat="server" Visible="false">
        <div class="panel_from_item panel_from_item_show">
            sad
        </div>
    </asp:Panel>
</asp:Content>

