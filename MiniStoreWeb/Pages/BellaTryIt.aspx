<%@ Page Title="Bella TryIt" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BellaTryIt.aspx.cs" Inherits="MiniStoreWeb.Pages.BellaTryIt" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-card">
        <h1>Bella TryIt Page</h1>
        <p class="lead">
            This page tests Bella's discount calculator web service.
        </p>
        <p>
            Enter a subtotal and select a coupon code to call the service and display the discounted total.
        </p>

        <div class="row" style="margin-top: 20px;">
            <div class="col-md-6">
                <div style="background:#f8f9fa; border-radius:14px; padding:20px;">
                    <div class="form-group">
                        <label for="txtSubtotal"><strong>Subtotal</strong></label>
                        <asp:TextBox ID="txtSubtotal" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group" style="margin-top: 16px;">
                        <label for="ddlCouponCode"><strong>Coupon Code</strong></label>
                        <asp:DropDownList ID="ddlCouponCode" runat="server" CssClass="form-control">
                            <asp:ListItem Text="(none)" Value="" />
                            <asp:ListItem Text="SAVE10" Value="SAVE10" />
                            <asp:ListItem Text="STUDENT15" Value="STUDENT15" />
                            <asp:ListItem Text="VIP20" Value="VIP20" />
                        </asp:DropDownList>
                    </div>

                    <div style="margin-top: 20px;">
                        <asp:Button ID="btnCalculate" runat="server" Text="Calculate Discounted Total" CssClass="btn btn-primary" OnClick="btnCalculate_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-default" OnClick="btnClear_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div style="background:#f8f9fa; border-radius:14px; padding:20px;">
                    <h3>Sample Test Cases</h3>
                    <ul>
                        <li><strong>100</strong> + <strong>SAVE10</strong> → 90.00</li>
                        <li><strong>100</strong> + <strong>STUDENT15</strong> → 85.00</li>
                        <li><strong>100</strong> + <strong>VIP20</strong> → 80.00</li>
                        <li><strong>100</strong> + no coupon → 100.00</li>
                    </ul>
                </div>
            </div>
        </div>

        <hr />

        <h3>Results</h3>
        <table class="table table-bordered">
            <tr>
                <th style="width: 220px;">Coupon Description</th>
                <td><asp:Label ID="lblCouponDescription" runat="server" /></td>
            </tr>
            <tr>
                <th>Discounted Total</th>
                <td><asp:Label ID="lblDiscountedTotal" runat="server" /></td>
            </tr>
        </table>

        <p>
            <asp:Label ID="lblTryItMessage" runat="server" ForeColor="Red" />
        </p>

        <p style="margin-top: 24px;">
            <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="~/Default.aspx" Text="Back to Home Page" CssClass="btn btn-primary" />
        </p>
    </div>

</asp:Content>