<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="hinhanhcongdong-chitiet.aspx.cs" Inherits="View_hinhanhcongdong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .hotro-left
        {
            width: 600px;
            padding: 20px;
            box-sizing: border-box;
            float: left;
        }

        .detail-title
        {
            color: #000;
            font-size: 32px;
            text-align: justify;
        }

            .detail-title:first-letter
            {
                text-transform: uppercase;
            }

        .detail-des
        {
            color: #777;
            font-size: 17px;
            margin-top: 10px;
            text-align: justify;
        }

        .detail-date
        {
            color: #888;
            font-size: 13px;
        }

        .detail-content
        {
            color: #000;
            font-size: 17px;
            margin-top: 10px;
            text-align: justify;
        }

            .detail-content img
            {
                text-align: center;
                border: 1px solid #CCC;
                padding: 2px;
                max-width: 100%;
                height: auto;
            }

        .hotro-right
        {
            float: left;
            width: calc(100% - 600px);
            height: 1020px;
        }

        #map
        {
            height: 100%;
            width: 100%;
        }

        .pagePhanTrang
        {
            text-align: right;
        }

        .panel-comment
        {
            border-top: 1px solid #CCC;
            margin-top: 20px;
            padding-top: 20px;
        }

            .panel-comment .panel-comment-input
            {
                position: relative;
                text-align: right;
            }

                .panel-comment .panel-comment-input input
                {
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

                .panel-comment .panel-comment-input .btn-comment
                {
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

                    .panel-comment .panel-comment-input .btn-comment:hover
                    {
                        background-color: #c663e6;
                    }

        .panel-comment-lst
        {
            margin-top: 20px;
        }

        .item-comment
        {
            position: relative;
            border-bottom: 1px dashed #DDD;
            margin-bottom: 10px;
            padding-bottom: 10px;
        }

            .item-comment .item-comment-avarta
            {
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

            .item-comment .item-comment-content
            {
                margin-left: 70px;
                font-size: 12px;
            }

                .item-comment .item-comment-content .item-comment-content-name
                {
                    font-weight: 700;
                }

                .item-comment .item-comment-content .item-comment-content-text
                {
                    text-align: justify;
                }

                .item-comment .item-comment-content .item-comment-content-date
                {
                    color: #888;
                    text-align: right;
                }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Banner" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" runat="Server">
    <div class="panel_1k2">
        <div class="hotro-left" id="viewnews">
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
                    $(document).ready(function(){
                        $('.panel-comment-input input').keypress(function( event ) {
                            if ( event.which == 13 ) {
                                $('.btn-comment').click();
                                event.preventDefault();
                            }
                        });
                        $('.btn-comment').click(function(){

                            var txtComment = $.trim($('.panel-comment-input input').val());
                            if(txtComment.length>0){
                                $.ajax({
                                    type: "POST",
                                    url: "<%=Lib.urlhome %>/service/service.asmx/addCommnet",
                                    data: "{'idTin':'<%=tintuc.ID %>','comment':"+JSON.stringify(txtComment)+"}",
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
                                                            <div class="item-comment-content-name">'+(lag==''?'Giấu tên':'Anonymous')+'</div>\
                                                            <div class="item-comment-content-text">'+data.Comment1+'</div>\
                                                            <div class="item-comment-content-date">'+data.CreateDateTxt+'</div>\
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
                                }else{
                                    lib.message(false,'<%=Lib.ContentLag("Nhập nội dung bình luận.","Enter comment.") %>');
                            }
                        });
                        
                    });
                </script>
            </div>
        </div>
        <div class="hotro-right">
            <div id="map"></div>
            <script>
                var arrayMarker = [];
                var arrayWindow = [];
                function initMap() {
                    var map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 10,
                        center: { lat: <%=thanhpho.lat.Value.ToString().Replace(",",".")%>, lng: <%=thanhpho.lng.Value.ToString().Replace(",",".")%> }
                    });
                    $.each(<%=getThanhPhoSoLuong()%>,function(index,item){
                        addMarker({ lat: item.lat, lng: item.lng }, map,item.name,item.count);
                    });
                    

                }
                function addMarker(location, map,name,count) {
                    // Add the marker at the clicked location, and add the next-available label
                    // from the array of alphabetical characters.
                    var infowindow = new google.maps.InfoWindow({
                        content: '<div style="background-color:#FFF;text-align:center;">Khu vực '+name+'<br/>'+count+' câu chuyện được đăng</div>'
                    });
                    var marker = new google.maps.Marker({
                        position: location,
                        animation: google.maps.Animation.DROP,
                        map: map,
                        icon:'<%=Lib.urlhome%>/Images/Csaga/iconMap.png'
                    });
                    marker.addListener('click', function(){
                        $.each(arrayMarker,function(index,item){
                            if (item!=marker && item.getAnimation() !== null) {
                                item.setAnimation(null);
                                arrayWindow[index].close();
                            }
                        });
                        if (marker.getAnimation() !== null) {
                            marker.setAnimation(null);
                            infowindow.close();
                        } else {
                            marker.setAnimation(google.maps.Animation.BOUNCE);
                            infowindow.open(map, marker);

                        }
                    });
                    arrayMarker.push(marker);
                    arrayWindow.push(infowindow);
                }
     

            </script>
            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBTwFsp9CfUVh-a_B7ql4J0A6NtLqjBHI8&callback=initMap&language=vi&region=VI" async defer></script>

        </div>
        <div style="clear: both;"></div>
    </div>
</asp:Content>

