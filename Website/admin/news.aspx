<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="news.aspx.cs" Inherits="admin_category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('div[menu-tintuc="<%=menuActive%>"]').addClass('page-menu-group-item-active');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    


    <div class="htm_loading_page"></div>
    <asp:Panel ID="PanelMenu" runat="server" Visible="true">
        <div class="parenmenu_new">
            <div class="panel_from">
                <div class="panel_from_row panel_from_row_radio_btn">
                    <a href="<%=Enums.LoaiTinTucUrlDanhSach((Enums.LoaiTinTuc)Type) %>">
                        <input typeaction="0" type="button" value="Danh sách <%=Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type) %>" /></a>
                    <a href="<%=Enums.LoaiTinTucUrlThemMoi((Enums.LoaiTinTuc)Type) %>">
                        <input typeaction="1" type="button" value="Thêm mới <%=Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type) %>" /></a>
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
                    <input type="text" placeholder="Tìm kiếm" value="<%=Request.QueryString["seach"] %>"/>
                    <span attr-close></span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <table cellpadding="0" cellspacing="0">

                    <tr>
                        <th style="width: 50px; text-align: center;" enabled-sort>STT</th>
                        <th class="row_img"></th>
                        <th style="width: calc(100% - 550px);" enabled-sort>Tiếu đề</th>
                        <th style="width: 150px;" enabled-sort sorted="desc">Ngày tạo</th>
                        <th style="width: 150px;text-align:center;">Trạng thái</th>
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
                        <td class="row_img" style="text-align:center;">
                            <span style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');"></span>
                        </td>
                        <td style="width: calc(100% - 550px);" class="ellipsis" valdata="<%=item.value.TieuDe_Vn %>"><%=item.value.TieuDe_Vn %></td>
                        <td style="width: 150px;" class="ellipsis" valdata="<%=item.value.CreateDate.Ticks %>"><%=item.value.CreateDate.ToString("dd/MM/yyyy, HH:mm") %></td>
                        <td style="width: 150px;text-align:center;"><%=item.value.Status==1?"Hiển thị":"Ẩn" %></td>
                        <td style="width: 100px; text-align: center;" class="ellipsis">
                            <a href="<%=string.Format(Enums.LoaiTinTucUrlChinhSua((Enums.LoaiTinTuc)Type),Lib.LocDau(item.value.TieuDe_En),item.value.ID) %>"><i class="fa fa-pencil" title="Chỉnh sửa"></i></a>
                            <a delete-link="Bạn chắc chắn muốn thay đổi trạng thái từ <%=item.value.Status==(int)Enums.Status.active?"ẩn thành hiển thị":"hiển thị thành ẩn" %> <%=item.value.TieuDe_Vn %>" href="<%=string.Format(Enums.LoaiTinTucUrlTrangThai((Enums.LoaiTinTuc)Type),Lib.LocDau(item.value.TieuDe_En),item.value.ID) %>"><i class="fa fa-check-circle" title="<%=item.value.Status==1?"Ẩn":"Hiển thị" %>" style="<%=item.value.Status==1?"":"color:#CCC;" %>"></i></a>
                            <a delete-link="Bạn chắc chắn muốn xóa <%=item.value.TieuDe_Vn %>" href="<%=string.Format(Enums.LoaiTinTucUrlXoa((Enums.LoaiTinTuc)Type),Lib.LocDau(item.value.TieuDe_En),item.value.ID) %>"><i class="fa fa-times" title="Xóa"></i></a>
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
            <div class="panel_from_title"><span>Nội dung <%=Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type) %></span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Tiêu đề (Vn)</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtTitle" runat="server" no-empty Width="100%" MaxLength="200"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Tiêu đề (En)</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtTitleEn" runat="server" Width="100%" MaxLength="200"></asp:TextBox>
                    </span>
                </div>
                <asp:Panel ID="panelImg" runat="server" Visible="true">
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_file">
                        <lable>Ảnh đại diên</lable>
                        <span img-oldaaa></span>
                        <span>Tải hình ảnh lên
                        <asp:FileUpload ID="fileUpload" runat="server" no-empty dataImg/>
                        </span>
                    </div>
                </asp:Panel>
                <asp:Panel ID="PanelMucLuc" runat="server" Visible="true">
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input" panel-danhmuc>
                        <lable>Thuộc danh mục</lable>
                        <span list-checkbox>
                            <asp:CheckBoxList ID="cbCate" runat="server"></asp:CheckBoxList>
                        </span>
                    </div>
                </asp:Panel>
                <asp:Panel ID="panelGioiThieu" runat="server" Visible="true">
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable style="vertical-align:top;">Giới thiệu (Vn)</lable>
                        <span style="width: 400px;">
                            <asp:TextBox ID="txtDes" runat="server" no-empty Width="100%" MaxLength="500" TextMode="MultiLine"></asp:TextBox>
                        </span>
                    </div>
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable style="vertical-align:top;">Giới thiệu (En)</lable>
                        <span style="width: 400px;">
                            <asp:TextBox ID="txtDesEn" runat="server" Width="100%" MaxLength="500" TextMode="MultiLine"></asp:TextBox>
                        </span>
                    </div>
                </asp:Panel>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable style="vertical-align:top;">Nội dung (Vn)</lable>
                    <span style="display:inline-block;width:calc(100% - 155px);":"width:calc(100% - 450px);">
                        <asp:TextBox ID="txtChiTiet" runat="server" Width="100%" contenteditable="true" TextMode="MultiLine" no-empty Text="Nội dung tại đây."></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable style="vertical-align:top;">Nội dung (En)</lable>
                    <span style="display:inline-block;width:calc(100% - 155px);":"width:calc(100% - 450px);">
                        <asp:TextBox ID="txtChiTietEn" runat="server" Width="100%" contenteditable="true" TextMode="MultiLine" no-empty Text="Nội dung tại đây."></asp:TextBox>
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
                    $('[dataImg]').attr('valdata', item);
                    var elClick = $('<span title="Xóa" style="background-image:url(\'<%=Lib.urlhome+"/Images/imageUpload/"%>' + item + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_old" value="' + item + '"/></span>').appendTo($('[img-oldaaa]'));
                    elClick.click(function () {
                        elClick.remove();
                    });
                });
                CKEDITOR.disableAutoInline = true;
                CKEDITOR.inline('<%=txtChiTiet.ClientID %>', { customConfig: '<%=Lib.urlhome %>/admin/ckeditorNew/configmini.js', language: 'vi' });
                CKEDITOR.inline('<%=txtChiTietEn.ClientID %>', { customConfig: '<%=Lib.urlhome %>/admin/ckeditorNew/configmini.js', language: 'vi' });

                
                $('[list-checkbox] input:checkbox').change(function () {
                    var _this =  $(this);
                    $('[list-checkbox] input:checkbox').prop('checked', false);
                    _this.prop('checked', true);
                });
                $('#<%=Action_AddNew.ClientID%>').click(function () {
                    if ($('[panel-danhmuc]').size() > 0 && $('[list-checkbox] input:checkbox:checked').size() == 0) {
                        chatLinkTamFun.message(false, 'Vui lòng chọn danh mục');
                        return false;
                    }
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

