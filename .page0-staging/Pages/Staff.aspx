<%@ Page Title="Staff Admin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Staff.aspx.cs" Inherits="MiniStoreWeb.Pages.Staff" MaintainScrollPositionOnPostBack="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .admin-layout {
            display: grid;
            grid-template-columns: 0.95fr 1.05fr;
            gap: 24px;
            align-items: start;
        }

        .admin-panel {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 24px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 24px rgba(0,0,0,0.08);
        }

        .admin-grid input,
        .admin-grid textarea,
        .admin-grid select {
            max-width: 100%;
        }

        .admin-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 14px 16px;
        }

        .admin-grid-span {
            grid-column: 1 / -1;
        }

        .admin-toggle-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 14px 16px;
        }

        .status-message {
            color: #2f5fa7;
            min-height: 24px;
        }

        .staff-thumb {
            width: 72px;
            height: 72px;
            border-radius: 10px;
            object-fit: cover;
            display: block;
            margin: 0 auto 8px;
            background: linear-gradient(180deg, #f8fbff 0%, #edf2fb 100%);
            border: 1px solid #dfe7f1;
        }

        .admin-table {
            margin-bottom: 0;
        }

        .admin-table th,
        .admin-table td {
            vertical-align: middle;
        }

        .admin-table .form-control {
            min-width: 100px;
        }

        .admin-grid-button {
            min-height: 34px;
            padding: 0 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }

        .admin-table-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .admin-status-pill {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 32px;
            padding: 4px 12px;
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.88rem;
            border: 1px solid transparent;
        }

        .admin-status-yes {
            background: linear-gradient(180deg, #f0fbf4 0%, #dff3e6 100%);
            color: #227a43;
            border-color: #c7e4d1;
        }

        .admin-status-no {
            background: linear-gradient(180deg, #fff2f2 0%, #fde2e2 100%);
            color: #b44545;
            border-color: #f0c8c8;
        }

        .admin-image-cell {
            text-align: center;
        }

        .admin-meta-note {
            color: #5f6f83;
            margin-bottom: 18px;
        }

        @media (max-width: 1100px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }

            .admin-grid,
            .admin-toggle-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="page-card">
        <div class="d-flex flex-wrap justify-content-between align-items-start">
            <div>
                <h1>Staff Product Manager</h1>
                <p class="lead"><asp:Label ID="lblStaffWelcome" runat="server" /></p>
            </div>
            <asp:Button ID="btnStaffLogout" runat="server" Text="Logout" CssClass="btn btn-outline-danger" OnClick="btnStaffLogout_Click" CausesValidation="false" />
        </div>

        <p>
            Products currently in XML: <strong><asp:Label ID="lblProductCount" runat="server" /></strong>
        </p>
        <p class="status-message">
            <asp:Label ID="lblStaffMessage" runat="server" />
        </p>

        <div class="admin-layout">
            <section class="admin-panel">
                <h2>Add Product</h2>
                <p class="admin-meta-note">Use a full image link, pick a store category, and set exactly how many units this item can support in carts.</p>
                <div class="admin-grid">
                    <div class="form-group">
                        <label for="txtNewName"><strong>Name</strong></label>
                        <asp:TextBox ID="txtNewName" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label for="ddlNewCategory"><strong>Category</strong></label>
                        <asp:DropDownList ID="ddlNewCategory" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Select a category..." Value="" />
                            <asp:ListItem Text="Stationery" Value="Stationery" />
                            <asp:ListItem Text="Accessories" Value="Accessories" />
                            <asp:ListItem Text="Drinkware" Value="Drinkware" />
                            <asp:ListItem Text="Clothing" Value="Clothing" />
                            <asp:ListItem Text="Study Tools" Value="Study Tools" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label for="txtNewPrice"><strong>Price</strong></label>
                        <asp:TextBox ID="txtNewPrice" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label for="txtNewStockQuantity"><strong>Available Quantity</strong></label>
                        <asp:TextBox ID="txtNewStockQuantity" runat="server" CssClass="form-control" Text="0" />
                    </div>

                    <div class="form-group admin-grid-span">
                        <label for="txtNewImage"><strong>Image Link</strong></label>
                        <asp:TextBox ID="txtNewImage" runat="server" CssClass="form-control" placeholder="https://example.com/product-photo.jpg" />
                    </div>

                    <div class="form-group admin-grid-span">
                        <label for="txtNewDescription"><strong>Description</strong></label>
                        <asp:TextBox ID="txtNewDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
                    </div>

                    <div class="admin-toggle-grid admin-grid-span">
                        <div class="form-group">
                            <label for="ddlNewInStock"><strong>Availability</strong></label>
                            <asp:DropDownList ID="ddlNewInStock" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Available For Purchase" Value="True" Selected="True" />
                                <asp:ListItem Text="Hidden / Out Of Stock" Value="False" />
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="ddlNewFeatured"><strong>Storefront Spotlight</strong></label>
                            <asp:DropDownList ID="ddlNewFeatured" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Featured On Storefront" Value="True" Selected="True" />
                                <asp:ListItem Text="Regular Catalog Item" Value="False" />
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="admin-grid-span" style="margin-top: 6px;">
                        <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" CssClass="btn btn-primary" OnClick="btnAddProduct_Click" />
                    </div>
                </div>
            </section>

            <section class="admin-panel">
                <h2>Edit Existing Products</h2>
                <p class="admin-meta-note">Edit, feature, hide, or delete products directly from the XML-backed catalog.</p>
                <asp:GridView
                    ID="gvProducts"
                    runat="server"
                    AutoGenerateColumns="false"
                    CssClass="table table-striped table-bordered admin-table"
                    DataKeyNames="Id"
                    OnRowEditing="gvProducts_RowEditing"
                    OnRowCancelingEdit="gvProducts_RowCancelingEdit"
                    OnRowUpdating="gvProducts_RowUpdating"
                    OnRowCommand="gvProducts_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate><%# Eval("Name") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category">
                            <ItemTemplate><%# Eval("Category") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlEditCategory" runat="server" CssClass="form-control" SelectedValue='<%# Bind("Category") %>'>
                                    <asp:ListItem Text="Stationery" Value="Stationery" />
                                    <asp:ListItem Text="Accessories" Value="Accessories" />
                                    <asp:ListItem Text="Drinkware" Value="Drinkware" />
                                    <asp:ListItem Text="Clothing" Value="Clothing" />
                                    <asp:ListItem Text="Study Tools" Value="Study Tools" />
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate><%# Eval("Price", "{0:C}") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditPrice" runat="server" Text='<%# Bind("Price", "{0:F2}") %>' CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty">
                            <ItemTemplate><%# Eval("StockQuantity") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditStockQuantity" runat="server" Text='<%# Bind("StockQuantity") %>' CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img class="staff-thumb" src="<%# Eval("Image") %>" alt="<%# Eval("Name") %>" loading="lazy" decoding="async" />
                                <div class="admin-image-cell">
                                    <a href="<%# Eval("Image") %>" target="_blank" rel="noopener noreferrer" class="btn btn-outline-secondary btn-sm admin-grid-button">Preview</a>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditImage" runat="server" Text='<%# Bind("Image") %>' CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate><%# Eval("Description") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditDescription" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" Rows="3" CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Featured">
                            <ItemTemplate>
                                <span class='admin-status-pill <%# (bool)Eval("Featured") ? "admin-status-yes" : "admin-status-no" %>'>
                                    <%# (bool)Eval("Featured") ? "Featured" : "Regular" %>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlEditFeatured" runat="server" CssClass="form-control" SelectedValue='<%# Bind("Featured") %>'>
                                    <asp:ListItem Text="Featured" Value="True" />
                                    <asp:ListItem Text="Regular" Value="False" />
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate>
                                <span class='admin-status-pill <%# (bool)Eval("InStock") ? "admin-status-yes" : "admin-status-no" %>'>
                                    <%# (bool)Eval("InStock") ? "Active" : "Hidden" %>
                                </span>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlEditInStock" runat="server" CssClass="form-control" SelectedValue='<%# Bind("InStock") %>'>
                                    <asp:ListItem Text="Active" Value="True" />
                                    <asp:ListItem Text="Hidden" Value="False" />
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditProduct" runat="server" Text="Edit" CommandName="Edit" CausesValidation="false" CssClass="btn btn-outline-secondary btn-sm admin-grid-button" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="admin-table-actions">
                                    <asp:LinkButton ID="btnUpdateProduct" runat="server" Text="Save" CommandName="Update" CausesValidation="false" CssClass="btn btn-primary btn-sm admin-grid-button" />
                                    <asp:LinkButton ID="btnCancelEdit" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" CssClass="btn btn-outline-secondary btn-sm admin-grid-button" />
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quick Actions">
                            <ItemTemplate>
                                <div class="admin-table-actions">
                                    <asp:LinkButton ID="btnToggleFeatured" runat="server" Text="Toggle Featured" CommandName="ToggleFeatured" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" CssClass="btn btn-outline-secondary btn-sm admin-grid-button" />
                                    <asp:LinkButton ID="btnToggleStock" runat="server" Text="Toggle Active" CommandName="ToggleStock" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" CssClass="btn btn-outline-secondary btn-sm admin-grid-button" />
                                    <asp:LinkButton ID="btnDeleteProduct" runat="server" Text="Delete" CommandName="DeleteProduct" CommandArgument='<%# Eval("Id") %>' CausesValidation="false" CssClass="btn btn-outline-danger btn-sm admin-grid-button" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </section>
        </div>
    </div>

</asp:Content>
