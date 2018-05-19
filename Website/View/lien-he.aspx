<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="lien-he.aspx.cs" Inherits="View_lien_he" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div class="panel_1k2" id="viewnews" style="background-color: rgba(255,255,255,0.8); padding: 20px 0px;">
        <div class="cate-link" style="margin-top: 0px; padding-left: 10px;">
            <span class="item-link-cate">
                <a href="<%=Lib.urlhome %>">Trang chủ</a>
            </span>
            <span class="item-link-cate">
                Liên hệ 2
            </span>
        </div>
        <div style="padding:10px;">
            <div style="text-align:left;font-size:14px;margin-bottom:10px;">
                <b><%=Lib.ContentLag("Địa chỉ: ","Address: ") %></b><%=sql.getSettingWeb().DiaChi %>
            </div>
            <div style="text-align:left;font-size:14px;margin-bottom:10px;">
                <b><%=Lib.ContentLag("Điện thoại: ","Phone: ") %></b><%=sql.getSettingWeb().DienThoai %>
            </div>
            <div style="text-align:left;font-size:14px;margin-bottom:10px;">
                <b><%=Lib.ContentLag("Fax: ","Fax: ") %></b><%=sql.getSettingWeb().Fax %>
            </div>
            <div style="text-align:left;font-size:14px;margin-bottom:10px;">
                <b><%=Lib.ContentLag("Thư điện tử: ","Email: ") %></b><%=sql.getSettingWeb().Email %>
            </div>
        </div>
        <div style="clear: both; height: 50px;"></div>

    </div>

</asp:Content>

