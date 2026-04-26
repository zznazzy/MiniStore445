using System;
using MiniStoreWeb.Helpers;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Pages
{
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                return;
            }

            FakeOrderReceipt receipt = FakeOrderReceiptState.GetCurrentReceipt();
            if (receipt == null)
            {
                Response.Redirect(ResolveUrl("~/Pages/Cart.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            lblOrderNumber.Text = receipt.OrderNumber;
            lblPlacedAt.Text = receipt.CreatedAt.ToString("f");
            lblPaymentMethod.Text = receipt.PaymentMethod;
            lblRegion.Text = receipt.Region;
            lblCouponUsed.Text = string.IsNullOrWhiteSpace(receipt.CouponCode) ? "(none)" : receipt.CouponCode;
            lblReceiptSubtotal.Text = "$" + receipt.Subtotal.ToString("F2");
            lblReceiptDiscount.Text = "-$" + receipt.DiscountAmount.ToString("F2");
            lblReceiptShipping.Text = "$" + receipt.ShippingCost.ToString("F2");
            lblReceiptTotal.Text = "$" + receipt.FinalTotal.ToString("F2");
            rptReceiptItems.DataSource = receipt.Items;
            rptReceiptItems.DataBind();
        }
    }
}
