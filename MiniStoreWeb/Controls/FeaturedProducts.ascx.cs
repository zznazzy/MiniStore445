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
        public string SearchTerm { get; set; }
        public string CategoryFilter { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadFeaturedProducts();
        }

        public override void DataBind()
        {
            LoadFeaturedProducts();
            base.DataBind();
        }

        private void LoadFeaturedProducts()
        {
            string filePath = Server.MapPath("~/App_Data/Products.xml");

            if (!File.Exists(filePath))
            {
                litFeaturedMessage.Text = "<p style='color:red;'>Products.xml was not found.</p>";
                rptFeaturedProducts.Visible = false;
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
                    Image = (string)p.Element("Image"),
                    InStock = ParseBool((string)p.Element("InStock")),
                    Featured = ParseBool((string)p.Element("Featured"))
                })
                .Where(p => p.Featured)
                .Where(p =>
                    string.IsNullOrWhiteSpace(CategoryFilter) || p.Category == CategoryFilter
                )
                .Where(p =>
                    string.IsNullOrWhiteSpace(SearchTerm) ||
                    p.Name.IndexOf(SearchTerm, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    p.Description.IndexOf(SearchTerm, StringComparison.OrdinalIgnoreCase) >= 0
                )
                .Take(12)
                .ToList();

            if (products.Count == 0)
            {
                litFeaturedMessage.Text = "<p>No products matched your search.</p>";
                rptFeaturedProducts.Visible = false;
                return;
            }

            litFeaturedMessage.Text = string.Empty;
            rptFeaturedProducts.Visible = true;
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
            public string Image { get; set; }
            public bool InStock { get; set; }
            public bool Featured { get; set; }
        }
    }
}