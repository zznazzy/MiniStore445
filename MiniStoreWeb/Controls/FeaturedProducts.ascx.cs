using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Xml.Linq;

namespace MiniStoreWeb.Controls
{
    public partial class FeaturedProducts : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeaturedProducts();
            }
        }

        private void LoadFeaturedProducts()
        {
            string filePath = Server.MapPath("~/App_Data/Products.xml");

            if (!File.Exists(filePath))
            {
                litFeaturedMessage.Text = "<p style='color:red;'>Products.xml was not found.</p>";
                return;
            }

            XDocument doc = XDocument.Load(filePath);

            List<ProductItem> products = doc.Root
                .Elements("Product")
                .Select(p => new ProductItem
                {
                    Id = (int)p.Element("Id"),
                    Name = (string)p.Element("Name"),
                    Category = (string)p.Element("Category"),
                    Price = (decimal)p.Element("Price"),
                    Description = (string)p.Element("Description"),
                    InStock = ParseBool((string)p.Element("InStock")),
                    Featured = ParseBool((string)p.Element("Featured"))
                })
                .Where(p => p.Featured)
                .Take(4)
                .ToList();

            if (products.Count == 0)
            {
                litFeaturedMessage.Text = "<p>No featured products are currently available.</p>";
                rptFeaturedProducts.Visible = false;
                return;
            }

            litFeaturedMessage.Text = string.Empty;
            rptFeaturedProducts.DataSource = products;
            rptFeaturedProducts.DataBind();
        }

        private static bool ParseBool(string value)
        {
            bool parsed;
            return bool.TryParse(value, out parsed) && parsed;
        }

        private sealed class ProductItem
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Category { get; set; }
            public decimal Price { get; set; }
            public string Description { get; set; }
            public bool InStock { get; set; }
            public bool Featured { get; set; }
            public string InStockText => InStock ? "Yes" : "No";
        }
    }
}