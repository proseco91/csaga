<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="View_Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        #heroSlider .flex-viewport img {
            opacity: 0;
            -webkit-transition: opacity 1s ease-out 0s;
            -moz-transition: opacity 1s ease-out 0s;
            -o-transition: opacity 1s ease-out 0s;
            transition: opacity 1s ease-out 0s;
            position:absolute;
            width:100%;
            height:100%;
        }
        #heroSlider .flex-viewport img.active {
            opacity: 1;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            var _heroSlider = $('#heroSlider');
            $('#heroSlider .flex-control-paging li').click(function () {
                var _index = $(this).index();
                $('#heroSlider .flex-viewport img').removeClass('active').eq(_index).addClass('active');
                $('#heroSlider .flex-control-paging li a').removeClass('flex-active');
                $(this).children('a').addClass('flex-active');
                _heroSlider.attr('valindex', _index);
            }).eq(0).click();
            $('#heroSlider .flex-direction-nav .flex-prev').click(function () {
                var _index = parseInt(_heroSlider.attr('valindex')) - 1;
                if (_index < 0)
                    _index = parseInt(_heroSlider.attr('valmax'))-1;
                $('#heroSlider .flex-control-paging li').eq(_index).click();
                return false;
            });
            $('#heroSlider .flex-direction-nav .flex-next').click(function () {
                var _index = parseInt(_heroSlider.attr('valindex')) + 1;
                if (_index >= parseInt(_heroSlider.attr('valmax')))
                    _index = 0;
                $('#heroSlider .flex-control-paging li').eq(_index).click();
                return false;
            });
            setInterval(function () {
                $('#heroSlider .flex-direction-nav .flex-next').click();
            }, 5000);
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">

    <% 
        string[] arrSlider = sql.GetSetting().Slider.Split(',').Where(d => !string.IsNullOrEmpty(d)).ToArray();
    %>
    <div id="heroSlider" class="flexslider" valindex="0" valmax="<%=arrSlider.Count() %>">
        <div class="flex-viewport" style="overflow: hidden; position: relative; height: 313px;">
            <%foreach (var item in arrSlider)
              {%>
            <img src="<%=Lib.urlhome+"/images/imageupload/"+item %>" />
            <%}%>
        </div>
        <ol class="flex-control-nav flex-control-paging">
            <%for (int i = 0; i < arrSlider.Length; i++)
              {%>
            <li><a class="<%=i==0?"flex-active":"" %>"></a></li>
            <%}%>
        </ol>
        <ul class="flex-direction-nav">
            <li><a href="#" class="flex-prev">Previous</a></li>
            <li><a href="#" class="flex-next">Next</a></li>
        </ul>
    </div>
    <hr>
    <%--<div class="section-header">
        <h2 class="h1 section-header--left">Shop For</h2>
        <div class="section-header--right">
            <a href="/collections">More categories ›</a>
        </div>
    </div>--%>
    <div class="grid-uniform text-center row-negative-bottom">
        <%foreach (var item in _Category)
          {%>
        <div class="grid-item small--one-half medium--one-third large--one-sixth">
            <a class="featured-box" title="Browse our Nutrition collection" href="<%=Lib.urlhome+"/collections/"+Lib.LocDau(item.Name) %>" style="height: 213px;">
                <div class="featured-box--inner">
                    <div class="featured-box--image" style="height: 153px;">
                        <img alt="Nutrition" src="<%=Lib.urlhome+"/Images/ImageUpload/"+item.Img %>">
                    </div>
                </div>
                <span class="featured-box--title"><%=item.Name %></span>
            </a>
        </div>
        <%}%>
    </div>
    <%
        foreach (var item in SanPhamIndex)
        {
            Category _cate = _Category.Where(d => d.ID == item.Key).FirstOrDefault();  
    %>
    <hr>
    <div class="section-header">
        <p class="h1 section-header--left"><%=_cate.Name %></p>
        <div class="section-header--right">
            <a href="<%=Lib.urlhome+"/collections/"+Lib.LocDau(_cate.Name) %>">More <%=_cate.Name.ToLower() %> ›</a>
        </div>
    </div>
    <div class="grid-uniform row-negative-bottom">
        <%foreach (var sp in item.Value)
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
    <%}%>
</asp:Content>

