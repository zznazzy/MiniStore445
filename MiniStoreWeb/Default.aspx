<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MiniStoreWeb._Default" %>
<%@ Register Src="~/Controls/FeaturedProducts.ascx" TagPrefix="uc" TagName="FeaturedProducts" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <section class="row" aria-labelledby="storeTitle">
            <div class="col-md-12">
                <h1 id="storeTitle">MiniStore445</h1>
                <p class="lead">
                    MiniStore445 is a mini online store web application for CSE 445/598.
                </p>
                <p>
                    This site demonstrates a public landing page, a user control, a Global.asax event handler,
                    and a web service with a TryIt page. Later, the project will expand into Member and Staff pages
                    with authentication and XML-backed data storage.
                </p>
            </div>
        </section>

        <section class="row">
            <div class="col-md-4">
                <h2>Navigation</h2>
                <p>
                    <asp:HyperLink ID="lnkMember" runat="server" NavigateUrl="~/Pages/Member.aspx" Text="Member Page" />
                </p>
                <p>
                    <asp:HyperLink ID="lnkStaff" runat="server" NavigateUrl="~/Pages/Staff.aspx" Text="Staff Page" />
                </p>
                <p>
                    <asp:HyperLink ID="lnkBellaTryIt" runat="server" NavigateUrl="~/Pages/BellaTryIt.aspx" Text="Bella TryIt Page" />
                </p>
                <p>
                    <asp:HyperLink ID="lnkGlobalDemo" runat="server" NavigateUrl="~/Pages/GlobalDemo.aspx" Text="Global Demo Page" />
                </p>
            </div>

            <div class="col-md-4">
                <h2>How to Test</h2>
                <ol>
                    <li>Scroll down to verify that the featured products user control loads products from XML.</li>
                    <li>Open the <strong>Global Demo Page</strong> to verify the app start time and visitor count.</li>
                    <li>Open the <strong>Bella TryIt Page</strong> and test coupon codes such as <code>SAVE10</code>, <code>STUDENT15</code>, and <code>VIP20</code>.</li>
                    <li>Use the Member and Staff links to verify that placeholder pages are present.</li>
                </ol>
            </div>

            <div class="col-md-4">
                <h2>Test Cases</h2>
                <ul>
                    <li>Subtotal: <code>100</code>, Coupon: <code>SAVE10</code> → Total should be <code>90.00</code></li>
                    <li>Subtotal: <code>100</code>, Coupon: <code>STUDENT15</code> → Total should be <code>85.00</code></li>
                    <li>Subtotal: <code>100</code>, Coupon: <code>VIP20</code> → Total should be <code>80.00</code></li>
                    <li>Subtotal: <code>100</code>, Coupon: blank or invalid → Total should remain <code>100.00</code></li>
                </ul>
            </div>
        </section>

        <section class="row">
            <div class="col-md-12">
                <h2>Application and Components Summary Table</h2>
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
                            <td>Public landing page with navigation, testing instructions, and the summary table.</td>
                            <td><a href="<%= ResolveUrl("~/Default.aspx") %>">Current page</a></td>
                        </tr>
                        <tr>
                            <td>Bella Rayner</td>
                            <td>User control</td>
                            <td>FeaturedProducts.ascx</td>
                            <td>Reads <code>Products.xml</code></td>
                            <td>Rendered product cards</td>
                            <td>Displays featured products loaded from XML.</td>
                            <td><a href="#featuredProductsSection">See below</a></td>
                        </tr>
                        <tr>
                            <td>Bella Rayner</td>
                            <td>Global.asax event handler</td>
                            <td>Application_Start / Session_Start</td>
                            <td>None</td>
                            <td>Application values / Session values</td>
                            <td>Stores app start time and increments a visitor count.</td>
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
                    </tbody>
                </table>
                <p>
                    Adrian's components will be added to the integrated team version as they are completed.
                </p>
            </div>
        </section>

        <section class="row">
            <div class="col-md-12">
                <uc:FeaturedProducts ID="FeaturedProducts1" runat="server" />
            </div>
        </section>
    </main>

</asp:Content>