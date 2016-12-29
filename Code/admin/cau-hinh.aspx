<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="cau-hinh.aspx.cs" Inherits="admin_mat_hang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('div[menu-cauhinh]').addClass('page-menu-group-item-active');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="htm_loading_page"></div>


    <asp:Panel ID="add" runat="server" Visible="true">
        <div class="panel_from_item panel_from_item_show">
            <div class="panel_from_title"><span>Cấu hình website</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Tên website</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtName" runat="server" no-empty Width="100%" MaxLength="500"></asp:TextBox>
                    </span>
                </div>

                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Email</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtEmail" runat="server" no-empty Width="100%" MaxLength="500"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>KeyWord</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtKeyWord" runat="server" no-empty Width="100%"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Destination</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtDestination" runat="server" no-empty Width="100%"></asp:TextBox>
                    </span>
                </div>


                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_file">
                    <lable>Slider<br />(1000px * 313px) và ko quá 2MB</lable>
                    <span img-oldaaa></span>
                    <span>Tải hình ảnh lên
                    <asp:FileUpload ID="fileUpload" runat="server" AllowMultiple="true" />
                    </span>
                </div>

                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Account Mail Send</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="txtEmailSend" runat="server" no-empty Width="100%"></asp:TextBox>
                    </span>
                </div>
            </div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from_title"><span>Cấu hình Paypal</span></div>
            <div style="clear: both; height: 20px;"></div>
            <div class="panel_from">
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Client Id</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="payClientId" runat="server" no-empty Width="100%"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Client Secret</lable>
                    <span style="width: 400px;">
                        <asp:TextBox ID="payClientSecret" runat="server" no-empty Width="100%"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Shipping</lable>
                    <span>
                        <asp:TextBox ID="payShipping" runat="server" no-empty Width="100%" valtype="number" MaxLength="9"></asp:TextBox>
                    </span>
                </div>
                <div style="clear: both; height: 20px;"></div>
                <div class="panel_from_row panel_from_row_input">
                    <lable>Tax</lable>
                    <span>
                        <asp:TextBox ID="payTax" runat="server" no-empty Width="100%" valtype="number" MaxLength="9"></asp:TextBox>
                    </span>
                </div>
            </div>
            <div style="clear: both; height: 50px;"></div>
            <div class="panel_from">
                <div class="panel_from_dis_panel"></div>
                <div class="panel_from_row panel_from_row_btn_submit">
                    <asp:Button ID="Action_AddNew" runat="server" Text="Cập nhật" CssClass="submit" OnClick="Action_AddNew_Click" />
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $.each(typeof ListImgOld == 'undefined' ? [] : ListImgOld, function (i, item) {
                    var elClick = $('<span title="Xóa" style="background-image:url(\'<%=Lib.urlhome+"/Images/imageUpload/"%>' + item + '\');display: inline-block;height: 60px;width: 60px;margin:5px;background-size:contain;background-repeat: no-repeat;background-position: center center;border:2px solid #CCC;border-radius:3px;"><input type="hidden" name="img_old" value="' + item + '"/></span>').appendTo($('[img-oldaaa]'));
                    elClick.click(function () {
                        elClick.remove();
                    });
                });
            });
        </script>
    </asp:Panel>

    <asp:Panel ID="update" runat="server" Visible="false">
        <div class="panel_from_item panel_from_item_show">
            sad
        </div>
    </asp:Panel>
</asp:Content>

