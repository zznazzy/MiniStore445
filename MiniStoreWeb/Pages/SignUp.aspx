<%@ Page Title="Member Sign Up" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="MiniStoreWeb.Pages.SignUp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .signup-shell {
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap: 24px;
            align-items: start;
        }

        .signup-card,
        .info-card-local {
            background: linear-gradient(180deg, #ffffff 0%, #f9fbff 100%);
            border-radius: 18px;
            padding: 28px;
            border: 1px solid #dde7f4;
            box-shadow: 0 6px 24px rgba(0,0,0,0.08);
        }

        .captcha-panel {
            background: linear-gradient(180deg, #f9fbff 0%, #eef4fc 100%);
            border-radius: 16px;
            padding: 20px;
            margin-top: 18px;
            border: 1px solid #dce5f2;
        }

        .info-card-local {
            justify-self: start;
            width: fit-content;
            max-width: 420px;
            padding: 22px 24px;
        }

        .info-card-local ul {
            margin-bottom: 0;
        }

        .status-message {
            color: #b44545;
            min-height: 24px;
        }

        @media (max-width: 991px) {
            .signup-shell {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="signup-shell">
        <section class="signup-card">
            <h1>Create a Member Account</h1>
            <p class="lead">Member self-enrollment writes credentials to <code>App_Data/Member.xml</code>.</p>

            <div class="form-group">
                <label for="txtDisplayName"><strong>Display Name</strong></label>
                <asp:TextBox ID="txtDisplayName" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group" style="margin-top: 16px;">
                <label for="txtUserName"><strong>Username</strong></label>
                <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group" style="margin-top: 16px;">
                <label for="txtPassword"><strong>Password</strong></label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
            </div>

            <div class="form-group" style="margin-top: 16px;">
                <label for="txtConfirmPassword"><strong>Confirm Password</strong></label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" />
            </div>

            <div class="captcha-panel">
                <h3 style="margin-bottom: 12px;">Captcha Verification</h3>
                <p style="margin-bottom: 14px;">Enter the characters shown in the image before creating the account.</p>

                <asp:Image ID="imgCaptcha" runat="server" AlternateText="Captcha image" CssClass="img-fluid" />

                <div style="margin-top: 14px;">
                    <asp:Button ID="btnRefreshCaptcha" runat="server" Text="Refresh Captcha" CssClass="btn btn-outline-secondary btn-sm" CausesValidation="false" OnClick="btnRefreshCaptcha_Click" />
                </div>

                <div class="form-group" style="margin-top: 16px;">
                    <label for="txtCaptcha"><strong>Type the Code</strong></label>
                    <asp:TextBox ID="txtCaptcha" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div style="margin-top: 22px;">
                <asp:Button ID="btnCreateAccount" runat="server" Text="Create Account" CssClass="btn btn-primary" OnClick="btnCreateAccount_Click" />
                <a runat="server" href="~/Login.aspx" class="btn btn-outline-secondary" style="margin-left: 10px;">Back to Login</a>
            </div>

            <p class="status-message" style="margin-top: 18px;">
                <asp:Label ID="lblSignUpMessage" runat="server" />
            </p>
        </section>

        <aside class="info-card-local">
            <h2>Sign-Up Notes</h2>
            <ul>
                <li>Passwords are hashed through the local <code>AdrianHashLib</code> wrapper before XML storage.</li>
                <li>The signup flow creates member accounts only. Staff accounts remain in <code>App_Data/Staff.xml</code>.</li>
                <li>Captcha refreshes are session-backed and rendered as an image handler response.</li>
            </ul>
        </aside>
    </div>

</asp:Content>
