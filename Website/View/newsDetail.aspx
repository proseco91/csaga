<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="newsDetail.aspx.cs" Inherits="View_newsDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <meta property="og:url" content="<%=Lib.urlhome %><%=Request.RawUrl.ToString()%>" />
    <meta property="og:title" content="<%=tintuc.TieuDe_Vn %>" />
    <meta property="og:description" content="<%=tintuc.Des_Vn %>" />
    <meta property="og:type" content="website" />
    <meta property="og:image" content="<%=Lib.urlhome %>/cat-anh.htm?url=http://nuyeunu.vn/<%="Images/imageUpload/"+tintuc.Img %>&width=500" />
    <meta property="og:image:url"  content="<%=Lib.urlhome %>/cat-anh.htm?url=http://nuyeunu.vn/<%="Images/imageUpload/"+tintuc.Img %>&width=500" />
    
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

        .panel-comment {
            border-top: 1px solid #CCC;
            margin-top: 20px;
            padding-top: 20px;
        }

            .panel-comment .panel-comment-input {
                position: relative;
                text-align: right;
            }

                .panel-comment .panel-comment-input input {
                    display: inline-block;
                    width: calc(100% - 140px);
                    height: 100%;
                    position: absolute;
                    left: 0px;
                    top: 0px;
                    box-sizing: border-box;
                    border: 1px solid #DDD;
                    padding: 3px 10px;
                }

                .panel-comment .panel-comment-input .btn-comment {
                    width: 130px;
                    background-color: #ae4bce;
                    display: inline-block;
                    height: 35px;
                    font-size: 17px;
                    color: #FFF;
                    text-align: center;
                    box-sizing: border-box;
                    line-height: 35px;
                    cursor: pointer;
                }

                    .panel-comment .panel-comment-input .btn-comment:hover {
                        background-color: #c663e6;
                    }

        .panel-comment-lst {
            margin-top: 20px;
        }

        .item-comment {
            position: relative;
            border-bottom: 1px dashed #DDD;
            margin-bottom: 10px;
            padding-bottom: 10px;
        }

            .item-comment .item-comment-avarta {
                position: absolute;
                top: 0px;
                left: 0px;
                width: 60px;
                height: 60px;
                background-position: center center;
                background-repeat: no-repeat;
                background-size: cover;
                box-sizing: border-box;
                border: 2px solid #EEE;
                border-radius: 3px;
            }

            .item-comment .item-comment-content {
                margin-left: 70px;
                font-size: 12px;
            }

                .item-comment .item-comment-content .item-comment-content-name {
                    font-weight: 700;
                }

                .item-comment .item-comment-content .item-comment-content-text {
                    text-align: justify;
                }

                .item-comment .item-comment-content .item-comment-content-date {
                    color: #888;
                    text-align: right;
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
                <a href="<%=Lib.urlhome + "/" + (Lib.getLag().Equals("vi-VN") ? "vi" : "en") + "/" + Enums.LoaiTinTucHrefTrangChu((Enums.LoaiTinTuc)tintuc.Type) %>">
                    <%=Enums.LoaiTinTucDesc((Enums.LoaiTinTuc)tintuc.Type) %>
                </a>

            </span>
            <%if (!string.IsNullOrEmpty(tintuc.Category))
                                           { %>
            <span class="item-link-cate">
                <a href="<%=Lib.urlhome + "/" + (Lib.getLag().Equals("vi-VN") ? "vi" : "en") + "/" + Enums.LoaiTinTucHrefTrangChu((Enums.LoaiTinTuc)tintuc.Type) + "#view" + tintuc.Category %>">
                    <%=Lib.ContentLag(sql.getCategory().Where(d => d.ID == Convert.ToInt32(tintuc.Category)).FirstOrDefault().TieuDe_Vn, sql.getCategory().Where(d => d.ID == Convert.ToInt32(tintuc.Category)).FirstOrDefault().TieuDe_En) %>
                </a>
            </span>
            <%} %>
        </div>
        <div style="padding: 20px;">
            <div class="detail-title">
                <%=tintuc.TieuDe_Vn %>
            </div>

            <div class="detail-date" style="position: relative;">
                <%=tintuc.NgayHienThi.ToString("dd-MM-yyyy lúc HH:mm") %>
                <div class="fb-share-button" data-href="http://nuyeunu.vn<%=Request.RawUrl.ToString()%>" data-layout="button_count" data-size="small" data-mobile-iframe="true" style="position: absolute; right: 0px; top: 0px;">Chia sẻ</div>
            </div>
            <div class="detail-des">
                <%=tintuc.Des_Vn %>
            </div>
            <div style="border-bottom: 1px dotted #CCC; margin-top: 20px;"></div>
            <div class="detail-content">
                <%=tintuc.NoiDung_Vn %>
            </div>
            <div style="border:1px dashed #cdcdcd;border-right:none;border-left:none;margin:20px 0px;padding:20px 0px;">
                <%foreach (var item in ((tintuc.HashTag) ?? string.Empty).Split(',').Where(d => !string.IsNullOrEmpty(d))){%>
                <span style="background-color:#77018b;padding:2px 8px;font-size:12px;color:#FFF;display:inline-block;margin-right:10px;">#<%=item.Trim() %></span>
                <%}%>
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
            <div class="panel-comment">
                <div class="panel-comment-input">
                    <input type="text" placeholder="<%=Lib.ContentLag("Bình luận ...","Comment ...") %>" maxlength="200" />
                    <span class="btn-comment"><%=Lib.ContentLag("Bình luận","Comment") %></span>
                </div>

                <div class="panel-comment-lst">
                    <%foreach (var item in getComment())
                        {%>
                    <div class="item-comment">
                        <div class="item-comment-avarta" style="background-image: url('<%=Lib.urlhome%>/Images/noavatar-2.gif');"></div>
                        <div class="item-comment-content">
                            <div class="item-comment-content-name"><%=Lib.ContentLag("Giấu tên","Anonymous") %></div>
                            <div class="item-comment-content-text"><%=item.Comment1 %></div>
                            <div class="item-comment-content-date"><%=item.CreateDate.ToString("dd-MM-yyyy lúc HH:mm") %></div>
                        </div>
                    </div>
                    <%}%>
                </div>
                <script type="text/javascript">
                    $(document).ready(function () {
                        $('.panel-comment-input input').keypress(function (event) {
                            if (event.which == 13) {
                                $('.btn-comment').click();
                                event.preventDefault();
                            }
                        });
                        $('.btn-comment').click(function () {

                            var txtComment = $.trim($('.panel-comment-input input').val());
                            if (txtComment.length > 0) {
                                $.ajax({
                                    type: "POST",
                                    url: "<%=Lib.urlhome %>/service/service.asmx/addCommnet",
                                    data: "{'idTin':'<%=tintuc.ID %>','comment':" + JSON.stringify(txtComment) + "}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    beforeSend: function () {
                                        $('#loading_masster').css({ 'display': 'block' });
                                    },
                                    success: function (message) {
                                        var data = JSON.parse(message.d);
                                        var html = '<div class="item-comment">\
                                                        <div class="item-comment-avarta" style="background-image: url(\'<%=Lib.urlhome%>/Images/noavatar-2.gif\');"></div>\
                                                        <div class="item-comment-content">\
                                                            <div class="item-comment-content-name">'+ (lag == '' ? 'Giấu tên' : 'Anonymous') + '</div>\
                                                            <div class="item-comment-content-text">'+ data.Comment1 + '</div>\
                                                            <div class="item-comment-content-date">'+ data.CreateDateTxt + '</div>\
                                                        </div>\
                                                    </div>';
                                        $('.panel-comment-lst').prepend(html);
                                        $('.panel-comment-input input').val('');
                                        lib.message(true,'<%=Lib.ContentLag("Thêm bình luận thành công.","Add comment succeed.") %>');
                                        $('#loading_masster').css({ 'display': 'none' });
                                    },
                                    error: function (errormessage) {
                                        lib.message(true,'<%=Lib.ContentLag("Thêm bình luận thất bại.","Add comment failed.") %>');
                                        $('.htm_loading_page').css({ 'display': 'none' });
                                    }
                                });
                            } else {
                                lib.message(false,'<%=Lib.ContentLag("Nhập nội dung bình luận.","Enter comment.") %>');
                            }
                        });

                    });
                </script>
            </div>
        </div>
    </div>
    <div style="clear: both; height: 100px;"></div>
</asp:Content>

