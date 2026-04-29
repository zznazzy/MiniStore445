using System;
using System.Collections.Generic;
using MiniStoreWeb.Helpers;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Pages
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCart();
            }
        }

        protected string GetImageUrl(object imageValue)
        {
            return ImageUrlHelper.ResolveForControl(this, Convert.ToString(imageValue));
        }

        protected void rptCartItems_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int productId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out productId))
            {
                lblCartMessage.Text = "That cart action could not be completed.";
                return;
            }

            switch (e.CommandName)
            {
                case "IncreaseQuantity":
                    lblCartMessage.Text = ShoppingCartService.IncreaseQuantity(productId)
                        ? "Cart quantity updated."
                        : "You already have every available unit of that item in your cart.";
                    break;
                case "DecreaseQuantity":
                    lblCartMessage.Text = ShoppingCartService.DecreaseQuantity(productId)
                        ? "Cart quantity updated."
                        : "That cart action could not be completed.";
                    break;
                case "RemoveItem":
                    lblCartMessage.Text = ShoppingCartService.RemoveProduct(productId)
                        ? "Item removed from cart."
                        : "That item is no longer in your cart.";
                    break;
            }

            BindCart();
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            ShoppingCartService.Clear();
            FakeOrderReceiptState.Clear();
            lblCartMessage.Text = "Cart cleared.";
            BindCart();
        }

        protected void btnProceedToCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/Pages/Checkout.aspx"), false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void BindCart()
        {
            List<StoreCartItemView> items = ShoppingCartService.GetCartItems();
            bool hasItems = items.Count > 0;

            pnlCart.Visible = hasItems;
            pnlEmptyCart.Visible = !hasItems;

            if (!hasItems)
            {
                lblItemCount.Text = "0";
                lblSubtotal.Text = "$0.00";
                return;
            }

            rptCartItems.DataSource = items;
            rptCartItems.DataBind();
            lblItemCount.Text = ShoppingCartService.GetItemCount().ToString();
            lblSubtotal.Text = "$" + ShoppingCartService.GetSubtotal().ToString("F2");
        }
    }
}
