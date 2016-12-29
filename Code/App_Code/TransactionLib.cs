using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.IO;
using System.Text.RegularExpressions;
using System.Net;
using System.Text;
using System.Threading;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Xml;
using System.Data;
using System.ComponentModel;
using Newtonsoft.Json;
using System.Dynamic;
using PayPal.Api;

public static class TransactionLib
{

    public static string CreateTransaction(List<strucItemCart> arrayCart, User user)
    {
        var apiContext = Configuration.GetAPIContext();
        // ###Items
        // Items within a transaction.
        var itemList = new ItemList()
        {
            items = new List<Item>()
        };
        itemList.items.AddRange(arrayCart.Select(sp => new Item
        {
            name = "[" + sp.Category + "]" + sp.Name + (sp.ColorAndSize != null ? "(" + sp.ColorAndSize + ")" : ""),
            currency = "USD",
            price = sp.Money.ToString(),
            quantity = sp.Number.ToString(),
            url = sp.ID
        }));
        var payer = new Payer() { payment_method = "paypal" };

        // ###Redirect URLS
        // These URLs will determine how the user is redirected from PayPal once they have either approved or canceled the payment.
        var baseURI = Lib.urlhome + "/pay?";
        var guid = Convert.ToString((new Random()).Next(100000));
        var redirectUrl = baseURI;
        var redirUrls = new RedirectUrls()
        {
            cancel_url = redirectUrl + "status=cancel",
            return_url = redirectUrl + "status=completed",
        };

        // ###Details
        // Let's you specify details of a payment amount.
        var details = new Details()
        {
            tax = "0",
            shipping = "0",
            subtotal = itemList.items.Select(d => long.Parse(d.price) * int.Parse(d.quantity)).Sum().ToString()
        };

        // ###Amount
        // Let's you specify a payment amount.
        var amount = new Amount()
        {
            currency = "USD",
            total = (long.Parse(details.subtotal) + long.Parse(details.tax) + long.Parse(details.shipping)).ToString(), // Total must be equal to sum of shipping, tax and subtotal.
            details = details,
        };

        // ###Transaction
        // A transaction defines the contract of a
        // payment - what is the payment for and who
        // is fulfilling it. 
        var transactionList = new List<Transaction>();

        // The Payment creation API requires a list of
        // Transaction; add the created `Transaction`
        // to a List
        transactionList.Add(new Transaction()
        {
            description = "Thông tin thanh toán.",
            amount = amount,
            invoice_number = Lib.CreateGuid(),
            custom = user.ID,
            item_list = itemList
        });

        // ###Payment
        // A Payment Resource; create one using
        // the above types and intent as `sale` or `authorize`
        var payment = new Payment()
        {
            intent = "sale",
            payer = payer,
            transactions = transactionList,
            redirect_urls = redirUrls
        };

        // Create a payment using a valid APIContext
        var createdPayment = payment.Create(apiContext);
        var links = createdPayment.links.GetEnumerator();
        while (links.MoveNext())
        {
            var link = links.Current;
            if (link.rel.ToLower().Trim().Equals("approval_url"))
            {
                return link.href;
            }
        }
        return string.Empty;
    }
    public static string ExecuteTransaction(LinqDataContext sql, string paymentId, string payerId, HttpResponse Response)
    {
        var paymentExecution = new PaymentExecution() { payer_id = payerId.Trim() };
        var payment = new Payment() { id = paymentId.Trim() };

        var pament = Payment.Get(Configuration.GetAPIContext(), paymentId);
        if (pament.state == "created" || pament.state == "approved")
        {
            List<Item> arrayItem = pament.transactions.FirstOrDefault().item_list.items.ToList();
            while (true)
            {
                try
                {
                    pament = Payment.Get(Configuration.GetAPIContext(), paymentId);
                    if (pament.state == "created" || pament.state == "approved")
                    {
                        if (pament.state == "created")
                        {
                            pament = payment.Execute(Configuration.GetAPIContext(), paymentExecution);
                            pament = Payment.Get(Configuration.GetAPIContext(), paymentId);
                        }
                        if (pament.state == "approved")
                        {
                            Transaction transaction = pament.transactions.FirstOrDefault();
                            string ID_Related_Resources = transaction.related_resources.FirstOrDefault().sale.id;
                            Refund refund = Refund.Get(Configuration.GetAPIContext(), ID_Related_Resources);
                            if (refund.state == "completed")
                            {
                                if (!sql.DonHangs.Any(d => d.ID == transaction.invoice_number))
                                {
                                    DonHang donhang = new DonHang();
                                    donhang.CreateDate = DateTime.Now;
                                    donhang.DetailItems = JsonConvert.SerializeObject(arrayItem);
                                    donhang.ID = transaction.invoice_number;
                                    donhang.ID_Related_Resources = ID_Related_Resources;
                                    donhang.Payer_Info = JsonConvert.SerializeObject(pament.payer.payer_info);
                                    donhang.PayerID = payerId;
                                    donhang.PaymentId = paymentId;
                                    donhang.Shipping_Address = JsonConvert.SerializeObject(pament.payer.payer_info.shipping_address);
                                    donhang.TotalItems = transaction.item_list.items.Count;
                                    donhang.TotalMoney = decimal.Parse(transaction.amount.total);
                                    donhang.TotalShipping = decimal.Parse(transaction.amount.details.shipping == null ? "0" : transaction.amount.details.shipping);
                                    donhang.TotalTax = decimal.Parse(transaction.amount.details.tax == null ? "0" : transaction.amount.details.tax);
                                    donhang.UserID = transaction.custom;
                                    donhang.Status = 0;
                                    sql.DonHangs.InsertOnSubmit(donhang);
                                    sql.SubmitChanges();
                                    Response.Cookies["Cart"].Expires = DateTime.Now.AddYears(-10);
                                    //Send Email

                                    //
                                    return donhang.ID;
                                }
                                else {
                                    return transaction.invoice_number;
                                }
                            }
                            else {
                                return string.Empty;
                            }
                        }
                        else {
                            return string.Empty;
                        }
                    }
                    else
                    {
                        return string.Empty;
                    }
                }
                catch
                {

                }
            }

        }
        return string.Empty;
    }
}