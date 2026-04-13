<%@ Page Title="Global Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GlobalDemo.aspx.cs" Inherits="MiniStoreWeb.Pages.GlobalDemo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-card">
        <%-- Visible verification page for Global.asax Application/Session state behavior. --%>
        <h1>Global.asax Demo</h1>
        <p class="lead">
            This page displays visible output from the Global.asax event handlers.
        </p>
        <p>
            It is used to verify that the application start logic and session start logic are working correctly.
        </p>

        <%-- Runtime values read from Application and Session state. --%>
        <table class="table table-bordered table-striped" style="margin-top: 20px;">
            <tr>
                <th style="width: 260px;">Application Start Time</th>
                <td><asp:Label ID="lblAppStartTime" runat="server" /></td>
            </tr>
            <tr>
                <th>Visitor Count</th>
                <td><asp:Label ID="lblVisitorCount" runat="server" /></td>
            </tr>
            <tr>
                <th>Session Start Time</th>
                <td><asp:Label ID="lblSessionStartTime" runat="server" /></td>
            </tr>
            <tr>
                <th>Current Session ID</th>
                <td><asp:Label ID="lblSessionId" runat="server" /></td>
            </tr>
            <tr>
                <th>Current Page URL</th>
                <td>
                    <a href="<%= Request.Url.AbsoluteUri %>"><%= Request.Url.AbsoluteUri %></a>
                </td>
            </tr>
        </table>

        <%-- Human-readable checklist of what this demo output confirms. --%>
        <div style="background:#f8f9fa; border-radius:14px; padding:20px; margin-top:20px;">
            <h3>What this page proves</h3>
            <ul>
                <li><code>Application_Start</code> stored the app start time.</li>
                <li><code>Session_Start</code> increments the visitor count.</li>
                <li>Session data is available and displayed through the GUI.</li>
            </ul>
        </div>

        <p style="margin-top: 24px;">
            <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Default.aspx" Text="Back to Home Page" CssClass="btn btn-primary" />
        </p>
    </div>

</asp:Content>
