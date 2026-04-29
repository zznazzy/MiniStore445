using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using MiniStoreWeb.Helpers;
using MiniStoreWeb.Models;

namespace MiniStoreWeb.Pages
{
    public partial class Member : System.Web.UI.Page
    {
        private const string TabQueryKey = "tab";
        private const string OverviewTab = "overview";
        private const string FavoritesTab = "favorites";
        private const string OrdersTab = "orders";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect(ResolveUrl("~/Login.aspx"), false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!User.IsInRole(AuthenticationHelper.MemberRole))
            {
                RedirectToRoleHome();
                return;
            }

            if (!IsPostBack)
            {
                BindFavoriteProductPicker();
            }

            BindMemberSummary();
            BindFavoritesGrid();
            BindOrdersGrid();
            ApplyActiveTab();
        }

        protected void btnAddFavorite_Click(object sender, EventArgs e)
        {
            lblFavoriteMessage.Text = string.Empty;

            int productId;
            if (!int.TryParse(ddlFavoriteProduct.SelectedValue, out productId))
            {
                lblFavoriteMessage.Text = "Choose a product before adding it to favorites.";
                return;
            }

            bool added = FavoritesState.AddFavorite(productId);
            lblFavoriteMessage.Text = added
                ? "Favorite saved."
                : "That product is already in your favorites list.";

            BindFavoritesGrid();
        }

        protected void btnClearFavorites_Click(object sender, EventArgs e)
        {
            FavoritesState.Clear();
            lblFavoriteMessage.Text = "Favorites cleared for this session.";
            BindFavoritesGrid();
        }

        protected void gvFavorites_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (!string.Equals(e.CommandName, "RemoveFavorite", StringComparison.Ordinal))
            {
                return;
            }

            int productId;
            if (int.TryParse(e.CommandArgument.ToString(), out productId))
            {
                FavoritesState.RemoveFavorite(productId);
                lblFavoriteMessage.Text = "Favorite removed.";
                BindFavoritesGrid();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            AuthenticationHelper.SignOut();
            Response.Redirect(ResolveUrl("~/Default.aspx"), false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected string GetOrderDetailsUrl(object orderNumberValue)
        {
            string orderNumber = Convert.ToString(orderNumberValue) ?? string.Empty;
            return ResolveUrl("~/Pages/OrderDetails.aspx?order=" + HttpUtility.UrlEncode(orderNumber));
        }

        private void BindMemberSummary()
        {
            StoreUser member = AccountRepository.FindMember(User.Identity.Name);
            string displayName = member != null && !string.IsNullOrWhiteSpace(member.DisplayName)
                ? member.DisplayName
                : User.Identity.Name;

            lblWelcomeMessage.Text = "Welcome back, " + displayName + ".";
            lblMemberSince.Text = member == null
                ? "(unknown)"
                : member.CreatedUtc.ToLocalTime().ToString("MMMM d, yyyy");
            lblCartCount.Text = ShoppingCartService.GetItemCount().ToString();

            object sessionStart = Session["SessionStartTime"];
            lblSessionStart.Text = sessionStart == null
                ? "(not set)"
                : Convert.ToDateTime(sessionStart).ToString("f");
        }

        private void BindFavoriteProductPicker()
        {
            // Favorites only list purchasable products so the picker matches the live catalog.
            List<ProductRecord> products = ProductRepository.GetProducts()
                .Where(product => product.IsPurchasable)
                .OrderBy(product => product.Name)
                .ToList();

            ddlFavoriteProduct.DataSource = products.Select(product => new
            {
                product.Id,
                Label = product.Name + " ($" + product.Price.ToString("F2") + ")"
            });
            ddlFavoriteProduct.DataTextField = "Label";
            ddlFavoriteProduct.DataValueField = "Id";
            ddlFavoriteProduct.DataBind();
            ddlFavoriteProduct.Items.Insert(0, new ListItem("Choose a product...", string.Empty));
        }

        private void BindFavoritesGrid()
        {
            List<int> favoriteIds = FavoritesState.GetFavoriteIds();
            List<ProductRecord> products = ProductRepository.GetProducts();

            List<ProductRecord> favorites = favoriteIds
                .Select(favoriteId => products.FirstOrDefault(product => product.Id == favoriteId))
                .Where(product => product != null)
                .ToList();

            gvFavorites.DataSource = favorites;
            gvFavorites.DataBind();
        }

        private void BindOrdersGrid()
        {
            List<FakeOrderReceipt> orders = FakeOrderHistoryRepository.GetOrdersForUser(User.Identity.Name);
            gvOrders.DataSource = orders;
            gvOrders.DataBind();
            lblOrderCount.Text = orders.Count.ToString();
        }

        private void ApplyActiveTab()
        {
            string activeTab = GetActiveTab();

            pnlOverview.Visible = string.Equals(activeTab, OverviewTab, StringComparison.OrdinalIgnoreCase);
            pnlFavorites.Visible = string.Equals(activeTab, FavoritesTab, StringComparison.OrdinalIgnoreCase);
            pnlOrders.Visible = string.Equals(activeTab, OrdersTab, StringComparison.OrdinalIgnoreCase);

            lnkTabOverview.NavigateUrl = ResolveUrl("~/Pages/Member.aspx?tab=" + OverviewTab);
            lnkTabFavorites.NavigateUrl = ResolveUrl("~/Pages/Member.aspx?tab=" + FavoritesTab);
            lnkTabOrders.NavigateUrl = ResolveUrl("~/Pages/Member.aspx?tab=" + OrdersTab);

            lnkTabOverview.CssClass = BuildTabCssClass(activeTab, OverviewTab);
            lnkTabFavorites.CssClass = BuildTabCssClass(activeTab, FavoritesTab);
            lnkTabOrders.CssClass = BuildTabCssClass(activeTab, OrdersTab);
        }

        private string GetActiveTab()
        {
            string requestedTab = (Request.QueryString[TabQueryKey] ?? string.Empty).Trim().ToLowerInvariant();

            switch (requestedTab)
            {
                case FavoritesTab:
                case OrdersTab:
                    return requestedTab;
                default:
                    return OverviewTab;
            }
        }

        private static string BuildTabCssClass(string activeTab, string tabName)
        {
            return string.Equals(activeTab, tabName, StringComparison.OrdinalIgnoreCase)
                ? "account-tab account-tab-active"
                : "account-tab";
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
