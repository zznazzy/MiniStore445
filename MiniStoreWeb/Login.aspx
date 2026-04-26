<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MiniStoreWeb.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .auth-shell {
            display: grid;
            grid-template-columns: 1.2fr 0.8fr;
            gap: 24px;
            align-items: start;
        }

        .auth-card,
        .support-card {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 28px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 24px rgba(0,0,0,0.08);
        }

        .auth-card .form-control,
        .auth-card .form-check-input,
        .auth-card textarea,
        .auth-card select {
            max-width: 100%;
        }

        .account-toggle label {
            margin-right: 18px;
            font-weight: 600;
        }

        .hint-box {
            background: linear-gradient(180deg, #f9fbff 0%, #eef4fc 100%);
            border-radius: 14px;
            padding: 18px;
            border: 1px solid #dce5f2;
        }

        .status-message {
            color: #b44545;
            min-height: 24px;
        }

        @media (max-width: 991px) {
            .auth-shell {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="auth-shell">
        <section class="auth-card">
            <h1>Login</h1>
            <p class="lead">Use the same form for member or staff access.</p>

            <div class="form-group">
                <label for="txtUsername"><strong>Username</strong></label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group" style="margin-top: 16px;">
                <label for="txtPassword"><strong>Password</strong></label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
            </div>

            <div class="form-group" style="margin-top: 18px;">
                <label><strong>Account Type</strong></label>
                <asp:RadioButtonList ID="rblAccountType" runat="server" RepeatDirection="Horizontal" CssClass="account-toggle">
                    <asp:ListItem Text="Member" Value="Member" Selected="True" />
                    <asp:ListItem Text="Staff" Value="Staff" />
                </asp:RadioButtonList>
            </div>

            <div class="form-check" style="margin-top: 6px;">
                <asp:CheckBox ID="chkRememberMe" runat="server" Text="Keep me signed in on this browser" />
            </div>

            <div style="margin-top: 22px;">
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                <a runat="server" href="~/Pages/SignUp.aspx" class="btn btn-outline-secondary" style="margin-left: 10px;">Create Member Account</a>
            </div>

            <p class="status-message" style="margin-top: 18px;">
                <asp:Label ID="lblLoginMessage" runat="server" />
            </p>
        </section>

        <aside class="support-card">
            <h2>Quick Access Notes</h2>
            <div class="hint-box">
                <p><strong>Staff test account</strong></p>
                <p style="margin-bottom: 8px;">Username: <code>TA</code></p>
                <p style="margin-bottom: 0;">Password: <code>Cse445!</code></p>
            </div>

            <div class="hint-box" style="margin-top: 18px;">
                <p><strong>Need a member account?</strong></p>
                <a runat="server" href="~/Pages/SignUp.aspx" class="btn btn-primary" style="margin-top: 6px;">Sign Up</a>
            </div>
        </aside>
    </div>

</asp:Content>
