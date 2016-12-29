<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="DangKyTaiKhoan.aspx.cs" Inherits="View_DangKyTaiKhoan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=txtEmail.ClientID%>').attr('type', 'email');
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="grid">

        <div class="grid-item large--one-third push--large--one-third text-center">

            <h1>Create Account</h1>

            <div id="create_customer">
                <asp:Label ID="labErr" runat="server" Text=""></asp:Label>
                <label class="hidden-label" for="first_name">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name"></asp:TextBox>
                
                <label class="hidden-label" for="email">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
                <p>
                    <asp:Button ID="Button1" runat="server" Text="Create" CssClass="btn" OnClick="Button1_Click"/>
                </p>
                or <a href="<%=Lib.urlhome %>">Return to Store</a>

            </div>

        </div>

    </div>
</asp:Content>

