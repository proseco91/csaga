<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/Home.master" AutoEventWireup="true" CodeFile="hinhanhcongdong.aspx.cs" Inherits="View_hinhanhcongdong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="Server">
    <style type="text/css">
        .hotro-left
        {
            width: calc(100% / 3 * 2);
            padding: 20px;
            padding-left: 0px;
            box-sizing: border-box;
            float: left;
        }

        .hinhanhcongdong-item
        {
            height: 300px;
            position: relative;
            margin-bottom: 20px;
        }

            .hinhanhcongdong-item .hinhanhcongdong-item-img
            {
                height: 300px;
                width: 270px;
                background-position: center center;
                background-repeat: no-repeat;
                background-size: cover;
                position: absolute;
                left: 5px;
                top: 0px;
            }

            .hinhanhcongdong-item .hinhanhcongdong-item-content
            {
                margin-left: 290px;
                position: relative;
                height: 300px;
            }

            .hinhanhcongdong-item .hinhanhcongdong-item-title
            {
                font-size: 20px;
                font-weight: 700;
                max-height: 64px;
                overflow: hidden;
            }

            .hinhanhcongdong-item .hinhanhcongdong-item-date
            {
                font-size: 15px;
                color: #555;
            }

            .hinhanhcongdong-item .hinhanhcongdong-item-des
            {
                margin-top: 5px;
                border-top: 1px dashed #DDD;
                font-size: 15px;
                color: #444;
                padding-top: 10px;
                max-height: 145px;
                overflow: hidden;
            }

            .hinhanhcongdong-item .item-hotro-btn
            {
                height: 32px;
                background-color: #ae4bce;
                position: absolute;
                bottom: 0px;
                width: 100%;
            }

                .hinhanhcongdong-item .item-hotro-btn::before
                {
                    content: "<%=Lib.ContentLag("Xem thêm","More")%>";
                    position: absolute;
                    right: 30px;
                    top: 10px;
                    color: #FFF;
                }

                .hinhanhcongdong-item .item-hotro-btn::after
                {
                    content: url('../Images/Csaga/icon-xemthem.png');
                    position: absolute;
                    right: 05px;
                    top: 10px;
                }

        .hotro-right
        {
            float: left;
            width: calc(100% / 3 * 1);
            height: 1156px;
            box-sizing: border-box;
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

        .panel-btn-guicauchuyen
        {
            
            padding-bottom: 0px;
            text-align: left;
        }

            .panel-btn-guicauchuyen .btn-guicauchuyen
            {
                padding: 8px 20px;
                font-size: 15px;
                text-transform: uppercase;
                color: #FFF;
                background-color: #ae4bce;
                font-weight: 700;
                cursor: pointer;
            }

                .panel-btn-guicauchuyen .btn-guicauchuyen:hover
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
        <iframe style="width: 100%; height: 100%; position: absolute; top: 0px; left: 0px; border: 0px;" src="<%=Lib.urlhome %>/View/ThemCauChuyen.aspx"></iframe>
    </div>
    <div class="panel_1k2" style="background-color: rgba(255,255,255,0.8); padding: 0px 0px;">
        <div class="hotro-left" id="viewnews">
            <div class="cate-link" style="padding-left: 10px;">
                <span class="item-link-cate">
                    <a href="<%=Lib.urlhome %>">Trang chủ</a>
                </span>
                <span class="item-link-cate">Tôi là nữ yêu nữ
                </span>
            </div>
            <div class="panel-btn-guicauchuyen">
                <span class="btn-guicauchuyen">Mời bạn gửi câu chuyện của mình tại đây</span>
                <span style="display: block; margin-top: 20px;font-size:14px;">Để chia sẻ câu chuyện của bản thân hoặc của người mà bạn quen biết, hãy gửi về cho chúng tôi bằng cách ấn vào phần “Mời bạn gửi câu chuyện của mình tại đây”. Các thông tin cá nhân sẽ hoàn toàn được giữ bí mật, chúng tôi sẽ biên tập lại trước khi lên trang nếu cần thiết. Cảm ơn bạn.</span>
            </div>
            <div style="clear: both; height: 10px;border-top:1px dashed #CCC;margin-top:5px;"></div>
            <%
                int totalRow = 0;
                int pageSelect = 1;
                int numInPage = 3;
                foreach (var item in getHinhAnh(numInPage, out totalRow, out pageSelect).Select((value, i) => new { i, value }))
                {
            %>

            <div class="hinhanhcongdong-item">
                <div class="hinhanhcongdong-item-img" style="background-image: url('<%=Lib.urlhome+"/Images/imageUpload/"+item.value.Img %>');">
                </div>
                <div class="hinhanhcongdong-item-content">
                    <div class="hinhanhcongdong-item-title">
                        <%=Lib.subString(item.value.TieuDe_Vn,110) %>
                    </div>
                    <div class="hinhanhcongdong-item-date">
                        <%=item.value.CreateDate.ToString("dd-MM-yyyy lúc HH:mm") %>
                    </div>
                    <div class="hinhanhcongdong-item-des">
                        <%=item.value.Des_Vn %>
                    </div>
                    <a href="chitiet-hinh-anh-cong-dong-<%=Lib.LocDau(item.value.TieuDe_Vn) %>-z-<%=item.value.ID %>.htm">
                        <div class="item-hotro-btn"></div>
                    </a>
                </div>
            </div>
            <%}%>
            <div style="clear: both; height: 0px;"></div>
            <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5,"viewnews")%>
            <div style="clear: both; height: 25px;"></div>
            
        </div>
        <div class="hotro-right">
            <div id="map"></div>
            <script>
                var arrayMarker = [];
                var arrayWindow = [];
                function initMap() {
                    var map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 6,
                        center: { lat: 18.565253, lng: 104.732666 }
                    });
                    $.each(<%=getThanhPhoSoLuong()%>, function (index, item) {
                        addMarker({ lat: item.lat, lng: item.lng }, map, item.name, item.count);
                    });


                }
                function addMarker(location, map, name, count) {
                    // Add the marker at the clicked location, and add the next-available label
                    // from the array of alphabetical characters.
                    var infowindow = new google.maps.InfoWindow({
                        content: '<div style="background-color:#FFF;text-align:center;">Khu vực ' + name + '<br/>' + count + ' câu chuyện được đăng</div>'
                    });
                    var marker = new google.maps.Marker({
                        position: location,
                        animation: google.maps.Animation.DROP,
                        map: map,
                        icon:'<%=Lib.urlhome%>/Images/Csaga/iconMap.png'
                    });
                    marker.addListener('click', function () {
                        $.each(arrayMarker, function (index, item) {
                            if (item != marker && item.getAnimation() !== null) {
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
    <script type="text/javascript">
                $(document).ready(function () {
                    $('.panel-btn-guicauchuyen .btn-guicauchuyen').click(function () {
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

