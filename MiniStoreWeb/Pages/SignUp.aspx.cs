using System;
using MiniStoreWeb.Helpers;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Pages
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                RedirectAuthenticatedUser();
                return;
            }

            if (!IsPostBack)
            {
                RefreshCaptchaChallenge();
            }
        }

        protected void btnRefreshCaptcha_Click(object sender, EventArgs e)
        {
            lblSignUpMessage.Text = string.Empty;
            RefreshCaptchaChallenge();
        }

        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            lblSignUpMessage.Text = string.Empty;

            if (!string.Equals(txtPassword.Text, txtConfirmPassword.Text, StringComparison.Ordinal))
            {
                lblSignUpMessage.Text = "Password and confirmation must match.";
                RefreshCaptchaChallenge();
                return;
            }

            if (!CaptchaManager.Validate(txtCaptcha.Text))
            {
                lblSignUpMessage.Text = "Captcha verification failed. Please try again.";
                RefreshCaptchaChallenge();
                return;
            }

            StoreUser createdUser;
            string errorMessage;
            if (!AccountService.TryRegisterMember(
                txtDisplayName.Text,
                txtUserName.Text,
                txtPassword.Text,
                out createdUser,
                out errorMessage))
            {
                lblSignUpMessage.Text = errorMessage;
                RefreshCaptchaChallenge();
                return;
            }

            AuthenticationHelper.SignIn(createdUser.Username, createdUser.Role, false);
            Response.Redirect(ResolveUrl("~/Pages/Member.aspx"), false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void RefreshCaptchaChallenge()
        {
            CaptchaManager.CreateNewChallenge();
            imgCaptcha.ImageUrl = ResolveUrl("~/CaptchaImage.ashx?ts=" + DateTime.UtcNow.Ticks);
            txtCaptcha.Text = string.Empty;
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
