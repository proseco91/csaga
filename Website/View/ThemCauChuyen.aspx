<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ThemCauChuyen.aspx.cs" Inherits="View_ThemCauChuyen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../linktamchat/Styles/chat/popup.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.10.2.js"></script>
    <link href="../linktamchat/Styles/chat/fonts.css" rel="stylesheet">
    <link href="../Styles/admin_style_new.css" rel="stylesheet">
    <script src="../Scripts/admin_style_new.js"></script>
    <script src="../admin/js/datetime/jquery.datetimepicker.js"></script>
    <link href="../plugin/colpick/css/colpick.css" rel="stylesheet" type="text/css" />
    <script src="../plugin/colpick/js/colpick.js"></script>
    <script src="../linktamchat/Scripts/chat/uploadfile.js"></script>
    <script type="text/javascript" src="../admin/ckeditorNew/ckeditor.js"></script>
    <script type="text/javascript" src="../admin/ckeditorNew/adapters/jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('input:submit').click(function () {
                if (!$(this).parents('.panel_from_item').validate()) {
                    return false;
                }
            });
        });
    </script>
    <style type="text/css">
        .submit
        {
            padding: 5px 20px !important;
        }

        body
        {
            max-width: 100%;
            max-height: 100%;
            overflow: auto;
        }
    </style>
</head>
<body>
    <div class="htm_err_respon">
        <%=Session["Message_Popup"]!=null?Session["Message_Popup"]+"":"" %>
        <%Session["Message_Popup"] = null; %>
    </div>
    <form id="form1" runat="server">
        <div>
            <div class="panel_from_item panel_from_item_show">
                <div class="panel_from_title"><span>Thông tin người gửi</span></div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from">

                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable>Email</lable>
                        <span style="width: 400px;">
                            <asp:TextBox ID="txtEmail" runat="server" no-empty Width="100%" MaxLength="200" AutoPostBack="true" OnTextChanged="txtEmail_TextChanged"></asp:TextBox>
                        </span>

                    </div>
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable>Điện thoại</lable>
                        <span style="width: 400px;">
                            <asp:TextBox ID="txtDienThoai" runat="server" no-empty Width="100%" MaxLength="200" AutoPostBack="true" OnTextChanged="txtDienThoai_TextChanged" Enabled="false"></asp:TextBox>
                        </span>
                    </div>
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_row panel_from_row_input">
                        <lable>Tên đầy đủ</lable>
                        <span style="width: 400px;">
                            <asp:TextBox ID="txtFullname" runat="server" no-empty Width="100%" MaxLength="200" AutoPostBack="true" OnTextChanged="txtFullname_TextChanged" Enabled="false"></asp:TextBox>
                        </span>
                    </div>
                </div>
                <asp:Panel ID="panelCauChuyen" runat="server" Enabled="false">
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from_title"><span>Nội dung câu chuyên</span></div>
                    <div style="clear: both; height: 20px;"></div>
                    <div class="panel_from">
                        <div style="clear: both; height: 20px;"></div>
                        <div class="panel_from_row panel_from_row_input">
                            <lable>Tiêu đề câu chuyện</lable>
                            <span style="width: 400px;">
                                <asp:TextBox ID="txtTitle" runat="server" no-empty Width="100%" MaxLength="200"></asp:TextBox>
                            </span>
                        </div>
                        <div style="clear: both; height: 20px;"></div>
                        <div class="panel_from_row panel_from_row_input">
                            <lable>Thành phố</lable>
                            <span style="width: 400px;">
                                <asp:DropDownList ID="lstThanhPho" runat="server"></asp:DropDownList>
                            </span>
                        </div>
                        <div style="clear: both; height: 20px;"></div>
                        <div class="panel_from_row panel_from_row_file">
                            <lable>Ảnh câu chuyện</lable>
                            <span img-oldaaa></span>
                            <span>Tải hình ảnh lên
                        <asp:FileUpload ID="fileUpload" runat="server" no-empty dataImg />
                            </span>
                        </div>
                        <div style="clear: both; height: 20px;"></div>
                        <div class="panel_from_row panel_from_row_input">
                            <lable style="vertical-align: top;">Giới thiệu qua</lable>
                            <span style="width: 400px;">
                                <asp:TextBox ID="txtDes" runat="server" no-empty Width="100%" MaxLength="500" TextMode="MultiLine"></asp:TextBox>
                            </span>
                        </div>
                        <div style="clear: both; height: 20px;"></div>
                        <div class="panel_from_row panel_from_row_input">
                            <lable style="vertical-align: top;">Nội dung</lable>
                            <span style="display: inline-block; width: calc(100% - 200px);">
                                <asp:TextBox ID="txtChiTiet" runat="server" Width="100%" contenteditable="true" TextMode="MultiLine" no-empty Text="Nội dung tại đây."></asp:TextBox>
                            </span>
                        </div>
                    </div>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            CKEDITOR.disableAutoInline = true;
                            CKEDITOR.inline('<%=txtChiTiet.ClientID %>', { customConfig: '<%=Lib.urlhome %>/admin/ckeditorNew/configmini.js', language: 'vi' });
                        });
                    </script>
                </asp:Panel>
                <div style="clear: both; height: 50px;"></div>
                <div class="panel_from">
                    <div class="panel_from_dis_panel"></div>
                    <div class="panel_from_row panel_from_row_btn_submit" style="text-align: right; padding-right: 4px;">
                        <asp:Button ID="Action_AddNew" runat="server" Text="Thêm câu chuyện" CssClass="submit" OnClick="Action_AddNew_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
