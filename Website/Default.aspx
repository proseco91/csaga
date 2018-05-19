<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="~/Masster/KhaoSat.ascx" TagPrefix="uc1" TagName="KhaoSat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .item-home {
            width: 371px;
            display: inline-block;
            margin: 0px;
            box-sizing: border-box;
            margin: 20px;
        }

            /*.item-home:nth-child(1), .item-home:nth-child(4) {
                margin-left: 0px;
            }
            .item-home:nth-child(3), .item-home:nth-child(6) {
                margin-right: 0px;
            }*/

            .item-home .item-home-hover {
                /*height: 135px;*/
                height: 190px;
                position: relative;
            }

            .item-home .item-home-icon {
                height: 190px;
                width: 100%;
                background-position: center center;
                background-repeat: no-repeat;
                background-size: cover;
                /*box-shadow: 0px -86px 100px -62px #77018b inset;*/
            }

            .item-home .item-home-text {
                height: 190px;
                width: 100%;
                background-color: #EEE;
                padding: 10px;
                box-sizing: border-box;
            }

            .item-home .item-home-name {
                color: #212d42;
                font-size: 24px;
                text-align: center;
                margin-top: 20px;
                position: relative;
                z-index: 1;
                background-color: rgba(255,255,255,0.7);
            }

            .item-home:hover .item-home-name {
                color: #212d42;
            }



        /* simple */
        .flip-container {
            -webkit-perspective: 1000;
            -moz-perspective: 1000;
            -ms-perspective: 1000;
            perspective: 1000;
            -ms-transform: perspective(1000px);
            -moz-transform: perspective(1000px);
            -moz-transform-style: preserve-3d;
            -ms-transform-style: preserve-3d;
        }

            /*
			.flip-container:hover .flipper, .flip-container.hover .flipper, #flip-toggle.flip .flipper {
				-webkit-transform: rotateY(180deg);
				-moz-transform: rotateY(180deg);
				-ms-transform: rotateY(180deg);
				transform: rotateY(180deg);
				filter: FlipH;
    			-ms-filter: "FlipH";
			}
			*/


            /* START: Accommodating for IE */
            .flip-container:hover .back, .flip-container.hover .back {
                -webkit-transform: rotateY(0deg);
                -moz-transform: rotateY(0deg);
                -o-transform: rotateY(0deg);
                -ms-transform: rotateY(0deg);
                transform: rotateY(0deg);
            }

            .flip-container:hover .front, .flip-container.hover .front {
                -webkit-transform: rotateY(180deg);
                -moz-transform: rotateY(180deg);
                -o-transform: rotateY(180deg);
                transform: rotateY(180deg);
            }

        /* END: Accommodating for IE */

        .flip-container, .front, .back {
        }

        .flipper {
            -webkit-transition: 0.6s;
            -webkit-transform-style: preserve-3d;
            -ms-transition: 0.6s;
            -moz-transition: 0.6s;
            -moz-transform: perspective(1000px);
            -moz-transform-style: preserve-3d;
            -ms-transform-style: preserve-3d;
            transition: 0.6s;
            transform-style: preserve-3d;
            position: relative;
        }

        .front, .back {
            -webkit-backface-visibility: hidden;
            -moz-backface-visibility: hidden;
            -ms-backface-visibility: hidden;
            backface-visibility: hidden;
            -webkit-transition: 0.6s;
            -webkit-transform-style: preserve-3d;
            -webkit-transform: rotateY(0deg);
            -moz-transition: 0.6s;
            -moz-transform-style: preserve-3d;
            -moz-transform: rotateY(0deg);
            -o-transition: 0.6s;
            -o-transform-style: preserve-3d;
            -o-transform: rotateY(0deg);
            -ms-transition: 0.6s;
            -ms-transform-style: preserve-3d;
            -ms-transform: rotateY(0deg);
            transition: 0.6s;
            transform-style: preserve-3d;
            transform: rotateY(0deg);
            position: absolute;
            top: 0;
            left: 0;
        }

        .front {
            -webkit-transform: rotateY(0deg);
            -ms-transform: rotateY(0deg);
            z-index: 2;
        }

        .back {
            -webkit-transform: rotateY(-180deg);
            -moz-transform: rotateY(-180deg);
            -o-transform: rotateY(-180deg);
            -ms-transform: rotateY(-180deg);
            transform: rotateY(-180deg);
        }

        .front .name {
            font-size: 2em;
            display: inline-block;
            background: rgba(33, 33, 33, 0.9);
            color: #f8f8f8;
            font-family: Courier;
            padding: 5px 10px;
            border-radius: 5px;
            bottom: 60px;
            left: 25%;
            position: absolute;
            text-shadow: 0.1em 0.1em 0.05em #333;
            display: none;
            -webkit-transform: rotate(-20deg);
            -moz-transform: rotate(-20deg);
            -ms-transform: rotate(-20deg);
            transform: rotate(-20deg);
        }

        .back-logo {
            position: absolute;
            top: 40px;
            left: 90px;
            width: 160px;
            height: 117px;
            background: url(logo.png) 0 0 no-repeat;
        }

        .back-title {
            font-weight: bold;
            color: #00304a;
            position: absolute;
            top: 180px;
            left: 0;
            right: 0;
            text-align: center;
            text-shadow: 0.1em 0.1em 0.05em #acd7e5;
            font-family: Courier;
            font-size: 22px;
        }

        .back p {
            position: absolute;
            bottom: 40px;
            left: 0;
            right: 0;
            text-align: center;
            padding: 0 20px;
            font-size: 18px;
        }

        /* vertical */
        .vertical.flip-container {
            position: relative;
        }

        .vertical .back {
            -webkit-transform: rotateX(180deg);
            -moz-transform: rotateX(180deg);
            -ms-transform: rotateX(180deg);
            transform: rotateX(180deg);
        }

        .vertical.flip-container .flipper {
            -webkit-transform-origin: 100% 213.5px;
            -moz-transform-origin: 100% 213.5px;
            -ms-transform-origin: 100% 213.5px;
            transform-origin: 100% 213.5px;
        }

        /*
			.vertical.flip-container:hover .flipper {
				-webkit-transform: rotateX(-180deg);
				-moz-transform: rotateX(-180deg);
				-ms-transform: rotateX(-180deg);
				transform: rotateX(-180deg);
			}
			*/

        /* START: Accommodating for IE */
        .vertical.flip-container:hover .back, .vertical.flip-container.hover .back {
            -webkit-transform: rotateX(0deg);
            -moz-transform: rotateX(0deg);
            -o-transform: rotateX(0deg);
            -ms-transform: rotateX(0deg);
            transform: rotateX(0deg);
        }

        .vertical.flip-container:hover .front, .vertical.flip-container.hover .front {
            -webkit-transform: rotateX(180deg);
            -moz-transform: rotateX(180deg);
            -o-transform: rotateX(180deg);
            transform: rotateX(180deg);
        }
        /* END: Accommodating for IE */

        .detail-tintuckhac-item {
            font-size: 13px;
            color: #333333;
            position: relative;
            margin: 17px 0px;
            padding-left: 30px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            text-align: left;
        }

            .detail-tintuckhac-item:before {
                content: url('Images/Csaga/icon-tinkhac.png');
                position: absolute;
                top: 0px;
                left: 0px;
            }

        .hinhanhcongdong-item {
            height: 100%;
            width: 100%;
            position: absolute;
        }

            .hinhanhcongdong-item .hinhanhcongdong-item-img {
                height: 100%;
                width: 60%;
                background-position: center center;
                background-repeat: no-repeat;
                background-size: cover;
                position: absolute;
                left: 0px;
                top: 0px;
            }

            .hinhanhcongdong-item .hinhanhcongdong-item-content {
                position: absolute;
                height: 100%;
                padding: 20px;
                right: 0px;
                overflow: hidden;
                width: 40%;
                box-sizing: border-box;
                background-color: rgba(255,255,255,0.7);
            }

            .hinhanhcongdong-item .hinhanhcongdong-item-title {
                font-size: 20px;
                font-weight: 700;
                max-height: 64px;
                overflow: hidden;
            }

            .hinhanhcongdong-item .hinhanhcongdong-item-date {
                font-size: 15px;
                color: #555;
            }

            .hinhanhcongdong-item .hinhanhcongdong-item-des {
                margin-top: 5px;
                border-top: 1px dashed #DDD;
                font-size: 15px;
                color: #444;
                padding-top: 10px;
                max-height: 145px;
                overflow: hidden;
            }

            .hinhanhcongdong-item .item-hotro-btn {
                height: 32px;
                background-color: #ae4bce;
                position: absolute;
                bottom: 0px;
                width: 100%;
            }

                .hinhanhcongdong-item .item-hotro-btn::before {
                    content: "<%=Lib.ContentLag("Xem thêm","More")%>";
                    position: absolute;
                    right: 30px;
                    top: 10px;
                    color: #FFF;
                }

                .hinhanhcongdong-item .item-hotro-btn::after {
                    content: url('../Images/Csaga/icon-xemthem.png');
                    position: absolute;
                    right: 05px;
                    top: 10px;
                }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div style="clear: both;"></div>
    <div class="bodyCrazy">
        <div class="banner" valindex="0">
            <%
                var arrayNuYeuNu = getHinhAnh();
            %>
            <div class="banner_content">
                <%foreach (var item in arrayNuYeuNu.Select((value, index) => new { value, index }))
                    {%>
                <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/" %>chitiet-hinh-anh-cong-dong-<%=Lib.LocDau(item.value.TieuDe_Vn) %>-z-<%=item.value.ID %>.htm">
                    <div class="item_banner" valindex="0">
                        <div class="hinhanhcongdong-item">
                            <div class="hinhanhcongdong-item-img" style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');">
                            </div>
                            <div class="hinhanhcongdong-item-content">
                                <div class="hinhanhcongdong-item-title">
                                    <%=Lib.subString(item.value.TieuDe_Vn,110) %>
                                </div>
                                <div class="hinhanhcongdong-item-date">
                                    <%=item.value.CreateDate.ToString("dd-MM-yyyy lúc HH:mm") %>
                                </div>
                                <div class="hinhanhcongdong-item-des">
                                    <%=item.value.Des_Vn %>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
                <%}%>
            </div>
            <div class="banner_index">
                <span class="banner_index_span">
                    <%foreach (var item in arrayNuYeuNu.Select((value, index) => new { value, index }))
                            {%>
                        <span valindex="<%=item.index %>"></span>
                    <%}%>
                </span>
            </div>
        </div>
    </div>
    <div style="clear: both;"></div>
    <div style="clear: both; height: 20px;"></div>
    <div class="panel_1k2" style="text-align: center; width: 1260px; max-width: calc(100% + 60px); left: -30px; position: relative;">
        <div class="item-home flip-container">
            <div class="item-home-hover flipper" ontouchstart="this.classList.toggle('hover');">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/imageUpload/<%=sql.getCategory().FirstOrDefault(d=>d.ID==1029).Img %>');"></div>
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
                <div class="item-home-name"><%=Enums.LoaiTinTucDesc(Enums.LoaiTinTuc.TinTucSuKien) %></div>
            </a>
        </div>
        <div class="item-home flip-container" ontouchstart="this.classList.toggle('hover');">
            <div class="item-home-hover flipper">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/imageUpload/<%=sql.getCategory().FirstOrDefault(d=>d.ID==1030).Img %>');"></div>
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
                <div class="item-home-name"><%=Enums.LoaiTinTucDesc(Enums.LoaiTinTuc.HinhAnhCongDongYeuNu) %></div>
            </a>
        </div>
        <div class="item-home flip-container" ontouchstart="this.classList.toggle('hover');">
            <div class="item-home-hover flipper">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/imageUpload/<%=sql.getCategory().FirstOrDefault(d=>d.ID==1031).Img %>');"></div>
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
                <div class="item-home-name"><%=Enums.LoaiTinTucDesc(Enums.LoaiTinTuc.CacNhomNuyeuNu) %></div>
            </a>
        </div>
        <div class="item-home flip-container" ontouchstart="this.classList.toggle('hover');">
            <div class="item-home-hover flipper">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/imageUpload/<%=sql.getCategory().FirstOrDefault(d=>d.ID==1032).Img %>');"></div>
                <div class="item-home-text back">
                    <%foreach (var item in getTinTuc(Enums.LoaiTinTuc.HoTro))
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
                <div class="item-home-name"><%=Enums.LoaiTinTucDesc(Enums.LoaiTinTuc.HoTro) %></div>
            </a>
        </div>
        <div class="item-home flip-container" ontouchstart="this.classList.toggle('hover');">
            <div class="item-home-hover flipper">
                <div class="item-home-icon front" style="background-image: url('<%=Lib.urlhome%>/Images/imageUpload/<%=sql.getCategory().FirstOrDefault(d=>d.ID==1033).Img %>');"></div>
                <div class="item-home-text back">
                    <%foreach (var item in getTinTuc(Enums.LoaiTinTuc.ThuVien))
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
                <div class="item-home-name"><%=Enums.LoaiTinTucDesc(Enums.LoaiTinTuc.ThuVien) %></div>
            </a>
        </div>
        <uc1:KhaoSat runat="server" ID="KhaoSat" />
        <div style="clear: both;"></div>
    </div>
    <div style="height: 20px; clear: both;"></div>
</asp:Content>

