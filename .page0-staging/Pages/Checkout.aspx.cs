using System;
using System.Collections.Generic;
using System.Linq;
using MiniStoreWeb.Helpers;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Pages
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCheckoutPage(false);
            }
        }

        protected void PricingInput_Changed(object sender, EventArgs e)
        {
            lblCheckoutMessage.Text = string.Empty;
            BindCheckoutPage(false);
        }

        protected void btnRefreshTotals_Click(object sender, EventArgs e)
        {
            lblCheckoutMessage.Text = string.Empty;
            BindCheckoutPage(false);
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            lblCheckoutMessage.Text = string.Empty;

            string selectedPaymentMethod = GetSelectedPaymentMethod();

            if (string.IsNullOrWhiteSpace(selectedPaymentMethod))
            {
                BindCheckoutPage(true);
                lblCheckoutMessage.Text = "Pick a fake payment method before placing the order.";
                return;
            }

            CheckoutPricingSummary pricingSummary;
            string errorMessage;
            if (!CheckoutPricingService.TryCalculate(
                ddlCouponCode.SelectedValue,
                ddlShippingRegion.SelectedValue,
                true,
                out pricingSummary,
                out errorMessage))
            {
                BindCheckoutPage(true);
                lblCheckoutMessage.Text = errorMessage;
                return;
            }

            FakeOrderReceipt receipt = new FakeOrderReceipt
            {
                Username = User.Identity.IsAuthenticated ? User.Identity.Name : string.Empty,
                OrderNumber = GenerateOrderNumber(),
                CreatedAt = DateTime.Now,
                PaymentMethod = selectedPaymentMethod,
                Region = ddlShippingRegion.SelectedItem == null ? ddlShippingRegion.SelectedValue : ddlShippingRegion.SelectedItem.Text,
                CouponCode = pricingSummary.CouponCode,
                CouponDescription = pricingSummary.CouponDescription,
                Subtotal = pricingSummary.Subtotal,
                DiscountAmount = pricingSummary.DiscountAmount,
                DiscountedSubtotal = pricingSummary.DiscountedSubtotal,
                ShippingCost = pricingSummary.ShippingCost ?? 0M,
                FinalTotal = pricingSummary.FinalTotal,
                Items = CloneItems(ShoppingCartService.GetCartItems())
            };

            FakeOrderReceiptState.Save(receipt);

            if (User.Identity.IsAuthenticated && User.IsInRole(AuthenticationHelper.MemberRole))
            {
                FakeOrderHistoryRepository.SaveMemberOrder(receipt);
            }

            ShoppingCartService.Clear();
            Response.Redirect(ResolveUrl("~/Pages/OrderConfirmation.aspx"), false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void BindCheckoutPage(bool requireRegion)
        {
            // The checkout view is rebuilt from the current session cart on every refresh.
            List<StoreCartItemView> cartItems = ShoppingCartService.GetCartItems();
            bool hasItems = cartItems.Count > 0;

            pnlCheckout.Visible = hasItems;
            pnlEmptyCheckout.Visible = !hasItems;

            if (!hasItems)
            {
                return;
            }

            rptCheckoutItems.DataSource = cartItems;
            rptCheckoutItems.DataBind();

            CheckoutPricingSummary pricingSummary;
            string errorMessage;
            bool pricingReady = CheckoutPricingService.TryCalculate(
                ddlCouponCode.SelectedValue,
                ddlShippingRegion.SelectedValue,
                requireRegion,
                out pricingSummary,
                out errorMessage);

            if (!pricingReady)
            {
                lblCouponDescription.Text = string.IsNullOrWhiteSpace(ddlCouponCode.SelectedValue)
                    ? "No coupon applied."
                    : "Coupon selected. Totals update after pricing.";
                lblCheckoutSubtotal.Text = "$" + ShoppingCartService.GetSubtotal().ToString("F2");
                lblCheckoutDiscount.Text = "Pending";
                lblCheckoutShipping.Text = string.IsNullOrWhiteSpace(ddlShippingRegion.SelectedValue) ? "Choose a region" : "Pending";
                lblCheckoutTotal.Text = "Pending";

                if (!string.IsNullOrWhiteSpace(errorMessage) && requireRegion)
                {
                    lblCheckoutMessage.Text = errorMessage;
                }

                return;
            }

            ApplyPricingSummary(pricingSummary);
        }

        private void ApplyPricingSummary(CheckoutPricingSummary pricingSummary)
        {
            lblCouponDescription.Text = BuildCouponMessage(pricingSummary);
            lblCheckoutSubtotal.Text = "$" + pricingSummary.Subtotal.ToString("F2");
            lblCheckoutDiscount.Text = "-$" + pricingSummary.DiscountAmount.ToString("F2");
            lblCheckoutShipping.Text = pricingSummary.ShippingCost.HasValue
                ? "$" + pricingSummary.ShippingCost.Value.ToString("F2")
                : "Choose a region";
            lblCheckoutTotal.Text = "$" + pricingSummary.FinalTotal.ToString("F2");
        }

        private static string BuildCouponMessage(CheckoutPricingSummary pricingSummary)
        {
            if (pricingSummary == null || pricingSummary.Subtotal <= 0M || pricingSummary.DiscountAmount <= 0M)
            {
                return "No coupon applied.";
            }

            decimal percentSaved = Math.Round((pricingSummary.DiscountAmount / pricingSummary.Subtotal) * 100M, 0);
            return "You're saving " + percentSaved.ToString("0") + "% on this order!";
        }

        private string GetSelectedPaymentMethod()
        {
            if (optInfiniteMoney.Checked)
            {
                return optInfiniteMoney.Value;
            }

            if (optFairyDust.Checked)
            {
                return optFairyDust.Value;
            }

            if (optFaceCard.Checked)
            {
                return optFaceCard.Value;
            }

            return string.Empty;
        }

        private string GenerateOrderNumber()
        {
            string[] prefixes = { "TOTALLY-REAL", "DEFINITELY-LEGIT", "VOID-RETAIL", "ABSOLUTELY-NOT-REAL" };
            Random random = new Random(Guid.NewGuid().GetHashCode());
            return prefixes[random.Next(prefixes.Length)] + "-" + random.Next(100000, 999999);
        }

        private static List<StoreCartItemView> CloneItems(IEnumerable<StoreCartItemView> items)
        {
            return items == null
                ? new List<StoreCartItemView>()
                : items.Select(item => new StoreCartItemView
                {
                    ProductId = item.ProductId,
                    Name = item.Name,
                    Category = item.Category,
                    Description = item.Description,
                    Image = item.Image,
                    UnitPrice = item.UnitPrice,
                    Quantity = item.Quantity,
                    InStock = item.InStock,
                    StockQuantity = item.StockQuantity
                }).ToList();
        }
    }
}
