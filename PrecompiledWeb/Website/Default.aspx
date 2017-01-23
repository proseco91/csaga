<%@ page title="" language="C#" masterpagefile="~/Masster/Home.master" autoeventwireup="true" inherits="_Default, App_Web_gjwi4y1f" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .item-home
        {
            width: 300px;
            display: inline-block;
            padding: 20px;
            margin: 0px;
            box-sizing: border-box;
            margin: 30px 0px;
        }

            .item-home .item-home-hover
            {
                height: 135px;
                position: relative;
            }

            .item-home .item-home-icon
            {
                height: 135px;
                width: 100%;
                background-position: center center;
                background-repeat: no-repeat;
                background-size: contain;
            }

            .item-home .item-home-text
            {
                height: 135px;
                width: 100%;
                background-color: #EEE;
                padding: 10px;
                box-sizing: border-box;
            }

            .item-home .item-home-name
            {
                color: #212d42;
                font-size: 24px;
                text-align: center;
                margin-top: 20px;
            }




        /* flip the pane when hovered */
        .flip-container:hover .flipper, .flip-container.hover .flipper
        {
            -ms-transform: rotateY(180deg);
            -webkit-transform: rotateY(180deg);
            transform: rotateY(180deg);
        }



        /* flip speed goes here */
        .flipper
        {
            -webkit-transition: 0.6s;
            -moz-transition: 0.6s;
            -o-transition: 0.6s;
            transition: 0.6s;
            -ms-transform-style: preserve-3d;
            -webkit-transform-style: preserve-3d;
            transform-style: preserve-3d;
            position: relative;
        }

        /* hide back of pane during swap */
        .front, .back
        {
            backface-visibility: hidden;
            position: absolute;
            top: 0;
            left: 0;
        }

        /* front pane, placed above back */
        .front
        {
            z-index: 2;
            /* for firefox 31 */
            -ms-transform: rotateY(0deg);
            -webkit-transform: rotateY(0deg);
            transform: rotateY(0deg);
        }

        /* back, initially hidden pane */
        .back
        {
            transform: rotateY(180deg);
            -ms-transform: rotateY(180deg);
            -webkit-transform: rotateY(180deg);
            transform: rotateY(180deg);
        }

        .detail-tintuckhac-item
        {
            font-size: 13px;
            color: #333333;
            position: relative;
            margin: 15px 0px;
            padding-left: 30px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            text-align:left;
        }

            .detail-tintuckhac-item:before
            {
                content: url('Images/Csaga/icon-tinkhac.png');
                position: absolute;
                top: 0px;
                left: 0px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div class="panel_1k" style="text-align: center;">
        <div class="item-home flip-container">
            <div class="item-home-hover flipper">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/Csaga/icon-tintuc.png');"></div>
                <div class="item-home-text back">
                    <%foreach (var item in getTinTuc(Enums.LoaiTinTuc.TinTucSuKien))
                      {%>
                    <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/" %><%=Lib.urlChiTiet(Enums.LoaiTinTuc.TinTucSuKien) %>-<%=Lib.LocDau(item.TieuDe_Vn) %>-z-<%=item.ID %>.htm">
                        <div class="detail-tintuckhac-item">
                            <%=item.TieuDe_Vn %>
                        </div>
                    </a>
                    <%} %>
                </div>
            </div>
            <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/tintuc-sukien.htm" %>">
                <div class="item-home-name">Tin tức - Sự kiện</div>
            </a>
        </div>
        <div class="item-home flip-container">
            <div class="item-home-hover flipper">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/Csaga/iocn-hinhfanh.png');"></div>
                <div class="item-home-text back">
                    <%foreach (var item in getTinTuc(Enums.LoaiTinTuc.HinhAnhCongDongYeuNu))
                      {%>
                    <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/" %><%=Lib.urlChiTiet(Enums.LoaiTinTuc.HinhAnhCongDongYeuNu) %>-<%=Lib.LocDau(item.TieuDe_Vn) %>-z-<%=item.ID %>.htm">
                        <div class="detail-tintuckhac-item">
                            <%=item.TieuDe_Vn %>
                        </div>
                    </a>
                    <%} %>
                </div>
            </div>
            <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/hinh-anh-cong-dong.htm" %>">
                <div class="item-home-name">Hình ảnh cộng đồng</div>
            </a>
        </div>
        <div class="item-home flip-container">
            <div class="item-home-hover flipper">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/Csaga/icon-nhom.png');"></div>
                <div class="item-home-text back">
                    <%foreach (var item in getTinTuc(Enums.LoaiTinTuc.CacNhomNuyeuNu))
                      {%>
                    <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/" %><%=Lib.urlChiTiet(Enums.LoaiTinTuc.CacNhomNuyeuNu) %>-<%=Lib.LocDau(item.TieuDe_Vn) %>-z-<%=item.ID %>.htm">
                        <div class="detail-tintuckhac-item">
                            <%=item.TieuDe_Vn %>
                        </div>
                    </a>
                    <%} %>
                </div>
            </div>
            <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/nhom-nu-yeu-nu.htm" %>">
                <div class="item-home-name">Nhóm nữ yêu nữ</div>
            </a>
        </div>
        <div class="item-home flip-container">
            <div class="item-home-hover flipper">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/Csaga/icon-hotro.png');"></div>
                <div class="item-home-text back">
                    <%foreach (var item in getTinTuc(Enums.LoaiTinTuc.CacNhomNuyeuNu))
                      {%>
                    <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/" %><%=Lib.urlChiTiet(Enums.LoaiTinTuc.HoTro) %>-<%=Lib.LocDau(item.TieuDe_Vn) %>-z-<%=item.ID %>.htm">
                        <div class="detail-tintuckhac-item">
                            <%=item.TieuDe_Vn %>
                        </div>
                    </a>
                    <%} %>
                </div>
            </div>
            <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/hotro.htm" %>">
                <div class="item-home-name">Hỗ trợ</div>
            </a>
        </div>
        <div class="item-home flip-container">
            <div class="item-home-hover flipper">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/Csaga/icon-thuvien.png');"></div>
                <div class="item-home-text back">
                    <%foreach (var item in getTinTuc(Enums.LoaiTinTuc.CacNhomNuyeuNu))
                      {%>
                    <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/" %><%=Lib.urlChiTiet(Enums.LoaiTinTuc.ThuVien) %>-<%=Lib.LocDau(item.TieuDe_Vn) %>-z-<%=item.ID %>.htm">
                        <div class="detail-tintuckhac-item">
                            <%=item.TieuDe_Vn %>
                        </div>
                    </a>
                    <%} %>
                </div>
            </div>
            <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/thuvien.htm" %>">
                <div class="item-home-name">Thư viện</div>
            </a>
        </div>
        <div style="clear: both;"></div>
    </div>
    <div style="height: 80px; clear: both;"></div>
</asp:Content>

