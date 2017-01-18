<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="tintuc-sukien.aspx.cs" Inherits="View_tintuc_sukien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .list-item-news
        {
        }

            .list-item-news .item-news
            {
                width: 300px;
                height: 240px;
                margin: 20px 25px;
                float: left;
                position: relative;
            }

                .list-item-news .item-news:nth-child(4n+0), .list-item-news .item-news:nth-child(1)
                {
                    margin-left: 0px;
                }

                .list-item-news .item-news:nth-child(3n+0)
                {
                    margin-right: 0px;
                }

                .list-item-news .item-news .item-news-title
                {
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

                .list-item-news .item-news .item-news-center
                {
                    position: relative;
                    margin: 20px 0px 20px;
                    height: 130px;
                }

                    .list-item-news .item-news .item-news-center .item-news-img
                    {
                        width: 130px;
                        height: 130px;
                        background-position: center center;
                        background-repeat: no-repeat;
                        background-size: cover;
                        position: absolute;
                    }

                    .list-item-news .item-news .item-news-center .item-news-content
                    {
                        margin-left: 145px;
                    }

                        .list-item-news .item-news .item-news-center .item-news-content .item-news-date
                        {
                            font-size: 12px;
                            color: #666;
                        }

                        .list-item-news .item-news .item-news-center .item-news-content .item-news-des
                        {
                            font-size: 13px;
                            color: #333;
                            font-weight: 500;
                            margin-top: 3px;
                            text-align: justify;
                            overflow: hidden;
                            position: relative;
                        }

                            .list-item-news .item-news .item-news-center .item-news-content .item-news-des:first-letter
                            {
                                text-transform: uppercase;
                            }

                .list-item-news .item-news .item-news-morre
                {
                    border-bottom: 1px solid #ff6666;
                    text-align: right;
                }

                    .list-item-news .item-news .item-news-morre span
                    {
                        display: inline-block;
                        padding: 5px 10px;
                        font-size: 12px;
                        background-color: #ff6666;
                        color: #333333;
                    }

                .list-item-news .item-news:nth-child(2) .item-news-morre
                {
                    border-color: #f89201;
                }

                    .list-item-news .item-news:nth-child(2) .item-news-morre span
                    {
                        background-color: #f89201;
                    }

                .list-item-news .item-news:nth-child(3) .item-news-morre
                {
                    border-color: #f8e900;
                }

                    .list-item-news .item-news:nth-child(3) .item-news-morre span
                    {
                        background-color: #f8e900;
                    }

                .list-item-news .item-news:nth-child(4) .item-news-morre
                {
                    border-color: #3cc061;
                }

                    .list-item-news .item-news:nth-child(4) .item-news-morre span
                    {
                        background-color: #3cc061;
                    }

                .list-item-news .item-news:nth-child(5) .item-news-morre
                {
                    border-color: #3996d3;
                }

                    .list-item-news .item-news:nth-child(5) .item-news-morre span
                    {
                        background-color: #3996d3;
                    }

                .list-item-news .item-news:nth-child(6) .item-news-morre
                {
                    border-color: #cc66ff;
                }

                    .list-item-news .item-news:nth-child(6) .item-news-morre span
                    {
                        background-color: #cc66ff;
                    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div style="clear: both; height: 30px;"></div>
    <div class="panel_1k" id="viewnews">
        <div class="list-item-news">
            <%
                int totalRow = 0;
                int pageSelect = 1;
                int numInPage = 6;
                foreach (var item in getTinTuc(numInPage, out totalRow, out pageSelect).Select((value, i) => new { i, value }))
                {
            %>

            <div class="item-news">
                <div class="item-news-title" title="<%=item.value.TieuDe_Vn %>">
                    <%=item.value.TieuDe_Vn %>
                </div>
                <div class="item-news-center">
                    <div class="item-news-img" style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');"></div>
                    <div class="item-news-content">
                        <div class="item-news-date"><%=item.value.CreateDate.ToString("dd-MM-yyyy lúc HH:mm") %></div>
                        <div class="item-news-des"><%=Lib.subString(item.value.Des_En,120) %></div>
                    </div>
                </div>
                <div class="item-news-morre">
                    <a href="tintuc-sukien-<%=Lib.LocDau(item.value.TieuDe_Vn) %>-z-<%=item.value.ID %>.htm"><span>Xem thêm >></span></a>
                </div>
            </div>
            <%}%>
        </div>
        <div style="clear: both; height: 0px;"></div>
        <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5,"viewnews")%>
    </div>
    <div style="clear: both; height: 100px;"></div>
</asp:Content>

