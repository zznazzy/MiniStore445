using System;

namespace MiniStoreWeb
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FeaturedProducts1.SearchTerm = string.Empty;
                FeaturedProducts1.CategoryFilter = string.Empty;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FeaturedProducts1.SearchTerm = txtSearch.Text.Trim();
            FeaturedProducts1.CategoryFilter = ddlCategory.SelectedValue;
        }
    }
}