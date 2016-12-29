<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="ChiTietSanPham.aspx.cs" Inherits="View_ChiTietSanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.product-photo-thumb[valid]').click(function () {
                $('#productPhotoImg').attr('src', $(this).attr('href'))
                return false;
            });
            $('#sizeandcolorselect').change(function () {
                $('.product-photo-thumb[valid="' + $(this).val() + '"]').click();
                $('#addToCart').attr('valid', $(this).val());
            }).change();

            $('#addToCart').click(function () {
                lib.add_cart($(this).attr('valid'));
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">

    <nav aria-label="breadcrumbs" role="navigation" class="breadcrumb">
        <a title="Back to the frontpage" href="<%=Lib.urlhome %>">Home</a>
        <span aria-hidden="true" class="divider">›</span>
        <a style="text-transform: capitalize;" title="" href="<%=Lib.urlhome %>/collections/<%=Lib.LocDau(_cate.Name) %>"><%=_cate.Name %></a>
        <span aria-hidden="true" class="divider">›</span>
        <span class="breadcrumb--truncate"><%=data.Title %></span>
    </nav>
    <div>
        <div class="grid-item large--two-fifths">
            <div class="grid">
                <div class="grid-item large--eleven-twelfths text-center">
                    <div id="productPhoto" class="product-photo-container">
                        <img alt="<%=data.Title %>" src="<%=Lib.urlhome+"/images/imageupload/"+data.Img %>" id="productPhotoImg">
                    </div>
                    <ul id="productThumbs" class="product-photo-thumbs grid-uniform">

                        <li class="grid-item medium-down--one-quarter large--one-quarter">
                            <a class="product-photo-thumb" href="<%=Lib.urlhome+"/images/imageupload/"+data.Img %>" valid="<%=data.ID %>">
                                <img alt="<%=data.Title %>" src="<%=Lib.urlhome+"/images/imageupload/"+data.Img %>">
                            </a>
                        </li>
                        <%foreach (var item in data.MatHangs)
                          {%>
                        <li class="grid-item medium-down--one-quarter large--one-quarter">
                            <a class="product-photo-thumb" href="<%=Lib.urlhome+"/images/imageupload/"+item.Img %>" valid="<%=item.ID %>">
                                <img alt="<%=data.Title %>" src="<%=Lib.urlhome+"/images/imageupload/"+item.Img %>">
                            </a>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>

        </div>

        <div class="grid-item large--three-fifths">

            <h2 itemprop="name"><%=data.Title %></h2>
            <div>
                <ul class="inline-list product-meta">
                    <li>
                        <span class="h1" id="productPrice"><%=data.Money() %><sup>00</sup></span>
                    </li>
                    <li>
                        <%=(data.GiamGia.HasValue &&  data.GiamGia.Value>0?"<span class=\"sale-tag large\" id=\"comparePrice\">Save $"+data.GiamGia.Value+"</span>":"") %>
                    </li>
                </ul>

                <hr class="hr--small" id="variantBreak">
                <%if (data.ColorAndSize != null)
                  { %>
                <div id="addToCartForm">
                    <div class="selector-wrapper">
                        <label>Color/Size</label>
                        <select class="single-option-selector" id="sizeandcolorselect">
                            <option value="<%=data.ID %>"><%=data.ColorAndSize %></option>
                            <%foreach (var item in data.MatHangs)
                              {%>
                            <option value="<%=item.ID %>"><%=item.ColorAndSize %></option>
                            <%} %>
                        </select>
                    </div>
                    <button class="btn" id="addToCart" name="add" type="button" valid="<%=data.ID %>">
                        <span class="icon icon-cart"></span>
                        <span id="addToCartText">Add to Cart</span>
                    </button>
                </div>
                <hr>
                <%}%>
            </div>
            <div itemprop="description" class="product-description rte">
                <%=data.ChiTiet %>
            </div>

        </div>
    </div>
    <hr>
    <div class="section-header">
        <p class="h1 section-header--left">We Also Recommend</p>

    </div>
    <div class="grid-uniform row-negative-bottom">
        <%foreach (var sp in getMatHangKhac())
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
                        <small><%=sp.GiamGia.HasValue &&  sp.GiamGia.Value>0?sp.GiaBan - sp.GiamGia.Value:sp.GiaBan %><sup>00</sup></small>
                    </span>
                    <%=(sp.GiamGia.HasValue &&  sp.GiamGia.Value>0?"<span class=\"sale-tag medium--right\">Save $"+sp.GiamGia.Value+"</span>":"") %>
                </div>
            </a>
        </div>
        <%}%>
    </div>
</asp:Content>

