<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="thuvien.aspx.cs" Inherits="View_thuvien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .list-item-thuvien {
            padding-bottom: 0px;
        }

            .list-item-thuvien:nth-child(2) {
                background-color: #c9dbff;
            }

            .list-item-thuvien .item-thuvien {
                width: 240px;
                height: 480px;
                float: left;
                margin: 40px 70px;
            }

                .list-item-thuvien .item-thuvien:nth-child(1) {
                    margin-left: 0px;
                }

                .list-item-thuvien .item-thuvien:nth-child(3) {
                    margin-right: 0px;
                }

                .list-item-thuvien .item-thuvien .item-thuvien-img {
                    height: 240px;
                    background-position: center center;
                    background-repeat: no-repeat;
                    background-size: contain;
                }

                .list-item-thuvien .item-thuvien .item-thuvien-title {
                    font-size: 23px;
                    font-weight: 700;
                    text-align: center;
                    position: relative;
                    box-sizing: border-box;
                    padding: 10px 0px;
                    color:#000;
                }

                    .list-item-thuvien .item-thuvien .item-thuvien-title::after {
                        content: " ";
                        width: 50%;
                        border-bottom: 1px solid #CCC;
                        position: absolute;
                        bottom: 5px;
                        left: 25%;
                    }

                .list-item-thuvien .item-thuvien .item-thuvien-des {
                    font-size: 15px;
                    color:#666666;
                    text-align: justify;
                    position: relative;
                    box-sizing: border-box;
                    padding: 5px 0px;
                    background-color:#FFF;
                    height:112px;
                }
                .list-item-thuvien .item-thuvien .item-thuvien-btn {
                    height:32px;
                    background-color:#ae4bce;
                    position:relative;
                }
                    .list-item-thuvien .item-thuvien .item-thuvien-btn::before {
                        content:"Xem thêm";
                        position:absolute;
                        right:30px;
                        top:10px;
                    }
                    .list-item-thuvien .item-thuvien .item-thuvien-btn::after {
                        content:url('../Images/Csaga/icon-xemthem.png');
                        position:absolute;
                        right:05px;
                        top:10px;
                    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div style="clear: both; height: 30px;"></div>
    <div class="panel_1k" id="viewnews">
        <div class="list-item-thuvien">
            <div class="item-thuvien">
                <div class="item-thuvien-img" style="background-image: url('data:image/jpeg;base64,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');"></div>
                <div class="item-thuvien-title"><%=Lib.subString("Feel - DJ Ben Heineken ReDmix Feel - DJ Ben Heineken ReDmix Feel - DJ Ben Heineken ReDmix",40) %></div>
                <div class="item-thuvien-des"><%=Lib.subString("Feel - DJ Ben Heineken ReDmix Feel - DJ Ben Heineken ReDmix Feel - DJ Ben Heineken ReDmixFeel - DJ Ben Heineken ReDmix Feel - DJ Ben Heineken ReDmix Feel - DJ Ben Heineken ReDmixFeel - DJ Ben Heineken ReDmix Feel - DJ Ben Heineken ReDmix Feel - DJ Ben Heineken ReDmix",140) %></div>
                <a href=""><div class="item-thuvien-btn"></div></a>
            </div>
            <div class="item-thuvien">
            </div>
            <div class="item-thuvien">
            </div>
            <div style="clear: both;"></div>
        </div>
        <div class="list-item-thuvien">
            <div class="item-thuvien">
            </div>
            <div class="item-thuvien">
            </div>
            <div class="item-thuvien">
            </div>
            <div style="clear: both;"></div>
        </div>
        <div style="clear: both; height: 0px;"></div>
        <%--<%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5,"viewnews")%>--%>
    </div>
    <div style="clear: both; height: 100px;"></div>
</asp:Content>

