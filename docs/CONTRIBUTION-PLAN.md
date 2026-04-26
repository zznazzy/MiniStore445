# MiniStore445 Contribution Plan

## Team

- Bella Rayner
- Adrian

## Current Contribution Split

- Bella Rayner: 55%
- Adrian: 45%

## Integrated Application Summary

MiniStore445 is an ASP.NET Web Forms storefront application with:

- a public landing page and XML-backed product browsing
- forms authentication for members and staff
- self-enrollment with captcha for members
- protected member and staff pages
- session cart, checkout, order confirmation, and previous-order history
- Bella and Adrian service/demo pages

## Bella-Owned Components

- `MiniStoreWeb/Default.aspx` and storefront UI flow
- `MiniStoreWeb/Controls/FeaturedProducts.ascx`
- `MiniStoreWeb/Global.asax`
- `MiniStoreWeb/Pages/GlobalDemo.aspx`
- `BellaStoreService/`
- `MiniStoreWeb/Pages/BellaTryIt.aspx`
- `MiniStoreWeb/About.aspx`
- `MiniStoreWeb/Login.aspx`
- `MiniStoreWeb/Pages/SignUp.aspx`
- `MiniStoreWeb/Pages/Member.aspx`
- `MiniStoreWeb/Pages/Staff.aspx`
- `MiniStoreWeb/Pages/Cart.aspx`
- `MiniStoreWeb/Pages/Checkout.aspx`
- `MiniStoreWeb/Pages/OrderConfirmation.aspx`
- `MiniStoreWeb/Pages/OrderDetails.aspx`
- `MiniStoreWeb/App_Data/Products.xml`
- `MiniStoreWeb/App_Data/Member.xml`
- `MiniStoreWeb/App_Data/Staff.xml`
- `MiniStoreWeb/App_Data/Orders.xml`

## Adrian-Owned Components

- `AdrianHashLib/`
- `AdrianStoreService/`
- `MiniStoreWeb/Pages/AdrianDemo.aspx`
- `MiniStoreWeb/Helpers/CartState.cs`

## Adrian Follow-Up Items

- keep the standalone deployed `ShippingService.svc` endpoint compatible with the shared `CalculateShipping(decimal subtotal, string region)` contract
- verify the Adrian demo against the final remote endpoint after deployment
- extend Adrian-owned service behavior only through the existing shared client path so the integrated site stays stable

## Shared Integration Notes

- password hashing is routed through `MiniStoreWeb/Helpers/PasswordSecurity.cs`, which wraps `AdrianHashLib`
- checkout pricing uses Bella discount logic and Adrian shipping logic together
- WebStrar deployment is staged as a single integrated `Page0` application
