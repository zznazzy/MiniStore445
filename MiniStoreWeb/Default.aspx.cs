using System;

namespace MiniStoreWeb
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initial load: clear filters so the user control shows all featured products.
                FeaturedProducts1.SearchTerm = string.Empty;
                FeaturedProducts1.CategoryFilter = string.Empty;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // On search, pass current UI values into the FeaturedProducts control.
            // The control applies these values when it reloads XML data.
            FeaturedProducts1.SearchTerm = txtSearch.Text.Trim();
            FeaturedProducts1.CategoryFilter = ddlCategory.SelectedValue;
        }
    }
}
