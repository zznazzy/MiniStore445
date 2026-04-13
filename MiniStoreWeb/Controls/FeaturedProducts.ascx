<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FeaturedProducts.ascx.cs" Inherits="MiniStoreWeb.Controls.FeaturedProducts" %>

<%-- Control-level styling for the featured product grid and cards. --%>
<style>
    .featured-subtext {
        color: #666;
        margin-bottom: 20px;
    }

    .product-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }

    .product-card {
        background: #ffffff;
        border-radius: 18px;
        box-shadow: 0 6px 22px rgba(0, 0, 0, 0.08);
        padding: 20px;
        width: calc(25% - 15px);
        min-width: 220px;
        transition: transform 0.15s ease, box-shadow 0.15s ease;
    }

    .product-card:hover {
        transform: translateY(-6px) scale(1.01);
        box-shadow: 0 10px 28px rgba(0, 0, 0, 0.12);
    }

    .product-image-wrap {
        width: 100%;
        height: 170px;
        background: #f8f9fb;
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 16px;
        overflow: hidden;
    }

    .product-image {
        max-width: 100%;
        max-height: 150px;
        object-fit: contain;
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
        background: #eef4ff;
        color: #2f5fa7;
        border-radius: 999px;
        padding: 4px 10px;
        font-size: 0.85rem;
        font-weight: 600;
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
    }

    .stock-badge {
        display: inline-block;
        border-radius: 999px;
        padding: 5px 10px;
        font-size: 0.85rem;
        font-weight: 600;
    }

    .stock-yes {
        background: #e9f8ef;
        color: #227a43;
    }

    .stock-no {
        background: #fdecec;
        color: #b44545;
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
    <%-- Context text for where data comes from. --%>
    <p class="featured-subtext">A few highlighted products loaded from <code>Products.xml</code>.</p>

    <%-- Displays file/load/no-match status messages from code-behind. --%>
    <asp:Literal ID="litFeaturedMessage" runat="server" />

    <%-- Repeater binds to the filtered featured product list generated in FeaturedProducts.ascx.cs. --%>
    <asp:Repeater ID="rptFeaturedProducts" runat="server">
        <HeaderTemplate>
            <div class="product-grid">
        </HeaderTemplate>
        <ItemTemplate>
            <%-- Single product card layout. --%>
            <div class="product-card">
                <div class="product-image-wrap">
                    <img class="product-image"
                         src="<%# ResolveUrl(Eval("Image").ToString()) %>"
                         alt="<%# Eval("Name") %>" />
                </div>

                <div class="product-card-header">
                    <div class="product-name"><%# Eval("Name") %></div>
                    <span class="product-category"><%# Eval("Category") %></span>
                </div>

                <div class="product-price">$<%# Eval("Price", "{0:F2}") %></div>

                <div class="product-description">
                    <%# Eval("Description") %>
                </div>

                <div>
                    <span class='stock-badge <%# (bool)Eval("InStock") ? "stock-yes" : "stock-no" %>'>
                        <%# (bool)Eval("InStock") ? "In Stock" : "Out of Stock" %>
                    </span>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>
</div>
