<%@ Page Title="Components Summary" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="MiniStoreWeb.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .summary-box {
            background: #fff;
            border-radius: 18px;
            padding: 30px;
            margin-top: 20px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
        }
    </style>

    <div class="summary-box">
        <h1>Application and Components Summary Table</h1>
        <p>
            This page lists the current Assignment 5 components implemented in MiniStore445 and provides
            access points for testing each visible component.
        </p>

        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Provider</th>
                    <th>Component Type</th>
                    <th>Operation / Item</th>
                    <th>Parameters / Inputs</th>
                    <th>Return Type / Output</th>
                    <th>Description</th>
                    <th>TryIt / Link</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Bella Rayner</td>
                    <td>ASPX page + server controls</td>
                    <td>Default.aspx</td>
                    <td>None</td>
                    <td>Page</td>
                    <td>Public landing page with store information and navigation.</td>
                    <td><a href="<%= ResolveUrl("~/Default.aspx") %>">Home Page</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>User control</td>
                    <td>FeaturedProducts.ascx</td>
                    <td>Reads Products.xml</td>
                    <td>Rendered product cards</td>
                    <td>Displays featured products loaded from XML.</td>
                    <td><a href="<%= ResolveUrl("~/Default.aspx") %>">Visible on Home Page</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>Global.asax event handler</td>
                    <td>Application_Start / Session_Start</td>
                    <td>None</td>
                    <td>Application values / Session values</td>
                    <td>Stores app start time and increments visitor count.</td>
                    <td><a href="<%= ResolveUrl("~/Pages/GlobalDemo.aspx") %>">Global Demo</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>WCF service</td>
                    <td>GetDiscountedTotal / GetCouponDescription</td>
                    <td>subtotal: decimal, couponCode: string</td>
                    <td>decimal / string</td>
                    <td>Calculates discounted totals for sample coupon codes.</td>
                    <td><a href="<%= ResolveUrl("~/Pages/BellaTryIt.aspx") %>">Bella TryIt</a></td>
                </tr>
                <tr>
                    <td>Adrian Simon</td>
                    <td>Class library (DLL)</td>
                    <td>HashUtil.Sha256</td>
                    <td>plaintext: string</td>
                    <td>string (64-char hex)</td>
                    <td>SHA-256 hashing utility for security use.</td>
                    <td><a href="<%= ResolveUrl("~/Pages/AdrianDemo.aspx") %>">Adrian Demo</a></td>
                </tr>
                <tr>
                    <td>Adrian Simon</td>
                    <td>WCF service</td>
                    <td>CalculateShipping</td>
                    <td>subtotal: decimal, region: string</td>
                    <td>decimal</td>
                    <td>Tiered shipping calculator: free over $50, $5 domestic, $15 international.</td>
                    <td><a href="<%= ResolveUrl("~/Pages/AdrianDemo.aspx") %>">Adrian Demo</a></td>
                </tr>
                <tr>
                    <td>Adrian Simon</td>
                    <td>Session helper</td>
                    <td>CartState.GetCartCount / IncrementCart</td>
                    <td>None</td>
                    <td>int / void</td>
                    <td>Session-backed cart counter for state management.</td>
                    <td><a href="<%= ResolveUrl("~/Pages/AdrianDemo.aspx") %>">Adrian Demo</a></td>
                </tr>
            </tbody>
        </table>

        <p>
            <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Default.aspx" Text="Back to Home Page" />
        </p>
    </div>

</asp:Content>