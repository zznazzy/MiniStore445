<%@ Page Title="Order Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="MiniStoreWeb.Pages.OrderDetails" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .order-detail-layout {
            display: grid;
            grid-template-columns: 0.95fr 1.05fr;
            gap: 24px;
        }

        .order-panel {
            background: #ffffff;
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 6px 24px rgba(0,0,0,0.08);
        }

        .timeline {
            margin-top: 18px;
            border-left: 3px solid #d9e5fb;
            padding-left: 18px;
        }

        .timeline-step {
            position: relative;
            margin-bottom: 18px;
            color: #4f5f73;
        }

        .timeline-step:before {
            content: "";
            position: absolute;
            left: -26px;
            top: 4px;
            width: 12px;
            height: 12px;
            border-radius: 999px;
            background: #9db5df;
        }

        .timeline-step-done:before {
            background: #1f7a45;
        }

        .timeline-step-active:before {
            background: #2f80ff;
            box-shadow: 0 0 0 6px rgba(47, 128, 255, 0.14);
        }

        @media (max-width: 991px) {
            .order-detail-layout {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="page-card">
        <div class="d-flex flex-wrap justify-content-between align-items-start">
            <div>
                <h1>Order Details</h1>
                <p class="lead">Tracking snapshot for <asp:Label ID="lblOrderNumber" runat="server" />.</p>
            </div>
            <a runat="server" href="~/Pages/Member.aspx?tab=orders" class="btn btn-outline-secondary">Back To Orders</a>
        </div>

        <div class="order-detail-layout">
            <section class="order-panel">
                <h2>Shipping Story</h2>
                <table class="table table-borderless" style="margin-bottom: 0;">
                    <tr>
                        <th style="width: 190px;">Placed</th>
                        <td class="text-end"><asp:Label ID="lblPlacedAt" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Region</th>
                        <td class="text-end"><asp:Label ID="lblRegion" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Payment Method</th>
                        <td class="text-end"><asp:Label ID="lblPaymentMethod" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Total</th>
                        <td class="text-end"><asp:Label ID="lblOrderTotal" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Carrier</th>
                        <td class="text-end"><asp:Label ID="lblCarrier" runat="server" /></td>
                    </tr>
                    <tr>
                        <th>Estimated Delivery</th>
                        <td class="text-end"><asp:Label ID="lblEstimatedDelivery" runat="server" /></td>
                    </tr>
                </table>

                <div class="timeline">
                    <div class="timeline-step timeline-step-done">
                        <strong>Shipping label printed</strong><br />
                        <span>Orbital routing paperwork is complete.</span>
                    </div>
                    <div class="timeline-step timeline-step-done">
                        <strong>Loaded onto spaceship</strong><br />
                        <span>The package has left the warehouse atmosphere.</span>
                    </div>
                    <div class="timeline-step timeline-step-active">
                        <strong>Package leaving orbit of OGLE-2017-BLG-0364Lb</strong><br />
                        <span>Transit remains technically on schedule, depending on several galaxies.</span>
                    </div>
                </div>
            </section>

            <section class="order-panel">
                <h2>Items In This Order</h2>
                <asp:Repeater ID="rptOrderItems" runat="server">
                    <ItemTemplate>
                        <div style="display:flex; justify-content:space-between; gap:12px; padding:10px 0; border-bottom:1px solid #eef1f5;">
                            <div>
                                <strong><%# Eval("Name") %></strong><br />
                                <span style="color:#5b6472;"><%# Eval("Category") %> | Qty <%# Eval("Quantity") %></span>
                            </div>
                            <strong>$<%# Eval("LineTotal", "{0:F2}") %></strong>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </section>
        </div>
    </div>

</asp:Content>
