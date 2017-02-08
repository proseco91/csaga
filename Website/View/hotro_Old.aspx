<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="hotro_Old.aspx.cs" Inherits="View_hotro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .hotro-left {
            min-height: 1150px;
            background-color: #d7d7d7;
            width: 350px;
            float: left;
            box-sizing: border-box;
            padding: 50px 0px 20px 50px;
        }

        .hotro-right {
            float: left;
            width: calc(100% - 350px);
            padding: 50px 10px 20px 20px;
            box-sizing: border-box;
        }

        .hotro-left .hotro-left-title {
            height: 40px;
            width: 100%;
            background-color: #ae4bce;
            position: relative;
            margin-bottom: 20px;
        }

            .hotro-left .hotro-left-title:before {
                content: " ";
                width: 10px;
                height: 100%;
                background-color: #000;
                top: 0px;
                left: 0px;
                position: absolute;
            }

            .hotro-left .hotro-left-title::after {
                content: "Alo tôi nghe";
                text-transform: uppercase;
                font-size: 20px;
                font-weight: 700;
                color: #FFF;
                padding: 0px 20px;
                position: relative;
                top: 7px;
            }

        .detail-tintuckhac-item {
            font-size: 18px;
            color: #333333;
            position: relative;
            margin: 10px 0px;
            padding-left: 30px;
        }

            .detail-tintuckhac-item:before {
                content: url('../Images/Csaga/icon-tinkhac.png');
                position: absolute;
                top: 2px;
                left: 0px;
            }

            .detail-tintuckhac-item[category="selected"] {
                border-bottom: 1px dashed #333;
                font-weight: 700;
            }

        .hotro-item {
            height: 300px;
            position: relative;
            margin-bottom: 20px;
        }

            .hotro-item .hotro-item-img {
                height: 300px;
                width: 270px;
                background-position: center center;
                background-repeat: no-repeat;
                background-size: cover;
                position: absolute;
                left: 0px;
                top: 0px;
            }

            .hotro-item .hotro-item-content {
                margin-left: 290px;
                position: relative;
                height: 300px;
            }

            .hotro-item .hotro-item-title {
                font-size: 20px;
                font-weight: 700;
                max-height: 64px;
                overflow: hidden;
            }

            .hotro-item .hotro-item-date {
                font-size: 15px;
                color: #555;
            }

            .hotro-item .hotro-item-des {
                margin-top: 5px;
                border-top: 1px dashed #DDD;
                font-size: 15px;
                color: #444;
                padding-top: 10px;
                max-height: 145px;
                overflow: hidden;
            }

            .hotro-item .item-hotro-btn {
                height: 32px;
                background-color: #ae4bce;
                position: absolute;
                bottom: 0px;
                width: 100%;
            }

                .hotro-item .item-hotro-btn::before {
                    content: "Xem thêm";
                    position: absolute;
                    right: 30px;
                    top: 10px;
                    color: #FFF;
                }

                .hotro-item .item-hotro-btn::after {
                    content: url('../Images/Csaga/icon-xemthem.png');
                    position: absolute;
                    right: 05px;
                    top: 10px;
                }

        .pagePhanTrang {
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div class="cate-link" style="padding-left: 5px;margin-bottom:0px;border-bottom:1px solid #d7d7d7;">
        <span class="item-link-cate">
            <a href="<%=Lib.urlhome %>">Trang chủ</a>
        </span>
        <span class="item-link-cate">Alo tôi nghe
        </span>
    </div>
    <div class="panel_1k2">
        <div class="panel-hotro">
            <div class="hotro-left">
                <div class="hotro-left-title">
                </div>
                <%foreach (var item in arrcate)
                  {%>
                <a href="mucluc-hotro-<%=Lib.LocDau(item.TieuDe_Vn) %>-z-<%=item.ID %>.htm">
                    <div class="detail-tintuckhac-item" category="<%=item.ID==category?"selected":"" %>">
                        <%=item.TieuDe_Vn %>
                    </div>
                </a>
                <%} %>
            </div>
            <div class="hotro-right" id="viewnews">
                <%
                    int totalRow = 0;
                    int pageSelect = 1;
                    int numInPage = 3;
                    foreach (var item in getHoTro(numInPage, out totalRow, out pageSelect).Select((value, i) => new { i, value }))
                    {
                %>

                <div class="hotro-item">
                    <div class="hotro-item-img" style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');">
                    </div>
                    <div class="hotro-item-content">
                        <div class="hotro-item-title">
                            <%=Lib.subString(item.value.TieuDe_En,110) %>
                        </div>
                        <div class="hotro-item-date">
                            <%=item.value.CreateDate.ToString("dd-MM-yyyy lúc HH:mm") %>
                        </div>
                        <div class="hotro-item-des">
                            <%=item.value.Des_En %>
                        </div>
                        <a href="hotro-<%=Lib.LocDau(item.value.TieuDe_Vn) %>-z-<%=item.value.ID %>.htm">
                            <div class="item-hotro-btn"></div>
                        </a>
                    </div>
                </div>
                <%}%>
                <div style="clear: both; height: 0px;"></div>
                <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5,"viewnews")%>
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>


</asp:Content>

