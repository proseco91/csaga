<%@ page title="" language="C#" masterpagefile="~/admin/Masster/MasterPage.master" autoeventwireup="true" inherits="admin_admin, App_Web_zoiubtqi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('div[menu-account]').addClass('page-menu-group-item-active');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    


    <div class="htm_loading_page"></div>
    <asp:Panel ID="PanelMenu" runat="server" Visible="true">
        <div class="parenmenu_new">
            <div class="panel_from">
                <div class="panel_from_row panel_from_row_radio_btn">
                    <a href="tai-khoan-quan-tri.htm">
                        <input typeaction="0" type="button" value="Danh sách tài khoản quản trị" /></a>
                    <a href="them-moi-tai-khoan-quan-tri.htm">
                        <input typeaction="1" type="button" value="Thêm mới tài khoản quản trị" /></a>
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
                        <th style="width: calc(100% - 675px);" enabled-sort>Tên</th>
                        <th style="width: 200px;" enabled-sort>Email</th>
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
                        
                        <td style="width: calc(100% - 675px);" class="ellipsis" valdata="<%=item.value.FullName %>"><%=item.value.FullName %></td>
                        <td style="width: 200px;" class="ellipsis" valdata="<%=item.value.Email%>"><%=item.value.Email %></td>
                        <td style="width: 150px;" class="ellipsis" valdata="<%=item.value.CreateDate.Ticks %>"><%=item.value.CreateDate.ToString("dd/MM/yyyy, HH:mm") %></td>
                        <td style="width: 150px;text-align:center;"><%=item.value.Status==1?"Hiển thị":"Ẩn" %></td>
                        <td style="width: 100px; text-align: center;" class="ellipsis">
                            <a href="<%=string.Format(Enums.LoaiTinTucUrlChinhSua((Enums.LoaiTinTuc.Account)),Lib.LocDau(item.value.Email),item.value.ID) %>"><i class="fa fa-pencil" title="Chỉnh sửa"></i></a>
                            <a delete-link="Bạn chắc chắn muốn thay đổi trạng thái từ <%=item.value.Status==(int)Enums.Status.active?"ẩn thành hiển thị":"hiển thị thành ẩn" %> <%=item.value.Email %>" href="<%=string.Format(Enums.LoaiTinTucUrlTrangThai((Enums.LoaiTinTuc.Account)),Lib.LocDau(item.value.Email),item.value.ID) %>"><i class="fa fa-check-circle" title="<%=item.value.Status==1?"Ẩn":"Hiển thị" %>" style="<%=item.value.Status==1?"":"color:#CCC;" %>"></i></a>
                            <a delete-link="Bạn chắc chắn muốn xóa <%=item.value.Email %>" href="<%=string.Format(Enums.LoaiTinTucUrlXoa((Enums.LoaiTinTuc.Account)),Lib.LocDau(item.value.Email),item.value.ID) %>"><i class="fa fa-times" title="Xóa"></i></a>
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
                    <lable>Email</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtEmail" runat="server" no-empty Width="100%" MaxLength="200" valtype="email"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Tên đầy đủ</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtFullName" runat="server" no-empty Width="100%" MaxLength="200" ></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Mật khẩu</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtPassword" runat="server" no-empty Width="100%" MaxLength="200" TextMode="Password"></asp:TextBox>
                    </span>
                </div>
                
                <asp:Panel ID="PanelMucLuc" runat="server" Visible="true">
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input" panel-danhmuc>
                        <lable>Quyền của account</lable>
                        <span list-checkbox>
                            <asp:CheckBoxList ID="cbCate" runat="server"></asp:CheckBoxList>
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
               
                
                
            });
        </script>
    </asp:Panel>

    <asp:Panel ID="update" runat="server" Visible="false">
        <div class="panel_from_item panel_from_item_show">
            sad
        </div>
    </asp:Panel>
</asp:Content>

