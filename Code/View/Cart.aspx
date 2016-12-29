<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="View_Cart" %>

<%@ Register Src="~/View/CartDetail.ascx" TagPrefix="uc1" TagName="CartDetail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.header-cart-btn').unbind("click");
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <uc1:CartDetail runat="server" ID="CartDetail" />
</asp:Content>

