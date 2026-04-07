using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;

namespace MiniStoreWeb
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Keep the default startup registrations
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // Your custom logic
            Application["AppStartTime"] = DateTime.Now;
            Application["VisitorCount"] = 0;
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Application.Lock();

            int visitorCount = 0;
            if (Application["VisitorCount"] != null)
            {
                visitorCount = (int)Application["VisitorCount"];
            }

            Application["VisitorCount"] = visitorCount + 1;
            Application.UnLock();

            Session["SessionStartTime"] = DateTime.Now;
        }
    }
}