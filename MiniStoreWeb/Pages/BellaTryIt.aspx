<%@ Page Title="Bella TryIt" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BellaTryIt.aspx.cs" Inherits="MiniStoreWeb.Pages.BellaTryIt" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Bella TryIt Page</h1>
    <p>Use this page to test Bella's discount calculator web service.</p>

    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="txtSubtotal">Subtotal</label>
                <asp:TextBox ID="txtSubtotal" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group">
                <label for="ddlCouponCode">Coupon Code</label>
                <asp:DropDownList ID="ddlCouponCode" runat="server" CssClass="form-control">
                    <asp:ListItem Text="(none)" Value="" />
                    <asp:ListItem Text="SAVE10" Value="SAVE10" />
                    <asp:ListItem Text="STUDENT15" Value="STUDENT15" />
                    <asp:ListItem Text="VIP20" Value="VIP20" />
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnCalculate" runat="server" Text="Calculate Discounted Total" CssClass="btn btn-primary" OnClick="btnCalculate_Click" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-default" OnClick="btnClear_Click" CausesValidation="false" />
        </div>
    </div>

    <hr />

    <h3>Results</h3>
    <p><strong>Coupon Description:</strong> <asp:Label ID="lblCouponDescription" runat="server" /></p>
    <p><strong>Discounted Total:</strong> <asp:Label ID="lblDiscountedTotal" runat="server" /></p>
    <p><asp:Label ID="lblTryItMessage" runat="server" ForeColor="Red" /></p>

    <p>
        <asp:HyperLink ID="lnkBackDefault" runat="server" NavigateUrl="~/Default.aspx" Text="Back to Default Page" />
    </p>

</asp:Content>