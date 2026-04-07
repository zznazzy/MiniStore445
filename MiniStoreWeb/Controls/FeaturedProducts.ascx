<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FeaturedProducts.ascx.cs" Inherits="MiniStoreWeb.Controls.FeaturedProducts" %>

<div id="featuredProductsSection">
    <h2>Featured Products</h2>
    <p>These products are loaded from <code>Products.xml</code>.</p>

    <asp:Literal ID="litFeaturedMessage" runat="server" />

    <asp:Repeater ID="rptFeaturedProducts" runat="server">
        <HeaderTemplate>
            <div class="row">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="col-md-3">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong><%# Eval("Name") %></strong>
                    </div>
                    <div class="panel-body">
                        <p><strong>Category:</strong> <%# Eval("Category") %></p>
                        <p><strong>Price:</strong> $<%# Eval("Price", "{0:F2}") %></p>
                        <p><%# Eval("Description") %></p>
                        <p><strong>In Stock:</strong> <%# Eval("InStockText") %></p>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>
</div>