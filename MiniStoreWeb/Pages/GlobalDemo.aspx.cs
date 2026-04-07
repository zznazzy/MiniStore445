using System;

namespace MiniStoreWeb.Pages
{
    public partial class GlobalDemo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblAppStartTime.Text = FormatValue(Application["AppStartTime"]);
            lblVisitorCount.Text = FormatValue(Application["VisitorCount"]);
            lblSessionStartTime.Text = FormatValue(Session["SessionStartTime"]);
            lblSessionId.Text = Session.SessionID;
        }

        private string FormatValue(object value)
        {
            return value == null ? "(not set)" : value.ToString();
        }
    }
}