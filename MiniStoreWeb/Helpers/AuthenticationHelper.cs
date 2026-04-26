using System;
using System.Web;
using System.Web.Security;

namespace MiniStoreWeb.Helpers
{
    public static class AuthenticationHelper
    {
        public const string MemberRole = "Member";
        public const string StaffRole = "Staff";

        public static void SignIn(string username, string role, bool isPersistent)
        {
            DateTime issuedAt = DateTime.Now;
            DateTime expiresAt = issuedAt.Add(FormsAuthentication.Timeout);

            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                1,
                username,
                issuedAt,
                expiresAt,
                isPersistent,
                role,
                FormsAuthentication.FormsCookiePath
            );

            string encryptedTicket = FormsAuthentication.Encrypt(ticket);
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket)
            {
                HttpOnly = true
            };

            if (isPersistent)
            {
                cookie.Expires = ticket.Expiration;
            }

            HttpContext.Current.Response.Cookies.Add(cookie);
        }

        public static void SignOut()
        {
            FormsAuthentication.SignOut();

            HttpContext context = HttpContext.Current;
            if (context == null)
            {
                return;
            }

            if (context.Session != null)
            {
                context.Session.Abandon();
            }
        }

        public static string GetDefaultLandingPage(string role)
        {
            return string.Equals(role, StaffRole, StringComparison.OrdinalIgnoreCase)
                ? "~/Pages/Staff.aspx"
                : "~/Pages/Member.aspx";
        }

        public static string GetSafeReturnUrl(string returnUrl)
        {
            if (string.IsNullOrWhiteSpace(returnUrl))
            {
                return null;
            }

            if (!returnUrl.StartsWith("/", StringComparison.Ordinal) || returnUrl.StartsWith("//", StringComparison.Ordinal))
            {
                return null;
            }

            return returnUrl;
        }

        public static string GetCurrentRole()
        {
            HttpContext context = HttpContext.Current;
            if (context == null || context.User == null || !context.User.Identity.IsAuthenticated)
            {
                return string.Empty;
            }

            if (context.User.IsInRole(StaffRole))
            {
                return StaffRole;
            }

            if (context.User.IsInRole(MemberRole))
            {
                return MemberRole;
            }

            return string.Empty;
        }
    }
}
