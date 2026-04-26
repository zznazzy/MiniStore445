using System;
using System.Web.UI;

namespace MiniStoreWeb.Helpers
{
    public static class ImageUrlHelper
    {
        public static bool IsRemoteImageUrl(string imageValue)
        {
            Uri imageUri;
            return Uri.TryCreate(imageValue ?? string.Empty, UriKind.Absolute, out imageUri) &&
                (imageUri.Scheme == Uri.UriSchemeHttp || imageUri.Scheme == Uri.UriSchemeHttps);
        }

        public static string ResolveForControl(Control control, string imageValue)
        {
            imageValue = (imageValue ?? string.Empty).Trim();
            if (imageValue.Length == 0)
            {
                return string.Empty;
            }

            if (IsRemoteImageUrl(imageValue))
            {
                return imageValue;
            }

            return control == null ? imageValue : control.ResolveUrl(imageValue);
        }
    }
}
