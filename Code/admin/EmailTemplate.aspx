<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master"
    AutoEventWireup="true" CodeFile="EmailTemplate.aspx.cs" Inherits="admin_EmailTemplate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {
            $('div[menu-mail]').addClass('page-menu-group-item-active');

            
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
                        <th style="width: calc(50% - 170px);">ID</th>
                        <th style="width: calc(50%);">Tiêu đề</th>
                        <th style="width: 100px;"></th>
                    </tr>
                    <%foreach (var item in sql.EmailTemplate().Select((value, index) => new { value, index }))
                      {%>
                    <tr>
                        <td style="width: 50px; text-align: center;"><%=item.index+1 %></td>
                        <td style="width: calc(50% - 170px);"><%=item.value.EmailTitleGoc %></td>
                        <td style="width: calc(50%);"><%=item.value.EmailTitle %></td>
                        <td style="width: 100px;">
                            <a href="email-template-<%=item.value.ID %>.htm"><i class="fa fa-pencil" title="Chỉnh sửa"></i></a>
                        </td>
                    </tr>
                    <%}%>
                </table>
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
                        <span style="border-bottom: 1px solid #ddd;display: block;font-size: 11px;margin: 0;padding: 5px 0;">
                            <span style="display: inline-block;padding-left: 5px;vertical-align: top;width: 50%;"><%=item["title"] %></span>
                            <span style="display: inline-block;padding: 0 5px;vertical-align: top;width: calc(50% - 15px);font-weight:bold;"><%=item["content"] %></span>
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

