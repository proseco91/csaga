<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="View_Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.search-bar input:text').val('<%=q%>');
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <h2 class="text-center">Your search for "<%=q %>" revealed the following</h2>
    <div class="grid-uniform row-negative-bottom">
        <%foreach (var sp in getMatHangSearch())
          {
              string[] arrcate = sp.Category.Split(',').Where(d => !string.IsNullOrEmpty(d)).ToArray() ;
              Category _cate = sql.Category().Where(d => arrcate.Contains(d.ID)).FirstOrDefault();
        %>
        <div class="grid-item large--one-fifth medium--one-third small--one-half on-sale">
            <a class="product-grid-item" href="<%=Lib.urlhome+"/collections/"+Lib.LocDau(_cate.Name)+"/products/"+Lib.LocDau(sp.Title)+"/"+sp.ID%>">
                <div class="product-grid-image" style="height: 221px;">
                    <div class="product-grid-image--centered">
                        <img alt="<%=sp.Title %>" src="<%=Lib.urlhome+"/images/imageupload/"+sp.Img %>">
                    </div>
                </div>
                <p><%=sp.Title %></p>
                <div class="product-item--price">
                    <span class="h1 medium--left" style="display: inline-block; margin-right: 5px;">
                        <small>$<%=Lib.formatMoney(sp.GiamGia.HasValue &&  sp.GiamGia.Value>0?sp.GiaBan - sp.GiamGia.Value:sp.GiaBan) %></small>
                    </span>
                    <%=(sp.GiamGia.HasValue &&  sp.GiamGia.Value>0?"<span class=\"sale-tag medium--right\">Save $"+sp.GiamGia.Value+"</span>":"") %>
                </div>
            </a>
        </div>
        <%} %>
    </div>
</asp:Content>

