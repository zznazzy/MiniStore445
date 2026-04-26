using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;

namespace MiniStoreWeb.Helpers
{
    public static class FavoritesState
    {
        private const string FavoritesKey = "MiniStoreFavoriteProductIds";

        public static List<int> GetFavoriteIds()
        {
            HttpSessionState session = GetSession();
            if (session == null)
            {
                return new List<int>();
            }

            List<int> favorites = session[FavoritesKey] as List<int>;
            if (favorites == null)
            {
                favorites = new List<int>();
                session[FavoritesKey] = favorites;
            }

            return favorites;
        }

        public static bool AddFavorite(int productId)
        {
            List<int> favorites = GetFavoriteIds();
            if (favorites.Contains(productId))
            {
                return false;
            }

            favorites.Add(productId);
            return true;
        }

        public static void RemoveFavorite(int productId)
        {
            List<int> favorites = GetFavoriteIds();
            favorites.RemoveAll(id => id == productId);
        }

        public static void Clear()
        {
            HttpSessionState session = GetSession();
            if (session != null)
            {
                session.Remove(FavoritesKey);
            }
        }

        private static HttpSessionState GetSession()
        {
            HttpContext context = HttpContext.Current;
            return context == null ? null : context.Session;
        }
    }
}
