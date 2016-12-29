<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="SanPhamDanhMuc.aspx.cs" Inherits="View_SanPhamDanhMuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#sortBy').change(function () {
                window.location.href = '<%=Lib.urlhome+"/collections/electrionics"%>?sort=' + $(this).val();
            }).val('<%=sort%>');
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <nav aria-label="breadcrumbs" role="navigation" class="breadcrumb">
        <a title="Back to the frontpage" href="<%=Lib.urlhome %>">Home</a>
        <span aria-hidden="true" class="divider">›</span>
        <span><%=_cate.Name %></span>
    </nav>
    <div class="grid grid-border">
        <div class="grid-item large--four-fifths" style="width: 100%;">
            <header class="section-header">
                <h1 class="section-header--title section-header--left"><%=_cate.Name %></h1>
                <div class="section-header--right">
                    <div class="form-horizontal">
                        <label class="small--hide" for="sortBy">Sort by</label>
                        <select id="sortBy" name="sortBy">
                            <option value="title-ascending">Alphabetically, A-Z</option>
                            <option value="title-descending">Alphabetically, Z-A</option>
                            <option value="price-ascending">Price, low to high</option>
                            <option value="price-descending">Price, high to low</option>
                            <option value="created-descending">Date, new to old</option>
                            <option value="created-ascending">Date, old to new</option>
                        </select>
                    </div>
                    <button class="btn btn--small right toggle-filters" id="toggleFilters">Filters</button>

                </div>
            </header>
            <div class="grid-uniform row-negative-bottom">
                <%foreach (var sp in getMatHangByCate())
                  {%>

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
                <%}%>
            </div>
        </div>
    </div>
</asp:Content>

