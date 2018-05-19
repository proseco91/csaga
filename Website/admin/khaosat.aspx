<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="khaosat.aspx.cs" Inherits="admin_khaosat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('div[menu-khaosat]').addClass('page-menu-group-item-active');

        });
    </script>
    <style type="text/css">
        [panel-cau]
        {
            margin-bottom: 20px;
            position: relative;
        }

        [item-remove-cau]
        {
            color: red;
            font-size: 25px;
            font-weight: bold;
            position: absolute;
            right: -7px;
            top: -5px;
            z-index: 1;
            height: 13px;
            line-height: 4px;
            cursor: pointer;
        }

        [panel-cau-item]
        {
            margin-bottom: 10px;
            border: 1px solid #CCC;
            box-sizing: border-box;
        }

            [panel-cau-item] table tr
            {
                border-bottom: 1px solid #CCC;
            }

                [panel-cau-item] table tr:last-child
                {
                    border: none;
                }

            [panel-cau-item] table th, [panel-cau-item] table td
            {
                font-size: 12px;
                text-align: center;
                vertical-align: middle;
            }

            [panel-cau-item] table td
            {
                margin: 5px 0px;
            }

            [panel-cau-item] table input[type=text]
            {
                width: 100% !important;
                border: none !important;
            }

        [itemcssboderright]
        {
            border-right: 1px solid #CCC;
        }

        [item-themcau]
        {
            padding: 3px 10px;
            font-size: 11px;
            display: block;
            cursor: pointer;
            background-color: #FFF;
        }

        [item-remove]
        {
            color: red;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
        }

        [btn-them]
        {
            padding: 5px 10px;
            border: 1px solid #CCC;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="htm_loading_page"></div>
    <asp:Panel ID="PanelMenu" runat="server" Visible="true">
        <div class="parenmenu_new">
            <div class="panel_from">
                <div class="panel_from_row panel_from_row_radio_btn">
                    <a href="khao-sat.htm">
                        <input typeaction="0" type="button" value="Danh sách khảo sát" /></a>
                    <a href="them-moi-khao-sat.htm">
                        <input typeaction="1" type="button" value="Thêm mới khảo sát" /></a>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div style="clear: both; height: 50px;"></div>
    <asp:Panel ID="index" runat="server" Visible="false">
        <script type="text/javascript">
            $(document).ready(function () {
                $('.panel_search input:text').unbind("keypress").keypress(function (event) {
                    if (event.which == 13) {
                        window.location.href = "khao-sat.htm?seach=" + $(this).val();
                        event.preventDefault();
                    }
                });
            });
        </script>
        <div class="panel_from_item panel_from_item_show">
            <div class="style_table">
                <div class="panel_search" action-default>
                    <input type="text" placeholder="Tìm kiếm" value="<%=Request.QueryString["seach"] %>"/>
                    <span attr-close></span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <table cellpadding="0" cellspacing="0">

                    <tr>
                        <th style="width: 50px; text-align: center;">STT</th>
                        <th style="width: calc(100% - 644px);">Tiêu đề</th>
                        <th style="width: 120px;">Khảo sát từ</th>
                        <th style="width: 120px;">Khảo sát đến</th>
                        <th style="width: 110px;text-align:center;">Số lần khảo sát</th>

                        <th style="width: 120px;">Ngày tạo</th>
                        <th style="width: 100px;"></th>
                    </tr>
                    <%
                        int totalRow = 0;
                        int pageSelect = 1;
                        int numInPage = 30;
                        foreach (var item in getData(numInPage, out totalRow, out pageSelect).Select((value, i) => new { i, value }))
                        {
                %>
                     <tr>
                        <td style="width: 50px; text-align: center;"><%=item.i+1 %></td>
                        <td style="width: calc(100% - 644px);"><%=item.value.TitleVn %></td>
                        <td style="width: 120px;"><%=item.value.KhaoSatTuNgay.ToString("dd/MM/yyyy, HH:mm") %></td>
                        <td style="width: 120px;"><%=item.value.KhaoSatDenNgay.ToString("dd/MM/yyyy, HH:mm") %></td>
                        <td style="width: 110px;text-align:center;"><%=item.value.arrayCauTraLoi.Count %></td>
                        <td style="width: 120px;"><%=item.value.CreateDate.ToString("dd/MM/yyyy") %></td>
                        <td style="width: 100px;">
                            <a href="<%=string.Format(Enums.LoaiTinTucUrlChinhSua((Enums.LoaiTinTuc.KhaoSat)),Lib.LocDau(item.value.TitleVn),item.value.ID) %>"><i class="fa fa-pencil" title="Chỉnh sửa"></i></a>
                            <a delete-link="Bạn chắc chắn muốn thay đổi trạng thái từ <%=item.value.Status==(int)Enums.Status.active?"ẩn thành hiển thị":"hiển thị thành ẩn" %> <%=item.value.TitleVn %>" href="<%=string.Format(Enums.LoaiTinTucUrlTrangThai((Enums.LoaiTinTuc.KhaoSat)),Lib.LocDau(item.value.TitleVn),item.value.ID) %>"><i class="fa fa-check-circle" title="<%=item.value.Status==1?"Ẩn":"Hiển thị" %>" style="<%=item.value.Status==1?"":"color:#CCC;" %>"></i></a>
                            <a delete-link="Bạn chắc chắn muốn xóa <%=item.value.TitleVn %>" href="<%=string.Format(Enums.LoaiTinTucUrlXoa((Enums.LoaiTinTuc.KhaoSat)),Lib.LocDau(item.value.TitleVn),item.value.ID) %>"><i class="fa fa-times" title="Xóa"></i></a>
                        </td>
                    </tr>
                    <%}%>
                </table>
                <div style="clear: both; height: 20px;"></div>
                <%=Lib.createPhanTrang(totalRow, numInPage, pageSelect,5)%>
                <div style="clear: both;"></div>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="add" runat="server" Visible="false">
        <div class="panel_from_item panel_from_item_show">
            <div class="panel_from_title"><span>Nội dung khảo sát</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Tiêu đề (Vn)</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtTitle" runat="server" no-empty Width="100%" MaxLength="200"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable style="vertical-align: top;">Giới thiệu</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtDes" runat="server" no-empty Width="100%" MaxLength="500" TextMode="MultiLine"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Link khảo sát</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtLink" runat="server" no-empty Width="100%"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Thời gian bắt đầu</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtDateTo" runat="server" no-empty Width="100%" MaxLength="200"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Thời gian kết thúc</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtDateEnd" runat="server" no-empty Width="100%" MaxLength="200"></asp:TextBox>
                    </span>
                </div>
                <%--<div style="clear: both; height: 20px;"></div>--%>
                <div class="panel_from_row panel_from_row_input" style="display:none;">
                    <lable style="vertical-align: top;">Nội dung khảo sát</lable>
                    <span style="width: 600px;">
                        <span btn-them>Thêm câu</span>
                    </span>
                </div>
            </div>
            <asp:HiddenField ID="dataContent" runat="server"/>
            <div style="clear: both; height: 50px;"></div>
            <div class="panel_from">
                <div class="panel_from_dis_panel"></div>
                <div class="panel_from_row panel_from_row_btn_submit">
                    <asp:Button ID="Action_AddNew" runat="server" Text="Thêm mới" CssClass="submit itemsubmitCreateData" OnClick="Action_AddNew_Click"/>
                    <%--<span class="submit">Lưu thay đổi</span>--%>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                var _dataStruc = $('#<%=dataContent.ClientID%>').val();
                _dataStruc = _dataStruc.length == 0 ? [] : JSON.parse(_dataStruc);
                if (_dataStruc.length > 0)
                    createByStruc(_dataStruc);
                $("#<%=txtDateTo.ClientID %>,#<%=txtDateEnd.ClientID %>").datetimepicker({
                    format: 'd-m-Y',
                    formatDate: 'd-m-Y',
                    minDate: '<%=DateTime.Now.AddDays(1).ToString("dd-MM-yyyy")%>',
                    startDate: '<%=DateTime.Now.AddDays(1).ToString("dd-MM-yyyy")%>',
                    defaultDate: '<%=DateTime.Now.AddDays(1).ToString("dd-MM-yyyy")%>',
                    timepicker: false,
                    onChangeDateTime: function (dp, $input) {
                        $input.keyup();
                    }
                });
                $('[btn-them]').click(function () {
                    var ele = $(createHTMLCAUPanel()).insertBefore($(this));
                    createEventCau(ele);
                });
                $('.itemsubmitCreateData').click(function () {
                    var array = [];
                    $('[panel-cau]').each(function () {
                        var struc = {
                            id: $(this).attr('valid'),
                            title: $(this).find('[name="tieude"]').val(),
                            array:[]
                        };
                        $(this).find('[name="cau"]').each(function () {
                            struc.array.push({
                                id: $(this).attr('valid'),
                                text: $(this).val()
                            });
                        });
                        array.push(struc);
                    });
                    if (array.length == 0) {
                        chatLinkTamFun.message(false, 'Nội dung khảo sát phải có');
                        return false;
                    }
                    $('#<%=dataContent.ClientID%>').val(JSON.stringify(array));
                });
            });
            function createByStruc(data) {
                $.each(data, function (index,item) {
                    var ele = $(createHTMLCAUPanel(item)).insertBefore($('[btn-them]'));
                    createEventCau(ele);

                });
            }
            function resetNumber(ele) {
                ele.find('[itemstt]').each(function (index) {
                    $(this).text(index + 1);
                });
            }
            function createEventCauRow(ele, eleRow) {
                eleRow.find('[item-remove]').click(function () {
                    eleRow.remove();
                    resetNumber(ele);
                });
            }
            function createEventCau(ele) {
                ele.find('[item-themcau]').click(function () {
                    var eleRow = $(createHTMLCAU()).insertBefore($(this).parent('td').parent('tr'));
                    createEventCauRow(ele, eleRow);
                    resetNumber(ele);
                });
                ele.find('[item-remove-cau]').click(function () {
                    ele.remove();
                });
                ele.find('[item-remove]').each(function () {
                    var eleRow = $(this).parent('td').parent('tr');
                    createEventCauRow(ele, eleRow);
                    resetNumber(ele);
                });
            }
            function createHTMLCAUPanel(data) {
                var htmlCau = '';
                if (data != null) {
                    $.each(data.array, function (index,item) {
                        htmlCau += createHTMLCAU(item);
                    });
                }
                return '<div panel-cau valid="' + (data == null ? chatLinkTamFun.new_guid() : data.id) + '"><span item-remove-cau>x</span>\
                            <div panel-cau-item>\
                                <table style="width: 100%;">\
                                    <tr>\
                                        <th style="width: 250px;" itemcssboderright>Tiêu đề</th>\
                                        <th style="width: 350px;">Nội dung câu</th>\
                                    </tr>\
                                    <tr>\
                                        <td itemcssboderright>\
                                            <input type="text" name="tieude" no-empty placeholder="Tiêu đề" value="' + (data == null ? "" : data.title) + '"/>\
                                        </td>\
                                        <td>\
                                            <table style="width: 100%;">\
                                                <tbody>\
                                                    <tr>\
                                                        <th itemcssboderright style="width: 50px;">STT</th>\
                                                        <th itemcssboderright style="width: calc(100% - 100px);">Câu tích chọn</th>\
                                                        <th style="width:50px;"></th>\
                                                    </tr>' + htmlCau + '\
                                                    <tr>\
                                                        <td colspan="3" style="">\
                                                            <span item-themcau>Thêm câu hỏi</span>\
                                                        </td>\
                                                    </tr>\
                                                </tbody>\
                                            </table>\
                                        </td>\
                                    </tr>\
                                </table>\
                            </div>\
                        </div>';
            }
            function createHTMLCAU(data) {

                return '<tr>\
                        <td itemcssboderright itemstt style="width: 50px;">1</td>\
                        <td itemcssboderright style="width: calc(100% - 100px);"><input type="text" name="cau" valid="' + (data == null ? chatLinkTamFun.new_guid() : data.id) + '" no-empty placeholder="Nội dung câu chọn lựa" value="' + (data == null ? "" : data.text) + '"/></td>\
                        <td style="width: 50px;"><span item-remove>x</span></td>\
                    </tr>';
            }
        </script>
    </asp:Panel>
</asp:Content>

