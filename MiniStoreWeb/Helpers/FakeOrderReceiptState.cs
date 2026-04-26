using System.Web;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Helpers
{
    public static class FakeOrderReceiptState
    {
        private const string SessionKey = "MiniStoreLatestFakeOrderReceipt";

        public static FakeOrderReceipt GetCurrentReceipt()
        {
            HttpContext context = HttpContext.Current;
            return context == null || context.Session == null
                ? null
                : context.Session[SessionKey] as FakeOrderReceipt;
        }

        public static void Save(FakeOrderReceipt receipt)
        {
            HttpContext context = HttpContext.Current;
            if (context != null && context.Session != null)
            {
                context.Session[SessionKey] = receipt;
            }
        }

        public static void Clear()
        {
            HttpContext context = HttpContext.Current;
            if (context != null && context.Session != null)
            {
                context.Session.Remove(SessionKey);
            }
        }
    }
}
