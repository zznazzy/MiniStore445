using System;
using System.Security.Principal;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;

namespace MiniStoreWeb
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Keep the default startup registrations for site routing and static asset bundles.
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Store values in Application state (shared across all users for the lifetime of the app).
            // AppStartTime is shown on the demo page to prove startup logic ran.
            // VisitorCount starts at 0 and is incremented once per new session in Session_Start.
            Application["AppStartTime"] = DateTime.Now;
            Application["VisitorCount"] = 0;
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            // Session_Start fires once for each new user session.
            // Use Application.Lock/UnLock so the shared VisitorCount update is thread-safe.
            Application.Lock();

            int visitorCount = 0;
            if (Application["VisitorCount"] != null)
            {
                visitorCount = (int)Application["VisitorCount"];
            }

            Application["VisitorCount"] = visitorCount + 1;
            Application.UnLock();

            // Session state is per visitor; save when this specific session began.
            Session["SessionStartTime"] = DateTime.Now;
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            if (authCookie == null || string.IsNullOrWhiteSpace(authCookie.Value))
            {
                return;
            }

            try
            {
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                if (ticket == null || ticket.Expired)
                {
                    return;
                }

                string[] roles = string.IsNullOrWhiteSpace(ticket.UserData)
                    ? new string[0]
                    : ticket.UserData.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                GenericPrincipal principal = new GenericPrincipal(new FormsIdentity(ticket), roles);
                Context.User = principal;
                HttpContext.Current.User = principal;
            }
            catch
            {
                // Ignore malformed auth cookies and let FormsAuthentication treat the request as anonymous.
            }
        }
    }
}
