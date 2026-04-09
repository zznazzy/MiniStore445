<%@ Page Title="Adrian Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdrianDemo.aspx.cs" Inherits="MiniStoreWeb.Pages.AdrianDemo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-card">
        <h1>Adrian Demo Page</h1>
        <p class="lead">
            This page exercises Adrian's three components together: the AdrianHashLib DLL,
            the AdrianStoreService web service, and the session-backed cart state helper.
        </p>
        <p>
            Enter a subtotal and region, then click the button to increment the cart counter,
            quote shipping from the service, and generate an order-reference hash.
        </p>

        <div class="row" style="margin-top: 20px;">
            <div class="col-md-6">
                <div style="background:#f8f9fa; border-radius:14px; padding:20px;">
                    <div class="form-group">
                        <label for="txtSubtotal"><strong>Subtotal</strong></label>
                        <asp:TextBox ID="txtSubtotal" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group" style="margin-top: 16px;">
                        <label for="ddlRegion"><strong>Region</strong></label>
                        <asp:DropDownList ID="ddlRegion" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Domestic" Value="Domestic" />
                            <asp:ListItem Text="International" Value="International" />
                        </asp:DropDownList>
                    </div>

                    <div style="margin-top: 20px;">
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to cart &amp; quote" CssClass="btn btn-primary" OnClick="btnAddToCart_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-default" OnClick="btnClear_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div style="background:#f8f9fa; border-radius:14px; padding:20px;">
                    <h3>Sample Test Cases</h3>
                    <ul>
                        <li><strong>75</strong> + <strong>Domestic</strong> → free shipping</li>
                        <li><strong>20</strong> + <strong>Domestic</strong> → $5.00</li>
                        <li><strong>20</strong> + <strong>International</strong> → tiered rate</li>
                    </ul>
                    <p>The cart count persists for the current session.</p>
                </div>
            </div>
        </div>

        <hr />

        <h3>Results</h3>
        <table class="table table-bordered">
            <tr>
                <th style="width: 220px;">Cart Count (session)</th>
                <td><asp:Label ID="lblCartCount" runat="server" /></td>
            </tr>
            <tr>
                <th>Shipping Quote</th>
                <td><asp:Label ID="lblShipping" runat="server" /></td>
            </tr>
            <tr>
                <th>Order Reference Hash (SHA-256)</th>
                <td><asp:Label ID="lblHash" runat="server" /></td>
            </tr>
        </table>

        <p>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
        </p>

        <p style="margin-top: 24px;">
            <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Default.aspx" Text="Back to Home Page" CssClass="btn btn-primary" />
        </p>
    </div>

</asp:Content>
