using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;
using MiniStoreWeb.Helpers;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Controls
{
    public partial class FeaturedProducts : UserControl
    {
        private bool _productsBound;

        public string SearchTerm { get; set; }
        public IList<string> SelectedCategories { get; set; }
        public string SortOption { get; set; }
        public string StockFilter { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            EnsureProductsBound();
        }

        public void BindFeaturedProducts()
        {
            LoadFeaturedProducts();
            _productsBound = true;
        }

        protected string GetImageUrl(object imageValue)
        {
            return ImageUrlHelper.ResolveForControl(this, Convert.ToString(imageValue));
        }

        protected string GetImageLoadingMode(int itemIndex)
        {
            return itemIndex < 4 ? "eager" : "lazy";
        }

        protected string GetImageFetchPriority(int itemIndex)
        {
            return itemIndex < 4 ? "high" : "low";
        }

        protected string GetCategoryCssClass(object categoryValue)
        {
            string category = (Convert.ToString(categoryValue) ?? string.Empty).Trim();

            switch (category.ToLowerInvariant())
            {
                case "stationery":
                    return "category-stationery";
                case "accessories":
                    return "category-accessories";
                case "drinkware":
                    return "category-drinkware";
                case "clothing":
                    return "category-clothing";
                case "study tools":
                    return "category-study-tools";
                default:
                    return "category-generic";
            }
        }

        protected string GetStockBadgeCssClass(object inStockValue, object stockQuantityValue, object productIdValue)
        {
            return CanAddToCart(productIdValue, inStockValue, stockQuantityValue)
                ? "stock-badge stock-yes"
                : "stock-badge stock-no";
        }

        protected string GetStockLabel(object inStockValue, object stockQuantityValue, object productIdValue)
        {
            bool inStock = Convert.ToBoolean(inStockValue);
            int stockQuantity = Convert.ToInt32(stockQuantityValue);
            int productId = Convert.ToInt32(productIdValue);

            if (!inStock || stockQuantity <= 0)
            {
                return "Out Of Stock";
            }

            int reservedQuantity = ShoppingCartService.GetReservedQuantity(productId);
            int remainingQuantity = stockQuantity - reservedQuantity;
            if (remainingQuantity <= 0)
            {
                return "Cart Maxed";
            }

            return remainingQuantity == 1
                ? "1 Left"
                : remainingQuantity + " Left";
        }

        protected string GetAddToCartText(object inStockValue, object stockQuantityValue, object productIdValue)
        {
            bool inStock = Convert.ToBoolean(inStockValue);
            int stockQuantity = Convert.ToInt32(stockQuantityValue);
            int productId = Convert.ToInt32(productIdValue);

            if (!inStock || stockQuantity <= 0)
            {
                return "Sold Out";
            }

            return ShoppingCartService.GetReservedQuantity(productId) >= stockQuantity
                ? "Limit Reached"
                : "Add To Cart";
        }

        protected bool CanAddToCart(object productIdValue, object inStockValue, object stockQuantityValue)
        {
            int productId = Convert.ToInt32(productIdValue);
            bool inStock = Convert.ToBoolean(inStockValue);
            int stockQuantity = Convert.ToInt32(stockQuantityValue);

            return inStock && stockQuantity > 0 && ShoppingCartService.GetReservedQuantity(productId) < stockQuantity;
        }

        protected void rptFeaturedProducts_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (!string.Equals(e.CommandName, "AddToCart", StringComparison.Ordinal))
            {
                return;
            }

            int productId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out productId))
            {
                lblCartActionMessage.Text = "That product could not be added to the cart.";
                return;
            }

            ProductRecord product = ProductRepository.FindProduct(productId);
            if (product == null || !ShoppingCartService.AddProduct(productId))
            {
                lblCartActionMessage.Text = product != null && product.StockQuantity > 0 && product.InStock
                    ? "You already have every available unit of that item in your cart."
                    : "That product is unavailable right now.";
                return;
            }

            lblCartActionMessage.Text = product.Name + " added to cart.";
            BindFeaturedProducts();
        }

        private void EnsureProductsBound()
        {
            if (_productsBound)
            {
                return;
            }

            LoadFeaturedProducts();
            _productsBound = true;
        }

        private void LoadFeaturedProducts()
        {
            List<ProductRecord> products;

            try
            {
                // Product data is sourced from App_Data/Products.xml through the shared repository.
                products = ProductRepository.GetProducts()
                    .Where(product => product.Featured)
                    .Where(product =>
                        SelectedCategories == null ||
                        SelectedCategories.Count == 0 ||
                        SelectedCategories.Any(category =>
                            string.Equals(category, product.Category, StringComparison.OrdinalIgnoreCase))
                    )
                    .Where(product =>
                        string.IsNullOrWhiteSpace(SearchTerm) ||
                        product.Name.IndexOf(SearchTerm, StringComparison.OrdinalIgnoreCase) >= 0 ||
                        product.Description.IndexOf(SearchTerm, StringComparison.OrdinalIgnoreCase) >= 0
                    )
                    .Where(ApplyStockFilter)
                    .ToList();

                products = ApplySort(products)
                    .ToList();
            }
            catch (FileNotFoundException)
            {
                litFeaturedMessage.Text = "<p style='color:red;'>Products.xml was not found.</p>";
                rptFeaturedProducts.Visible = false;
                return;
            }

            if (products.Count == 0)
            {
                litFeaturedMessage.Text = "<p>No products matched your current filters.</p>";
                rptFeaturedProducts.Visible = false;
                return;
            }

            litFeaturedMessage.Text = string.Empty;
            rptFeaturedProducts.Visible = true;
            rptFeaturedProducts.DataSource = products;
            rptFeaturedProducts.DataBind();
        }

        private bool ApplyStockFilter(ProductRecord product)
        {
            switch ((StockFilter ?? string.Empty).Trim().ToLowerInvariant())
            {
                case "in":
                    return product.IsPurchasable;
                case "out":
                    return !product.IsPurchasable;
                default:
                    return true;
            }
        }

        private List<ProductRecord> ApplySort(IEnumerable<ProductRecord> products)
        {
            switch ((SortOption ?? string.Empty).Trim().ToLowerInvariant())
            {
                case "price-asc":
                    return products.OrderBy(product => product.Price).ThenBy(product => product.Name).ToList();
                case "price-desc":
                    return products.OrderByDescending(product => product.Price).ThenBy(product => product.Name).ToList();
                default:
                    return products.OrderBy(product => product.Id).ToList();
            }
        }
    }
}
