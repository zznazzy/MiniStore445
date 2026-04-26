<%@ Page Title="Order Confirmation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="MiniStoreWeb.Pages.OrderConfirmation" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .confirmation-shell {
            position: relative;
            overflow: hidden;
            background: linear-gradient(180deg, #ffffff 0%, #f7fbff 100%);
        }

        .confirmation-title {
            font-size: 2.4rem;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .confirmation-message {
            font-size: 1.05rem;
            color: #58606d;
            max-width: 760px;
        }

        .receipt-grid {
            display: grid;
            grid-template-columns: 0.95fr 1.05fr;
            gap: 24px;
            margin-top: 24px;
        }

        .receipt-panel {
            background: rgba(255,255,255,0.9);
            border-radius: 18px;
            padding: 22px;
            border: 1px solid #eef2f6;
        }

        .receipt-panel-stack {
            display: flex;
            flex-direction: column;
        }

        .receipt-panel-actions {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
            margin-top: auto;
            padding-top: 22px;
        }

        .confetti {
            position: absolute;
            inset: 0;
            pointer-events: none;
            overflow: hidden;
            z-index: 1;
        }

        .confirmation-content {
            position: relative;
            z-index: 2;
        }

        .confetti span {
            position: absolute;
            top: -12%;
            width: 10px;
            height: 20px;
            opacity: 0.85;
            animation: confetti-fall 7s linear infinite;
        }

        @keyframes confetti-fall {
            0% {
                transform: translateY(0) rotate(0deg);
            }
            100% {
                transform: translateY(125vh) rotate(540deg);
            }
        }

        @media (max-width: 991px) {
            .receipt-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="page-card confirmation-shell">
        <div class="confetti" aria-hidden="true">
            <span style="left:4%; background:#ff6b6b; animation-delay:0s;"></span>
            <span style="left:11%; background:#ffd166; animation-delay:0.6s;"></span>
            <span style="left:18%; background:#4ecdc4; animation-delay:1.2s;"></span>
            <span style="left:25%; background:#5dade2; animation-delay:0.4s;"></span>
            <span style="left:33%; background:#f7b267; animation-delay:1.4s;"></span>
            <span style="left:40%; background:#c77dff; animation-delay:0.8s;"></span>
            <span style="left:48%; background:#06d6a0; animation-delay:1.6s;"></span>
            <span style="left:56%; background:#ef476f; animation-delay:0.2s;"></span>
            <span style="left:63%; background:#ffd166; animation-delay:1.8s;"></span>
            <span style="left:71%; background:#118ab2; animation-delay:1s;"></span>
            <span style="left:79%; background:#ff8fab; animation-delay:0.5s;"></span>
            <span style="left:87%; background:#80ed99; animation-delay:1.5s;"></span>
            <span style="left:94%; background:#9b5de5; animation-delay:0.9s;"></span>
        </div>

        <div class="confirmation-content">
            <h1 class="confirmation-title">Order Confirmed</h1>
            <p class="confirmation-message">
                None of this is real so you're not actually getting any items, sorry :( but the checkout flow worked exactly like it was supposed to.
            </p>

            <div class="receipt-grid">
                <section class="receipt-panel">
                    <h2>Receipt Snapshot</h2>
                    <table class="table table-borderless" style="margin-bottom: 0;">
                        <tr>
                            <th>Order Number</th>
                            <td class="text-end"><asp:Label ID="lblOrderNumber" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Placed</th>
                            <td class="text-end"><asp:Label ID="lblPlacedAt" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Payment</th>
                            <td class="text-end"><asp:Label ID="lblPaymentMethod" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Region</th>
                            <td class="text-end"><asp:Label ID="lblRegion" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Coupon</th>
                            <td class="text-end"><asp:Label ID="lblCouponUsed" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Subtotal</th>
                            <td class="text-end"><asp:Label ID="lblReceiptSubtotal" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Discount</th>
                            <td class="text-end"><asp:Label ID="lblReceiptDiscount" runat="server" /></td>
                        </tr>
                        <tr>
                            <th>Shipping</th>
                            <td class="text-end"><asp:Label ID="lblReceiptShipping" runat="server" /></td>
                        </tr>
                        <tr style="font-size:1.08rem;">
                            <th>Total</th>
                            <td class="text-end"><strong><asp:Label ID="lblReceiptTotal" runat="server" /></strong></td>
                        </tr>
                    </table>
                </section>

                <section class="receipt-panel receipt-panel-stack">
                    <h2>What You Definitely Are Not Receiving</h2>
                    <asp:Repeater ID="rptReceiptItems" runat="server">
                        <ItemTemplate>
                            <div style="display:flex; justify-content:space-between; gap:12px; padding:8px 0; border-bottom:1px solid #eef1f5;">
                                <span><%# Eval("Name") %> x <%# Eval("Quantity") %></span>
                                <strong>$<%# Eval("LineTotal", "{0:F2}") %></strong>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <div class="receipt-panel-actions">
                        <a runat="server" href="~/Default.aspx" class="btn btn-primary">Back To Store</a>
                        <a runat="server" href="~/Pages/Cart.aspx" class="btn btn-outline-secondary">Start Another Cart</a>
                    </div>
                </section>
            </div>
        </div>
    </div>

</asp:Content>
