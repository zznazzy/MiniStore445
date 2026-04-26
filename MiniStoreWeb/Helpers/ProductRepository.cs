using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Xml.Linq;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Helpers
{
    public static class ProductRepository
    {
        private static readonly object SyncRoot = new object();
        private const string ProductCacheKey = "MiniStoreWeb.Products";

        public static List<ProductRecord> GetProducts()
        {
            List<ProductRecord> cachedProducts = HttpRuntime.Cache[ProductCacheKey] as List<ProductRecord>;
            if (cachedProducts != null)
            {
                return CloneProducts(cachedProducts);
            }

            lock (SyncRoot)
            {
                cachedProducts = HttpRuntime.Cache[ProductCacheKey] as List<ProductRecord>;
                if (cachedProducts != null)
                {
                    return CloneProducts(cachedProducts);
                }

                XDocument document = LoadDocument();
                List<ProductRecord> products = document.Root
                    .Elements("Product")
                    .Select(ToProductRecord)
                    .OrderBy(product => product.Id)
                    .ToList();

                HttpRuntime.Cache.Insert(
                    ProductCacheKey,
                    products,
                    new CacheDependency(ResolvePath()),
                    Cache.NoAbsoluteExpiration,
                    Cache.NoSlidingExpiration);

                return CloneProducts(products);
            }
        }

        public static ProductRecord FindProduct(int id)
        {
            return GetProducts().FirstOrDefault(product => product.Id == id);
        }

        public static ProductRecord AddProduct(ProductRecord product)
        {
            lock (SyncRoot)
            {
                XDocument document = LoadDocument();
                List<ProductRecord> products = document.Root.Elements("Product").Select(ToProductRecord).ToList();

                int nextId = products.Count == 0 ? 1 : products.Max(item => item.Id) + 1;
                product.Id = nextId;

                document.Root.Add(ToElement(product));
                document.Save(ResolvePath());
                InvalidateCache();
                return product;
            }
        }

        public static bool UpdateProduct(ProductRecord updatedProduct)
        {
            lock (SyncRoot)
            {
                XDocument document = LoadDocument();
                XElement existingElement = document.Root
                    .Elements("Product")
                    .FirstOrDefault(element => (int?)element.Element("Id") == updatedProduct.Id);

                if (existingElement == null)
                {
                    return false;
                }

                existingElement.ReplaceWith(ToElement(updatedProduct));
                document.Save(ResolvePath());
                InvalidateCache();
                return true;
            }
        }

        public static bool ToggleFeatured(int id)
        {
            return ToggleFlag(id, product => product.Featured = !product.Featured);
        }

        public static bool ToggleInStock(int id)
        {
            return ToggleFlag(id, product =>
            {
                product.InStock = !product.InStock;

                if (product.InStock && product.StockQuantity <= 0)
                {
                    product.StockQuantity = 1;
                }
            });
        }

        public static bool DeleteProduct(int id)
        {
            lock (SyncRoot)
            {
                XDocument document = LoadDocument();
                XElement existingElement = document.Root
                    .Elements("Product")
                    .FirstOrDefault(element => (int?)element.Element("Id") == id);

                if (existingElement == null)
                {
                    return false;
                }

                existingElement.Remove();
                document.Save(ResolvePath());
                InvalidateCache();
                return true;
            }
        }

        private static bool ToggleFlag(int id, Action<ProductRecord> toggleAction)
        {
            lock (SyncRoot)
            {
                XDocument document = LoadDocument();
                XElement existingElement = document.Root
                    .Elements("Product")
                    .FirstOrDefault(element => (int?)element.Element("Id") == id);

                if (existingElement == null)
                {
                    return false;
                }

                ProductRecord product = ToProductRecord(existingElement);
                toggleAction(product);
                existingElement.ReplaceWith(ToElement(product));
                document.Save(ResolvePath());
                InvalidateCache();
                return true;
            }
        }

        private static void InvalidateCache()
        {
            HttpRuntime.Cache.Remove(ProductCacheKey);
        }

        private static List<ProductRecord> CloneProducts(IEnumerable<ProductRecord> products)
        {
            return products.Select(product => new ProductRecord
            {
                Id = product.Id,
                Name = product.Name,
                Category = product.Category,
                Price = product.Price,
                Description = product.Description,
                Image = product.Image,
                InStock = product.InStock,
                Featured = product.Featured,
                StockQuantity = product.StockQuantity
            }).ToList();
        }

        private static ProductRecord ToProductRecord(XElement element)
        {
            // Missing XML fields fall back to safe defaults so older product entries still load.
            return new ProductRecord
            {
                Id = (int?)element.Element("Id") ?? 0,
                Name = ((string)element.Element("Name") ?? string.Empty).Trim(),
                Category = ((string)element.Element("Category") ?? string.Empty).Trim(),
                Price = (decimal?)element.Element("Price") ?? 0M,
                Description = ((string)element.Element("Description") ?? string.Empty).Trim(),
                Image = ((string)element.Element("Image") ?? string.Empty).Trim(),
                InStock = ParseBool((string)element.Element("InStock")),
                Featured = ParseBool((string)element.Element("Featured")),
                StockQuantity = ParseStockQuantity(element, (string)element.Element("InStock"))
            };
        }

        private static XElement ToElement(ProductRecord product)
        {
            return new XElement("Product",
                new XElement("Id", product.Id),
                new XElement("Name", product.Name ?? string.Empty),
                new XElement("Category", product.Category ?? string.Empty),
                new XElement("Price", product.Price.ToString("F2")),
                new XElement("Description", product.Description ?? string.Empty),
                new XElement("Image", product.Image ?? string.Empty),
                new XElement("InStock", product.InStock.ToString().ToLowerInvariant()),
                new XElement("Featured", product.Featured.ToString().ToLowerInvariant()),
                new XElement("StockQuantity", product.StockQuantity < 0 ? 0 : product.StockQuantity)
            );
        }

        private static bool ParseBool(string value)
        {
            bool parsedValue;
            return bool.TryParse(value, out parsedValue) && parsedValue;
        }

        private static int ParseStockQuantity(XElement element, string inStockValue)
        {
            int stockQuantity;
            if (int.TryParse((string)element.Element("StockQuantity"), out stockQuantity))
            {
                return stockQuantity < 0 ? 0 : stockQuantity;
            }

            return ParseBool(inStockValue) ? 1 : 0;
        }

        private static XDocument LoadDocument()
        {
            string path = ResolvePath();

            if (!File.Exists(path))
            {
                throw new FileNotFoundException("Products.xml was not found.", path);
            }

            XDocument document = XDocument.Load(path);
            if (document.Root == null)
            {
                // Recreate the root node if the file exists but is empty or malformed.
                document = new XDocument(new XElement("Products"));
                document.Save(path);
            }

            return document;
        }

        private static string ResolvePath()
        {
            HttpContext context = HttpContext.Current;
            if (context == null)
            {
                throw new InvalidOperationException("An active HTTP context is required to resolve Products.xml.");
            }

            return context.Server.MapPath("~/App_Data/Products.xml");
        }
    }
}
