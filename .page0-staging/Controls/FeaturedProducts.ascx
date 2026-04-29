<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FeaturedProducts.ascx.cs" Inherits="MiniStoreWeb.Controls.FeaturedProducts" %>

<%-- Control-level styling for the featured product grid and cards. --%>
<style>
    .featured-header {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        margin-bottom: 18px;
    }

    .featured-subtext {
        color: #666;
        margin-bottom: 0;
    }

    .featured-cart-message {
        color: #1f7a45;
        font-weight: 600;
        min-height: 24px;
        margin-bottom: 16px;
        display: block;
    }

    .product-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }

    .product-card {
        background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
        border-radius: 18px;
        border: 1px solid #dde7f4;
        box-shadow: 0 6px 22px rgba(0, 0, 0, 0.08);
        padding: 20px;
        width: calc(25% - 15px);
        min-width: 220px;
        transition: transform 0.15s ease, box-shadow 0.15s ease;
        display: flex;
        flex-direction: column;
    }

    .product-card:hover {
        transform: translateY(-6px) scale(1.01);
        box-shadow: 0 10px 28px rgba(0, 0, 0, 0.12);
    }

    .product-image-wrap {
        width: 100%;
        aspect-ratio: 1 / 1;
        background: linear-gradient(180deg, #f8fbff 0%, #edf2fb 100%);
        border-radius: 14px;
        border: 1px solid #e0e7f1;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 16px;
        overflow: hidden;
    }

    .product-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
    }

    .product-card-header {
        margin-bottom: 12px;
    }

    .product-name {
        font-size: 1.2rem;
        font-weight: 700;
        margin-bottom: 4px;
        color: #222;
    }

    .product-category {
        display: inline-block;
        border-radius: 999px;
        padding: 5px 12px;
        font-size: 0.85rem;
        font-weight: 600;
        border: 1px solid transparent;
    }

    .category-stationery {
        background: linear-gradient(180deg, #fff0f6 0%, #ffe0ea 100%);
        color: #b23b67;
        border-color: #f2bfd2;
    }

    .category-accessories {
        background: linear-gradient(180deg, #fff6e7 0%, #ffe7c1 100%);
        color: #b16c17;
        border-color: #f1d2a0;
    }

    .category-drinkware {
        background: linear-gradient(180deg, #ebfcfb 0%, #d7f2f1 100%);
        color: #177c82;
        border-color: #b6e4e2;
    }

    .category-clothing {
        background: linear-gradient(180deg, #eff3ff 0%, #dde6ff 100%);
        color: #3d57b8;
        border-color: #c5d1f7;
    }

    .category-study-tools {
        background: linear-gradient(180deg, #eefaf0 0%, #def1e2 100%);
        color: #2f7c41;
        border-color: #c5e3cb;
    }

    .category-generic {
        background: linear-gradient(180deg, #f5f8fc 0%, #e8eef6 100%);
        color: #4f5f73;
        border-color: #d9e1ea;
    }

    .product-price {
        font-size: 1.25rem;
        font-weight: 700;
        color: #1f7a45;
        margin-top: 12px;
        margin-bottom: 10px;
    }

    .product-description {
        color: #555;
        min-height: 60px;
        margin-bottom: 14px;
        flex-grow: 1;
    }

    .stock-badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 999px;
        padding: 5px 12px;
        font-size: 0.85rem;
        font-weight: 600;
        min-height: 38px;
        text-align: center;
        border: 1px solid transparent;
    }

    .stock-yes {
        background: linear-gradient(180deg, #f0fbf4 0%, #dff3e6 100%);
        color: #227a43;
        border-color: #c7e4d1;
    }

    .stock-no {
        background: linear-gradient(180deg, #fff2f2 0%, #fde2e2 100%);
        color: #b44545;
        border-color: #f0c8c8;
    }

    .product-actions {
        display: flex;
        justify-content: space-between;
        align-items: stretch;
        gap: 10px;
        margin-top: 16px;
    }

    .product-actions .btn {
        border-radius: 12px;
        width: 100%;
        min-height: 38px;
    }

    @media (max-width: 992px) {
        .product-card {
            width: calc(50% - 10px);
        }
    }

    @media (max-width: 576px) {
        .product-card {
            width: 100%;
        }
    }
</style>

<div id="featuredProductsSection">
    <div class="featured-header">
        <p class="featured-subtext">Featured picks update live as you filter and add items to the cart.</p>
    </div>

    <asp:Label ID="lblCartActionMessage" runat="server" CssClass="featured-cart-message" />

    <%-- Displays file/load/no-match status messages from code-behind. --%>
    <asp:Literal ID="litFeaturedMessage" runat="server" />

    <%-- Repeater binds to the filtered featured product list generated in FeaturedProducts.ascx.cs. --%>
    <asp:Repeater ID="rptFeaturedProducts" runat="server" OnItemCommand="rptFeaturedProducts_ItemCommand">
        <HeaderTemplate>
            <div class="product-grid">
        </HeaderTemplate>
        <ItemTemplate>
            <%-- Single product card layout. --%>
            <div class="product-card">
                <div class="product-image-wrap">
                    <img class="product-image"
                         src="<%# GetImageUrl(Eval("Image")) %>"
                         alt="<%# Eval("Name") %>"
                         width="640"
                         height="640"
                         loading="<%# GetImageLoadingMode(Container.ItemIndex) %>"
                         decoding="async"
                         fetchpriority="<%# GetImageFetchPriority(Container.ItemIndex) %>" />
                </div>

                <div class="product-card-header">
                    <div class="product-name"><%# Eval("Name") %></div>
                    <span class='product-category <%# GetCategoryCssClass(Eval("Category")) %>'><%# Eval("Category") %></span>
                </div>

                <div class="product-price">$<%# Eval("Price", "{0:F2}") %></div>

                <div class="product-description">
                    <%# Eval("Description") %>
                </div>

                <div class="product-actions">
                    <span class='<%# GetStockBadgeCssClass(Eval("InStock"), Eval("StockQuantity"), Eval("Id")) %>'>
                        <%# GetStockLabel(Eval("InStock"), Eval("StockQuantity"), Eval("Id")) %>
                    </span>
                    <asp:Button
                        ID="btnAddToCart"
                        runat="server"
                        Text='<%# GetAddToCartText(Eval("InStock"), Eval("StockQuantity"), Eval("Id")) %>'
                        Enabled='<%# CanAddToCart(Eval("Id"), Eval("InStock"), Eval("StockQuantity")) %>'
                        CommandName="AddToCart"
                        CommandArgument='<%# Eval("Id") %>'
                        CssClass="btn btn-primary btn-sm" />
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>
</div>
