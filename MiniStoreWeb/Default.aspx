<%@ Page Title="MiniStore445" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MiniStoreWeb._Default" MaintainScrollPositionOnPostBack="true" %>
<%@ Register Src="~/Controls/FeaturedProducts.ascx" TagPrefix="uc" TagName="FeaturedProducts" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%-- Page-local styling for the home page hero, browse panel, and info cards. --%>
    <style>
        .hero-box {
            background: linear-gradient(135deg, #ffffff 0%, #edf4ff 55%, #e6efff 100%);
            border-radius: 22px;
            padding: 42px;
            margin-top: 20px;
            margin-bottom: 30px;
            border: 1px solid #dbe6f6;
            box-shadow: 0 6px 24px rgba(0,0,0,0.08);
            text-align: center;
        }

        .hero-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 14px;
            color: #1f1f1f;
        }

        .hero-title-accent {
            color: #2f80ff;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            color: #555;
            margin: 0 auto;
            max-width: 820px;
            line-height: 1.6;
        }

        .hero-cart-mark {
            width: 106px;
            height: 106px;
            margin: 0 auto 20px;
            border-radius: 30px;
            background: linear-gradient(180deg, #eef5ff 0%, #e0ecff 100%);
            border: 1px solid #cfe0fb;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: inset 0 0 0 1px rgba(47, 128, 255, 0.12);
        }

        .hero-cart-mark svg {
            width: 60px;
            height: 60px;
            display: block;
        }

        .info-card {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 24px;
            margin-bottom: 25px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 22px rgba(0,0,0,0.08);
            height: 100%;
        }

        .section-title {
            font-size: 2rem;
            font-weight: 700;
            margin-top: 20px;
            margin-bottom: 18px;
            color: #1f1f1f;
        }

        .soft-list li {
            margin-bottom: 10px;
        }

        .browse-card {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 24px;
            margin-bottom: 28px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 22px rgba(0,0,0,0.08);
        }

        .browse-card h2 {
            margin-top: 0;
            margin-bottom: 8px;
        }

        .browse-subtext {
            color: #666;
            margin-bottom: 20px;
        }

        .browse-controls .form-control {
            border-radius: 12px;
            min-height: 44px;
        }

        .browse-controls .btn {
            min-height: 44px;
            border-radius: 12px;
            width: 100%;
        }

        .category-filter-block {
            margin-top: 18px;
            background: linear-gradient(180deg, #f9fbff 0%, #f1f6fd 100%);
            border-radius: 16px;
            padding: 18px;
            border: 1px solid #dce5f2;
        }

        .category-filter-block label {
            display: block;
            margin-bottom: 10px;
        }

        .category-checklist {
            display: flex;
            flex-wrap: wrap;
            gap: 10px 12px;
        }

        .category-checklist span {
            display: inline-flex;
            align-items: center;
            position: relative;
        }

        .category-checklist input[type=checkbox] {
            position: absolute;
            opacity: 0;
            pointer-events: none;
            width: 1px;
            height: 1px;
        }

        .category-checklist label {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 999px;
            padding: 8px 14px;
            font-size: 0.9rem;
            font-weight: 600;
            background: linear-gradient(180deg, #f7f9fd 0%, #edf2f8 100%);
            color: #687587;
            border: 1px solid #dbe2ea;
            cursor: pointer;
            margin-bottom: 0;
            transition: transform 0.15s ease, box-shadow 0.15s ease, background 0.15s ease, color 0.15s ease, border-color 0.15s ease;
            white-space: nowrap;
        }

        .category-checklist label:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.08);
        }

        .category-checklist input[type=checkbox]:checked + label.category-chip-stationery {
            background: linear-gradient(180deg, #ffeef5 0%, #ffdfe9 100%);
            color: #b23b67;
            border-color: #f3bfd3;
        }

        .category-checklist input[type=checkbox]:checked + label.category-chip-accessories {
            background: linear-gradient(180deg, #fff5e4 0%, #ffe9c4 100%);
            color: #b16c17;
            border-color: #f2d3a0;
        }

        .category-checklist input[type=checkbox]:checked + label.category-chip-drinkware {
            background: linear-gradient(180deg, #e8fbfb 0%, #d4f3f1 100%);
            color: #177c82;
            border-color: #afe5e1;
        }

        .category-checklist input[type=checkbox]:checked + label.category-chip-clothing {
            background: linear-gradient(180deg, #eef2ff 0%, #dde6ff 100%);
            color: #3d57b8;
            border-color: #c0cff8;
        }

        .category-checklist input[type=checkbox]:checked + label.category-chip-study-tools {
            background: linear-gradient(180deg, #eefaf0 0%, #dff3e3 100%);
            color: #2f7c41;
            border-color: #bfe2c5;
        }

        .store-pill {
            display: inline-block;
            background: linear-gradient(180deg, #f3f7ff 0%, #e5eeff 100%);
            color: #2f5fa7;
            border-radius: 999px;
            padding: 6px 12px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 16px;
            border: 1px solid #d8e4f7;
        }

        .explore-footer-card {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 24px;
            margin-top: 12px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 22px rgba(0,0,0,0.08);
            text-align: center;
        }

        .explore-footer-buttons {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 12px;
            margin-top: 18px;
        }

        .tester-card {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 24px;
            margin-bottom: 28px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 22px rgba(0,0,0,0.08);
        }

        .tester-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .tester-list {
            margin-bottom: 0;
            color: #566273;
        }

        .tester-list li {
            margin-bottom: 10px;
        }

        .tester-actions {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 12px;
            margin-top: 22px;
        }

        .tester-note {
            margin-top: 16px;
            color: #607086;
            text-align: center;
        }

        @media (max-width: 991px) {
            .tester-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".category-checklist label").forEach(function (label) {
                var key = label.textContent.trim().toLowerCase().replace(/\s+/g, "-");
                label.classList.add("category-chip", "category-chip-" + key);
            });
        });
    </script>

    <main>
        <%-- Intro/branding hero for the landing page. --%>
        <section class="hero-box">
            <span class="store-pill">Everyday essentials, thoughtfully picked</span>
            <h1 class="hero-title">MiniStore<span class="hero-title-accent">445</span></h1>
            <div class="hero-cart-mark" aria-hidden="true">
                <svg viewBox="0 0 24 24" focusable="false">
                    <circle cx="9" cy="19" r="1.7" fill="none" stroke="#2f80ff" stroke-width="1.9"></circle>
                    <circle cx="18" cy="19" r="1.7" fill="none" stroke="#2f80ff" stroke-width="1.9"></circle>
                    <path d="M3 4h2.3l1.8 9.1c.1.6.6 1 1.2 1H18a1.2 1.2 0 0 0 1.2-.9L21 7.6H7.1" fill="none" stroke="#2f80ff" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"></path>
                </svg>
            </div>
            <p class="hero-subtitle">
                Simple, useful items for study, work, and everyday life. Browse a curated collection,
                explore featured picks, and quickly find what you need.
            </p>
        </section>

        <%-- Public testing guide so graders can reach protected pages and component demos quickly. --%>
        <section class="tester-card">
            <div class="tester-grid">
                <div>
                    <h2 style="margin-top: 0;">What This App Offers</h2>
                    <ul class="tester-list">
                        <li>Public storefront browsing with search, category, stock, and price filters.</li>
                        <li>Member self-enrollment, member login, and a protected account page.</li>
                        <li>Staff login and an XML-backed admin page for product management.</li>
                        <li>Session cart, checkout totals, fake order confirmation, and previous order history.</li>
                    </ul>
                </div>
                <div>
                    <h2 style="margin-top: 0;">How To Test</h2>
                    <ul class="tester-list">
                        <li>Create a member account from Sign Up, complete the captcha, then open the Member page.</li>
                        <li>Use the staff test account <code>TA</code> / <code>Cse445!</code> to open the Staff page.</li>
                        <li>Try Bella coupon cases such as <code>100 + SAVE10</code>, <code>100 + STUDENT15</code>, and <code>100 + VIP20</code>.</li>
                        <li>Try Adrian demo inputs such as <code>75 + Domestic</code> for free shipping and hash any sample text through the DLL tester.</li>
                    </ul>
                </div>
            </div>

            <div class="tester-actions">
                <a runat="server" href="~/Pages/Member.aspx" class="btn btn-primary">Member Page</a>
                <a runat="server" href="~/Pages/Staff.aspx" class="btn btn-outline-secondary">Staff Page</a>
                <a runat="server" href="~/Pages/SignUp.aspx" class="btn btn-outline-secondary">Sign Up</a>
                <a runat="server" href="~/About.aspx" class="btn btn-outline-secondary">Summary Table</a>
            </div>

            <p class="tester-note">
                The Member and Staff buttons use forms-auth redirection automatically. Anonymous users are sent to Login, and authenticated users land on the protected page directly.
            </p>
        </section>

        <%-- Search + category filters; values are handled in Default.aspx.cs and passed to FeaturedProducts. --%>
        <section id="browseProducts" class="browse-card">
            <h2>Browse Products</h2>
            <p class="browse-subtext">
                Search, stack filters, and sort by price without leaving the storefront.
            </p>

            <div class="row browse-controls">
                <div class="col-lg-4 col-md-6">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search products..." />
                </div>

                <div class="col-lg-3 col-md-6" style="margin-top: 0;">
                    <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Featured Order" Value="" />
                        <asp:ListItem Text="Price: Low To High" Value="price-asc" />
                        <asp:ListItem Text="Price: High To Low" Value="price-desc" />
                    </asp:DropDownList>
                </div>

                <div class="col-lg-3 col-md-6" style="margin-top: 0;">
                    <asp:DropDownList ID="ddlStock" runat="server" CssClass="form-control">
                        <asp:ListItem Text="All Stock" Value="" />
                        <asp:ListItem Text="In Stock" Value="in" />
                        <asp:ListItem Text="Out Of Stock" Value="out" />
                    </asp:DropDownList>
                </div>

                <div class="col-lg-2 col-md-6">
                    <asp:Button ID="btnSearch" runat="server" Text="Apply Filters" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                </div>
            </div>

            <div class="row browse-controls" style="margin-top: 14px;">
                <div class="col-lg-10">
                    <div class="category-filter-block">
                        <label><strong>Categories</strong></label>
                        <asp:CheckBoxList ID="cblCategories" runat="server" CssClass="category-checklist" RepeatLayout="Flow" RepeatDirection="Horizontal" />
                    </div>
                </div>
                <div class="col-lg-2" style="display:flex; align-items:stretch; margin-top: 12px;">
                    <asp:Button ID="btnClearFilters" runat="server" Text="Reset Filters" CssClass="btn btn-outline-secondary" OnClick="btnClearFilters_Click" CausesValidation="false" />
                </div>
            </div>
        </section>

        <%-- FeaturedProducts user control renders filtered featured items from Products.xml. --%>
        <section>
            <h2 class="section-title">Featured Products</h2>
            <uc:FeaturedProducts ID="FeaturedProducts1" runat="server" />
        </section>

        <%-- Supporting informational content shown below the interactive browsing area. --%>
        <section class="row" style="margin-top: 30px;">
            <div class="col-md-6">
                <div class="info-card">
                    <h2>About MiniStore</h2>
                    <p>
                        MiniStore is a lightweight online storefront built around a clean browsing experience.
                        The collection focuses on practical products that fit into everyday routines.
                    </p>
                    <p>
                        Member signup, staff access, protected account pages, and a full cart and checkout flow
                        all fit into the same store UI without getting in the way of browsing.
                    </p>
                </div>
            </div>

            <div class="col-md-6">
                <div class="info-card">
                    <h2>Why Shop Here?</h2>
                    <ul class="soft-list">
                        <li>Clean, uncluttered browsing experience</li>
                        <li>Stackable category, stock, and price filters</li>
                        <li>Protected member and staff areas with forms authentication</li>
                        <li>Curated collection of useful everyday products</li>
                        <li>Quick access to store tools, cart, checkout, and component demos</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="explore-footer-card">
            <h2>More To Explore</h2>
            <p class="browse-subtext" style="margin-bottom: 0;">
                Summary details, global behavior, and the Bella/Adrian demos all live down here.
            </p>
            <div class="explore-footer-buttons">
                <a runat="server" href="~/About.aspx" class="btn btn-primary">Summary</a>
                <a runat="server" href="~/Pages/GlobalDemo.aspx" class="btn btn-outline-secondary">Global Demo</a>
                <a runat="server" href="~/Pages/BellaTryIt.aspx" class="btn btn-outline-secondary">Bella TryIt</a>
                <a runat="server" href="~/Pages/AdrianDemo.aspx" class="btn btn-outline-secondary">Adrian Demo</a>
            </div>
        </section>
    </main>

</asp:Content>
