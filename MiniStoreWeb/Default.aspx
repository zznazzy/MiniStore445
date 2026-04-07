<%@ Page Title="MiniStore445" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MiniStoreWeb._Default" %>
<%@ Register Src="~/Controls/FeaturedProducts.ascx" TagPrefix="uc" TagName="FeaturedProducts" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .hero-box {
            background: linear-gradient(135deg, #f8f9fa, #e9f2ff);
            border-radius: 22px;
            padding: 42px;
            margin-top: 20px;
            margin-bottom: 30px;
            box-shadow: 0 6px 24px rgba(0,0,0,0.08);
        }

        .hero-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: #1f1f1f;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 22px;
            max-width: 820px;
            line-height: 1.6;
        }

        .info-card {
            background: #fff;
            border-radius: 18px;
            padding: 24px;
            margin-bottom: 25px;
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
            background: #ffffff;
            border-radius: 18px;
            padding: 24px;
            margin-bottom: 28px;
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

        .store-pill {
            display: inline-block;
            background: #eef4ff;
            color: #2f5fa7;
            border-radius: 999px;
            padding: 6px 12px;
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 16px;
        }
    </style>

    <main>
        <section class="hero-box">
            <span class="store-pill">Everyday essentials, thoughtfully picked</span>
            <h1 class="hero-title">MiniStore445</h1>
            <p class="hero-subtitle">
                Simple, useful items for study, work, and everyday life. Browse a curated collection,
                explore featured picks, and quickly find what you need.
            </p>
        </section>

        <section id="browseProducts" class="browse-card">
            <h2>Browse Products</h2>
            <p class="browse-subtext">
                Search by name or filter by category to explore the collection.
            </p>

            <div class="row browse-controls">
                <div class="col-md-5">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search products..." />
                </div>

                <div class="col-md-4">
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                        <asp:ListItem Text="All Categories" Value="" />
                        <asp:ListItem Text="Stationery" Value="Stationery" />
                        <asp:ListItem Text="Accessories" Value="Accessories" />
                        <asp:ListItem Text="Drinkware" Value="Drinkware" />
                        <asp:ListItem Text="Clothing" Value="Clothing" />
                        <asp:ListItem Text="Study Tools" Value="Study Tools" />
                    </asp:DropDownList>
                </div>

                <div class="col-md-3">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                </div>
            </div>
        </section>

        <section>
            <h2 class="section-title">Featured Products</h2>
            <uc:FeaturedProducts ID="FeaturedProducts1" runat="server" />
        </section>

        <section class="row" style="margin-top: 30px;">
            <div class="col-md-6">
                <div class="info-card">
                    <h2>About MiniStore</h2>
                    <p>
                        MiniStore is a lightweight online storefront built around a clean browsing experience.
                        The collection focuses on practical products that fit into everyday routines.
                    </p>
                    <p>
                        From stationery and accessories to simple lifestyle items, everything is designed to feel easy to browse and pleasant to use.
                    </p>
                </div>
            </div>

            <div class="col-md-6">
                <div class="info-card">
                    <h2>Why Shop Here?</h2>
                    <ul class="soft-list">
                        <li>Clean, uncluttered browsing experience</li>
                        <li>Simple category filtering and product search</li>
                        <li>Curated collection of useful everyday products</li>
                        <li>Featured picks highlighted on the home page</li>
                        <li>Quick access to store tools and pages</li>
                    </ul>
                </div>
            </div>
        </section>
    </main>

</asp:Content>