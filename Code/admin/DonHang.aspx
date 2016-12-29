<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master"
    AutoEventWireup="true" CodeFile="DonHang.aspx.cs" Inherits="admin_EmailTemplate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {
            $('div[menu-don-hang]').addClass('page-menu-group-item-active');


        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="htm_loading_page"></div>
    <div style="clear: both; height: 0px;"></div>
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
                        <th style="width: 50px; text-align: center;">STT</th>
                        <th style="width: calc(100% - 594px);">Địa chỉ</th>
                        <th style="width: 100px; text-align: center;">Số món hàng</th>
                        <th style="width: 120px; text-align: right;">Tổng tiền</th>
                        <th style="width: 100px; text-align: center;">Trạng thái</th>
                        <th style="width: 150px; text-align: center;">Ngày đặt</th>
                        <th style="width: 50px;"></th>
                    </tr>
                    <%
                        int totalRow = 0;
                        int pageSelect = 1;
                        int numInPage = 30;
                        foreach (var item in getDonHang(numInPage, out totalRow, out pageSelect).Select((value, i) => new { i, value }))
                        {
                    %>
                    <tr>
                        <td style="width: 50px; text-align: center;"><%=((pageSelect-1)*numInPage)+(item.i+1) %></td>
                        <td style="width: calc(100% - 594px);"><%=Lib.getShippingAddress(item.value.Shipping_Address) %></td>
                        <td style="width: 100px; text-align: center;"><%=item.value.TotalItems %></td>
                        <td style="width: 120px; text-align: right;">$<%=Lib.formatMoney(item.value.TotalMoney) %></td>
                        <td style="width: 100px; text-align: center;"><%=item.value.Status==0?"Chưa xử lý":"Đã xử lý" %></td>
                        <td style="width: 150px; text-align: center;"><%=item.value.CreateDate.ToString("dd/MM/yyyy, HH:mm:ss") %></td>
                        <td style="width: 50px;text-align:center;">
                            <a href="don-hang-<%=Lib.LocDau(item.value.ID) %>.htm"><i class="fa fa-pencil" title="Chi tiết"></i></a>
                        </td>
                    </tr>

                    <%} %>
                </table>
                <div style="clear: both; height: 20px;"></div>
                <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5)%>
                <div style="clear: both;"></div>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="add" runat="server" Visible="false">
        <div class="panel_from_item panel_from_item_show">

            <div class="panel_from_title"><span>Chỉnh sửa email loại '<%=_dataSelect!=null?_dataSelect.EmailTitleGoc:"" %>'</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">

                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Tiêu đề</lable>
                    <span style="display: inline-block; width: calc(100% - 155px);">
                        <asp:TextBox ID="txtName" runat="server" valname="email_title" no-empty Width="100%"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable style="vertical-align: top;">Nội dung</lable>
                    <span style="display: inline-block; width: calc(100% - 450px);">
                        <asp:TextBox ID="txtContent" runat="server" valname="email_content" Width="100%" contenteditable="true" TextMode="MultiLine" no-empty Text="Nội dung tại đây."></asp:TextBox>
                    </span>
                    <span style="display: inline-block; width: 290px; border: 1px solid #DDD; vertical-align: top; border-bottom: none;">
                        <%foreach (var item in _dataDes)
                          {%>
                        <span style="border-bottom: 1px solid #ddd; display: block; font-size: 11px; margin: 0; padding: 5px 0;">
                            <span style="display: inline-block; padding-left: 5px; vertical-align: top; width: 50%;"><%=item["title"] %></span>
                            <span style="display: inline-block; padding: 0 5px; vertical-align: top; width: calc(50% - 15px); font-weight: bold;"><%=item["content"] %></span>
                        </span>
                        <%}%>
                    </span>
                </div>
            </div>

            <div style="clear: both; height: 50px;"></div>
            <div class="panel_from">
                <div class="panel_from_dis_panel"></div>
                <div class="panel_from_row panel_from_row_btn_submit">
                    <asp:Button ID="Action_AddNew" runat="server" Text="Cập nhật" CssClass="submit" OnClick="Action_AddNew_Click" />
                    <%--<span class="submit">Lưu thay đổi</span>--%>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                CKEDITOR.disableAutoInline = true;
                CKEDITOR.inline('<%=txtContent.ClientID %>', { customConfig: '<%=Lib.urlhome %>/admin/ckeditorNew/configmini.js', language: 'vi' });
            });
        </script>
    </asp:Panel>

</asp:Content>

