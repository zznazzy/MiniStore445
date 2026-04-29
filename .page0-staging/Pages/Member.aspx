<%@ Page Title="My Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Member.aspx.cs" Inherits="MiniStoreWeb.Pages.Member" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .account-tabs {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 18px 0 24px;
        }

        .account-tab {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 18px;
            border-radius: 999px;
            background: linear-gradient(180deg, #f8fbff 0%, #edf3fb 100%);
            color: #4f5f73;
            text-decoration: none;
            font-weight: 600;
            border: 1px solid #d7e2f2;
            box-shadow: 0 8px 18px rgba(36, 72, 126, 0.10);
            transition: transform 0.15s ease, box-shadow 0.15s ease, color 0.15s ease;
        }

        .account-tab:hover,
        .account-tab:focus {
            text-decoration: none;
            color: #1f3552;
            transform: translateY(-1px);
            box-shadow: 0 12px 24px rgba(36, 72, 126, 0.15);
        }

        .account-tab-active {
            background: linear-gradient(180deg, #61a7ff 0%, #2f80ff 100%);
            color: #ffffff;
            border-color: #78adf7;
        }

        .account-tab-active:hover,
        .account-tab-active:focus {
            color: #ffffff;
        }

        .member-grid {
            display: grid;
            grid-template-columns: 0.95fr 1.05fr;
            gap: 24px;
            align-items: start;
        }

        .member-panel {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 24px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 24px rgba(0,0,0,0.08);
        }

        .status-message {
            color: #2f5fa7;
            min-height: 24px;
        }

        .favorites-table .btn {
            min-height: 34px;
            padding: 0 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .order-link-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 34px;
            padding: 0 12px;
            border-radius: 999px;
            text-decoration: none;
            color: #35517d;
            background: linear-gradient(180deg, #ffffff 0%, #eef4ff 100%);
            border: 1px solid #d3dff0;
            box-shadow: 0 8px 18px rgba(36, 72, 126, 0.10);
            transition: transform 0.15s ease, box-shadow 0.15s ease, color 0.15s ease;
        }

        .order-link-button:hover,
        .order-link-button:focus {
            color: #2f80ff;
            text-decoration: none;
            transform: translateY(-1px);
            box-shadow: 0 12px 24px rgba(36, 72, 126, 0.16);
        }

        .account-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 18px;
            justify-content: center;
        }

        .account-actions .btn {
            min-width: 170px;
        }

        .quick-actions-panel {
            text-align: center;
        }

        .quick-actions-panel p {
            max-width: 360px;
            margin-left: auto;
            margin-right: auto;
        }

        .quick-actions-panel .account-actions {
            max-width: 390px;
            margin-left: auto;
            margin-right: auto;
        }

        @media (max-width: 991px) {
            .member-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="page-card">
        <div class="d-flex flex-wrap justify-content-between align-items-start">
            <div>
                <h1>My Account</h1>
                <p class="lead"><asp:Label ID="lblWelcomeMessage" runat="server" /></p>
            </div>
            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-danger" OnClick="btnLogout_Click" CausesValidation="false" />
        </div>

        <div class="account-tabs">
            <asp:HyperLink ID="lnkTabOverview" runat="server" CssClass="account-tab" Text="Overview" />
            <asp:HyperLink ID="lnkTabFavorites" runat="server" CssClass="account-tab" Text="Favorites" />
            <asp:HyperLink ID="lnkTabOrders" runat="server" CssClass="account-tab" Text="Previous Orders" />
        </div>

        <asp:Panel ID="pnlOverview" runat="server">
            <div class="member-grid">
                <section class="member-panel">
                    <h2>Account Snapshot</h2>
                    <table class="table table-bordered">
                        <tr>
                            <th style="width: 180px;">Member Since</th>
                            <td><asp:Label ID="lblMemberSince" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Cart Count</th>
                            <td><asp:Label ID="lblCartCount" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Previous Orders</th>
                            <td><asp:Label ID="lblOrderCount" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Session Started</th>
                            <td><asp:Label ID="lblSessionStart" runat="server" /></td>
                        </tr>
                    </table>

                    <p style="margin-bottom: 0;">
                        This page is protected by forms authentication and only available to authenticated members.
                    </p>
                </section>

                <section class="member-panel quick-actions-panel">
                    <h2>Quick Actions</h2>
                    <p>Jump back into the storefront, review your cart, or open your latest order trail.</p>
                    <div class="account-actions">
                        <a runat="server" href="~/Default.aspx" class="btn btn-primary">Browse Products</a>
                        <a runat="server" href="~/Pages/Cart.aspx" class="btn btn-outline-secondary">View Cart</a>
                        <a runat="server" href="~/Pages/Checkout.aspx" class="btn btn-outline-secondary">Checkout ;)</a>
                    </div>
                </section>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlFavorites" runat="server" Visible="false">
            <section class="member-panel">
                <h2>Favorite Products</h2>
                <p>Select an item from <code>Products.xml</code> and keep a simple member-only session list.</p>

                <div class="form-group">
                    <label for="ddlFavoriteProduct"><strong>Choose a Product</strong></label>
                    <asp:DropDownList ID="ddlFavoriteProduct" runat="server" CssClass="form-control" />
                </div>

                <div style="margin-top: 18px;">
                    <asp:Button ID="btnAddFavorite" runat="server" Text="Add Favorite" CssClass="btn btn-primary" OnClick="btnAddFavorite_Click" />
                    <asp:Button ID="btnClearFavorites" runat="server" Text="Clear Favorites" CssClass="btn btn-outline-secondary" OnClick="btnClearFavorites_Click" CausesValidation="false" style="margin-left: 10px;" />
                </div>

                <p class="status-message" style="margin-top: 16px;">
                    <asp:Label ID="lblFavoriteMessage" runat="server" />
                </p>

                <asp:GridView ID="gvFavorites" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered favorites-table" EmptyDataText="No favorites saved yet." OnRowCommand="gvFavorites_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Product" />
                        <asp:BoundField DataField="Category" HeaderText="Category" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnRemoveFavorite" runat="server" Text="Remove" CssClass="btn btn-outline-danger btn-sm" CommandName="RemoveFavorite" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </section>
        </asp:Panel>

        <asp:Panel ID="pnlOrders" runat="server" Visible="false">
                <section class="member-panel">
                    <h2>Previous Orders</h2>
                    <p>Open any order for the receipt, delivery estimate, and the latest tracking snapshot. No refunds.</p>

                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered" EmptyDataText="No orders yet. Place one from checkout and it will show up here.">
                    <Columns>
                        <asp:TemplateField HeaderText="Order">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkOrderDetails" runat="server" NavigateUrl='<%# GetOrderDetailsUrl(Eval("OrderNumber")) %>' Text='<%# Eval("OrderNumber") %>' CssClass="order-link-button" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CreatedAt" HeaderText="Placed" DataFormatString="{0:f}" />
                        <asp:BoundField DataField="Region" HeaderText="Region" />
                        <asp:BoundField DataField="PaymentMethod" HeaderText="Payment" />
                        <asp:BoundField DataField="FinalTotal" HeaderText="Total" DataFormatString="{0:C}" />
                    </Columns>
                </asp:GridView>
            </section>
        </asp:Panel>
    </div>

</asp:Content>
