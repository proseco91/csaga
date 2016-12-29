<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="mat-hang.aspx.cs" Inherits="admin_mat_hang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('div[menu-mat-hang]').addClass('page-menu-group-item-active');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="htm_loading_page"></div>
    <div class="parenmenu_new">
        <div class="panel_from">
            <div class="panel_from_row panel_from_row_radio_btn">
                <a href="mat-hang.htm">
                    <input typeaction="0" type="button" value="Danh sách mặt hàng" /></a>
                <a href="them-moi-mat-hang.htm">
                    <input typeaction="1" type="button" value="Thêm mới mặt hàng" /></a>
            </div>
        </div>
    </div>
    <div style="clear: both; height: 50px;"></div>
    <asp:Panel ID="index" runat="server" Visible="false">
        <script type="text/javascript">
            $(document).ready(function () {
                $('.panel_search input:text').unbind("keypress").keypress(function (event) {
                    if (event.which == 13) {
                        window.location.href = "mat-hang.htm?seach=" + $(this).val();
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
                        <th style="width: 50px; text-align: center;">STT</th>
                        <th class="row_img"></th>
                        <th style="width: calc(100% - 750px);">Tên</th>
                        <th style="width: 150px;text-align: center;">Size và Color</th>
                        <th style="width: 150px;">Ngày tạo</th>
                        <th style="width: 150px;text-align:center;">Trạng thái</th>
                        <th style="width: 150px;"></th>
                    </tr>
                    <%
                        int totalRow = 0;
                        int pageSelect = 1;
                        int numInPage = 30;
                        foreach (var item in getMatHang(numInPage, out totalRow, out pageSelect).Select((value, i) => new { i, value }))
                        {
                %>
                    
                    <tr>
                        <td style="width: 50px; text-align: center;" class="ellipsis">
                            <%=((pageSelect-1)*numInPage)+(item.i+1) %>
                        </td>
                        <td class="row_img" style="text-align:center;">
                            <span style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');"></span>
                        </td>
                        <td style="width: calc(100% - 750px);" class="ellipsis"><%=item.value.ParentID==null?item.value.Title:"" %></td>
                        <td style="width: 150px;text-align: center;" class="ellipsis"><%=item.value.ColorAndSize %></td>
                        <td style="width: 150px;" class="ellipsis"><%=item.value.CreateDate.ToString("dd/MM/yyyy, HH:mm") %></td>
                        <td style="width: 150px;text-align:center;"><%=item.value.Status==1?"Hiển thị":"Ẩn" %></td>
                        <td style="width: 150px; text-align: center;" class="ellipsis">
                            <a href="mat-hang-chinh-sua-<%=Lib.LocDau(item.value.Title) %>-z-<%=item.value.ID %>.htm"><i class="fa fa-pencil" title="Chỉnh sửa"></i></a>
                            <%if (item.value.Category != null)
                              { %>
                            <a href="mat-hang-them-<%=Lib.LocDau(item.value.Title) %>-z-<%=item.value.ID %>.htm"><i class="fa fa-plus" title="Thêm"></i></a>
                            <%}%>
                            <a delete-link="Bạn chắc chắn muốn thay đổi trạng thái từ <%=item.value.Status==0?"ẩn thành hiển thị":"hiển thị thành ẩn" %> <%=item.value.Title %>" href="mat-hang-trangthai-<%=Lib.LocDau(item.value.Title) %>-z-<%=item.value.ID %>.htm"><i class="fa fa-check-circle" title="<%=item.value.Status==1?"Ẩn":"Hiển thị" %>" style="<%=item.value.Status==1?"":"color:#CCC;" %>"></i></a>
                            <a delete-link="Bạn chắc chắn muốn xóa <%=item.value.Title %>" href="mat-hang-xoa-<%=Lib.LocDau(item.value.Title) %>-z-<%=item.value.ID %>.htm"><i class="fa fa-times" title="Xóa"></i></a>
                        </td>
                    </tr>
                        <%
                            bool isFirst = true;
                            foreach (var itemChi in item.value.MatHangs)
                          {
                                
                                %>
                             <tr>
                                <td style="width: 50px; text-align: center;position:relative;">
                                    <div style="position:absolute;background-color:#FFF;width:100%;height:calc(100% + 1px);"></div>
                                    <div style="position:absolute;height:50%;width:50%;left:50%;top:0px;border-bottom:1px dotted #CCC;"></div>
                                    <div style="position:absolute;<%=isFirst?"height:50%;top:0px":"height:100%;top:-50%"%>;width:1px;left:50%;border-right:1px dotted #CCC;"></div>
                                </td>
                                <td class="row_img" style="text-align:center;">
                                    <span style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+itemChi.Img%>');"></span>
                                </td>
                                <td style="width: calc(100% - 750px);" class="ellipsis"></td>
                                <td style="width: 150px;text-align: center;" class="ellipsis"><%=itemChi.ColorAndSize %></td>
                                <td style="width: 150px;" class="ellipsis"><%=itemChi.CreateDate.ToString("dd/MM/yyyy, HH:mm") %></td>
                                <td style="width: 150px;text-align:center;"><%=itemChi.Status==1?"Hiển thị":"Ẩn" %></td>
                                <td style="width: 150px; text-align: center;" class="ellipsis">
                                    <a href="mat-hang-chinh-sua-<%=Lib.LocDau(item.value.Title) %>-z-<%=itemChi.ID %>.htm"><i class="fa fa-pencil" title="Chỉnh sửa"></i></a>
                                    <a delete-link="Bạn chắc chắn muốn thay đổi trạng thái từ <%=itemChi.Status==0?"ẩn thành hiển thị":"hiển thị thành ẩn" %> <%=item.value.Title %>" href="mat-hang-trangthai-<%=Lib.LocDau(item.value.Title) %>-z-<%=itemChi.ID %>.htm"><i class="fa fa-check-circle" title="<%=itemChi.Status==1?"Ẩn":"Hiển thị" %>" style="<%=itemChi.Status==1?"":"color:#CCC;" %>"></i></a>
                                    <a delete-link="Bạn chắc chắn muốn xóa <%=item.value.Title %>" href="mat-hang-xoa-<%=Lib.LocDau(item.value.Title) %>-z-<%=itemChi.ID %>.htm"><i class="fa fa-times" title="Xóa"></i></a>
                                </td>
                            </tr>
                        <%
                              isFirst = false;
                          }
                          %>
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
            <div class="panel_from_title"><span><asp:Label ID="LabelTitle" runat="server" Text="Label"></asp:Label></span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <asp:Panel ID="PanelThemSize1" runat="server" Visible="true">
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable>Tên sản phẩm</lable>
                        <span style="width: 400px;">
                            <asp:TextBox ID="txtTitle" runat="server" no-empty Width="100%" MaxLength="500"></asp:TextBox>
                        </span>
                    </div>
                </asp:Panel>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_file">
                    <lable>Ảnh sản phẩm</lable>
                    <span img-oldaaa></span>
                    <span>Tải hình ảnh lên
                    <asp:FileUpload ID="fileUpload" runat="server" no-empty/>
                    </span>
                </div>
                <asp:Panel ID="PanelThemSize2" runat="server" Visible="true">
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable>Thuộc danh mục</lable>
                        <span list-checkbox>
                            <asp:CheckBoxList ID="cbCate" runat="server"></asp:CheckBoxList>
                        </span>
                    </div>

                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable>Giá</lable>
                        <span>
                            <asp:TextBox ID="txtMoney" runat="server" no-empty Width="100%" MaxLength="9" valtype="money"></asp:TextBox>
                        </span>
                    </div>
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable>Giá giảm</lable>
                        <span>
                            <asp:TextBox ID="txtGiaGiam" runat="server" Width="100%" MaxLength="9" valtype="money"></asp:TextBox>
                        </span>
                    </div>
                    
                </asp:Panel>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Màu và kích cỡ</lable>
                    <span>
                        <asp:TextBox ID="txtColorAndSize" runat="server" Width="100%"></asp:TextBox>
                    </span>
                </div>
                <asp:Panel ID="PanelThemSize3" runat="server" Visible="true">
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable style="vertical-align:top;">Giới thiệu</lable>
                        <span style="display:inline-block;width:calc(100% - 155px);":"width:calc(100% - 450px);">
                            <asp:TextBox ID="txtChiTiet" runat="server" Width="100%" contenteditable="true" TextMode="MultiLine" no-empty Text="Nội dung tại đây."></asp:TextBox>
                        </span>
                    </div>
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

                $.each(typeof ListImgOld == 'undefined' ? [] : ListImgOld, function (i, item) {
                    $('#<%=fileUpload.ClientID%>').attr('valdata', item);
                    var elClick = $('<span title="Xóa" style="background-image:url(\'<%=Lib.urlhome+"/Images/imageUpload/"%>' + item + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:cover;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_old" value="' + item + '"/></span>').appendTo($('[img-oldaaa]'));
                    elClick.click(function () {
                        elClick.remove();
                    });
                });
                CKEDITOR.disableAutoInline = true;
                CKEDITOR.inline('<%=txtChiTiet.ClientID %>', { customConfig: '<%=Lib.urlhome %>/admin/ckeditorNew/configmini.js', language: 'vi' });

                $('[list-checkbox] [isparent="False"]').each(function () {
                    $(this).parent('td').css({ 'padding-left': '20px' });
                });
                $('[list-checkbox] input:checkbox').change(function () {
                    var parent = $(this).parent('span');

                    if (parent.attr('isparent') == 'False' && $(this).prop('checked')) {
                        $('span[valid="' + parent.attr('valparent') + '"]').children('input:checkbox').prop('checked', true);
                    } else if (parent.attr('isparent') == 'True') {
                        if ($('span[valparent="' + parent.attr('valid') + '"] input:checkbox:checked').size() > 0 && !$(this).prop('checked')) {
                            $(this).prop('checked', true);
                        }
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

