function uploadSucFile(filename, dataname) {
    $('*[name="' + dataname + '"]').css('background-image', 'url("' + urlhome + '/images/imageUpload/' + filename + '")').attr('valfile', filename);
}
var indexTotal = 0;

function loadStrucDeThi() {

    if (strucdata.length > 0 && typeof strucdata[0].arrayQuestion != 'undefined') {
        $.each(strucdata, function (index, item) {
            $('.addContext').append(createHtmlParent());
            createEventParent(indexTotal);
            var itemNgayparent = $('#itemNgay' + indexTotal);
            CKEDITOR.instances[itemNgayparent.find('.parentTitle-Data').attr('id')].setData(item.title);
            indexTotal++;
            $.each(item.arrayQuestion, function (indexQu, itemQe) {
                itemNgayparent.find('.parentTinhHuong').append(createHtmlTinhHuong());
                var _htmlpage = createHtmlPage().replace("sotrang", itemNgayparent.find('.itemTinhHuong').size());
                itemNgayparent.find('.itemTinhHuong-Page').append(_htmlpage);
                var parrentTH = $('.itemTinhHuong[name="itemTinhHuong' + indexTotal + '"]');
                parrentTH.find('.itemTinhHuong-List-Type').attr('valitem', itemQe.type);

                createEventPage(indexTotal);
                createEventTinhHuong(indexTotal);
                $('span[name="itemTinhHuong-PageItem' + indexTotal + '"]').click();
                parrentTH.find('.textarea_titleAll').val(itemQe.itemPanelKeoTha.title);
                //                parrentTH.find('.admin-panelKeoTha-Cau').find('textarea').eq(0).val(itemQe.itemPanelKeoTha.title).trigger('autosize.resize');
                parrentTH.find('.admin-panelKeoTha-Cau').find('textarea').eq(1).val(itemQe.itemPanelKeoTha.content).focusout().trigger('autosize.resize');

                //                parrentTH.find('.admin-panelDienCau-Cau').find('textarea').eq(0).val(itemQe.itemDienCau.title).trigger('autosize.resize');
                parrentTH.find('.admin-panelDienCau-Cau').find('textarea').eq(1).val(itemQe.itemDienCau.content).focusout().trigger('autosize.resize');

                //                parrentTH.find('.admin-panelMatching-Cau').find('textarea').eq(0).val(itemQe.itemMatching.title).trigger('autosize.resize');
                parrentTH.find('.admin-panelMatching-Cau').find('textarea').eq(1).val(itemQe.itemMatching.content).focusout().trigger('autosize.resize');

                //                parrentTH.find('.admin-panelPhanLoai-Cau').find('.textareaTieuDe').val(itemQe.itemPhanLoai.title).trigger('autosize.resize');
                parrentTH.find('.admin-panelPhanLoai-Cau').find('.inputPl').eq(0).val(itemQe.itemPhanLoai.title1);
                parrentTH.find('.admin-panelPhanLoai-Cau').find('.textareaPl').eq(0).val(itemQe.itemPhanLoai.content1).trigger('autosize.resize');
                parrentTH.find('.admin-panelPhanLoai-Cau').find('.inputPl').eq(1).val(itemQe.itemPhanLoai.title2);
                parrentTH.find('.admin-panelPhanLoai-Cau').find('.textareaPl').eq(1).val(itemQe.itemPhanLoai.content2).trigger('autosize.resize');

                //                parrentTH.find('.admin-ChonLuaDapAn-Cau').find('textarea').eq(0).val(itemQe.itemLuaChon.title).trigger('autosize.resize');
                parrentTH.find('.admin-ChonLuaDapAn-Cau').find('textarea').eq(1).val(itemQe.itemLuaChon.content).focusout().trigger('autosize.resize');

                parrentTH.find('.itembaihoclienquan').val(itemQe.itembaihoclienquan);

                //                parrentTH.find('.admin-Image-Cau').find('textarea').eq(0).val(itemQe.itemImage.title).trigger('autosize.resize');
                var _dataPanelImg = parrentTH.find('.admin-Image-Cau-Img-Data');
                _dataPanelImg.attr('valfile', itemQe.itemImage.urlimage).css({ 'background-image': 'url("../images/imageUpload/' + itemQe.itemImage.urlimage + '")', 'height': itemQe.itemImage.height + 'px' });
                $.each(itemQe.itemImage.arrayPixel, function (indexPixel, itemPixel) {
                    var _txtEnter = _dataPanelImg.append('<div class="admin-Image-Cau-Img-Data-Pixel-Item" style="top:' + (itemPixel.offset.top - 9) + 'px;left:' + (itemPixel.offset.left - 9) + 'px;" valpixel="{<!>top<!>:' + itemPixel.offset.top + ',<!>left<!>:' + itemPixel.offset.left + '}"><span class="admin-Image-Cau-Img-Data-Pixel-ItemEff"></span><span class="admin-Image-Cau-Img-Data-Pixel-ItemText">' + itemPixel.text + '</span><input type="text" value="' + itemPixel.text + '"/></div>');
                    _txtEnter.find('input:text').keyup(function (event) {
                        $(this).prev('.admin-Image-Cau-Img-Data-Pixel-ItemText').text($(this).val());
                    }).keyup();
                    _txtEnter.find('.admin-Image-Cau-Img-Data-Pixel-ItemEff').click(function (event) {
                        $(this).parent('.admin-Image-Cau-Img-Data-Pixel-Item').remove();
                    }).keyup();
                });
                //
                //                var itemImage = {
                //                    title: $(this).find('.admin-Image-Cau').find('textarea').eq(0).val(),
                //                    urlimage: _dataImg.attr('valfile'),
                //                    width: _dataImg.outerWidth(),
                //                    height: _dataImg.outerHeight(),
                //                    arrayPixel: arrayPixel
                //                };

                indexTotal++;
            });
        });
    }
}

$(document).ready(function () {

    

    $('.btnAddNgay').click(function () {
        $('.addContext').append(createHtmlParent());
        createEventParent(indexTotal);
        indexTotal++;
    });
    //$(document).keydown(function (event) {
    //    if (event.ctrlKey == true && (event.which == '118' || event.which == '83')) {
    //        event.preventDefault();
    //        if ($('.popuplammo').css('display') == 'none') {
    //            createJsonSave();
    //        }
    //    }
    //});
    loadStrucDeThi();
});
function createJsonSave() {
    $('.popuplammo').css('display', 'block');
    var _arraySave = [];
    $('.itemNgay').each(function (indexEx) {
        var _arrayQuestion = [];
        $(this).find('.itemTinhHuong').each(function (indexQuestion) {
            var _type = parseInt($(this).find('.itemTinhHuong-List-Type').attr('valitem'));
            var itemPanelKeoTha = {
                title: CKEDITOR.instances[$(this).find('.textarea_titleAll').attr('id')].getData(),
                content: $(this).find('.admin-panelKeoTha-Cau').find('textarea').eq(1).val()
            };
            var itemDienCau = {
                title: CKEDITOR.instances[$(this).find('.textarea_titleAll').attr('id')].getData(),
                content: $(this).find('.admin-panelDienCau-Cau').find('textarea').eq(1).val()
            };
            var itemMatching = {
                title: CKEDITOR.instances[$(this).find('.textarea_titleAll').attr('id')].getData(),
                content: $(this).find('.admin-panelMatching-Cau').find('textarea').eq(1).val()
            };
            var itemPhanLoai = {
                title: CKEDITOR.instances[$(this).find('.textarea_titleAll').attr('id')].getData(),
                title1: $(this).find('.admin-panelPhanLoai-Cau').find('.inputPl').eq(0).val(),
                content1: $(this).find('.admin-panelPhanLoai-Cau').find('.textareaPl').eq(0).val(),
                title2: $(this).find('.admin-panelPhanLoai-Cau').find('.inputPl').eq(1).val(),
                content2: $(this).find('.admin-panelPhanLoai-Cau').find('.textareaPl').eq(1).val()
            };
            var itemLuaChon = {
                title: CKEDITOR.instances[$(this).find('.textarea_titleAll').attr('id')].getData(),
                content: $(this).find('.admin-ChonLuaDapAn-Cau').find('textarea').eq(1).val()
            };
            var _dataImg = $(this).find('.admin-Image-Cau').find('.admin-Image-Cau-Img-Data');
            var arrayPixel = [];
            _dataImg.find('.admin-Image-Cau-Img-Data-Pixel-Item').each(function (indexPixel) {
                var itemImagePixel = {
                    text: $(this).find('input:text').val(),
                    offset: $.parseJSON($(this).attr('valpixel').replace(new RegExp('<!>', "g"), '"'))
                };
                arrayPixel.push(itemImagePixel);
            });
            var itemImage = {
                title: CKEDITOR.instances[$(this).find('.textarea_titleAll').attr('id')].getData(),
                urlimage: _dataImg.attr('valfile'),
                width: _dataImg.outerWidth(),
                height: _dataImg.outerHeight(),
                arrayPixel: arrayPixel
            };
            var itemQuestion = {
                type: _type,
                itemPanelKeoTha: itemPanelKeoTha,
                itemDienCau: itemDienCau,
                itemMatching: itemMatching,
                itemPhanLoai: itemPhanLoai,
                itemLuaChon: itemLuaChon,
                itemImage: itemImage,
                itembaihoclienquan: $(this).find('.itembaihoclienquan').val()
            };
            _arrayQuestion.push(itemQuestion);
        });
        var itemEx = {
            arrayQuestion: _arrayQuestion,
            title: CKEDITOR.instances[$(this).find('.parentTitle-Data').attr('id')].getData()
        };
        _arraySave.push(itemEx);
    });
    var dataDes = {
        dethi_title: $('[valname="dethi_title"]').val(),
        dethi_video: $('[valname="dethi_video"]').val(),
        dethi_img: $('[valname="dethi_img"]').attr('valdata'),
        dethi_daocau: $('[valname="dethi_daocau"][class="select"]').attr('valdata'),
        dethi_thutu: $('[valname="dethi_thutu"][class="select"]').attr('valdata'),
        dethi_des: CKEDITOR.instances[desId].getData(),
        dethi_status: $('[valname="dethi_status"][class="select"]').attr('valdata'),
        dethi_publish: $('[valname="dethi_publish"][class="select"]').attr('valdata'),
        dethi_chuyengia: $('[valname="dethi_chuyengia"]').val()
    };
    setTimeout(function () {
        $.ajax({
            type: "POST",
            url: "../service/service.asmx/de_thi",
            data: "{'data':" + JSON.stringify(JSON.stringify(_arraySave)) + ",'des':" + JSON.stringify(JSON.stringify(dataDes)) + ",'ID':" + _ID + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () {
            },
            success: function (message) {
                var objJson = message.d;
                if (objJson[0]==0) {
                    window.location.href = urlhome + '/de-thi-' + objJson[1] + '.htm';
                } else {
                    
                    $('.htm_err_respon').html('<div class="alertmessage-lintam bg-danger-lintam">Cập nhật thành công.</div>');
                }
                
                $('.popuplammo').css('display', 'none');
            },
            error: function (errormessage) {

            }
        });
    }, 1000);
}
function editUrl(_url) {
    var state = { "thisIsOnPopState": true };
    history.pushState({ path: _url }, _url, _url);
}
function createHtmlParent() {
    var html = '	<div class="itemNgay" name="itemNgay' + indexTotal + '" id="itemNgay' + indexTotal + '">';
    html += '	     <div class="itemNgay-Title"></div>';
    html += '        <div class="parentTitle">';
    html += '           <div class="parentTitle-Title"><span>Tiêu đề Bài tập</span></div>';
    html += '           <div contenteditable="true" id="parentTitle' + indexTotal + '" name="parentTitle' + indexTotal + '" class="parentTitle-Data"></div>';
    html += '        </div>';
    html += '        <div class="parentTinhHuong"></div>';
    html += '        <div style="clear:both;height:20px;"></div>';
    html += '        <div style="margin: 0 125px 10px 5px;">';
    html += '            <span class="itemTinhHuong-Page"></span>';
    html += '            <span class="itemTinhHuong-Add">Thêm Câu hỏi</span>';
    html += '        </div>';
    html += '        <div style="bottom: 21px;position: absolute;right: 18px;"><span class="btnAll" style="background-image:url(\'../images/delete-icon.png\');margin-left:20px;">Xóa Bài tập</span></div>';
    html += '        <div style="clear:both;"></div>';
    html += '    </div>';
    return html;
}
function createHtmlTinhHuong() {
    var html = '	<div class="itemTinhHuong" name="itemTinhHuong' + indexTotal + '">';
    html += '        <div class="itemTinhHuong-List-Type" valitem="0">';
    html += '           <span>Kéo thả câu khuyết</span>';
    html += '           <span>Gõ text hoàn thành</span>';
    html += '           <span>Matching hai nửa vế câu</span>';
    html += '           <span>Phân loại các từ</span>';
    html += '           <span>Lựa chọn đáp án</span>';
    html += '           <span>Kéo thả mô tả hình ảnh</span>';
    html += '        </div>';
    html += '        <div class="itemTinhHuong-List-Data">';
    html += '               <table style="width:100%;height:100%;">';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;">Tiêu đề</th>';
    html += '                       <td><textarea class="textarea_titleAll" placeholder="Nhập tiêu đề vào đây" id="textEditor_panelTitleNew_' + indexTotal + '" name="textEditor_panelTitleNew_' + indexTotal + '"></textarea></td>';
    html += '                   </tr>';
    html += '               </table>';
    html += '           <div class="itemTinhHuong-List-Data-Item admin-panelKeoTha-Cau">';
    html += '               <table style="width:100%;height:100%;">';
    html += '                   <tr style="display:none;">';
    html += '                       <th style="text-align:left;width:75px;">Tiêu đề</th>';
    html += '                       <td><textarea placeholder="Nhập tiêu đề vào đây" id="textEditor_panelKeoTha_' + indexTotal + '" name="textEditor_panelKeoTha_' + indexTotal + '"></textarea></td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;">Nội dung</th>';
    html += '                       <td>';
    html += '                           <div class="contentAllEnterText">';
    html += '                               <span class="contentAllEnterText-Add">Nhập vào đây</span>';
    html += '                               <textarea placeholder="Nhập vào đây"></textarea>';
    html += '                           </div>';
    html += '                       </td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;"></th>';
    html += '                       <td class="txtHuongDan">Lưu ý: Mỗi câu sẽ tương đương với 1 dòng.<br/>VD: \'I am a man.\' Bạn muốn kéo thả ở cụm từ \'a man\' bạn viết câ như sau: \'I am {a man}.\'<br/>VD: \'Table cells can span across more than one column or row. The attributes colspan.\' Bạn muốn kéo thả ở cụm từ \'Table cells\' và \'attributes\' bạn viết câ như sau: \'{Table cells} can span across more than one column or row. The {attributes} colspan.\'<br/>Mỗi câu có nhiều nhất 2 cụm từ được kéo thả.<br/>Nhấn \'Tab\' để tạo \'{}\'</td>';
    html += '                   </tr>';
    html += '               </table>';
    html += '           </div>';
    html += '           <div class="itemTinhHuong-List-Data-Item admin-panelDienCau-Cau">';
    html += '               <table style="width:100%;height:100%;">';
    html += '                   <tr style="display:none;">';
    html += '                       <th style="text-align:left;width:75px;">Tiêu đề</th>';
    html += '                       <td><textarea placeholder="Nhập tiêu đề vào đây" id="textEditor_panelDienCau_' + indexTotal + '" name="textEditor_panelDienCau_' + indexTotal + '"></textarea></td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;">Nội dung</th>';
    html += '                       <td>';
    html += '                           <div class="contentAllEnterText">';
    html += '                               <span class="contentAllEnterText-Add">Nhập vào đây</span>';
    html += '                               <textarea placeholder="Nhập vào đây"></textarea>';
    html += '                           </div>';
    html += '                       </td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;"></th>';
    html += '                       <td class="txtHuongDan">Lưu ý: Từ cần điền sẽ được cho trong \'{}\'.Nếu có nhiều muốn có nhiều đáp án đúng trong 1 lần điền hãy sử dụng \'\\\' để ngăn.<br/>VD Im a man. {I\'m\\I am} a man.<br/>Nhấn \'Tab\' để tạo \'{}\'</td>';
    html += '                   </tr>';
    html += '               </table>';
    html += '           </div>';
    html += '           <div class="itemTinhHuong-List-Data-Item admin-panelMatching-Cau">';
    html += '               <table style="width:100%;height:100%;">';
    html += '                   <tr style="display:none;">';
    html += '                       <th style="text-align:left;width:75px;">Tiêu đề</th>';
    html += '                       <td><textarea placeholder="Nhập tiêu đề vào đây" id="textEditor_panelMatching_' + indexTotal + '" name="textEditor_panelMatching_' + indexTotal + '"></textarea></td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;">Nội dung</th>';
    html += '                       <td>';
    html += '                           <div class="contentAllEnterText">';
    html += '                               <span class="contentAllEnterText-Add">Nhập vào đây</span>';
    html += '                               <textarea placeholder="Nhập vào đây"></textarea>';
    html += '                           </div>';
    html += '                       </td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;"></th>';
    html += '                       <td class="txtHuongDan">Lưu ý: Mỗi câu sẽ tương đương với 1 dòng. Trông mỗi dòng sẽ có 2 phần {Câu cần nối}{Câu nối}<br/>Nhấn \'Tab\' để tạo \'{}\'</td>';
    html += '                   </tr>';
    html += '               </table>';
    html += '           </div>';
    html += '           <div class="itemTinhHuong-List-Data-Item admin-panelPhanLoai-Cau">';
    html += '               <table style="width:100%;height:100%;">';
    html += '                   <tr style="display:none;">';
    html += '                       <th style="text-align:left;width:75px;">Tiêu đề</th>';
    html += '                       <td><textarea placeholder="Nhập tiêu đề vào đây" class="textareaTieuDe" id="textEditor_panelPhanLoai_' + indexTotal + '" name="textEditor_panelPhanLoai_' + indexTotal + '"></textarea></td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;"></th>';
    html += '                       <td>';
    html += '                           <table style="width:100%;height:100%;" CELLSPACING="10">';
    html += '                               <tr>';
    html += '                                   <th>Tên cột 1</th>';
    html += '                                   <th>Tên cột 2</th>';
    html += '                               </tr>';
    html += '                               <tr>';
    html += '                                   <td><input type="text" placeholder="Tên cột 1" class="inputPl"/></td>';
    html += '                                   <td><input type="text" placeholder="Tên cột 2" class="inputPl"/></td>';
    html += '                               </tr>';
    html += '                               <tr>';
    html += '                                   <td valign="top"><textarea placeholder="Danh sách các từ cột 1" class="textareaPl"></textarea></td>';
    html += '                                   <td valign="top"><textarea placeholder="Danh sách các từ cột 2" class="textareaPl"></textarea></td>';
    html += '                               </tr>';
    html += '                           </table>';
    html += '                       </td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;"></th>';
    html += '                       <td class="txtHuongDan">Lưu ý: Mỗi từ sẽ tương đương 1 dòng.</td>';
    html += '                   </tr>';
    html += '               </table>';
    html += '           </div>';
    html += '           <div class="itemTinhHuong-List-Data-Item admin-ChonLuaDapAn-Cau">';
    html += '               <table style="width:100%;height:100%;">';
    html += '                   <tr style="display:none;">';
    html += '                       <th style="text-align:left;width:75px;">Tiêu đề</th>';
    html += '                       <td><textarea placeholder="Nhập tiêu đề vào đây" id="textEditor_ChonLuaDapAn_' + indexTotal + '" name="textEditor_ChonLuaDapAn_' + indexTotal + '"></textarea></td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;">Nội dung</th>';
    html += '                       <td>';
    html += '                           <div class="contentAllEnterText">';
    html += '                               <span class="contentAllEnterText-Add">Nhập vào đây</span>';
    html += '                               <textarea placeholder="Nhập vào đây"></textarea>';
    html += '                           </div>';
    html += '                       </td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;"></th>';
    html += '                       <td class="txtHuongDan">Lưu ý: Danh sách từ được chọn lựa sẽ nằm trong \'{}\'. Nhấn \'Tab\' để tạo \'{}\'<br/>Trong {} sẽ có 4 đáp án, mỗi đáp án sẽ nằm trong [].<br/>Nếu đúng [lựa chọn-1], nếu sai [lựa chọn-0].<br/>Nhấn Ctrl + Space để tạo lựa chọn đúng, Shift + Space để tạo lựa chọn sai<br/>Cấu trúc đúng 1 câu chọn lựa chọn sẽ như sau {[Lựa chọn 1-1][Lựa chọn 2-0][Lựa chọn 3-1][Lựa chọn 4-4]}<br/></td>';
    html += '                   </tr>';
    html += '               </table>';
    html += '           </div>';
    html += '           <div class="itemTinhHuong-List-Data-Item admin-Image-Cau">';
    html += '               <table style="width:100%;height:100%;">';
    html += '                   <tr style="display:none;">';
    html += '                       <th style="text-align:left;width:75px;">Tiêu đề</th>';
    html += '                       <td><textarea placeholder="Nhập tiêu đề vào đây" id="textEditor_Image_' + indexTotal + '" name="textEditor_Image_' + indexTotal + '"></textarea></td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;"></th>';
    html += '                       <td>';
    html += '                           <div class="admin-Image-Cau-Img">';
    html += '                               <div class="admin-Image-Cau-Img-Tool">';
    html += '                                   <span class="btn-tool-img Tool-AddDiem">Thêm điểm ảnh</span>';
    html += '                                   <span class="btn-tool-img Tool-Tang">Tăng độ cao</span>';
    html += '                                   <span class="btn-tool-img Tool-Giam">Giảm độ cao</span>';
    html += '                                   <span class="btn-tool-img Tool-upload">Tải hình ảnh</span>';
    html += '                               </div>';
    html += '                               <div class="admin-Image-Cau-Img-Data" name="admin-Image-Cau-Img-Data' + indexTotal + '" valfile=""></div>';
    html += '                           </div>';
    html += '                       </td>';
    html += '                   </tr>';
    html += '                   <tr>';
    html += '                       <th style="text-align:left;width:75px;"></th>';
    html += '                       <td class="txtHuongDan">Lưu ý: Danh sách từ được chọn lựa sẽ nằm trong \'{}\'. Nhấn \'Tab\' để tạo \'{}\'<br/>Trong {} sẽ có 4 đáp án, mỗi đáp án sẽ nằm trong [].<br/>Nếu đúng [lựa chọn-1], nếu sai [lựa chọn-0].<br/>Nhấn Ctrl + Tab để tạo lựa chọn đúng, Shift + Tab để tạo lựa chọn sai<br/>Cấu trúc đúng 1 câu chọn lựa chọn sẽ như sau {[Lựa chọn 1-1][Lựa chọn 2-0][Lựa chọn 3-1][Lựa chọn 4-4]}<br/></td>';
    html += '                   </tr>';
    html += '               </table>';
    html += '           </div>';
    html += '           <div>';
    html += '               <div style="float:left;width:75px;font-size: 12px;font-weight: bold;">Bài học</div>';
    html += '               <div style="margin: 0 0 0 5px;width: calc(100% - 15px);"><input placeholder="Đường link bài học liên quan" type="text" class="itembaihoclienquan"/></div>';
    html += '               <div style="clear:both;"></div>';
    html += '           </div>';
    html += '        </div>';
    html += '        <div style="clear:both;"></div>';
    html += '    </div>';
    return html;
}
function createHtmlPage() {
    return '<span class="itemTinhHuong-PageItem" name="itemTinhHuong-PageItem' + indexTotal + '"><span class="xxxxxx">sotrang</span><span class="itemTinhHuong-PageItem-Delete"></span></span>'; ;
}
function createEventParent(_index) {
    var parent = $('div[name="itemNgay' + _index + '"]');

    CKEDITOR.inline('parentTitle' + _index, { language: 'vi', filebrowserUploadUrl: urlhome + '/ajax/uploadImage.ashx' });



    parent.find('.btnAll').click(function () {
        if (confirm("Bạn chắc chăn muốn xóa.")) {
            parent.remove();
            resetNumNgay();
        }
    });
    parent.find('.itemTinhHuong-Add').click(function () {
        parent.find('.parentTinhHuong').append(createHtmlTinhHuong());
        var _htmlpage = createHtmlPage().replace("sotrang", parent.find('.itemTinhHuong').size());
        parent.find('.itemTinhHuong-Page').append(_htmlpage);
        createEventPage(indexTotal);
        createEventTinhHuong(indexTotal);
        $('span[name="itemTinhHuong-PageItem' + indexTotal + '"]').click();
        indexTotal++;
    });
    resetNumNgay();
}
function resetNumNgay() {
    // Đếm ngày
    $('.addContext').find('.itemNgay').each(function (index) {
        $(this).find('.itemNgay-Title').text('Bài tập ' + (index + 1));
    });
}
function resetNumpage(_this) {
    // Đếm ngày
    _this.find('.itemTinhHuong-PageItem').each(function (index) {
        $(this).find('.xxxxxx').text(index + 1);
    });
}
function createEventPage(_index) {
    $('span[name="itemTinhHuong-PageItem' + _index + '"]').click(function () {
        var parent = $(this).parents('.itemNgay');
        var _index = parent.find('.itemTinhHuong-PageItem').index($(this));
        parent.find('.itemTinhHuong-PageItem').removeClass('itemTinhHuong-PageItem-Select');
        $(this).addClass('itemTinhHuong-PageItem-Select');
        parent.find('.itemTinhHuong').css('display', 'none');
        parent.find('.itemTinhHuong').eq(_index).css('display', 'block');
    });
    $('span[name="itemTinhHuong-PageItem' + _index + '"]').find('.itemTinhHuong-PageItem-Delete').click(function () {
        var isSelect = false;
        if ($(this).parent('.itemTinhHuong-PageItem-Select').size() > 0)
            isSelect = true;
        var _parents = $(this).parents('.itemTinhHuong-Page');
        var nIndex = _parents.find('.itemTinhHuong-PageItem').index($(this).parent('.itemTinhHuong-PageItem'));
        var parent = $(this).parents('.itemNgay');
        parent.find('.itemTinhHuong').eq(nIndex).remove();
        parent.find('.itemTinhHuong-PageItem').eq(nIndex).remove();
        resetNumpage(_parents);
        if (isSelect) {
            if (parent.find('.itemTinhHuong-PageItem').eq(nIndex).size() > 0) {
                parent.find('.itemTinhHuong-PageItem').eq(nIndex).click();
            } else {
                parent.find('.itemTinhHuong-PageItem').eq(nIndex - 1).click();
            }
        }
    });
}
function createEventTinhHuong(_index) {
    var parent = $('div[name="itemTinhHuong' + _index + '"]');
    var parentType = parent.find('.itemTinhHuong-List-Type');
    var listType = parent.find('.itemTinhHuong-List-Data .itemTinhHuong-List-Data-Item');

    CKEDITOR.replace('textEditor_panelTitleNew_' + _index, { toolbar: [['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'], ['TextColor', 'BGColor'], ['BidiRtl', 'BidiLtr'], ['Table'], ['JustifyRight', 'JustifyCenter', 'JustifyLeft', 'JustifyBlock'], ['Blockquote', 'HorizontalRule', 'Smiley', 'SpecialChar'], ['Preview', 'Maximize']], height: 100, language: 'vi', filebrowserUploadUrl: 'http://suphutienganh.com/ajax/uploadImage.ashx' });
    //    CKEDITOR.replace('textEditor_panelKeoTha_' + _index, { toolbar: [['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'],['TextColor', 'BGColor'],['BidiRtl', 'BidiLtr'],['Table'],['JustifyRight', 'JustifyCenter', 'JustifyLeft', 'JustifyBlock'],['Blockquote', 'HorizontalRule', 'Smiley', 'SpecialChar'],['Preview', 'Maximize']], height: 100, language: 'vi', filebrowserUploadUrl: 'http://suphutienganh.com/ajax/uploadImage.ashx'});
    //    CKEDITOR.replace('textEditor_panelDienCau_' + _index, { toolbar: [['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'], ['TextColor', 'BGColor'], ['BidiRtl', 'BidiLtr'], ['Table'], ['JustifyRight', 'JustifyCenter', 'JustifyLeft', 'JustifyBlock'], ['Blockquote', 'HorizontalRule', 'Smiley', 'SpecialChar'], ['Preview', 'Maximize']], height: 100, language: 'vi', filebrowserUploadUrl: 'http://suphutienganh.com/ajax/uploadImage.ashx' });
    //    CKEDITOR.replace('textEditor_panelMatching_' + _index, { toolbar: [['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'], ['TextColor', 'BGColor'], ['BidiRtl', 'BidiLtr'], ['Table'], ['JustifyRight', 'JustifyCenter', 'JustifyLeft', 'JustifyBlock'], ['Blockquote', 'HorizontalRule', 'Smiley', 'SpecialChar'], ['Preview', 'Maximize']], height: 100, language: 'vi', filebrowserUploadUrl: 'http://suphutienganh.com/ajax/uploadImage.ashx' });
    //    CKEDITOR.replace('textEditor_panelPhanLoai_' + _index, { toolbar: [['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'], ['TextColor', 'BGColor'], ['BidiRtl', 'BidiLtr'], ['Table'], ['JustifyRight', 'JustifyCenter', 'JustifyLeft', 'JustifyBlock'], ['Blockquote', 'HorizontalRule', 'Smiley', 'SpecialChar'], ['Preview', 'Maximize']], height: 100, language: 'vi', filebrowserUploadUrl: 'http://suphutienganh.com/ajax/uploadImage.ashx' });
    //    CKEDITOR.replace('textEditor_ChonLuaDapAn_' + _index, { toolbar: [['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'], ['TextColor', 'BGColor'], ['BidiRtl', 'BidiLtr'], ['Table'], ['JustifyRight', 'JustifyCenter', 'JustifyLeft', 'JustifyBlock'], ['Blockquote', 'HorizontalRule', 'Smiley', 'SpecialChar'], ['Preview', 'Maximize']], height: 100, language: 'vi', filebrowserUploadUrl: 'http://suphutienganh.com/ajax/uploadImage.ashx' });
    //    CKEDITOR.replace('textEditor_Image_' + _index, { toolbar: [['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink'], ['TextColor', 'BGColor'], ['BidiRtl', 'BidiLtr'], ['Table'], ['JustifyRight', 'JustifyCenter', 'JustifyLeft', 'JustifyBlock'], ['Blockquote', 'HorizontalRule', 'Smiley', 'SpecialChar'], ['Preview', 'Maximize']], height: 100, language: 'vi', filebrowserUploadUrl: 'http://suphutienganh.com/ajax/uploadImage.ashx' });

    parentType.find('span').eq(parseInt(parentType.attr('valitem'))).addClass('itemTinhHuong-List-Type-Select');
    listType.eq(parseInt(parentType.attr('valitem'))).css('display', 'block');
    parentType.find('span').click(function () {
        var _indexSpan = parentType.find('span').index($(this));
        parentType.find('span').removeClass('itemTinhHuong-List-Type-Select');
        $(this).addClass('itemTinhHuong-List-Type-Select');
        parentType.attr('valitem', _indexSpan);
        listType.css('display', 'none');
        listType.eq(_indexSpan).css('display', 'block');
    });
    // Even Keo Thả Câu
    listType.eq(0).find('textarea').autosize({ append: "\n", callback: function () { } });
    listType.eq(0).find('.contentAllEnterText').find('textarea').focusout(function () {
        var _spanAdd = $(this).prev('.contentAllEnterText-Add');
        _spanAdd.html('');
        $.each($(this).val().split('\n'), function (index, item) {
            _spanAdd.append((index + 1) + ". " + item.replace(new RegExp('{', "g"), '<span class="contentAllEnterText-Add-Eff">').replace(new RegExp("}", "g"), '</span>') + "<br/>");
        });
    });
    listType.eq(0).find('.contentAllEnterText').find('textarea').keydown(function (event) {
        if (event.keyCode == 9 && !event.shiftKey) {
            $(this).val($(this).val() + " {}").setCursorPosition($(this).val().length - 1);
            event.preventDefault();
        }
    });
    //
    // Even Điền câu
    listType.eq(1).find('textarea').autosize({ append: "\n", callback: function () { } });
    listType.eq(1).find('.contentAllEnterText').find('textarea').focusout(function () {
        var _spanAdd = $(this).prev('.contentAllEnterText-Add');
        _spanAdd.html($(this).val().replace(new RegExp('\n', "g"), '<br/>').replace(new RegExp('{', "g"), '<span class="contentAllEnterText-Add-Eff">').replace(new RegExp("}", "g"), '</span>'));
    });
    listType.eq(1).find('.contentAllEnterText').find('textarea').keydown(function (event) {
        if (event.keyCode == 9 && !event.shiftKey) {
            $(this).val($(this).val() + " {}").setCursorPosition($(this).val().length - 1);
            event.preventDefault();
        }
    });
    //
    // Even Matching
    listType.eq(2).find('textarea').autosize({ append: "\n", callback: function () { } });
    listType.eq(2).find('.contentAllEnterText').find('textarea').focusout(function () {
        var _spanAdd = $(this).prev('.contentAllEnterText-Add');
        _spanAdd.html('');
        $.each($(this).val().split('\n'), function (index, item) {
            _spanAdd.append((index + 1) + ". " + item.replace(new RegExp('}{', "g"), '} - {').replace(new RegExp('} {', "g"), '} - {').replace(new RegExp('\n', "g"), '<br/>').replace(new RegExp('{', "g"), '<span class="contentAllEnterText-Add-Eff">').replace(new RegExp("}", "g"), '</span>') + "<br/>");
        });
    });
    listType.eq(2).find('.contentAllEnterText').find('textarea').keydown(function (event) {
        if (event.keyCode == 9 && !event.shiftKey) {
            $(this).val($(this).val() + "{}{}\n").setCursorPosition($(this).val().length - 4);
            event.preventDefault();
        }
    });
    //
    // Even Phân loại câu
    listType.eq(3).find('textarea').autosize({ append: "\n", callback: function () { } });
    //
    // Even Chọn Câu
    listType.eq(4).find('textarea').autosize({ append: "\n", callback: function () { } });
    listType.eq(4).find('.contentAllEnterText').find('textarea').focusout(function () {
        var _spanAdd = $(this).prev('.contentAllEnterText-Add');
        _spanAdd.html($(this).val().replace(new RegExp('\n', "g"), '<br/>').replace(new RegExp('{', "g"), '<span class="contentAllEnterText-Add-Eff">').replace(new RegExp("}", "g"), '</span>'));
    });
    listType.eq(4).find('.contentAllEnterText').find('textarea').keydown(function (event) {
        if (event.keyCode == 9 && !event.shiftKey && !event.ctrlKey) {

            //            $(this).val($(this).val() + " {} ").setCursorPosition($(this).val().length - 2);

            var _indexCus = $(this).addTextCursorPosition("{}");
            $(this).setCursorPosition(_indexCus + 1);
            event.preventDefault();
        } else if (event.keyCode == 32 && !event.shiftKey && event.ctrlKey) {
            var _indexCus = $(this).addTextCursorPosition("[-1]");
            $(this).setCursorPosition(_indexCus + 1);
            event.preventDefault();
        } else if (event.keyCode == 32 && event.shiftKey && !event.ctrlKey) {
            var _indexCus = $(this).addTextCursorPosition("[-0]");
            $(this).setCursorPosition(_indexCus + 1);
            event.preventDefault();
        }

    });
    //
    // Even Chọn Câu
    var panelImg = listType.eq(5);
    panelImg.find('textarea').autosize({ append: "\n", callback: function () { } });
    panelImg.find('.Tool-Tang,.Tool-AddDiem,.Tool-Giam,.Tool-upload').mousedown(function (event) {
        event.preventDefault();
    });
    panelImg.find('.Tool-Tang').click(function () {
        var _dataPanel = panelImg.find('.admin-Image-Cau-Img-Data');
        _dataPanel.css('height', '+=10px');
    });
    panelImg.find('.Tool-Giam').click(function () {
        var _dataPanel = panelImg.find('.admin-Image-Cau-Img-Data');
        _dataPanel.css('height', '-=10px');
    });
    panelImg.find('.Tool-upload').click(function () {
        var _dataPanel = panelImg.find('.admin-Image-Cau-Img-Data');
        document.getElementById('scriptUpload').contentWindow.clickUpload(_dataPanel.attr('name'));
    });
    panelImg.find('.Tool-AddDiem').click(function () {
        var _dataPanel = panelImg.find('.admin-Image-Cau-Img-Data');
        var _this = $(this);
        if ($(this).attr('class').indexOf('btn-tool-img-select') > -1) {
            $(this).removeClass('btn-tool-img-select');
            _dataPanel.find('.admin-Image-Cau-Img-Data-Pixel').css('opacity', '0');
            setTimeout(function () { _dataPanel.find('.admin-Image-Cau-Img-Data-Pixel').remove(); }, 310);
        } else {
            $(this).addClass('btn-tool-img-select');
            var _width = _dataPanel.outerWidth();
            var _height = _dataPanel.outerHeight();
            var _html = '<div class="admin-Image-Cau-Img-Data-Pixel">';
            for (var i = 0; i < (_height / 18); i++) {
                for (var j = 0; j < _width / 18; j++) {
                    _html += "<span></span>";
                }
            }
            _html += '<div>';
            _dataPanel.append(_html);
            setTimeout(function () { _dataPanel.find('.admin-Image-Cau-Img-Data-Pixel').css('opacity', '1'); }, 310);
            _dataPanel.find('.admin-Image-Cau-Img-Data-Pixel span').click(function () {
                _this.removeClass('btn-tool-img-select');
                var _ofset = $(this).offsetRelative();
                _dataPanel.find('.admin-Image-Cau-Img-Data-Pixel').css('opacity', '0');
                setTimeout(function () {
                    _dataPanel.find('.admin-Image-Cau-Img-Data-Pixel').remove();
                    var _txtEnter = _dataPanel.append('<div class="admin-Image-Cau-Img-Data-Pixel-Item" style="top:' + (_ofset.top - 9) + 'px;left:' + (_ofset.left - 9) + 'px;" valpixel="{<!>top<!>:' + (_ofset.top) + ',<!>left<!>:' + (_ofset.left) + '}"><span class="admin-Image-Cau-Img-Data-Pixel-ItemEff"></span><span class="admin-Image-Cau-Img-Data-Pixel-ItemText"></span><input type="text"/></div>');
                    _txtEnter.find('input:text').keyup(function (event) {
                        $(this).prev('.admin-Image-Cau-Img-Data-Pixel-ItemText').text($(this).val());
                    }).keyup();
                    _txtEnter.find('.admin-Image-Cau-Img-Data-Pixel-ItemEff').click(function (event) {
                        $(this).parent('.admin-Image-Cau-Img-Data-Pixel-Item').remove();
                    }).keyup();
                    _txtEnter.find('input:text').focus();
                }, 310);
            });
        }
    });
    //
}
function createTroChuyen(_index) {
    $('span[name="itemTroChuyen-Avar' + _index + '"]').click(function () {
        document.getElementById('scriptUpload').contentWindow.clickUpload('itemTroChuyen-Avar' + _index);
    });
    $('span[name="btnDeleteTroChuyen' + _index + '"]').click(function () {
        $(this).parent('.itemTroChuyen').remove();
    });

}
function createHtmlTroChuyen() {
    return '<div class="itemTroChuyen"><span class="itemTroChuyen-Avar" name="itemTroChuyen-Avar' + indexTotal + '" valid=""><span></span></span><textarea placeholder="Nội dung trò chuyện..."></textarea><span class="btnDeleteTroChuyen" name="btnDeleteTroChuyen' + indexTotal + '"></span></div>';
}

(function ($) {
    $.fn.setCursorPosition = function (pos) {
        this.each(function (index, elem) {
            if (elem.setSelectionRange) {
                elem.setSelectionRange(pos, pos);
            } else if (elem.createTextRange) {
                var range = elem.createTextRange();
                range.collapse(true);
                range.moveEnd('character', pos);
                range.moveStart('character', pos);
                range.select();
            }
        });
        return this;
    };
    $.fn.getCursorPosition = function () {
        var input = this.get(0);
        if (!input) return; // No (input) element found
        if ('selectionStart' in input) {
            // Standard-compliant browsers
            return input.selectionStart;
        } else if (document.selection) {
            // IE
            input.focus();
            var sel = document.selection.createRange();
            var selLen = document.selection.createRange().text.length;
            sel.moveStart('character', -input.value.length);
            return sel.text.length - selLen;
        }
    }
    $.fn.addTextCursorPosition = function (txt) {
        var input = this;
        var _textOld = input.val();
        var _indexCus = input.getCursorPosition();
        input.val(_textOld.substring(0, _indexCus) + txt + _textOld.substring(_indexCus));
        return _indexCus;
    }
    $.fn.offsetRelative = function (top) {
        var $this = $(this);
        var $parent = $this.offsetParent();
        var offset = $this.position();
        if (!top) return offset; // Didn't pass a 'top' element
        else if ($parent.get(0).tagName == "BODY") return offset; // Reached top of document
        else if ($(top, $parent).length) return offset; // Parent element contains the 'top' element we want the offset to be relative to
        else if ($parent[0] == $(top)[0]) return offset; // Reached the 'top' element we want the offset to be relative to
        else { // Get parent's relative offset
            var parent_offset = $parent.offsetRelative(top);
            offset.top += parent_offset.top;
            offset.left += parent_offset.left;
            return offset;
        }
    };
    $.fn.positionRelative = function (top) {
        return $(this).offsetRelative(top);
    };
} (jQuery));