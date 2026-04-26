using System.Collections.Generic;
using System.Linq;
using System.Web;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Helpers
{
    public static class ShoppingCartService
    {
        private const string SessionKey = "MiniStoreShoppingCartLines";
        private const string PulseSessionKey = "MiniStoreCartCountPulse";

        public static bool AddProduct(int productId)
        {
            ProductRecord product = ProductRepository.FindProduct(productId);
            if (product == null || !product.IsPurchasable)
            {
                return false;
            }

            List<StoreCartLine> lines = GetOrCreateLines();
            StoreCartLine existingLine = lines.FirstOrDefault(line => line.ProductId == productId);
            int currentQuantity = existingLine == null ? 0 : existingLine.Quantity;

            if (currentQuantity >= product.StockQuantity)
            {
                return false;
            }

            if (existingLine == null)
            {
                lines.Add(new StoreCartLine
                {
                    ProductId = productId,
                    Quantity = 1
                });
            }
            else
            {
                existingLine.Quantity += 1;
            }

            SetPulseFlag();
            return true;
        }

        public static bool IncreaseQuantity(int productId)
        {
            return AddProduct(productId);
        }

        public static bool DecreaseQuantity(int productId)
        {
            List<StoreCartLine> lines = GetOrCreateLines();
            StoreCartLine existingLine = lines.FirstOrDefault(line => line.ProductId == productId);
            if (existingLine == null)
            {
                return false;
            }

            existingLine.Quantity -= 1;
            if (existingLine.Quantity <= 0)
            {
                lines.Remove(existingLine);
            }

            return true;
        }

        public static bool RemoveProduct(int productId)
        {
            List<StoreCartLine> lines = GetOrCreateLines();
            return lines.RemoveAll(line => line.ProductId == productId) > 0;
        }

        public static void Clear()
        {
            HttpContext context = HttpContext.Current;
            if (context != null && context.Session != null)
            {
                context.Session.Remove(SessionKey);
            }
        }

        public static List<StoreCartItemView> GetCartItems()
        {
            List<StoreCartLine> lines = GetOrCreateLines();
            List<ProductRecord> products = ProductRepository.GetProducts();
            NormalizeCart(lines, products);

            List<StoreCartItemView> items = lines
                .Select(line =>
                {
                    ProductRecord product = products.FirstOrDefault(item => item.Id == line.ProductId);
                    if (product == null)
                    {
                        return null;
                    }

                    return new StoreCartItemView
                    {
                        ProductId = product.Id,
                        Name = product.Name,
                        Category = product.Category,
                        Description = product.Description,
                        Image = product.Image,
                        UnitPrice = product.Price,
                        Quantity = line.Quantity,
                        InStock = product.InStock,
                        StockQuantity = product.StockQuantity,
                        CanIncreaseQuantity = product.IsPurchasable && line.Quantity < product.StockQuantity,
                        RemainingAvailableQuantity = product.StockQuantity - line.Quantity < 0
                            ? 0
                            : product.StockQuantity - line.Quantity
                    };
                })
                .Where(item => item != null)
                .ToList();

            return items;
        }

        public static int GetItemCount()
        {
            return GetOrCreateLines().Sum(line => line.Quantity);
        }

        public static decimal GetSubtotal()
        {
            return GetCartItems().Sum(item => item.LineTotal);
        }

        public static int GetReservedQuantity(int productId)
        {
            return GetOrCreateLines()
                .Where(line => line.ProductId == productId)
                .Select(line => line.Quantity)
                .FirstOrDefault();
        }

        public static bool ConsumePulseFlag()
        {
            HttpContext context = HttpContext.Current;
            if (context == null || context.Session == null)
            {
                return false;
            }

            bool shouldPulse = context.Session[PulseSessionKey] is bool && (bool)context.Session[PulseSessionKey];
            context.Session[PulseSessionKey] = false;
            return shouldPulse;
        }

        private static List<StoreCartLine> GetOrCreateLines()
        {
            HttpContext context = HttpContext.Current;
            if (context == null || context.Session == null)
            {
                return new List<StoreCartLine>();
            }

            List<StoreCartLine> lines = context.Session[SessionKey] as List<StoreCartLine>;
            if (lines == null)
            {
                lines = new List<StoreCartLine>();
                context.Session[SessionKey] = lines;
            }

            return lines;
        }

        private static void NormalizeCart(List<StoreCartLine> lines, List<ProductRecord> products)
        {
            foreach (StoreCartLine line in lines.ToList())
            {
                ProductRecord product = products.FirstOrDefault(item => item.Id == line.ProductId);
                if (product == null)
                {
                    lines.Remove(line);
                    continue;
                }

                int allowedQuantity = product.IsPurchasable ? product.StockQuantity : 0;
                if (allowedQuantity <= 0)
                {
                    lines.Remove(line);
                    continue;
                }

                if (line.Quantity > allowedQuantity)
                {
                    line.Quantity = allowedQuantity;
                }
            }
        }

        private static void SetPulseFlag()
        {
            HttpContext context = HttpContext.Current;
            if (context != null && context.Session != null)
            {
                context.Session[PulseSessionKey] = true;
            }
        }
    }
}
