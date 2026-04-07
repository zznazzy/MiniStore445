<%@ Page Title="Member Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Member.aspx.cs" Inherits="MiniStoreWeb.Pages.Member" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-card">
        <h1>Member Page</h1>
        <p class="lead">
            This page is the future member area for MiniStore445.
        </p>
        <p>
            In Assignment 6, this page will be available only to authenticated members and will support
            member-specific store features such as account access, shopping cart functionality, or saved product data.
        </p>

        <div class="row" style="margin-top: 24px;">
            <div class="col-md-6">
                <div style="background:#f8f9fa; border-radius:14px; padding:20px;">
                    <h3>Planned Member Features</h3>
                    <ul>
                        <li>Secure member login</li>
                        <li>Shopping cart or account area</li>
                        <li>XML-backed member data</li>
                        <li>Captcha-protected sign-up flow</li>
                    </ul>
                </div>
            </div>

            <div class="col-md-6">
                <div style="background:#f8f9fa; border-radius:14px; padding:20px;">
                    <h3>Current Status</h3>
                    <p>
                        This is currently a placeholder page for Assignment 5 so the public landing page can link here.
                    </p>
                    <p>
                        Authentication and member-only access will be implemented in Assignment 6.
                    </p>
                </div>
            </div>
        </div>

        <p style="margin-top: 24px;">
            <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Default.aspx" Text="Back to Home Page" CssClass="btn btn-primary" />
        </p>
    </div>

</asp:Content>