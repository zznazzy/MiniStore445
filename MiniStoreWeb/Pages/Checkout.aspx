<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="MiniStoreWeb.Pages.Checkout" MaintainScrollPositionOnPostBack="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .checkout-layout {
            display: grid;
            grid-template-columns: minmax(0, 1.7fr) minmax(250px, 0.72fr);
            gap: 18px;
            align-items: start;
        }

        .checkout-panel,
        .checkout-summary {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 20px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 24px rgba(0,0,0,0.08);
        }

        .checkout-message {
            color: #b44545;
            min-height: 24px;
            font-weight: 600;
        }

        .coupon-note {
            display: block;
            margin-top: 12px;
            color: #2f80ff;
            font-weight: 700;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding: 8px 0;
            border-bottom: 1px solid #eef1f5;
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .summary-total-row th,
        .summary-total-row td,
        .summary-total-row strong {
            color: #1f7a45;
        }

        .payment-list {
            display: grid;
            grid-template-columns: repeat(3, 206px);
            justify-content: space-between;
            gap: 12px;
            margin-top: 10px;
        }

        .payment-option {
            position: relative;
            width: 206px;
        }

        .payment-option input[type=radio] {
            position: absolute;
            opacity: 0;
            pointer-events: none;
            width: 1px;
            height: 1px;
        }

        .payment-card-label {
            display: block;
            width: 100%;
            height: 100%;
            aspect-ratio: 1.586 / 1;
            margin-bottom: 0;
            border-radius: 18px;
            padding: 12px 14px;
            border: 1px solid rgba(255,255,255,0.12);
            cursor: pointer;
            color: #ffffff;
            position: relative;
            overflow: hidden;
            transition: transform 0.14s ease, box-shadow 0.14s ease, border-color 0.14s ease;
            box-shadow: 0 12px 24px rgba(15, 23, 42, 0.12);
        }

        .payment-card-label::after {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(125deg, rgba(255,255,255,0.2), rgba(255,255,255,0.02) 40%, rgba(255,255,255,0.12) 100%);
            pointer-events: none;
        }

        .payment-card-label:hover {
            transform: translateY(-3px);
            box-shadow: 0 16px 28px rgba(15, 23, 42, 0.18);
        }

        .payment-option input[type=radio]:focus + .payment-card-label,
        .payment-option input[type=radio]:checked + .payment-card-label {
            transform: translateY(-3px);
            box-shadow: 0 0 0 3px rgba(255,255,255,0.72), 0 18px 30px rgba(15, 23, 42, 0.22);
        }

        .payment-card-shell {
            position: relative;
            z-index: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

        .payment-card-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 12px;
        }

        .payment-card-brand {
            font-size: 0.68rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-weight: 700;
            text-align: right;
            opacity: 0.95;
            max-width: 84px;
            line-height: 1.2;
        }

        .payment-card-chip {
            width: 34px;
            height: 24px;
            border-radius: 7px;
            background: linear-gradient(145deg, rgba(255,255,255,0.82), rgba(255,255,255,0.28));
            box-shadow: inset 0 0 0 1px rgba(255,255,255,0.24);
            position: relative;
        }

        .payment-card-chip::before,
        .payment-card-chip::after {
            content: "";
            position: absolute;
            top: 4px;
            bottom: 4px;
            width: 1px;
            background: rgba(0,0,0,0.1);
        }

        .payment-card-chip::before {
            left: 11px;
        }

        .payment-card-chip::after {
            right: 11px;
        }

        .payment-card-number {
            font-family: Consolas, "Courier New", monospace;
            font-size: 0.82rem;
            font-weight: 700;
            letter-spacing: 0.9px;
            line-height: 1.35;
            margin: 12px 0 10px;
            display: block;
        }

        .payment-card-meta {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 14px;
        }

        .payment-card-caption {
            display: block;
            font-size: 0.58rem;
            letter-spacing: 0.9px;
            text-transform: uppercase;
            opacity: 0.82;
            margin-bottom: 2px;
        }

        .payment-card-value {
            display: block;
            font-size: 0.78rem;
            font-weight: 700;
            line-height: 1.18;
        }

        .payment-card-holder {
            text-align: right;
            max-width: 84px;
            word-break: break-word;
        }

        .payment-card-infinite {
            background: linear-gradient(135deg, #0c4fcb 0%, #2f80ff 52%, #6ec1ff 100%);
        }

        .payment-card-fairy {
            background: linear-gradient(135deg, #c84b89 0%, #ff86be 56%, #ffd18b 100%);
        }

        .payment-card-face {
            background: linear-gradient(135deg, #1f6f58 0%, #40b383 54%, #9ae6c9 100%);
        }

        @media (max-width: 991px) {
            .checkout-layout {
                grid-template-columns: 1fr;
            }

            .payment-list {
                grid-template-columns: repeat(auto-fit, minmax(206px, 206px));
                justify-content: center;
            }
        }
    </style>

    <div class="page-card">
        <div class="d-flex flex-wrap justify-content-between align-items-start">
            <div>
                <h1>Checkout</h1>
                <p class="lead">Ready to commit?</p>
            </div>
            <a runat="server" href="~/Pages/Cart.aspx" class="btn btn-outline-secondary">Back To Cart</a>
        </div>

        <p class="checkout-message">
            <asp:Label ID="lblCheckoutMessage" runat="server" />
        </p>

        <asp:Panel ID="pnlEmptyCheckout" runat="server" Visible="false" CssClass="checkout-panel">
            <h2>Your cart is empty.</h2>
            <p>There is nothing to check out yet.</p>
            <a runat="server" href="~/Default.aspx" class="btn btn-primary">Browse Products</a>
        </asp:Panel>

        <asp:Panel ID="pnlCheckout" runat="server" Visible="false">
            <div class="checkout-layout">
                <section class="checkout-panel">
                    <h2>Checkout Details</h2>

                    <div class="form-group">
                        <label for="ddlCouponCode"><strong>Coupon Code</strong></label>
                        <asp:DropDownList ID="ddlCouponCode" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="PricingInput_Changed">
                            <asp:ListItem Text="(none)" Value="" />
                            <asp:ListItem Text="SAVE10" Value="SAVE10" />
                            <asp:ListItem Text="STUDENT15" Value="STUDENT15" />
                            <asp:ListItem Text="VIP20" Value="VIP20" />
                        </asp:DropDownList>
                        <asp:Label ID="lblCouponDescription" runat="server" CssClass="coupon-note" />
                    </div>

                    <div class="form-group" style="margin-top: 18px;">
                        <label for="ddlShippingRegion"><strong>Shipping Region</strong></label>
                        <asp:DropDownList ID="ddlShippingRegion" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="PricingInput_Changed">
                            <asp:ListItem Text="Select a region..." Value="" />
                            <asp:ListItem Text="United States" Value="US" />
                            <asp:ListItem Text="Canada" Value="CA" />
                            <asp:ListItem Text="International" Value="INTL" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group" style="margin-top: 18px;">
                        <label><strong>Payment Method</strong></label>
                        <div class="payment-list">
                            <div class="payment-option">
                                <input id="optInfiniteMoney" type="radio" name="checkoutPaymentMethod" value="Infinite Money Glitch" runat="server" />
                                <label for="<%= optInfiniteMoney.ClientID %>" class="payment-card-label payment-card-infinite">
                                    <span class="payment-card-shell">
                                        <span class="payment-card-top">
                                            <span class="payment-card-chip" aria-hidden="true"></span>
                                            <span class="payment-card-brand">Infinite Money Glitch</span>
                                        </span>
                                        <span class="payment-card-number">**** ***** ***** ****</span>
                                        <span class="payment-card-meta">
                                            <span>
                                                <span class="payment-card-caption">Valid Thru</span>
                                                <span class="payment-card-value">l/ol</span>
                                            </span>
                                            <span class="payment-card-holder">
                                                <span class="payment-card-caption">Cardholder</span>
                                                <span class="payment-card-value">Error 404</span>
                                            </span>
                                        </span>
                                    </span>
                                </label>
                            </div>

                            <div class="payment-option">
                                <input id="optFairyDust" type="radio" name="checkoutPaymentMethod" value="Fairy Dust" runat="server" />
                                <label for="<%= optFairyDust.ClientID %>" class="payment-card-label payment-card-fairy">
                                    <span class="payment-card-shell">
                                        <span class="payment-card-top">
                                            <span class="payment-card-chip" aria-hidden="true"></span>
                                            <span class="payment-card-brand">Fairy Dust</span>
                                        </span>
                                        <span class="payment-card-number">**** ***** ***** ****</span>
                                        <span class="payment-card-meta">
                                            <span>
                                                <span class="payment-card-caption">Valid Thru</span>
                                                <span class="payment-card-value">First Frost</span>
                                            </span>
                                            <span class="payment-card-holder">
                                                <span class="payment-card-caption">Cardholder</span>
                                                <span class="payment-card-value">Sprinklefoot</span>
                                            </span>
                                        </span>
                                    </span>
                                </label>
                            </div>

                            <div class="payment-option">
                                <input id="optFaceCard" type="radio" name="checkoutPaymentMethod" value="Face Card" runat="server" />
                                <label for="<%= optFaceCard.ClientID %>" class="payment-card-label payment-card-face">
                                    <span class="payment-card-shell">
                                        <span class="payment-card-top">
                                            <span class="payment-card-chip" aria-hidden="true"></span>
                                            <span class="payment-card-brand">Face Card</span>
                                        </span>
                                        <span class="payment-card-number">**** ***** ***** ****</span>
                                        <span class="payment-card-meta">
                                            <span>
                                                <span class="payment-card-caption">Valid Thru</span>
                                                <span class="payment-card-value">Forever</span>
                                            </span>
                                            <span class="payment-card-holder">
                                                <span class="payment-card-caption">Cardholder</span>
                                                <span class="payment-card-value"><%: string.IsNullOrWhiteSpace(Context.User.Identity.Name) ? "Guest Shopper" : Context.User.Identity.Name %></span>
                                            </span>
                                        </span>
                                    </span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div style="margin-top: 22px;">
                        <asp:Button ID="btnRefreshTotals" runat="server" Text="Refresh Totals" CssClass="btn btn-outline-secondary" OnClick="btnRefreshTotals_Click" CausesValidation="false" />
                        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-primary" OnClick="btnPlaceOrder_Click" style="margin-left: 10px;" />
                    </div>
                </section>

                <aside class="checkout-summary">
                    <h2>Order Summary</h2>

                    <asp:Repeater ID="rptCheckoutItems" runat="server">
                        <ItemTemplate>
                            <div class="summary-item">
                                <span><%# Eval("Name") %> x <%# Eval("Quantity") %></span>
                                <strong>$<%# Eval("LineTotal", "{0:F2}") %></strong>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <hr />

                    <table class="table table-borderless" style="margin-bottom: 0;">
                        <tr>
                            <th>Subtotal</th>
                            <td class="text-end"><asp:Label ID="lblCheckoutSubtotal" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Discount</th>
                            <td class="text-end"><asp:Label ID="lblCheckoutDiscount" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Shipping</th>
                            <td class="text-end"><asp:Label ID="lblCheckoutShipping" runat="server" /></td>
                        </tr>
                        <tr class="summary-total-row" style="font-size: 1.1rem;">
                            <th>Total</th>
                            <td class="text-end"><strong><asp:Label ID="lblCheckoutTotal" runat="server" /></strong></td>
                        </tr>
                    </table>
                </aside>
            </div>
        </asp:Panel>
    </div>

</asp:Content>
