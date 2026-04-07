<%@ Page Title="Staff Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Staff.aspx.cs" Inherits="MiniStoreWeb.Pages.Staff" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-card">
        <h1>Staff Page</h1>
        <p class="lead">
            This page is the future staff/admin area for MiniStore445.
        </p>
        <p>
            In Assignment 6, this page will be restricted to authorized staff users and will support
            administrative actions such as managing store products or viewing protected store data.
        </p>

        <div class="row" style="margin-top: 24px;">
            <div class="col-md-6">
                <div style="background:#f8f9fa; border-radius:14px; padding:20px;">
                    <h3>Planned Staff Features</h3>
                    <ul>
                        <li>Staff-only authentication</li>
                        <li>Protected administrative access</li>
                        <li>Product management tools</li>
                        <li>XML-backed staff credentials</li>
                    </ul>
                </div>
            </div>

            <div class="col-md-6">
                <div style="background:#f8f9fa; border-radius:14px; padding:20px;">
                    <h3>Current Status</h3>
                    <p>
                        This page is currently a placeholder for Assignment 5.
                    </p>
                    <p>
                        Staff authorization and admin functionality will be implemented in Assignment 6.
                    </p>
                </div>
            </div>
        </div>

        <p style="margin-top: 24px;">
            <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Default.aspx" Text="Back to Home Page" CssClass="btn btn-primary" />
        </p>
    </div>

</asp:Content>