using System.Web;

namespace MiniStoreWeb.Helpers
{
    public static class CartState
    {
        private const string CartCountKey = "AdrianCartCount";

        public static int GetCartCount()
        {
            var session = HttpContext.Current?.Session;
            if (session == null) return 0;
            var value = session[CartCountKey];
            return value is int count ? count : 0;
        }

        public static void IncrementCart()
        {
            var session = HttpContext.Current?.Session;
            if (session == null) return;
            session[CartCountKey] = GetCartCount() + 1;
        }
    }
}
