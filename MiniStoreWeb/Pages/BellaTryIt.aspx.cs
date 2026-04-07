using System;
using MiniStoreWeb.BellaServiceReference;

namespace MiniStoreWeb.Pages
{
    public partial class BellaTryIt : System.Web.UI.Page
    {
        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            lblTryItMessage.Text = string.Empty;
            lblCouponDescription.Text = string.Empty;
            lblDiscountedTotal.Text = string.Empty;

            decimal subtotal;
            if (!decimal.TryParse(txtSubtotal.Text.Trim(), out subtotal))
            {
                lblTryItMessage.Text = "Please enter a valid decimal subtotal.";
                return;
            }

            Service1Client client = null;

            try
            {
                client = new Service1Client();

                string couponCode = ddlCouponCode.SelectedValue;
                string description = client.GetCouponDescription(couponCode);
                decimal discountedTotal = client.GetDiscountedTotal(subtotal, couponCode);

                lblCouponDescription.Text = description;
                lblDiscountedTotal.Text = "$" + discountedTotal.ToString("F2");

                client.Close();
            }
            catch (Exception ex)
            {
                if (client != null)
                {
                    client.Abort();
                }

                lblTryItMessage.Text = "Service call failed: " + ex.Message;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSubtotal.Text = string.Empty;
            ddlCouponCode.SelectedIndex = 0;
            lblCouponDescription.Text = string.Empty;
            lblDiscountedTotal.Text = string.Empty;
            lblTryItMessage.Text = string.Empty;
        }
    }
}