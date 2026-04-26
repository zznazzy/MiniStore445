using System;
using System.Web.UI;

namespace MiniStoreWeb
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected string BuildAbsoluteUrl(string appRelativePath)
        {
            Uri requestUrl = Request == null ? null : Request.Url;
            string relativeUrl = ResolveUrl(appRelativePath);

            return requestUrl == null
                ? relativeUrl
                : new Uri(requestUrl, relativeUrl).ToString();
        }
    }
}
