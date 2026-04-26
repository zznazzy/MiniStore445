using System;
using MiniStoreWeb.Helpers;
using MiniStoreWeb.Models;

namespace MiniStoreWeb
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                RedirectAuthenticatedUser();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblLoginMessage.Text = string.Empty;

            StoreUser authenticatedUser;
            string errorMessage;
            if (!AccountService.TryAuthenticate(
                txtUsername.Text,
                txtPassword.Text,
                rblAccountType.SelectedValue,
                out authenticatedUser,
                out errorMessage))
            {
                lblLoginMessage.Text = errorMessage;
                return;
            }

            AuthenticationHelper.SignIn(authenticatedUser.Username, authenticatedUser.Role, chkRememberMe.Checked);

            string returnUrl = AuthenticationHelper.GetSafeReturnUrl(Request.QueryString["ReturnUrl"]);
            if (!CanAccessReturnUrl(authenticatedUser.Role, returnUrl))
            {
                returnUrl = null;
            }

            string destination = returnUrl ?? ResolveUrl(AuthenticationHelper.GetDefaultLandingPage(authenticatedUser.Role));
            Response.Redirect(destination, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private bool CanAccessReturnUrl(string role, string returnUrl)
        {
            if (string.IsNullOrWhiteSpace(returnUrl))
            {
                return true;
            }

            if (returnUrl.IndexOf("/Pages/Staff.aspx", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                return string.Equals(role, AuthenticationHelper.StaffRole, StringComparison.OrdinalIgnoreCase);
            }

            if (returnUrl.IndexOf("/Pages/Member.aspx", StringComparison.OrdinalIgnoreCase) >= 0 ||
                returnUrl.IndexOf("/Pages/OrderDetails.aspx", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                return string.Equals(role, AuthenticationHelper.MemberRole, StringComparison.OrdinalIgnoreCase);
            }

            return true;
        }

        private void RedirectAuthenticatedUser()
        {
            string currentRole = AuthenticationHelper.GetCurrentRole();
            string destination = string.IsNullOrWhiteSpace(currentRole)
                ? ResolveUrl("~/Default.aspx")
                : ResolveUrl(AuthenticationHelper.GetDefaultLandingPage(currentRole));

            Response.Redirect(destination, false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
