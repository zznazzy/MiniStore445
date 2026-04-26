using System;
using System.Configuration;
using System.ServiceModel;
using System.Web;
using MiniStoreWeb.AdrianServiceReference;
using MiniStoreWeb.BellaServiceReference;

namespace MiniStoreWeb.Helpers
{
    public static class ServiceClientFactory
    {
        public static Service1Client CreateBellaServiceClient()
        {
            string endpointUrl = ResolveServiceUrl("BellaServicePath", "/BellaStoreService/Service1.svc");

            return new Service1Client(
                CreateBasicHttpBinding(endpointUrl),
                new EndpointAddress(endpointUrl)
            );
        }

        public static ShippingServiceClient CreateAdrianShippingClient()
        {
            string endpointUrl = ResolveServiceUrl("AdrianServicePath", "/AdrianStoreService/ShippingService.svc");

            return new ShippingServiceClient(
                CreateBasicHttpBinding(endpointUrl),
                new EndpointAddress(endpointUrl)
            );
        }

        private static BasicHttpBinding CreateBasicHttpBinding(string endpointUrl)
        {
            Uri endpointUri = new Uri(endpointUrl, UriKind.Absolute);
            BasicHttpBinding binding = endpointUri.Scheme == Uri.UriSchemeHttps
                ? new BasicHttpBinding(BasicHttpSecurityMode.Transport)
                : new BasicHttpBinding(BasicHttpSecurityMode.None);

            binding.MaxReceivedMessageSize = 65536;
            if (endpointUri.Scheme == Uri.UriSchemeHttps)
            {
                binding.Security.Transport.ClientCredentialType = HttpClientCredentialType.None;
            }

            return binding;
        }

        private static string ResolveServiceUrl(string appSettingKey, string defaultPath)
        {
            string configuredValue = ConfigurationManager.AppSettings[appSettingKey];
            string pathOrUrl = string.IsNullOrWhiteSpace(configuredValue) ? defaultPath : configuredValue.Trim();

            Uri absoluteUri;
            if (Uri.TryCreate(pathOrUrl, UriKind.Absolute, out absoluteUri))
            {
                return absoluteUri.ToString();
            }

            HttpRequest request = HttpContext.Current == null ? null : HttpContext.Current.Request;
            if (request == null)
            {
                throw new InvalidOperationException("An HTTP request is required to resolve a relative service endpoint.");
            }

            string appRelativePath;
            if (pathOrUrl.StartsWith("~/", StringComparison.Ordinal))
            {
                appRelativePath = pathOrUrl;
            }
            else if (pathOrUrl.StartsWith("/", StringComparison.Ordinal))
            {
                appRelativePath = "~" + pathOrUrl;
            }
            else
            {
                appRelativePath = "~/" + pathOrUrl.TrimStart('/');
            }

            string absolutePath = VirtualPathUtility.ToAbsolute(appRelativePath);
            return new Uri(request.Url, absolutePath).ToString();
        }
    }
}
