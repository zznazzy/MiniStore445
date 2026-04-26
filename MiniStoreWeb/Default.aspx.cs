using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using MiniStoreWeb.Helpers;

namespace MiniStoreWeb
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            BindCategoryFilter();
            ApplyFiltersToFeaturedProducts();
            FeaturedProducts1.BindFeaturedProducts();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ApplyFiltersToFeaturedProducts();
            FeaturedProducts1.BindFeaturedProducts();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            SelectDropDownValue(ddlSort, string.Empty);
            SelectDropDownValue(ddlStock, string.Empty);

            foreach (ListItem item in cblCategories.Items)
            {
                item.Selected = false;
            }

            ApplyExplicitFilters(string.Empty, new string[0], string.Empty, string.Empty);
            FeaturedProducts1.BindFeaturedProducts();
        }

        private void BindCategoryFilter()
        {
            List<string> categories = ProductRepository.GetProducts()
                .Select(product => product.Category)
                .Where(category => !string.IsNullOrWhiteSpace(category))
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .OrderBy(category => category)
                .ToList();

            cblCategories.DataSource = categories;
            cblCategories.DataBind();
        }

        private void ApplyFiltersToFeaturedProducts()
        {
            string searchTerm = GetPostedValue(txtSearch.UniqueID, txtSearch.Text);
            string sortOption = GetPostedValue(ddlSort.UniqueID, ddlSort.SelectedValue);
            string stockFilter = GetPostedValue(ddlStock.UniqueID, ddlStock.SelectedValue);
            string[] selectedCategories = GetSelectedCategoriesFromRequest();

            ApplyExplicitFilters(searchTerm, selectedCategories, sortOption, stockFilter);
        }

        private void ApplyExplicitFilters(string searchTerm, IEnumerable<string> selectedCategories, string sortOption, string stockFilter)
        {
            FeaturedProducts1.SearchTerm = (searchTerm ?? string.Empty).Trim();
            FeaturedProducts1.SelectedCategories = (selectedCategories ?? new string[0]).ToArray();
            FeaturedProducts1.SortOption = (sortOption ?? string.Empty).Trim();
            FeaturedProducts1.StockFilter = (stockFilter ?? string.Empty).Trim();
        }

        private string[] GetSelectedCategoriesFromRequest()
        {
            if (!IsPostBack)
            {
                return cblCategories.Items.Cast<ListItem>()
                    .Where(item => item.Selected)
                    .Select(item => item.Value)
                    .ToArray();
            }

            string prefix = cblCategories.UniqueID + "$";

            return Request.Form.AllKeys
                .Where(key => !string.IsNullOrWhiteSpace(key) && key.StartsWith(prefix, StringComparison.Ordinal))
                .Select(ParseTrailingIndex)
                .Where(index => index >= 0 && index < cblCategories.Items.Count)
                .Select(index => cblCategories.Items[index].Value)
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .ToArray();
        }

        private string GetPostedValue(string uniqueId, string fallback)
        {
            if (!IsPostBack)
            {
                return (fallback ?? string.Empty).Trim();
            }

            return (Request.Form[uniqueId] ?? fallback ?? string.Empty).Trim();
        }

        private static int ParseTrailingIndex(string key)
        {
            if (string.IsNullOrWhiteSpace(key))
            {
                return -1;
            }

            int separatorIndex = key.LastIndexOf('$');
            int itemIndex;
            return separatorIndex >= 0 && int.TryParse(key.Substring(separatorIndex + 1), out itemIndex)
                ? itemIndex
                : -1;
        }

        private static void SelectDropDownValue(DropDownList dropDownList, string value)
        {
            if (dropDownList == null)
            {
                return;
            }

            ListItem item = dropDownList.Items.FindByValue((value ?? string.Empty).Trim());
            dropDownList.ClearSelection();

            if (item != null)
            {
                item.Selected = true;
            }
            else if (dropDownList.Items.Count > 0)
            {
                dropDownList.Items[0].Selected = true;
            }
        }
    }
}
