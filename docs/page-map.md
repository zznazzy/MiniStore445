Page0: Integrated MiniStoreWeb application

- `Default.aspx` is the main public entry page.
- `About.aspx`, `Login.aspx`, `Pages/*`, `Controls/*`, `Content/*`, `Scripts/*`, `App_Data/*`, and `bin/*` deploy together in the same application root.
- `Service1.svc` and `ShippingService.svc` stay at the Page0 root so the integrated TryIt pages can resolve them with app-relative paths.
