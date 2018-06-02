<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="tintuc-sukien.aspx.cs" Inherits="View_tintuc_sukien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .list-item-news {
        }

            .list-item-news .item-news {
                width: calc(100% / 3 - 34px);
                height: 240px;
                margin: 20px 25px;
                float: left;
                position: relative;
            }

                .list-item-news .item-news:nth-child(4n+0), .list-item-news .item-news:nth-child(1) {
                    margin-left: 0px;
                }

                .list-item-news .item-news:nth-child(3n+0) {
                    margin-right: 0px;
                }

                .list-item-news .item-news .item-news-title {
                    background-color: #823386;
                    font-size: 15px;
                    color: #FFF;
                    height: 38px;
                    box-sizing: border-box;
                    overflow: hidden;
                    white-space: nowrap;
                    text-overflow: ellipsis;
                    padding: 7px 5px;
                }

                .list-item-news .item-news .item-news-center {
                    position: relative;
                    margin: 20px 0px 20px;
                    height: 130px;
                }

                    .list-item-news .item-news .item-news-center .item-news-img {
                        width: 130px;
                        height: 130px;
                        background-position: center center;
                        background-repeat: no-repeat;
                        background-size: cover;
                        position: absolute;
                    }

                    .list-item-news .item-news .item-news-center .item-news-content {
                        margin-left: 145px;
                    }

                        .list-item-news .item-news .item-news-center .item-news-content .item-news-date {
                            font-size: 12px;
                            color: #666;
                        }

                        .list-item-news .item-news .item-news-center .item-news-content .item-news-des {
                            font-size: 13px;
                            color: #333;
                            font-weight: 500;
                            margin-top: 3px;
                            text-align: justify;
                            overflow: hidden;
                            position: relative;
                        }

                            .list-item-news .item-news .item-news-center .item-news-content .item-news-des:first-letter {
                                text-transform: uppercase;
                            }

                .list-item-news .item-news .item-news-morre {
                    border-bottom: 1px solid #ff6666;
                    text-align: right;
                }

                    .list-item-news .item-news .item-news-morre span {
                        display: inline-block;
                        padding: 5px 10px;
                        font-size: 12px;
                        background-color: #ff6666;
                        color: #333333;
                    }

                .list-item-news .item-news:nth-child(2) .item-news-morre {
                    border-color: #f89201;
                }

                    .list-item-news .item-news:nth-child(2) .item-news-morre span {
                        background-color: #f89201;
                    }

                .list-item-news .item-news:nth-child(3) .item-news-morre {
                    border-color: #f8e900;
                }

                    .list-item-news .item-news:nth-child(3) .item-news-morre span {
                        background-color: #f8e900;
                    }

                .list-item-news .item-news:nth-child(4) .item-news-morre {
                    border-color: #3cc061;
                }

                    .list-item-news .item-news:nth-child(4) .item-news-morre span {
                        background-color: #3cc061;
                    }

                .list-item-news .item-news:nth-child(5) .item-news-morre {
                    border-color: #3996d3;
                }

                    .list-item-news .item-news:nth-child(5) .item-news-morre span {
                        background-color: #3996d3;
                    }

                .list-item-news .item-news:nth-child(6) .item-news-morre {
                    border-color: #cc66ff;
                }

                    .list-item-news .item-news:nth-child(6) .item-news-morre span {
                        background-color: #cc66ff;
                    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div class="panel_1k2" id="viewnews" style="background-color: rgba(255,255,255,0.8); padding: 20px 0px;">
        <div class="cate-link" style="margin-top: 0px; padding-left: 10px;">
            <span class="item-link-cate">
                <a href="<%=Lib.urlhome %>">Trang chủ</a>
            </span>
            <span class="item-link-cate">Tin tức - sự kiện
            </span>
        </div>
        <div style="clear: both; height: 0px;"></div>
        <%foreach (var cate in sql.getCategory().Where(d => d.Type == (int)Enums.LoaiTinTuc.TinTucSuKien))
            {%>
        <div id="<%="view"+cate.ID %>">
            <div style="clear: both; height: 0px;"></div>
            <div class="cate-link" style="padding-left: 10px; margin-top: 0px; background-color: #c9dbff; padding-top: 9px; color: #333; border: medium none;">

                <span class="item-link-cate">
                    <%=Lib.ContentLag(cate.TieuDe_Vn,cate.TieuDe_En) %>
                </span>
            </div>
            <div style="clear: both; height: 0px;"></div>
            <div class="list-item-news" style="padding: 0px 20px;">
                <%
                    int totalRow = 0;
                    int pageSelect = 1;
                    int numInPage = 6;
                    var datain = getTinTuc(numInPage, cate.ID, out totalRow, out pageSelect);
                    foreach (var item in datain.Select((value, i) => new { i, value }))
                    {
                %>

                <div class="item-news">
                    <a href="tintuc-sukien-<%=Lib.LocDau(item.value.TieuDe_Vn) %>-z-<%=item.value.ID %>.htm">
                        <div class="item-news-title" title="<%=item.value.TieuDe_Vn.Replace("\"","'") %>">
                            <%=item.value.TieuDe_Vn %>
                        </div>
                    </a>
                    <div class="item-news-center">
                        <div class="item-news-img" style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');"></div>
                        <div class="item-news-content">
                            <div class="item-news-date"><%=item.value.NgayHienThi.Value.ToString("dd-MM-yyyy lúc HH:mm") %></div>
                            <div class="item-news-des"><%=Lib.subString(item.value.Des_Vn,120) %></div>
                        </div>
                    </div>
                    <div class="item-news-morre">
                        <a href="tintuc-sukien-<%=Lib.LocDau(item.value.TieuDe_Vn) %>-z-<%=item.value.ID %>.htm"><span><%=Lib.ContentLag("Xem thêm","More")%> >></span></a>
                    </div>
                </div>
                <%}%>
                <div style="clear: both;"></div>
            </div>
            <div style="clear: both; height: 0px;"></div>
            <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5,"view"+cate.ID,"page"+cate.ID)%>
            <div style="clear: both; height: 50px;"></div>
        </div>
        <%}%>
    </div>

</asp:Content>
