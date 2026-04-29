using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using MiniStoreWeb.Helpers;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Pages
{
    public partial class Staff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect(ResolveUrl("~/Login.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!User.IsInRole(AuthenticationHelper.StaffRole))
            {
                RedirectToRoleHome();
                return;
            }

            if (!IsPostBack)
            {
                BindProducts();
                lblStaffWelcome.Text = "Signed in as staff user " + User.Identity.Name + ".";
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            ProductRecord newProduct;
            string errorMessage;
            if (!TryBuildProductFromAddForm(out newProduct, out errorMessage))
            {
                lblStaffMessage.Text = errorMessage;
                return;
            }

            ProductRepository.AddProduct(newProduct);
            ClearAddForm();
            lblStaffMessage.Text = "Product added to Products.xml.";
            BindProducts();
        }

        protected void gvProducts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProducts.EditIndex = e.NewEditIndex;
            BindProducts();
        }

        protected void gvProducts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProducts.EditIndex = -1;
            BindProducts();
        }

        protected void gvProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvProducts.Rows[e.RowIndex];
            int productId = (int)gvProducts.DataKeys[e.RowIndex].Value;

            ProductRecord updatedProduct;
            string errorMessage;
            if (!TryBuildProductFromEditRow(productId, row, out updatedProduct, out errorMessage))
            {
                lblStaffMessage.Text = errorMessage;
                return;
            }

            if (!ProductRepository.UpdateProduct(updatedProduct))
            {
                lblStaffMessage.Text = "The selected product could not be found for updating.";
                return;
            }

            gvProducts.EditIndex = -1;
            lblStaffMessage.Text = "Product updated successfully.";
            BindProducts();
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (!string.Equals(e.CommandName, "ToggleFeatured", StringComparison.Ordinal) &&
                !string.Equals(e.CommandName, "ToggleStock", StringComparison.Ordinal) &&
                !string.Equals(e.CommandName, "DeleteProduct", StringComparison.Ordinal))
            {
                return;
            }

            int productId;
            if (!int.TryParse(e.CommandArgument.ToString(), out productId))
            {
                lblStaffMessage.Text = "The product action could not be completed.";
                return;
            }

            bool updated;
            if (string.Equals(e.CommandName, "ToggleFeatured", StringComparison.Ordinal))
            {
                updated = ProductRepository.ToggleFeatured(productId);
            }
            else if (string.Equals(e.CommandName, "ToggleStock", StringComparison.Ordinal))
            {
                updated = ProductRepository.ToggleInStock(productId);
            }
            else
            {
                updated = ProductRepository.DeleteProduct(productId);
            }

            if (!updated)
            {
                lblStaffMessage.Text = "The requested product could not be found.";
                return;
            }

            if (string.Equals(e.CommandName, "ToggleFeatured", StringComparison.Ordinal))
            {
                lblStaffMessage.Text = "Featured flag updated.";
            }
            else if (string.Equals(e.CommandName, "ToggleStock", StringComparison.Ordinal))
            {
                lblStaffMessage.Text = "Availability flag updated.";
            }
            else
            {
                lblStaffMessage.Text = "Product deleted from Products.xml.";
            }

            BindProducts();
        }

        protected void btnStaffLogout_Click(object sender, EventArgs e)
        {
            AuthenticationHelper.SignOut();
            Response.Redirect(ResolveUrl("~/Default.aspx"), false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void BindProducts()
        {
            // The staff grid always reflects the current XML catalog contents.
            List<ProductRecord> products = ProductRepository.GetProducts();
            gvProducts.DataSource = products;
            gvProducts.DataBind();
            lblProductCount.Text = products.Count.ToString();
            lblStaffWelcome.Text = "Signed in as staff user " + User.Identity.Name + ".";
        }

        private bool TryBuildProductFromAddForm(out ProductRecord product, out string errorMessage)
        {
            return TryBuildProduct(
                txtNewName.Text,
                ddlNewCategory.SelectedValue,
                txtNewPrice.Text,
                txtNewStockQuantity.Text,
                txtNewImage.Text,
                txtNewDescription.Text,
                ParseBooleanSelection(ddlNewFeatured.SelectedValue),
                ParseBooleanSelection(ddlNewInStock.SelectedValue),
                out product,
                out errorMessage);
        }

        private bool TryBuildProductFromEditRow(int productId, GridViewRow row, out ProductRecord product, out string errorMessage)
        {
            TextBox txtEditName = row.FindControl("txtEditName") as TextBox;
            DropDownList ddlEditCategory = row.FindControl("ddlEditCategory") as DropDownList;
            TextBox txtEditPrice = row.FindControl("txtEditPrice") as TextBox;
            TextBox txtEditStockQuantity = row.FindControl("txtEditStockQuantity") as TextBox;
            TextBox txtEditImage = row.FindControl("txtEditImage") as TextBox;
            TextBox txtEditDescription = row.FindControl("txtEditDescription") as TextBox;
            DropDownList ddlEditFeatured = row.FindControl("ddlEditFeatured") as DropDownList;
            DropDownList ddlEditInStock = row.FindControl("ddlEditInStock") as DropDownList;

            bool success = TryBuildProduct(
                txtEditName == null ? string.Empty : txtEditName.Text,
                ddlEditCategory == null ? string.Empty : ddlEditCategory.SelectedValue,
                txtEditPrice == null ? string.Empty : txtEditPrice.Text,
                txtEditStockQuantity == null ? string.Empty : txtEditStockQuantity.Text,
                txtEditImage == null ? string.Empty : txtEditImage.Text,
                txtEditDescription == null ? string.Empty : txtEditDescription.Text,
                ddlEditFeatured != null && ParseBooleanSelection(ddlEditFeatured.SelectedValue),
                ddlEditInStock != null && ParseBooleanSelection(ddlEditInStock.SelectedValue),
                out product,
                out errorMessage);

            if (success)
            {
                product.Id = productId;
            }

            return success;
        }

        private bool TryBuildProduct(
            string name,
            string category,
            string priceText,
            string stockQuantityText,
            string image,
            string description,
            bool featured,
            bool inStock,
            out ProductRecord product,
            out string errorMessage)
        {
            product = null;
            errorMessage = string.Empty;

            // Normalize free-text fields once before validation.
            name = (name ?? string.Empty).Trim();
            category = (category ?? string.Empty).Trim();
            image = (image ?? string.Empty).Trim();
            description = (description ?? string.Empty).Trim();

            if (name.Length == 0)
            {
                errorMessage = "Product name is required.";
                return false;
            }

            if (category.Length == 0)
            {
                errorMessage = "Product category is required.";
                return false;
            }

            decimal price;
            if (!decimal.TryParse((priceText ?? string.Empty).Trim(), out price))
            {
                errorMessage = "Enter a valid decimal price.";
                return false;
            }

            int stockQuantity;
            if (!int.TryParse((stockQuantityText ?? string.Empty).Trim(), out stockQuantity) || stockQuantity < 0)
            {
                errorMessage = "Enter a valid non-negative stock quantity.";
                return false;
            }

            if (!ImageUrlHelper.IsRemoteImageUrl(image))
            {
                errorMessage = "Enter a full image link that starts with http:// or https://.";
                return false;
            }

            if (description.Length == 0)
            {
                errorMessage = "Product description is required.";
                return false;
            }

            if (stockQuantity == 0)
            {
                inStock = false;
            }

            product = new ProductRecord
            {
                Name = name,
                Category = category,
                Price = price,
                StockQuantity = stockQuantity,
                Image = image,
                Description = description,
                Featured = featured,
                InStock = inStock
            };

            return true;
        }

        private void ClearAddForm()
        {
            txtNewName.Text = string.Empty;
            ddlNewCategory.SelectedIndex = 0;
            txtNewPrice.Text = string.Empty;
            txtNewStockQuantity.Text = "0";
            txtNewImage.Text = string.Empty;
            txtNewDescription.Text = string.Empty;
            ddlNewFeatured.SelectedValue = bool.TrueString;
            ddlNewInStock.SelectedValue = bool.TrueString;
        }

        private static bool ParseBooleanSelection(string selectedValue)
        {
            bool parsedValue;
            return bool.TryParse(selectedValue, out parsedValue) && parsedValue;
        }

        private void RedirectToRoleHome()
        {
            string currentRole = AuthenticationHelper.GetCurrentRole();
            string destination = string.IsNullOrWhiteSpace(currentRole)
                ? ResolveUrl("~/Login.aspx")
                : ResolveUrl(AuthenticationHelper.GetDefaultLandingPage(currentRole));

            Response.Redirect(destination, false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
