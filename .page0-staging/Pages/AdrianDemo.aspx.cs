using System;
using AdrianHashLib;
using MiniStoreWeb.AdrianServiceReference;
using MiniStoreWeb.Helpers;

namespace MiniStoreWeb.Pages
{
    public partial class AdrianDemo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblCartCount.Text = CartState.GetCartCount().ToString();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty;
            lblShipping.Text = string.Empty;
            lblHash.Text = string.Empty;

            decimal subtotal;
            if (!decimal.TryParse(txtSubtotal.Text.Trim(), out subtotal))
            {
                lblMessage.Text = "Please enter a valid decimal subtotal.";
                return;
            }

            string region = ddlRegion.SelectedValue;

            // The demo increments its own lightweight session counter instead of the full storefront cart.
            CartState.IncrementCart();
            lblCartCount.Text = CartState.GetCartCount().ToString();

            ShippingServiceClient client = null;

            try
            {
                // The shared client helper keeps this demo aligned with the deployed Adrian service contract.
                client = ServiceClientFactory.CreateAdrianShippingClient();
                decimal shipping = client.CalculateShipping(subtotal, region);
                lblShipping.Text = "$" + shipping.ToString("F2");
                client.Close();
            }
            catch (Exception ex)
            {
                if (client != null)
                {
                    client.Abort();
                }

                lblMessage.Text = "Service call failed: " + ex.Message;
                return;
            }

            string orderRef = subtotal + "|" + region + "|" + DateTime.UtcNow.ToString("O");
            lblHash.Text = HashUtil.Sha256(orderRef);
        }

        protected void btnGenerateHash_Click(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty;
            lblHashPreview.Text = HashUtil.Sha256(txtHashInput.Text.Trim());
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSubtotal.Text = string.Empty;
            ddlRegion.SelectedIndex = 0;
            lblShipping.Text = string.Empty;
            lblHash.Text = string.Empty;
            txtHashInput.Text = string.Empty;
            lblHashPreview.Text = string.Empty;
            lblMessage.Text = string.Empty;
        }
    }
}
