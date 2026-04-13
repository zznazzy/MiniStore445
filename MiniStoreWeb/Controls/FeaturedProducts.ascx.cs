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
        // These filter values are set by Default.aspx before this control binds data.
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
            // Product data is sourced from App_Data/Products.xml.
            string filePath = Server.MapPath("~/App_Data/Products.xml");

            if (!File.Exists(filePath))
            {
                litFeaturedMessage.Text = "<p style='color:red;'>Products.xml was not found.</p>";
                rptFeaturedProducts.Visible = false;
                return;
            }

            XDocument doc = XDocument.Load(filePath);

            // Parse each Product node from XML into a strongly-typed in-memory list.
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
                // Only show products marked as featured in XML.
                .Where(p => p.Featured)
                // Apply optional category filter (empty filter means "all categories").
                .Where(p =>
                    string.IsNullOrWhiteSpace(CategoryFilter) || p.Category == CategoryFilter
                )
                // Apply optional text search against name/description (case-insensitive).
                .Where(p =>
                    string.IsNullOrWhiteSpace(SearchTerm) ||
                    p.Name.IndexOf(SearchTerm, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    p.Description.IndexOf(SearchTerm, StringComparison.OrdinalIgnoreCase) >= 0
                )
                // Keep the featured grid lightweight by showing only the first 12 matches.
                .Take(12)
                .ToList();

            if (products.Count == 0)
            {
                // If filters/search remove all items, show a friendly message instead of an empty grid.
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
