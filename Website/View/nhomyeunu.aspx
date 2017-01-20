<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="nhomyeunu.aspx.cs" Inherits="View_nhomyeunu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .item-nhomyeunu {
            height: 500px;
            position: relative;
        }

            .item-nhomyeunu .item-nhomyeunu-tennhom {
                width: 600px;
                position: absolute;
                height: 100%;
                background-color: #c9dbff;
                box-sizing: border-box;
                padding: 50px;
                text-align: center;
            }

                .item-nhomyeunu .item-nhomyeunu-tennhom .item-nhomyeunu-tennhom-img {
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

                .item-nhomyeunu .item-nhomyeunu-tennhom .item-nhomyeunu-tennhom-name {
                    font-size: 28px;
                    color: #000000;
                    font-weight: bold;
                    overflow: hidden;
                    white-space: nowrap;
                    text-overflow: ellipsis;
                }

                .item-nhomyeunu .item-nhomyeunu-tennhom .item-nhomyeunu-tennhom-info {
                    color: #333333;
                    font-size: 17px;
                    margin-top: 5px;
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
        </div>
        <%}%>
    </div>

</asp:Content>

