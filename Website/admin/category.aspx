<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="category.aspx.cs" Inherits="admin_category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('div[menu-category="<%=menuActive%>"]').addClass('page-menu-group-item-active');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <div class="htm_loading_page"></div>
    <asp:Panel ID="PanelMenu" runat="server" Visible="true">
        <div class="parenmenu_new">
            <div class="panel_from">
                <div class="panel_from_row panel_from_row_radio_btn">
                    <a href="<%=Enums.MucLucUrlDanhSach((Enums.LoaiTinTuc)Type) %>">
                        <input typeaction="0" type="button" value="Danh sách <%=Enums.MucLucDesc((Enums.LoaiTinTuc)Type) %>" /></a>
                    <a href="<%=Enums.MucLucUrlThemMoi((Enums.LoaiTinTuc)Type) %>">
                        <input typeaction="1" type="button" value="Thêm mới <%=Enums.MucLucDesc((Enums.LoaiTinTuc)Type) %>" /></a>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div style="clear: both; height: 50px;"></div>
    <asp:Panel ID="index" runat="server" Visible="false">
        <script type="text/javascript">
            $(document).ready(function () {
                $('.panel_search input:text').unbind("keypress").keypress(function (event) {
                    if (event.which == 13) {
                        window.location.href = "tin-tuc.htm?seach=" + $(this).val();
                        event.preventDefault();
                    }
                });
            });
        </script>
        <div class="panel_from_item panel_from_item_show">
            <div class="style_table">
                <div class="panel_search" action-default>
                    <input type="text" placeholder="Tìm kiếm" value="<%=Request.QueryString["seach"] %>" />
                    <span attr-close></span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <table cellpadding="0" cellspacing="0">

                    <tr>
                        <th style="width: 50px; text-align: center;" enabled-sort>STT</th>
                        <th style="width: calc(100% - 550px);" enabled-sort>Tên</th>
                        <th style="width: 150px;" enabled-sort sorted="desc">Ngày tạo</th>
                        <th style="width: 150px; text-align: center;">Trạng thái</th>
                        <th style="width: 100px;"></th>
                    </tr>
                    <%
                        int totalRow = 0;
                        int pageSelect = 1;
                        int numInPage = 30;
                        foreach (var item in getTinTuc(numInPage, out totalRow, out pageSelect).Select((value, i) => new { i, value }))
                        {
                    %>

                    <tr>
                        <td style="width: 50px; text-align: center;" class="ellipsis">
                            <%=((pageSelect-1)*numInPage)+(item.i+1) %>
                        </td>
                        <td style="width: calc(100% - 550px);" class="ellipsis" valdata="<%=item.value.TieuDe_Vn %>"><%=item.value.TieuDe_Vn %></td>
                        <td style="width: 150px;" class="ellipsis" valdata="<%=item.value.CreateDate.Ticks %>"><%=item.value.CreateDate.ToString("dd/MM/yyyy, HH:mm") %></td>
                        <td style="width: 150px; text-align: center;"><%=item.value.Status==1?"Hiển thị":"Ẩn" %></td>
                        <td style="width: 100px; text-align: center;" class="ellipsis">
                            <a href="<%=string.Format(Enums.MucLucUrlChinhSua((Enums.LoaiTinTuc)Type),Lib.LocDau(item.value.TieuDe_En),item.value.ID) %>"><i class="fa fa-pencil" title="Chỉnh sửa"></i></a>
                            <a delete-link="Bạn chắc chắn muốn thay đổi trạng thái từ <%=item.value.Status==(int)Enums.Status.active?"ẩn thành hiển thị":"hiển thị thành ẩn" %> <%=item.value.TieuDe_Vn %>" href="<%=string.Format(Enums.MucLucUrlTrangThai((Enums.LoaiTinTuc)Type),Lib.LocDau(item.value.TieuDe_En),item.value.ID) %>"><i class="fa fa-check-circle" title="<%=item.value.Status==1?"Ẩn":"Hiển thị" %>" style="<%=item.value.Status==1?"": "color:#CCC;" %>"></i></a>
                            <a delete-link="Bạn chắc chắn muốn xóa <%=item.value.TieuDe_Vn %>" href="<%=string.Format(Enums.MucLucUrlXoa((Enums.LoaiTinTuc)Type),Lib.LocDau(item.value.TieuDe_En),item.value.ID) %>"><i class="fa fa-times" title="Xóa"></i></a>
                        </td>
                    </tr>
                    <%}%>
                </table>
                <div style="clear: both; height: 20px;"></div>
                <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5)%>
                <div style="clear: both;"></div>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="add" runat="server" Visible="false">
        <div class="panel_from_item panel_from_item_show">
            <div class="panel_from_title"><span>Nội dung <%=Enums.MucLucDesc((Enums.LoaiTinTuc)Type) %></span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable><%=Type==(int)Enums.LoaiTinTuc.CacNhomNuyeuNu?"Tên nhóm (Vn)": "Tiêu đề (Vn)"%> </lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtTitle" runat="server" no-empty Width="100%" MaxLength="200"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable><%=Type==(int)Enums.LoaiTinTuc.CacNhomNuyeuNu?"Tên nhóm (En)": "Tiêu đề (En)"%> </lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtTitleEn" runat="server" Width="100%" MaxLength="200"></asp:TextBox>
                    </span>
                </div>
                <asp:Panel ID="panelNhom" runat="server" Visible="false">
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable>Trưởng nhóm</lable>
                        <span style="width: 400px;">
                            <asp:TextBox ID="txtTruongNhom" runat="server" no-empty Width="100%" MaxLength="200"></asp:TextBox>
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
                        <lable>Email</lable>
                        <span style="width: 400px;">
                            <asp:TextBox ID="txtEmail" runat="server" no-empty Width="100%" MaxLength="400"></asp:TextBox>
                        </span>
                    </div>
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable>Điện thoại</lable>
                        <span style="width: 400px;">
                            <asp:TextBox ID="txtDienThoai" no-empty runat="server" Width="100%" MaxLength="400"></asp:TextBox>
                        </span>
                    </div>
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_file">
                        <lable>Ảnh đại diên</lable>
                        <span img-oldaaa></span>
                        <span>Tải hình ảnh lên
                        <asp:FileUpload ID="fileUpload" runat="server" no-empty dataImg />
                        </span>
                    </div>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            $.each(typeof ListImgOld == 'undefined' ? [] : ListImgOld, function (i, item) {
                                $('[dataImg]').attr('valdata', item);
                                var elClick = $('<span title="Xóa" style="background-image:url(\'<%=Lib.urlhome+"/Images/imageUpload/"%>' + item + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_old" value="' + item + '"/></span>').appendTo($('[img-oldaaa]'));
                                elClick.click(function () {
                                    elClick.remove();
                                });
                            });
                        });
                    </script>
                </asp:Panel>
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

            });
        </script>
    </asp:Panel>

    <asp:Panel ID="update" runat="server" Visible="false">
        <div class="panel_from_item panel_from_item_show">
        </div>
    </asp:Panel>
</asp:Content>

