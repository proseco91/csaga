<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="newsDetail.aspx.cs" Inherits="View_newsDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <meta property="og:url" content="http://nuyeunu.vn<%=Request.RawUrl.ToString()%>" />
    <meta property="og:title" content="<%=tintuc.TieuDe_Vn %>" />
    <meta property="og:description" content="<%=tintuc.Des_Vn %>" />
    <meta property="og:type" content="website" />
    <meta property="og:image" content="http://megasage.com/cat-anh.htm?url=http://nuyeunu.vn/<%="Images/imageUpload/"+tintuc.Img %>&width=500" />
    <meta property="og:image:url" content="http://megasage.com/cat-anh.htm?url=http://nuyeunu.vn/<%="Images/imageUpload/"+tintuc.Img %>&width=500" />
    <style type="text/css">
        .panel_1k {
            text-align: justify;
        }

        .detail-title {
            color: #000;
            font-size: 32px;
        }

            .detail-title:first-letter {
                text-transform: uppercase;
            }

        .detail-des {
            color: #777;
            font-size: 17px;
            margin-top: 10px;
        }

        .detail-date {
            color: #888;
            font-size: 13px;
        }

        .detail-content {
            color: #000;
            font-size: 17px;
            margin-top: 10px;
            text-align: justify;
        }

            .detail-content img {
                text-align: center;
                border: 1px solid #CCC;
                padding: 2px;
                max-width: 100%;
                height: auto;
            }

        .detail-tintuckhac {
            color: #205bd1;
            font-size: 23px;
            font-weight: 500;
            text-transform: uppercase;
            margin-top: 50px;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div class="panel_1k2" style="background-color: rgba(255,255,255,0.8); padding: 20px 0px;">
        <div class="cate-link" style="padding-left: 20px; margin-bottom: 20px; border: none; margin-top: 0px;">
            <span class="item-link-cate">
                <a href="<%=Lib.urlhome %>">Trang chủ</a>
            </span>
            <span class="item-link-cate">
                <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/"+Enums.LoaiTinTucHrefTrangChu((Enums.LoaiTinTuc)tintuc.Type) %>">
                    <%=Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)tintuc.Type) %>
                </a>

            </span>
            <%if (!string.IsNullOrEmpty(tintuc.Category))
                { %>
            <span class="item-link-cate">
                <a href="<%=Lib.urlhome+"/"+(Lib.getLag().Equals("vi-VN")?"vi":"en")+"/"+Enums.LoaiTinTucHrefTrangChu((Enums.LoaiTinTuc)tintuc.Type)+"#view"+tintuc.Category %>">
                    <%=Lib.ContentLag(sql.getCategory().Where(d=>d.ID==Convert.ToInt32(tintuc.Category)).FirstOrDefault().TieuDe_Vn,sql.getCategory().Where(d=>d.ID==Convert.ToInt32(tintuc.Category)).FirstOrDefault().TieuDe_En) %>
                </a>
            </span>
            <%} %>
        </div>
        <div style="padding:20px;">
            <div class="detail-title">
                <%=tintuc.TieuDe_Vn %>
            </div>
            <div class="detail-date">
                <%=tintuc.CreateDate.ToString("dd-MM-yyyy lúc HH:mm") %>
            </div>
            <div class="detail-des">
                <%=tintuc.Des_Vn %>
            </div>
            <div style="border-bottom: 1px dotted #CCC; margin-top: 20px;"></div>
            <div class="detail-content">
                <%=tintuc.NoiDung_Vn %>
            </div>
            <div class="detail-tintuckhac">
                Các tin tức khác
            </div>
            <%foreach (var item in getTinTucKhac())
                {%>
            <a href="<%=Lib.urlChiTiet((Enums.LoaiTinTuc)item.Type) %>-<%=Lib.LocDau(item.TieuDe_Vn) %>-z-<%=item.ID %>.htm">
                <div class="detail-tintuckhac-item">
                    <%=item.TieuDe_Vn %>
                </div>
            </a>
            <%} %>
        </div>
    </div>
    <div style="clear: both; height: 100px;"></div>
</asp:Content>

