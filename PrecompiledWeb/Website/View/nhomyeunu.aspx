<%@ page title="" language="C#" masterpagefile="~/Masster/Home.master" autoeventwireup="true" inherits="View_nhomyeunu, App_Web_qq4yenyu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .item-nhomyeunu
        {
            height: 520px;
            position: relative;
        }

            .item-nhomyeunu:last-child
            {
                padding-bottom: 80px;
            }

            .item-nhomyeunu .item-nhomyeunu-tennhom
            {
                width: 600px;
                position: absolute;
                height: 100%;
                background-color: #c9dbff;
                box-sizing: border-box;
                padding: 50px;
                text-align: center;
            }
            .item-nhomyeunu:nth-child(2n+0) .item-nhomyeunu-tennhom
            {
                background-color: #FFF;
            }
                .item-nhomyeunu .item-nhomyeunu-tennhom .item-nhomyeunu-tennhom-img
                {
                    display: inline-block;
                    height: 135px;
                    width: 135px;
                    background-color: #FFF;
                    background-position: center center;
                    background-repeat: no-repeat;
                    background-size: cover;
                    border-radius: 50%;
                    box-shadow: 0px 0px 3px rgba(0,0,0,0.5);
                    box-sizing: border-box;
                    border: 5px solid #FFF;
                }

                .item-nhomyeunu .item-nhomyeunu-tennhom .item-nhomyeunu-tennhom-name
                {
                    font-size: 28px;
                    color: #000000;
                    font-weight: bold;
                    overflow: hidden;
                    white-space: nowrap;
                    text-overflow: ellipsis;
                }

                .item-nhomyeunu .item-nhomyeunu-tennhom .item-nhomyeunu-tennhom-info
                {
                    color: #333333;
                    font-size: 17px;
                    margin-top: 5px;
                }

        .item-nhomyeunu-news-item
        {
            height: 140px;
            position: relative;
            margin-bottom: 20px;
        }
        
        .item-nhomyeunu:nth-child(2n+0)
            {
                background-color: #ffcbe1;
            }
            .item-nhomyeunu-news-item .item-nhomyeunu-news-item-img
            {
                height: 140px;
                width: 140px;
                background-position: center center;
                background-repeat: no-repeat;
                background-size: cover;
                position: absolute;
                left: 0px;
                top: 0px;
            }

            .item-nhomyeunu-news-item .item-nhomyeunu-news-item-content
            {
                margin-left: 160px;
                position: relative;
                height: 140px;
            }

            .item-nhomyeunu-news-item .item-nhomyeunu-news-item-title
            {
                font-size: 15px;
                font-weight: 700;
                max-height: 20px;
                overflow: hidden;
                line-height: 20px;
            }

            .item-nhomyeunu-news-item .item-nhomyeunu-news-item-date
            {
                font-size: 12px;
                color: #555;
            }

            .item-nhomyeunu-news-item .item-nhomyeunu-news-item-des
            {
                margin-top: 5px;
                border-top: 1px dashed #DDD;
                font-size: 15px;
                color: #444;
                padding-top: 5px;
                max-height: 50px;
                overflow: hidden;
            }

            .item-nhomyeunu-news-item .item-hotro-btn
            {
                height: 32px;
                background-color: #ae4bce;
                position: absolute;
                bottom: 0px;
                width: 100%;
            }

                .item-nhomyeunu-news-item .item-hotro-btn::before
                {
                    content: "<%=Lib.ContentLag("Xem thêm","More")%>";
                    position: absolute;
                    right: 30px;
                    top: 10px;
                    color: #FFF;
                }

                .item-nhomyeunu-news-item .item-hotro-btn::after
                {
                    content: url('../Images/Csaga/icon-xemthem.png');
                    position: absolute;
                    right: 05px;
                    top: 10px;
                }

        .item-nhomyeunu .item-nhomyeunu-news
        {
            margin-left: 600px;
            padding: 20px;
            padding-right: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div class="panel_1k2">
        <%foreach (var item in getNhom())
          {%>
        <div class="item-nhomyeunu">
            <div class="item-nhomyeunu-tennhom">
                <div class="item-nhomyeunu-tennhom-img" style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.Img %>');"></div>
                <div class="item-nhomyeunu-tennhom-name">
                    <%=item.TieuDe_Vn %>
                </div>
                <div class="item-nhomyeunu-tennhom-info">
                    <b><%=Lib.getLag()=="vi-VN"?"Địa chỉ":"Address" %></b>
                    <%=": "+item.DiaChi %>
                </div>
                <div class="item-nhomyeunu-tennhom-info">
                    <b><%=Lib.getLag()=="vi-VN"?"Email":"Email" %></b>
                    <%=": "+item.Email %>
                </div>
                <div class="item-nhomyeunu-tennhom-info">
                    <b><%=Lib.getLag()=="vi-VN"?"Điện thoại":"Phone" %></b>
                    <%=": "+item.DienThoai %>
                </div>
            </div>
            <div class="item-nhomyeunu-news">
                <%foreach (var news in getTinNhom(item.ID))
                  {%>
                <div class="item-nhomyeunu-news-item">
                    <div class="item-nhomyeunu-news-item-img" style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+news.Img %>');">
                    </div>
                    <div class="item-nhomyeunu-news-item-content">
                        <div class="item-nhomyeunu-news-item-title">
                            <%=Lib.subString(news.TieuDe_En,110) %>
                        </div>
                        <div class="item-nhomyeunu-news-item-date">
                            <%=news.CreateDate.ToString("dd-MM-yyyy lúc HH:mm") %>
                        </div>
                        <div class="item-nhomyeunu-news-item-des">
                            <%=news.Des_En %>
                        </div>
                        <a href="nhom-nu-yeu-nu-<%=Lib.LocDau(news.TieuDe_Vn) %>-z-<%=news.ID %>.htm">
                            <div class="item-hotro-btn"></div>
                        </a>
                    </div>
                </div>
                <%} %>
            </div>
        </div>
        <%}%>
    </div>

</asp:Content>

