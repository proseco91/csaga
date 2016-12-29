<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="BillDetail.aspx.cs" Inherits="View_BillDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <nav aria-label="breadcrumbs" role="navigation" class="breadcrumb">
        <a title="Back to the frontpage" href="<%=Lib.urlhome %>">Home</a>
        <span aria-hidden="true" class="divider">›</span>
        <a title="Back to the frontpage" href="<%=Lib.urlhome %>/bills">Bills</a>
        <span aria-hidden="true" class="divider">›</span>
        <span><%=Lib.getShippingAddress(bill.Shipping_Address) %></span>
    </nav>
    <div class="cart-form">
    <%foreach (var sp in arrayCart)
      {%>
    <div class="cart-row" valid="<%=sp.ID %>">
        <div class="grid">
            <div class="grid-item large--seven-twelfths">
                <div class="grid">

                    <div class="grid-item one-third large--one-quarter">
                        <a class="cart-image" href="<%=Lib.urlhome+"/collections/"+Lib.LocDau(sp.Category)+"/products/"+Lib.LocDau(sp.Name)+"/"+sp.ID%>">
                            <img alt="<%=sp.Name %>" src="<%=Lib.urlhome+"/images/imageupload/"+sp.Img %>">
                        </a>
                    </div>

                    <div class="grid-item two-thirds large--three-quarters">
                        <a href="<%=Lib.urlhome+"/collections/"+Lib.LocDau(sp.Category)+"/products/"+Lib.LocDau(sp.Name)+"/"+sp.ID%>"><%=sp.Name %></a>
                        <br>
                        <small><%=sp.ColorAndSize==null?"":sp.ColorAndSize%></small>
                    </div>

                </div>
            </div>
            <div class="grid-item large--five-twelfths medium--two-thirds push--medium--one-third">
                <div class="grid">

                    <div class="grid-item one-half medium-down--one-third text-right">


                        <div class="js-qty">
                            <%=sp.Number %>
                            
                        </div>


                    </div>

                    <div class="grid-item one-third medium-down--one-third medium-down--text-left text-right" style="width:50%;">
                        <span class="h2">
                            <small>$<%=sp.Money %></small>

                        </span>
                    </div>

                    

                </div>
            </div>

        </div>
    </div>
    <%}%>
    <div class="cart-row" item-row-thanhtoan>
        <div class="grid">
            <div class="grid-item text-right ">
                <div class="cart-subtotal">
                    Subtotal
                    <span class="h1 cart-subtotal--price">
                        <small cart-subtotal--price>$<%=Lib.formatMoney(bill.TotalMoney) %></small>

                    </span>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>

