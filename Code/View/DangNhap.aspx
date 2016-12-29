<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="DangNhap.aspx.cs" Inherits="View_DangNhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function ActionType(type) {
            if (type == "1") {
                $('[attr-none]').css({ 'display': 'none' });
                $('#<%=typeLogin.ClientID%>').val(1);
                $('[attr-forgot]').attr('attr-forgot', 1).text('Cancel');
                $('#<%=btnSubmit.ClientID%>').val('Submit');
                $('[attr-title]').text('Reset your password');
            } else {
                $('[attr-none]').css({ 'display': 'block' });
                $('#<%=typeLogin.ClientID%>').val(0);
                $('[attr-forgot]').attr('attr-forgot', 0).text('Forgot your password?');
                $('#<%=btnSubmit.ClientID%>').val('Sing In');
                $('[attr-title]').text('login');
            }

        }
        $(document).ready(function () {
            $('#<%=txtEmail.ClientID%>').attr('type', 'email');
            $('[attr-forgot]').click(function () {
                var _value = $(this).attr('attr-forgot');
                if (_value == "0") {
                    ActionType("1");
                } else {
                    ActionType("0");
                }
                return false;
            });
            ActionType($('#<%=typeLogin.ClientID%>').val());
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="grid">

        <div class="grid-item large--one-third push--large--one-third text-center">

            <h1 attr-title style="font-size: 22px;">login</h1>

            <div id="create_customer">
                <asp:Label ID="labErr" runat="server" Text=""></asp:Label>
                <asp:HiddenField ID="typeLogin" runat="server" Value="0" />
                <label class="hidden-label" for="email">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>

                <label class="hidden-label" for="first_name" attr-none>Password</label>
                <asp:TextBox ID="txtPass" runat="server" placeholder="Password" TextMode="Password" attr-none></asp:TextBox>

                <p>
                    <asp:Button ID="btnSubmit" runat="server" Text="Sing In" CssClass="btn" OnClick="btnSubmit_Click" />
                </p>
                <p>
                    <a href="javascript:;" attr-forgot="0">Forgot your password?</a>
                </p>

            </div>

        </div>

    </div>
</asp:Content>

