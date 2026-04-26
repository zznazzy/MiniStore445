using System;
using MiniStoreWeb.BellaServiceReference;
using MiniStoreWeb.Helpers;

namespace MiniStoreWeb.Pages
{
    public partial class BellaTryIt : System.Web.UI.Page
    {
        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            // Reset output labels before each calculation attempt.
            lblTryItMessage.Text = string.Empty;
            lblCouponDescription.Text = string.Empty;
            lblDiscountedTotal.Text = string.Empty;

            decimal subtotal;
            // Validate subtotal input before calling the service.
            if (!decimal.TryParse(txtSubtotal.Text.Trim(), out subtotal))
            {
                lblTryItMessage.Text = "Please enter a valid decimal subtotal.";
                return;
            }

            // Service client is created per request and safely closed/aborted below.
            Service1Client client = null;

            try
            {
                client = ServiceClientFactory.CreateBellaServiceClient();

                // Call service operations using UI-selected coupon + validated subtotal.
                string couponCode = ddlCouponCode.SelectedValue;
                string description = client.GetCouponDescription(couponCode);
                decimal discountedTotal = client.GetDiscountedTotal(subtotal, couponCode);

                lblCouponDescription.Text = description;
                lblDiscountedTotal.Text = "$" + discountedTotal.ToString("F2");

                // Close gracefully after successful calls.
                client.Close();
            }
            catch (Exception ex)
            {
                if (client != null)
                {
                    // Abort to dispose faulted channel if a service exception occurred.
                    client.Abort();
                }

                // Surface a readable error message for TryIt testing.
                lblTryItMessage.Text = "Service call failed: " + ex.Message;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            // Restore form and results to default state for a fresh TryIt run.
            txtSubtotal.Text = string.Empty;
            ddlCouponCode.SelectedIndex = 0;
            lblCouponDescription.Text = string.Empty;
            lblDiscountedTotal.Text = string.Empty;
            lblTryItMessage.Text = string.Empty;
        }
    }
}
