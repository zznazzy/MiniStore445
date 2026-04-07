<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MiniStoreWeb._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <section class="row" aria-labelledby="storeTitle">
            <h1 id="storeTitle">MiniStore445</h1>
            <p class="lead">
                Welcome to MiniStore445, a mini online store web application for CSE 445/598.
            </p>
            <p>
                This application lets users browse sample products and test local components and web services.
                For Assignment 5, this page serves as the public landing page and service directory. For Assignment 6,
                the project will expand to include Member and Staff functionality.
            </p>
        </section>

        <div class="row">
            <section class="col-md-4" aria-labelledby="navTitle">
                <h2 id="navTitle">Navigation</h2>
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
            </section>

            <section class="col-md-4" aria-labelledby="testingTitle">
                <h2 id="testingTitle">How to Test</h2>
                <p>
                    Use the links on this page to open the Member and Staff placeholder pages, the Bella TryIt page,
                    and the Global demo page.
                </p>
                <p>
                    Additional test instructions and service inputs will be added as components are completed.
                </p>
            </section>

            <section class="col-md-4" aria-labelledby="serviceDirectoryTitle">
                <h2 id="serviceDirectoryTitle">Service Directory</h2>
                <p>
                    The service directory table will list each component, its provider, parameters, return type,
                    description, and TryIt link.
                </p>
            </section>
        </div>
    </main>

</asp:Content>