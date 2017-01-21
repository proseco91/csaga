<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="thuvien.aspx.cs" Inherits="View_thuvien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .list-item-thuvien
        {
            padding-bottom: 0px;
        }
            .list-item-thuvien:nth-child(2)
            {
                background-color: #c9dbff;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div style="clear: both; height: 30px;"></div>
    <div id="viewnews">
        <%
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
    <div style="clear: both; height: 0px;"></div>
    </div>
</asp:Content>

