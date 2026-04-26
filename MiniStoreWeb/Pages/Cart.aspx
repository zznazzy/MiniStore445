<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="MiniStoreWeb.Pages.Cart" MaintainScrollPositionOnPostBack="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .cart-layout {
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 24px;
        }

        .cart-panel,
        .cart-summary {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 24px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 24px rgba(0,0,0,0.08);
        }

        .cart-item {
            display: grid;
            grid-template-columns: 108px 1fr auto;
            gap: 18px;
            align-items: center;
            padding: 18px 0;
            border-bottom: 1px solid #eef1f5;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .cart-item img {
            width: 108px;
            height: 108px;
            border-radius: 14px;
            object-fit: cover;
            background: #f5f6fb;
        }

        .cart-item-title {
            font-size: 1.15rem;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .cart-item-meta {
            color: #5b6472;
            margin-bottom: 6px;
        }

        .cart-item-desc {
            color: #6a7280;
            margin-bottom: 0;
        }

        .cart-item-stock {
            color: #2f5fa7;
            font-size: 0.92rem;
            margin-top: 8px;
        }

        .cart-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 10px;
        }

        .quantity-controls {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: linear-gradient(180deg, #f9fbff 0%, #eef4fc 100%);
            border-radius: 999px;
            padding: 6px 10px;
            border: 1px solid #dce5f2;
        }

        .quantity-controls .btn {
            border-radius: 999px;
            min-width: 36px;
        }

        .cart-total {
            font-size: 1.05rem;
            font-weight: 700;
            color: #1f7a45;
        }

        .cart-remove-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 38px;
            padding: 0 14px;
            border-radius: 999px;
            text-decoration: none;
            font-weight: 600;
            color: #9f4242;
            background: linear-gradient(180deg, #fff4f4 0%, #ffe8e8 100%);
            border: 1px solid #efc7c7;
            box-shadow: 0 8px 18px rgba(176, 69, 69, 0.12);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .cart-remove-button:hover,
        .cart-remove-button:focus {
            color: #8f3636;
            transform: translateY(-1px);
            box-shadow: 0 12px 22px rgba(176, 69, 69, 0.18);
        }

        .cart-message {
            color: #2f5fa7;
            min-height: 24px;
            font-weight: 600;
        }

        .empty-cart {
            text-align: center;
            padding: 42px 22px;
        }

        .empty-cart h2 {
            margin-bottom: 12px;
        }

        @media (max-width: 991px) {
            .cart-layout {
                grid-template-columns: 1fr;
            }

            .cart-item {
                grid-template-columns: 1fr;
            }

            .cart-actions {
                align-items: flex-start;
            }
        }
    </style>

    <div class="page-card">
        <div class="d-flex flex-wrap justify-content-between align-items-start">
            <div>
                <h1>Your Cart</h1>
                <p class="lead">Is your shopping cart full or are you just happy to see me?</p>
            </div>
            <div>
                <a runat="server" href="~/Default.aspx" class="btn btn-outline-secondary">Keep Shopping</a>
            </div>
        </div>

        <p class="cart-message">
            <asp:Label ID="lblCartMessage" runat="server" />
        </p>

        <asp:Panel ID="pnlEmptyCart" runat="server" CssClass="cart-panel empty-cart" Visible="false">
            <h2>Your cart is currently vibing with zero items.</h2>
            <p>Add a few products from the home page and come back when you are ready to check out.</p>
            <a runat="server" href="~/Default.aspx" class="btn btn-primary">Browse Products</a>
        </asp:Panel>

        <asp:Panel ID="pnlCart" runat="server" Visible="false">
            <div class="cart-layout">
                <section class="cart-panel">
                    <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                        <ItemTemplate>
                            <div class="cart-item">
                                <img src="<%# GetImageUrl(Eval("Image")) %>" alt="<%# Eval("Name") %>" loading="lazy" decoding="async" />
                                <div>
                                    <div class="cart-item-title"><%# Eval("Name") %></div>
                                    <div class="cart-item-meta"><%# Eval("Category") %> | $<%# Eval("UnitPrice", "{0:F2}") %> each</div>
                                    <p class="cart-item-desc"><%# Eval("Description") %></p>
                                    <div class="cart-item-stock">
                                        <%# (int)Eval("RemainingAvailableQuantity") == 0 ? "You already reserved every available unit." : Eval("RemainingAvailableQuantity") + " more available for this cart." %>
                                    </div>
                                </div>
                                <div class="cart-actions">
                                    <div class="quantity-controls">
                                        <asp:LinkButton ID="btnDecreaseQuantity" runat="server" Text="-" CssClass="btn btn-outline-secondary btn-sm" CommandName="DecreaseQuantity" CommandArgument='<%# Eval("ProductId") %>' CausesValidation="false" />
                                        <strong><%# Eval("Quantity") %></strong>
                                        <asp:LinkButton ID="btnIncreaseQuantity" runat="server" Text="+" CssClass="btn btn-outline-secondary btn-sm" CommandName="IncreaseQuantity" CommandArgument='<%# Eval("ProductId") %>' CausesValidation="false" Enabled='<%# Eval("CanIncreaseQuantity") %>' />
                                    </div>
                                    <div class="cart-total">$<%# Eval("LineTotal", "{0:F2}") %></div>
                                    <asp:LinkButton ID="btnRemoveItem" runat="server" Text="Remove" CssClass="cart-remove-button" CommandName="RemoveItem" CommandArgument='<%# Eval("ProductId") %>' CausesValidation="false" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </section>

                <aside class="cart-summary">
                    <h2>Cart Summary</h2>
                    <table class="table table-borderless" style="margin-bottom: 20px;">
                        <tr>
                            <th>Items</th>
                            <td class="text-end"><asp:Label ID="lblItemCount" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Subtotal</th>
                            <td class="text-end"><asp:Label ID="lblSubtotal" runat="server" /></td>
                        </tr>
                    </table>

                    <asp:Button ID="btnProceedToCheckout" runat="server" Text="Checkout ;)" CssClass="btn btn-primary w-100" OnClick="btnProceedToCheckout_Click" />
                    <asp:Button ID="btnClearCart" runat="server" Text="Clear Cart" CssClass="btn btn-outline-secondary w-100" style="margin-top: 10px;" OnClick="btnClearCart_Click" CausesValidation="false" />
                </aside>
            </div>
        </asp:Panel>
    </div>

</asp:Content>
