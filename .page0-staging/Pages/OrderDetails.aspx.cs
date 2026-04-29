using System;
using MiniStoreWeb.Helpers;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Pages
{
    public partial class OrderDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect(ResolveUrl("~/Login.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!User.IsInRole(AuthenticationHelper.MemberRole))
            {
                string currentRole = AuthenticationHelper.GetCurrentRole();
                string destination = string.IsNullOrWhiteSpace(currentRole)
                    ? ResolveUrl("~/Login.aspx")
                    : ResolveUrl(AuthenticationHelper.GetDefaultLandingPage(currentRole));

                Response.Redirect(destination, false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (IsPostBack)
            {
                return;
            }

            string orderNumber = (Request.QueryString["order"] ?? string.Empty).Trim();
            FakeOrderReceipt order = FakeOrderHistoryRepository.FindOrder(User.Identity.Name, orderNumber);
            if (order == null)
            {
                Response.Redirect(ResolveUrl("~/Pages/Member.aspx?tab=orders"), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            lblOrderNumber.Text = order.OrderNumber;
            lblPlacedAt.Text = order.CreatedAt.ToString("f");
            lblRegion.Text = order.Region;
            lblPaymentMethod.Text = order.PaymentMethod;
            lblOrderTotal.Text = "$" + order.FinalTotal.ToString("F2");
            lblCarrier.Text = "Orbital Parcel Express";
            lblEstimatedDelivery.Text = BuildImpossibleEta(order.CreatedAt, order.OrderNumber);
            rptOrderItems.DataSource = order.Items;
            rptOrderItems.DataBind();
        }

        private static string BuildImpossibleEta(DateTime placedAt, string orderNumber)
        {
            int orderSignal = string.IsNullOrWhiteSpace(orderNumber) ? 7 : orderNumber.Length;
            DateTime eta = placedAt.AddYears(2800 + orderSignal).AddDays(orderSignal * 9);
            return eta.ToString("MMMM d, yyyy") + " by 11:59 PM galactic standard time";
        }
    }
}
