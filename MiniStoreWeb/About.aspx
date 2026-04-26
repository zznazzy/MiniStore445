<%@ Page Title="Components Summary" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="MiniStoreWeb.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Local styling for the integrated summary table and grading notes. --%>
    <style>
        .summary-box {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 30px;
            margin-top: 20px;
            border: 1px solid #dde7f4;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
        }

        .summary-links-table a,
        .summary-footer-link {
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

        .summary-links-table a:hover,
        .summary-links-table a:focus,
        .summary-footer-link:hover,
        .summary-footer-link:focus {
            color: #2f80ff;
            text-decoration: none;
            transform: translateY(-1px);
            box-shadow: 0 12px 24px rgba(36, 72, 126, 0.16);
        }

        .summary-top-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
            margin: 18px 0 26px;
        }

        .summary-note-card {
            background: linear-gradient(180deg, #ffffff 0%, #f4f8ff 100%);
            border-radius: 16px;
            padding: 20px;
            border: 1px solid #dde7f4;
            box-shadow: 0 4px 16px rgba(36, 72, 126, 0.08);
        }

        .summary-note-card h2 {
            margin-top: 0;
            font-size: 1.15rem;
        }

        .summary-note-card ul {
            margin-bottom: 0;
        }

        .summary-note-card li {
            margin-bottom: 10px;
        }

        .summary-links-table td {
            vertical-align: top;
        }

        .summary-detail {
            color: #556275;
            line-height: 1.55;
        }

        .summary-strong {
            color: #2b405f;
            font-weight: 700;
        }

        @media (max-width: 991px) {
            .summary-top-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="summary-box">
        <%-- This table documents the integrated storefront pieces and where each can be tested. --%>
        <h1>Application and Components Summary Table</h1>
        <p>
            This page lists the integrated MiniStore445 pages, services, XML data sources, and local components
            used in the final Assignment 6 submission.
        </p>

        <div class="summary-top-grid">
            <section class="summary-note-card">
                <h2>Contribution Split</h2>
                <ul>
                    <li><span class="summary-strong">Bella Rayner:</span> 55%</li>
                    <li><span class="summary-strong">Adrian:</span> 45%</li>
                </ul>
            </section>

            <section class="summary-note-card">
                <h2>Deployment And Test Links</h2>
                <ul>
                    <li><span class="summary-strong">Current app URL:</span> <a href="<%: BuildAbsoluteUrl("~/Default.aspx") %>"><%: BuildAbsoluteUrl("~/Default.aspx") %></a></li>
                    <li><span class="summary-strong">Bella service endpoint:</span> <a href="<%: BuildAbsoluteUrl("~/Service1.svc") %>"><%: BuildAbsoluteUrl("~/Service1.svc") %></a></li>
                    <li><span class="summary-strong">Adrian service endpoint:</span> <a href="<%: BuildAbsoluteUrl("~/ShippingService.svc") %>"><%: BuildAbsoluteUrl("~/ShippingService.svc") %></a></li>
                    <li><span class="summary-strong">Legacy Bella TryIt deployment URL:</span> <a href="https://webstrarportal.fulton.asu.edu/sites/website37/Page0/Pages/BellaTryIt">https://webstrarportal.fulton.asu.edu/sites/website37/Page0/Pages/BellaTryIt</a></li>
                </ul>
            </section>
        </div>

        <div class="summary-note-card" style="margin-bottom: 24px;">
            <h2>Grader Notes</h2>
            <ul>
                <li>Use <a href="<%= ResolveUrl("~/Default.aspx") %>">Default.aspx</a> for the public landing page, visible test instructions, and the protected Member and Staff access buttons.</li>
                <li>Use the staff credential <code>TA</code> / <code>Cse445!</code> from the Login page to test the protected staff tools.</li>
                <li>Use the Adrian demo page to verify the shipping service, session helper, and explicit SHA-256 DLL tester.</li>
            </ul>
        </div>

        <table class="table table-bordered table-striped summary-links-table">
            <thead>
                <tr>
                    <th>Provider</th>
                    <th>Page / Component Type</th>
                    <th>Description, Inputs, and Output</th>
                    <th>Actual Resources And Where Used</th>
                    <th>TryIt / Link</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Bella Rayner</td>
                    <td>ASPX page + server controls</td>
                    <td class="summary-detail">
                        <span class="summary-strong">Default.aspx</span> is the public landing page for MiniStore445.
                        It introduces the application, shows grader test instructions, provides buttons to the protected Member and Staff pages,
                        and supports product browsing, search, stacked category filtering, stock filtering, and price sorting.
                        <br /><span class="summary-strong">Inputs:</span> user navigation, search text, category selections, stock filter, sort option.
                        <br /><span class="summary-strong">Output:</span> rendered storefront UI and filtered product display.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Default.aspx</code> and <code>Default.aspx.cs</code> using ASP.NET Web Forms controls,
                        server-side event handling, and the FeaturedProducts user control. Used as the main public entry page of the application.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Default.aspx") %>">Home Page</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>User control</td>
                    <td class="summary-detail">
                        <span class="summary-strong">FeaturedProducts.ascx</span> loads product information from <code>Products.xml</code>
                        and displays featured products as cards with name, category, price, description, stock status, image, and add-to-cart action.
                        <br /><span class="summary-strong">Inputs:</span> <code>SearchTerm</code>, selected categories, stock filter, sort option, and XML product data.
                        <br /><span class="summary-strong">Output:</span> rendered product card list.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Controls/FeaturedProducts.ascx</code> and <code>Controls/FeaturedProducts.ascx.cs</code>
                        using XML-backed repository access and ASP.NET Repeater binding. Used on <code>Default.aspx</code>.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Default.aspx") %>">Visible on Home Page</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>Global.asax event handler</td>
                    <td class="summary-detail">
                        <span class="summary-strong">Global.asax</span> stores the application start time, tracks session-based visitor count,
                        and rebuilds the authenticated principal from the forms-auth cookie.
                        <br /><span class="summary-strong">Inputs:</span> <code>Application_Start</code>, <code>Session_Start</code>, and <code>Application_AuthenticateRequest</code>.
                        <br /><span class="summary-strong">Output:</span> application state values, session state values, and authenticated roles for protected pages.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Global.asax</code> and <code>Global.asax.cs</code> using Application, Session, and Forms Authentication objects.
                        Results are displayed through <code>Pages/GlobalDemo.aspx</code> and consumed throughout the site.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/GlobalDemo.aspx") %>">Global Demo</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>ASPX page + server controls</td>
                    <td class="summary-detail">
                        <span class="summary-strong">GlobalDemo.aspx</span> is the visible demo page for the Global.asax component.
                        It displays application start time, visitor count, session start time, session ID, and current page URL.
                        <br /><span class="summary-strong">Inputs:</span> Application and Session state values.
                        <br /><span class="summary-strong">Output:</span> rendered diagnostic/demo page.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Pages/GlobalDemo.aspx</code> and <code>Pages/GlobalDemo.aspx.cs</code>
                        using ASP.NET Label controls and server-side page load logic. Used as Bella's local component demo page.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/GlobalDemo.aspx") %>">Global Demo</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>WCF / WSDL service (.svc)</td>
                    <td class="summary-detail">
                        <span class="summary-strong">BellaStoreService</span> provides coupon-based discount calculation for MiniStore445.
                        <br /><span class="summary-strong">Inputs:</span> <code>GetDiscountedTotal(decimal subtotal, string couponCode)</code>,
                        <code>GetCouponDescription(string couponCode)</code>.
                        <br /><span class="summary-strong">Output:</span> discounted total and coupon description text.
                    </td>
                    <td class="summary-detail">
                        Implemented in the <code>BellaStoreService</code> project using <code>IService1.cs</code> and <code>Service1.svc.cs</code> as a WCF service.
                        Called from <code>Pages/BellaTryIt.aspx</code> and mirrored in the integrated checkout workflow.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/BellaTryIt.aspx") %>">Bella TryIt</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>ASPX TryIt page</td>
                    <td class="summary-detail">
                        <span class="summary-strong">BellaTryIt.aspx</span> is the visible testing page for BellaStoreService.
                        It lets the user enter a subtotal, select a coupon code, call the service, and display results.
                        <br /><span class="summary-strong">Inputs:</span> subtotal and coupon code.
                        <br /><span class="summary-strong">Output:</span> coupon description and discounted total.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Pages/BellaTryIt.aspx</code> and <code>Pages/BellaTryIt.aspx.cs</code>
                        using ASP.NET Web Forms controls and a service client created through <code>ServiceClientFactory</code>.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/BellaTryIt.aspx") %>">Bella TryIt</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>ASPX page + server controls</td>
                    <td class="summary-detail">
                        <span class="summary-strong">About.aspx</span> serves as the integrated Application and Components Summary page for the final submission.
                        It documents the component directory, provider ownership, deployment links, and tester notes.
                        <br /><span class="summary-strong">Inputs:</span> user navigation input.
                        <br /><span class="summary-strong">Output:</span> rendered summary/documentation page.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>About.aspx</code> and linked from the public storefront.
                        Used as the visible summary table page for grading.
                    </td>
                    <td><a href="<%= ResolveUrl("~/About.aspx") %>">Summary Page</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>XML data source</td>
                    <td class="summary-detail">
                        <span class="summary-strong">Products.xml</span> stores the product catalog used by MiniStore445.
                        It includes product ID, name, category, price, description, remote image link, stock flag, featured flag, and stock quantity.
                        <br /><span class="summary-strong">Inputs:</span> product records in XML format.
                        <br /><span class="summary-strong">Output:</span> structured XML product data.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>App_Data/Products.xml</code> and loaded by <code>Helpers/ProductRepository.cs</code>.
                        Used by the storefront, cart, checkout, member favorites, and staff admin tools.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Default.aspx") %>">Storefront Data</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>ASPX auth page + forms security integration</td>
                    <td class="summary-detail">
                        <span class="summary-strong">Login.aspx</span> handles member and staff sign-in for protected pages.
                        It supports the staff test credential and performs role-aware redirection after authentication.
                        <br /><span class="summary-strong">Inputs:</span> username, password, account type, remember-me choice.
                        <br /><span class="summary-strong">Output:</span> authenticated member or staff session.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Login.aspx</code> and <code>Login.aspx.cs</code> using Forms Authentication,
                        XML-backed account lookup, and role-based redirect logic. Used by the Member and Staff access flows.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Login.aspx") %>">Login</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>ASPX auth page + captcha/image handler</td>
                    <td class="summary-detail">
                        <span class="summary-strong">SignUp.aspx</span> is the member self-enrollment flow.
                        It creates new member accounts, validates a captcha challenge, hashes the password through the local DLL wrapper,
                        and signs the new member in automatically.
                        <br /><span class="summary-strong">Inputs:</span> display name, username, password, password confirmation, captcha text.
                        <br /><span class="summary-strong">Output:</span> new authenticated member account stored in XML.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Pages/SignUp.aspx</code>, <code>Pages/SignUp.aspx.cs</code>, <code>CaptchaImage.ashx</code>,
                        and <code>Helpers/CaptchaManager.cs</code>. Used as the visible member registration entry point.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/SignUp.aspx") %>">Sign Up</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>XML account storage + local auth helpers</td>
                    <td class="summary-detail">
                        <span class="summary-strong">Member.xml</span> and <span class="summary-strong">Staff.xml</span> store account credentials,
                        while the local auth helpers manage signup, login, role checks, and password hashing through the Adrian DLL wrapper.
                        <br /><span class="summary-strong">Inputs:</span> usernames, display names, passwords, and role selection.
                        <br /><span class="summary-strong">Output:</span> persistent XML account records and authenticated principals for protected pages.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>App_Data/Member.xml</code>, <code>App_Data/Staff.xml</code>, <code>Helpers/AuthenticationHelper.cs</code>,
                        <code>Helpers/AccountService.cs</code>, <code>Helpers/AccountRepository.cs</code>, and <code>Helpers/PasswordSecurity.cs</code>.
                        Used by Login, Sign Up, Member, Staff, and order history features.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Login.aspx") %>">Visible Through Login / Sign Up</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>Protected member page + XML/session state</td>
                    <td class="summary-detail">
                        <span class="summary-strong">Member.aspx</span> is the protected member dashboard.
                        It shows a welcome message, session cart count, favorites management, previous orders, and links to per-order details.
                        <br /><span class="summary-strong">Inputs:</span> authenticated member session, favorites actions, and order selection.
                        <br /><span class="summary-strong">Output:</span> member-only dashboard, favorites list, and order history UI.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Pages/Member.aspx</code>, <code>Pages/Member.aspx.cs</code>,
                        <code>Pages/OrderDetails.aspx</code>, <code>Pages/OrderDetails.aspx.cs</code>, <code>App_Data/Orders.xml</code>,
                        and helper classes for favorites and fake order history. Used as the protected Member page for Assignment 6.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/Member.aspx") %>">Member Page</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>Protected staff page + XML management</td>
                    <td class="summary-detail">
                        <span class="summary-strong">Staff.aspx</span> is the protected staff product manager.
                        It lets staff add, edit, feature, hide, and delete products stored in XML, including stock quantity and image link management.
                        <br /><span class="summary-strong">Inputs:</span> authenticated staff session and product form/grid actions.
                        <br /><span class="summary-strong">Output:</span> updated XML product catalog and admin UI feedback.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Pages/Staff.aspx</code>, <code>Pages/Staff.aspx.cs</code>, and <code>Helpers/ProductRepository.cs</code>.
                        Used as the protected Staff page for Assignment 6.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/Staff.aspx") %>">Staff Page</a></td>
                </tr>
                <tr>
                    <td>Bella Rayner</td>
                    <td>ASPX workflow + session/XML data management</td>
                    <td class="summary-detail">
                        <span class="summary-strong">Cart.aspx</span>, <span class="summary-strong">Checkout.aspx</span>,
                        and <span class="summary-strong">OrderConfirmation.aspx</span> implement the integrated storefront cart and fake checkout flow.
                        They support quantity changes, coupon totals, shipping totals, payment selection, receipt generation, and order persistence.
                        <br /><span class="summary-strong">Inputs:</span> cart actions, coupon code, shipping region, payment method.
                        <br /><span class="summary-strong">Output:</span> cart summary, checkout totals, confirmation receipt, and stored member order history.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Pages/Cart.aspx</code>, <code>Pages/Checkout.aspx</code>, <code>Pages/OrderConfirmation.aspx</code>,
                        <code>Helpers/ShoppingCartService.cs</code>, <code>Helpers/CheckoutPricingService.cs</code>,
                        <code>Helpers/FakeOrderHistoryRepository.cs</code>, and related cart/order models. Used throughout the storefront purchase flow.
                    </td>
                    <td>
                        <a href="<%= ResolveUrl("~/Pages/Cart.aspx") %>">Cart</a><br />
                        <a href="<%= ResolveUrl("~/Pages/Checkout.aspx") %>">Checkout</a>
                    </td>
                </tr>
                <tr>
                    <td>Adrian</td>
                    <td>DLL class library</td>
                    <td class="summary-detail">
                        <span class="summary-strong">AdrianHashLib</span> provides the local SHA-256 hash function used for credential security and explicit demo testing.
                        <br /><span class="summary-strong">Inputs:</span> plaintext string input.
                        <br /><span class="summary-strong">Output:</span> 64-character hexadecimal hash string.
                    </td>
                    <td class="summary-detail">
                        Implemented in the <code>AdrianHashLib</code> project through <code>HashUtil.Sha256</code>.
                        Used by <code>Helpers/PasswordSecurity.cs</code> for account hashing and exposed visibly on <code>Pages/AdrianDemo.aspx</code>.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/AdrianDemo.aspx") %>">Adrian Demo</a></td>
                </tr>
                <tr>
                    <td>Adrian</td>
                    <td>WCF / WSDL service (.svc)</td>
                    <td class="summary-detail">
                        <span class="summary-strong">AdrianStoreService</span> provides shipping-cost calculation for the storefront.
                        <br /><span class="summary-strong">Inputs:</span> <code>CalculateShipping(decimal subtotal, string region)</code>.
                        <br /><span class="summary-strong">Output:</span> decimal shipping total.
                    </td>
                    <td class="summary-detail">
                        Implemented in the <code>AdrianStoreService</code> project using <code>IShippingService.cs</code> and <code>ShippingService.svc.cs</code>.
                        The integrated application is already wired to the shared shipping client path; Adrian should keep the standalone deployed endpoint compatible with this contract.
                    </td>
                    <td>
                        <a href="<%= ResolveUrl("~/Pages/AdrianDemo.aspx") %>">Adrian Demo</a><br />
                        <a href="<%= ResolveUrl("~/ShippingService.svc") %>">Service Endpoint</a>
                    </td>
                </tr>
                <tr>
                    <td>Adrian</td>
                    <td>ASPX demo page + integration surface</td>
                    <td class="summary-detail">
                        <span class="summary-strong">AdrianDemo.aspx</span> is the visible testing surface for Adrian's service, DLL, and session-state helper.
                        It quotes shipping, increments a lightweight session cart counter, and hashes arbitrary sample text.
                        <br /><span class="summary-strong">Inputs:</span> subtotal, region, and sample text.
                        <br /><span class="summary-strong">Output:</span> shipping quote, session cart count, and SHA-256 hash result.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Pages/AdrianDemo.aspx</code> and <code>Pages/AdrianDemo.aspx.cs</code>.
                        Uses the shared client helper for shipping, the local DLL for hashing, and the session helper below for a visible state-management demo.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/AdrianDemo.aspx") %>">Adrian Demo</a></td>
                </tr>
                <tr>
                    <td>Adrian</td>
                    <td>Session helper</td>
                    <td class="summary-detail">
                        <span class="summary-strong">CartState</span> is Adrian's lightweight session-state helper for demo purposes.
                        <br /><span class="summary-strong">Inputs:</span> current session state and increment actions.
                        <br /><span class="summary-strong">Output:</span> session-backed cart counter value.
                    </td>
                    <td class="summary-detail">
                        Implemented in <code>Helpers/CartState.cs</code> and surfaced through <code>Pages/AdrianDemo.aspx</code>.
                        Used as Adrian's visible session-state component.
                    </td>
                    <td><a href="<%= ResolveUrl("~/Pages/AdrianDemo.aspx") %>">Adrian Demo</a></td>
                </tr>
            </tbody>
        </table>

        <p>
            <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Default.aspx" Text="Back to Home Page" CssClass="summary-footer-link" />
        </p>
    </div>

</asp:Content>
