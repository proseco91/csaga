<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="khong-co-quyen.aspx.cs" Inherits="admin_khong_co_quyen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .alertmessage-lintam
        {
            text-align:center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%=Lib.createInfoLinkTam("<b>"+Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)Type)+"</b></br>Bạn không có quyền xử dụng",false) %>
</asp:Content>

