<%@ Page Title="Global Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GlobalDemo.aspx.cs" Inherits="MiniStoreWeb.Pages.GlobalDemo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <section class="row">
            <div class="col-md-12">
                <h1>Global.asax Demo</h1>
                <p class="lead">
                    This page displays values set by the Global.asax event handlers.
                </p>
                <p>
                    It shows the application start time, the current visitor count, the session start time,
                    the current session ID, and the current page URL.
                </p>
            </div>
        </section>

        <section class="row">
            <div class="col-md-8">
                <table class="table table-bordered table-striped">
                    <tr>
                        <th>Application Start Time</th>
                        <td>
                            <asp:Label ID="lblAppStartTime" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <th>Visitor Count</th>
                        <td>
                            <asp:Label ID="lblVisitorCount" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <th>Session Start Time</th>
                        <td>
                            <asp:Label ID="lblSessionStartTime" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <th>Current Session ID</th>
                        <td>
                            <asp:Label ID="lblSessionId" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <th>Current Page URL</th>
                        <td>
                            <a href="<%= Request.Url.AbsoluteUri %>"><%= Request.Url.AbsoluteUri %></a>
                        </td>
                    </tr>
                </table>
            </div>
        </section>

        <section class="row">
            <div class="col-md-12">
                <p>
                    <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Default.aspx" Text="Back to Default Page" />
                </p>
            </div>
        </section>
    </main>

</asp:Content>