<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="hotro.aspx.cs" Inherits="View_hotro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .list-item-thuvien
        {
            padding-bottom: 0px;
        }
            .list-item-thuvien:nth-child(2n+0)
            {
                background-color: #c9dbff;
            }
            .list-item-thuvien:nth-child(2n+0) .cate-link{
                border-bottom: 1px dashed #FFF;
            }
            .list-item-thuvien .item-thuvien
            {
                width: 240px;
                height: 480px;
                float: left;
                margin: 40px 70px;
            }

                .list-item-thuvien .item-thuvien:nth-child(1)
                {
                    margin-left: 0px;
                }

                .list-item-thuvien .item-thuvien:nth-child(3)
                {
                    margin-right: 0px;
                }

                .list-item-thuvien .item-thuvien .item-thuvien-img
                {
                    height: 240px;
                    background-position: center center;
                    background-repeat: no-repeat;
                    background-size: cover;
                    border-radius:50%;
                }

                .list-item-thuvien .item-thuvien .item-thuvien-title
                {
                    font-size: 23px;
                    font-weight: 700;
                    text-align: center;
                    position: relative;
                    box-sizing: border-box;
                    padding: 10px 0px;
                    color: #000;
                }

                    .list-item-thuvien .item-thuvien .item-thuvien-title::after
                    {
                        content: " ";
                        width: 50%;
                        border-bottom: 1px solid #CCC;
                        position: absolute;
                        bottom: 5px;
                        left: 25%;
                    }

                .list-item-thuvien .item-thuvien .item-thuvien-des
                {
                    font-size: 15px;
                    color: #666666;
                    text-align: justify;
                    position: relative;
                    box-sizing: border-box;
                    padding: 5px 0px;
                    height: 112px;
                }

                .list-item-thuvien .item-thuvien .item-thuvien-btn
                {
                    height: 32px;
                    background-color: #ae4bce;
                    position: relative;
                }

                    .list-item-thuvien .item-thuvien .item-thuvien-btn::before
                    {
                        content: "<%=Lib.ContentLag("Xem thêm","More")%>";
                        position: absolute;
                        right: 30px;
                        top: 10px;
                        color: #FFF;
                    }

                    .list-item-thuvien .item-thuvien .item-thuvien-btn::after
                    {
                        content: url('../Images/Csaga/icon-xemthem.png');
                        position: absolute;
                        right: 05px;
                        top: 10px;
                    }
        .pagePhanTrang
        {
            padding-bottom:80px;
        }
        .panel-btn-guicauchuyenhotro
        {
            
            padding: 10px;
            text-align: left;
        }

            .panel-btn-guicauchuyenhotro .btn-guicauchuyenhotro
            {
                padding: 8px 20px;
                font-size: 15px;
                text-transform: uppercase;
                color: #FFF;
                background-color: #ae4bce;
                font-weight: 700;
                cursor: pointer;
            }

                .panel-btn-guicauchuyenhotro .btn-guicauchuyenhotro:hover
                {
                    background-color: #8e2bae;
                }
        [panel-addcauchuyen]
        {
            display: none;
            position: fixed;
            z-index: 1000;
            width: calc(100% - 20px);
            height: calc(100% - 20px);
            left: 10px;
            top: 10px;
            background-color: #FFF;
            box-shadow: 0px 0px 3px rgba(0,0,0,0.5);
            box-sizing: border-box;
        }

        [panel-addcauchuyen="show"]
        {
            display: block;
        }

        [panel-addcauchuyen] [btn-close]
        {
            display: block;
            width: 25px;
            height: 25px;
            position: absolute;
            z-index: 1;
            right: -3px;
            top: -7px;
            cursor: pointer;
            background-image: url('../Images/close-popupnew.png');
            background-position: center center;
            background-size: 15px;
            background-repeat: no-repeat;
            background-color: #FFF;
            border-radius: 50%;
            padding: 5px;
            box-sizing: border-box;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div panel-addcauchuyen>
        <span btn-close></span>
        <iframe style="width: 100%; height: 100%; position: absolute; top: 0px; left: 0px; border: 0px;" src="<%=Lib.urlhome %>/View/ThemCauHoi.aspx"></iframe>
    </div>
    <div class="panel_1k2" style="background-color: rgba(255,255,255,0.8); padding: 20px 0px;">
        <div style="clear: both; height: 0px;"></div>
        <div class="cate-link" style="padding-left: 10px; margin-bottom: 20px; border: none;margin-top:0px;">
            <span class="item-link-cate">
                <a href="<%=Lib.urlhome %>">Trang chủ</a>
            </span>
            <span class="item-link-cate">Alo tôi nghe
            </span>
        </div>
        <div style="clear: both; height: 0px;"></div>
        <%foreach (var cate in sql.getCategory().Where(d => d.Type == (int)Enums.LoaiTinTuc.HoTro))
          {%>
        <div class="list-item-thuvien" style="padding-top: 0px;">
            <div style="clear: both; height: 0px;"></div>
            <div class="cate-link" style="padding-left: 10px; margin-top: 0px; background-color: #ae4bce; padding-top: 9px; color: rgb(255, 255, 255); border: medium none;">

                <span class="item-link-cate">
                    <%=Lib.ContentLag(cate.TieuDe_Vn,cate.TieuDe_En) %>
                </span>
            </div>
            <div style="clear: both; height: 0px;"></div>
            <%if (cate.ID == 1023)
              { %>
            <div class="panel-btn-guicauchuyenhotro">
                <span class="btn-guicauchuyenhotro">Gửi câu hỏi tư vấn cho chúng tôi</span>
                <span style="display: block; margin-top: 20px;font-size:14px;">Nếu bạn đang gặp một tình huống cần được giải quyết, hãy ghi rõ và gửi câu hỏi cho chúng tôi bằng cách ấn vào phần “Gửi câu hỏi tư vấn cho chúng tôi” để được chuyên gia tư vấn giải đáp. Các thông tin cá nhân sẽ hoàn toàn được giữ bí mật, chúng tôi sẽ biên tập lại trước khi lên trang nếu cần thiết. Cảm ơn bạn.</span>
            </div>
            <%}%>
            <div style="clear: both; height: 0px;"></div>
            <div class="panel_1k arrayThuVien" id="view<%=cate.ID %>">
                <% 
              int totalRow = 0;
              int pageSelect = 1;
              int numInPage = 3;
              var thuVien = getThuVien(numInPage, cate.ID, out totalRow, out pageSelect);
              foreach (var item in thuVien.Select((value, i) => new { i, value }))
              {    
                %>

                <div class="item-thuvien">
                    <div class="item-thuvien-img" style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');"></div>
                    <a href="thuvien-<%=Lib.LocDau(item.value.TieuDe_Vn) %>-z-<%=item.value.ID %>.htm">
                        <div class="item-thuvien-title"><%=Lib.subString(item.value.TieuDe_Vn,40) %></div>
                    </a>
                    <div class="item-thuvien-des"><%=Lib.subString(item.value.Des_Vn,140) %></div>
                    <a href="thuvien-<%=Lib.LocDau(item.value.TieuDe_Vn) %>-z-<%=item.value.ID %>.htm">
                        <div class="item-thuvien-btn"></div>
                    </a>
                </div>

                <%}%>
                <div style="clear: both;"></div>
                <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5,"view"+cate.ID,"page"+cate.ID)%>
            </div>
            <div style="clear: both;"></div>
        </div>
        <%}%>

        <%--<%
            int totalRow = 0;
            int pageSelect = 1;
            int numInPage = 6;
            var thuVien = getThuVien(numInPage, out totalRow, out pageSelect);
            foreach (var item in thuVien.Select((value, i) => new { i, value }))
            {
        %>
        <%if (item.i == 0 || item.i == 3)
          { %>
        <div class="list-item-thuvien">
            <div class="panel_1k ">

                <%}%>


                <div class="item-thuvien">
                    <div class="item-thuvien-img" style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');"></div>
                    <div class="item-thuvien-title"><%=Lib.subString(item.value.TieuDe_En,40) %></div>
                    <div class="item-thuvien-des"><%=Lib.subString(item.value.Des_En,140) %></div>
                    <a href="thuvien-<%=Lib.LocDau(item.value.TieuDe_Vn) %>-z-<%=item.value.ID %>.htm">
                        <div class="item-thuvien-btn"></div>
                    </a>
                </div>

                <%if (item.i == 2 || item.i == 5)
                  { %>
                <div style="clear: both;"></div>
                <%if (item.i == 5)
                  { %>
                <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5,"viewnews")%>
                <%}%>
            </div>
        </div>
        <%}%>

        <%}%>
        <%if (thuVien.Count < 3 || thuVien.Count < 6)
          { %>
        <div style="clear: both;"></div>
        <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5,"viewnews")%>
    </div>
    </div>
                <%}%>
    <div style="clear: both; height: 0px;"></div>--%>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.panel-btn-guicauchuyenhotro .btn-guicauchuyenhotro').click(function () {
                $('[panel-addcauchuyen]').attr('panel-addcauchuyen', 'show');
            });
            $('[panel-addcauchuyen] [btn-close]').click(function () {
                $('[panel-addcauchuyen]').attr('panel-addcauchuyen', '');
            });
        });
        function closeThemCauChuyen() {
            $('[panel-addcauchuyen] [btn-close]').click();
        }
    </script>
</asp:Content>

