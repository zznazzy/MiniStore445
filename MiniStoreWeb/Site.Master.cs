using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using MiniStoreWeb.Helpers;

namespace MiniStoreWeb
{
    public partial class SiteMaster : MasterPage
    {
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            int itemCount = ShoppingCartService.GetItemCount();
            lblCartCount.Text = itemCount > 99 ? "99+" : itemCount.ToString();
            cartBadge.Attributes["class"] = ShoppingCartService.ConsumePulseFlag()
                ? "cart-count-badge cart-count-badge-pulse"
                : "cart-count-badge";
        }

        protected void LoginStatus_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            AuthenticationHelper.SignOut();
        }
    }
}
