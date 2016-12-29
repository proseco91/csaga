using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PayPal.Api;

public partial class View_Index : BasePageHome
{
    public List<Category> _Category
    {
        get
        {
            return sql.Category();
        }
    }
    public Dictionary<string, List<MatHang>> SanPhamIndex = new Dictionary<string, List<MatHang>>();
    protected void Page_Load(object sender, EventArgs e)
    {
        foreach (var item in _Category)
        {
            var _mathang = sql.MatHangs.Where(d => d.Status == 1 && d.ParentID == null && d.Category.IndexOf(item.ID) > -1).Take(15).ToList();
            if (_mathang.Count > 0)
                SanPhamIndex.Add(item.ID, _mathang);
        }
        setTitle("");
    }

    

    //public void test()
    //{
    //    var apiContext = Configuration.GetAPIContext();

    //    string payerId = Request.QueryString["PayerID"] as string;

    //    if (payerId == null || string.IsNullOrEmpty(payerId))
    //    {
    //        // ###Items
    //        // Items within a transaction.
    //        var itemList = new ItemList()
    //        {
    //            items = new List<Item>() 
    //                {
    //                    new Item()
    //                    {
    //                        name = "Item Name1",
    //                        currency = "USD",
    //                        price = "15",
    //                        quantity = "5",
    //                        url="1"
    //                    },
    //                    new Item()
    //                    {
    //                        name = "Item Name2",
    //                        currency = "USD",
    //                        price = "10",
    //                        quantity = "1",
    //                        url="2"
    //                    }
    //                }
    //        };

    //        var payer = new Payer() { payment_method = "paypal" };

    //        // ###Redirect URLS
    //        // These URLs will determine how the user is redirected from PayPal once they have either approved or canceled the payment.
    //        var baseURI = Lib.urlhome + "/View/Index.aspx?";
    //        var guid = Convert.ToString((new Random()).Next(100000));
    //        var redirectUrl = baseURI + "guid=" + guid;
    //        var redirUrls = new RedirectUrls()
    //        {
    //            cancel_url = redirectUrl + "&cancel=true",
    //            return_url = redirectUrl
    //        };

    //        // ###Details
    //        // Let's you specify details of a payment amount.
    //        var details = new Details()
    //        {
    //            tax = "0",
    //            shipping = "0",
    //            subtotal = "85"
    //        };

    //        // ###Amount
    //        // Let's you specify a payment amount.
    //        var amount = new Amount()
    //        {
    //            currency = "USD",
    //            total = "85", // Total must be equal to sum of shipping, tax and subtotal.
    //            details = details,
    //        };

    //        // ###Transaction
    //        // A transaction defines the contract of a
    //        // payment - what is the payment for and who
    //        // is fulfilling it. 
    //        var transactionList = new List<Transaction>();

    //        // The Payment creation API requires a list of
    //        // Transaction; add the created `Transaction`
    //        // to a List
    //        transactionList.Add(new Transaction()
    //        {
    //            description = "Thông tin hóa đơn.",
    //            amount = amount,
    //            invoice_number = Guid.NewGuid().ToString().Trim(),
    //            item_list = itemList
    //        });

    //        // ###Payment
    //        // A Payment Resource; create one using
    //        // the above types and intent as `sale` or `authorize`
    //        var payment = new Payment()
    //        {
    //            intent = "sale",
    //            payer = payer,
    //            transactions = transactionList,
    //            redirect_urls = redirUrls
    //        };

    //        // Create a payment using a valid APIContext
    //        var createdPayment = payment.Create(apiContext);
    //        var links = createdPayment.links.GetEnumerator();
    //        while (links.MoveNext())
    //        {
    //            var link = links.Current;
    //            if (link.rel.ToLower().Trim().Equals("approval_url"))
    //            {
    //                Response.Redirect(link.href, true);


    //            }
    //        }
    //    }
    //    else
    //    {

    //        var paymentId = Request.QueryString["paymentId"] as string;
    //        var paymentExecution = new PaymentExecution() { payer_id = payerId.Trim() };
    //        var payment = new Payment() { id = paymentId.Trim() };
    //        var a = Payment.Get(apiContext, paymentId);

    //        var executedPayment = payment.Execute(apiContext, paymentExecution);
    //        ////ID_Related_Resources
    //        //executedPayment.transactions.FirstOrDefault().related_resources.FirstOrDefault().sale.id

    //        ////Payer_Info
    //        //executedPayment.payer.payer_info

    //        ////Shipping_Address
    //        //executedPayment.payer.payer_info.shipping_address
            
    //        string ab= JsonFormatter.ConvertToJson(executedPayment.payer.payer_info.shipping_address);
    //        var a2 = Payment.Get(apiContext, paymentId);
    //    }
    //}

}