<%@ Page Title="" Language="C#" MasterPageFile="~/Masster/MasterPage.master" AutoEventWireup="true" CodeFile="Bills.aspx.cs" Inherits="View_Bills" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <nav aria-label="breadcrumbs" role="navigation" class="breadcrumb">
        <a title="Back to the frontpage" href="<%=Lib.urlhome %>">Home</a>
        <span aria-hidden="true" class="divider">›</span>
        <span>Bills</span>
    </nav>
    <div>
        <table class="table" style="width:100%;">
            <colgroup>
                <col style="width:50px;"/>
                <col/>
                <col style="width:80px;"/>
                <col style="width:150px;"/>
                <col style="width:150px;"/>
                <col style="width:50px;"/>
            </colgroup>
            <thead>
                <tr>
                    <th style="text-align:center;">STT</th>
                    <th>shipping address</th>
                    <th style="text-align:center;">quantity</th>
                    <th style="text-align:right;">total amount</th>
                    <th style="text-align:right;">Create Date</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <%foreach (var item in getDonHang().Select((value, index) => new {value,index }))
                  {%>
                <tr>
                    <td style="text-align:center;"><%=item.index+1 %></td>
                    <td><%=Lib.getShippingAddress(item.value.Shipping_Address) %></td>
                    <td style="text-align:center;"><%=Lib.formatMoney(item.value.TotalItems) %></td>
                    <td style="text-align:right;">$<%=Lib.formatMoney(item.value.TotalMoney) %></td>
                    <td style="text-align:right;"><%=item.value.CreateDate.ToString("MM/dd/yyyy, HH:mm:ss") %></td>
                    <td style="text-align:center;">
                        <a href="<%=Lib.urlhome+"/bill-"+item.value.ID %>">
                            <span class="fa fa-info" style="font-size:15px;"></span>
                        </a>
                    </td>
                </tr>
                <%}%>
            </tbody>
        </table>
    </div>
</asp:Content>

