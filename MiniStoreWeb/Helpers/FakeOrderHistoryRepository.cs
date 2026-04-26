using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml.Linq;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Helpers
{
    public static class FakeOrderHistoryRepository
    {
        private static readonly object SyncRoot = new object();
        private const string RootName = "Orders";

        public static void SaveMemberOrder(FakeOrderReceipt receipt)
        {
            if (receipt == null || string.IsNullOrWhiteSpace(receipt.Username))
            {
                return;
            }

            lock (SyncRoot)
            {
                string path = ResolvePath();
                XDocument document = LoadOrCreateDocument(path);
                document.Root.Add(ToElement(receipt));
                document.Save(path);
            }
        }

        public static List<FakeOrderReceipt> GetOrdersForUser(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                return new List<FakeOrderReceipt>();
            }

            lock (SyncRoot)
            {
                return LoadOrCreateDocument(ResolvePath()).Root
                    .Elements("Order")
                    .Select(ToReceipt)
                    .Where(order => string.Equals(order.Username, username, StringComparison.OrdinalIgnoreCase))
                    .OrderByDescending(order => order.CreatedAt)
                    .ToList();
            }
        }

        public static FakeOrderReceipt FindOrder(string username, string orderNumber)
        {
            return GetOrdersForUser(username).FirstOrDefault(order =>
                string.Equals(order.OrderNumber, orderNumber, StringComparison.OrdinalIgnoreCase));
        }

        private static XElement ToElement(FakeOrderReceipt receipt)
        {
            return new XElement("Order",
                new XElement("Username", receipt.Username ?? string.Empty),
                new XElement("OrderNumber", receipt.OrderNumber ?? string.Empty),
                new XElement("CreatedAt", receipt.CreatedAt.ToString("o")),
                new XElement("PaymentMethod", receipt.PaymentMethod ?? string.Empty),
                new XElement("Region", receipt.Region ?? string.Empty),
                new XElement("CouponCode", receipt.CouponCode ?? string.Empty),
                new XElement("CouponDescription", receipt.CouponDescription ?? string.Empty),
                new XElement("Subtotal", receipt.Subtotal.ToString("F2")),
                new XElement("DiscountAmount", receipt.DiscountAmount.ToString("F2")),
                new XElement("DiscountedSubtotal", receipt.DiscountedSubtotal.ToString("F2")),
                new XElement("ShippingCost", receipt.ShippingCost.ToString("F2")),
                new XElement("FinalTotal", receipt.FinalTotal.ToString("F2")),
                new XElement("Items",
                    (receipt.Items ?? new List<StoreCartItemView>()).Select(item =>
                        new XElement("Item",
                            new XElement("ProductId", item.ProductId),
                            new XElement("Name", item.Name ?? string.Empty),
                            new XElement("Category", item.Category ?? string.Empty),
                            new XElement("Description", item.Description ?? string.Empty),
                            new XElement("Image", item.Image ?? string.Empty),
                            new XElement("UnitPrice", item.UnitPrice.ToString("F2")),
                            new XElement("Quantity", item.Quantity)
                        )
                    )
                )
            );
        }

        private static FakeOrderReceipt ToReceipt(XElement element)
        {
            return new FakeOrderReceipt
            {
                Username = ((string)element.Element("Username") ?? string.Empty).Trim(),
                OrderNumber = ((string)element.Element("OrderNumber") ?? string.Empty).Trim(),
                CreatedAt = ParseDate((string)element.Element("CreatedAt")),
                PaymentMethod = ((string)element.Element("PaymentMethod") ?? string.Empty).Trim(),
                Region = ((string)element.Element("Region") ?? string.Empty).Trim(),
                CouponCode = ((string)element.Element("CouponCode") ?? string.Empty).Trim(),
                CouponDescription = ((string)element.Element("CouponDescription") ?? string.Empty).Trim(),
                Subtotal = ParseDecimal((string)element.Element("Subtotal")),
                DiscountAmount = ParseDecimal((string)element.Element("DiscountAmount")),
                DiscountedSubtotal = ParseDecimal((string)element.Element("DiscountedSubtotal")),
                ShippingCost = ParseDecimal((string)element.Element("ShippingCost")),
                FinalTotal = ParseDecimal((string)element.Element("FinalTotal")),
                Items = element.Element("Items") == null
                    ? new List<StoreCartItemView>()
                    : element.Element("Items")
                        .Elements("Item")
                        .Select(item => new StoreCartItemView
                        {
                            ProductId = ParseInt((string)item.Element("ProductId")),
                            Name = ((string)item.Element("Name") ?? string.Empty).Trim(),
                            Category = ((string)item.Element("Category") ?? string.Empty).Trim(),
                            Description = ((string)item.Element("Description") ?? string.Empty).Trim(),
                            Image = ((string)item.Element("Image") ?? string.Empty).Trim(),
                            UnitPrice = ParseDecimal((string)item.Element("UnitPrice")),
                            Quantity = ParseInt((string)item.Element("Quantity"))
                        })
                        .ToList()
            };
        }

        private static XDocument LoadOrCreateDocument(string path)
        {
            EnsureDirectory(path);

            if (!File.Exists(path))
            {
                XDocument newDocument = new XDocument(new XElement(RootName));
                newDocument.Save(path);
                return newDocument;
            }

            XDocument document = XDocument.Load(path);
            if (document.Root == null || !string.Equals(document.Root.Name.LocalName, RootName, StringComparison.Ordinal))
            {
                document = new XDocument(new XElement(RootName));
                document.Save(path);
            }

            return document;
        }

        private static void EnsureDirectory(string path)
        {
            string directoryPath = Path.GetDirectoryName(path);
            if (!string.IsNullOrWhiteSpace(directoryPath) && !Directory.Exists(directoryPath))
            {
                Directory.CreateDirectory(directoryPath);
            }
        }

        private static decimal ParseDecimal(string value)
        {
            decimal parsedValue;
            return decimal.TryParse(value, out parsedValue) ? parsedValue : 0M;
        }

        private static int ParseInt(string value)
        {
            int parsedValue;
            return int.TryParse(value, out parsedValue) ? parsedValue : 0;
        }

        private static DateTime ParseDate(string value)
        {
            DateTime parsedValue;
            return DateTime.TryParse(value, out parsedValue) ? parsedValue : DateTime.UtcNow;
        }

        private static string ResolvePath()
        {
            HttpContext context = HttpContext.Current;
            if (context == null)
            {
                throw new InvalidOperationException("An active HTTP context is required to resolve XML storage paths.");
            }

            return context.Server.MapPath("~/App_Data/Orders.xml");
        }
    }
}
