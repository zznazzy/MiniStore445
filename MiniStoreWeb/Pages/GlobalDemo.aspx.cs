using System;

namespace MiniStoreWeb.Pages
{
    public partial class GlobalDemo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // This visible demo page reads values written in Global.asax:
            // - Application values (shared app-wide)
            // - Session values (current user session only)
            lblAppStartTime.Text = FormatValue(Application["AppStartTime"]);
            lblVisitorCount.Text = FormatValue(Application["VisitorCount"]);
            lblSessionStartTime.Text = FormatValue(Session["SessionStartTime"]);
            lblSessionId.Text = Session.SessionID;
        }

        private string FormatValue(object value)
        {
            // Keep output user-friendly when an expected state value has not been initialized yet.
            return value == null ? "(not set)" : value.ToString();
        }
    }
}
