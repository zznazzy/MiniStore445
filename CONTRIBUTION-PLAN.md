# MiniStore445 Contribution Plan

## Team Members

- **Bella Rayner**
- **Adrian**

## App Concept

A **mini online store** with sample products.

The app will start as a public-facing store demo for **Assignment 5** and expand into a member/staff store system for **Assignment 6**.

## Main Division of Labor

### Bella
- `Default.aspx`
- Service Directory / TryIt page
- `Global.asax` event handler
- User control
- One web service

### Adrian
- DLL library for hashing or encryption/decryption
- Cookie / session state component
- One web service
- Integration help

## Planned Project Structure

```text
MiniStore445/
  README.md
  contribution-plan.md
  .gitignore
  MiniStore445.sln
  src/
    MiniStoreWeb/
      Default.aspx
      Default.aspx.cs
      Web.config
      Global.asax
      App_Data/
        Products.xml
        Member.xml
        Staff.xml
      Controls/
        FeaturedProducts.ascx
        FeaturedProducts.ascx.cs
      Pages/
        BellaTryIt.aspx
        BellaTryIt.aspx.cs
        GlobalDemo.aspx
        GlobalDemo.aspx.cs
        Member.aspx
        Member.aspx.cs
        Staff.aspx
        Staff.aspx.cs
    BellaStoreService/
    AdrianStoreService/
    AdrianHashLib/
  docs/
  submission/
```
## Bella Deliverables

### 1. `Default.aspx`
- public landing page
- store description
- testing instructions
- buttons or links to **Member** and **Staff** pages
- service directory table
- links to TryIt pages

### 2. User Control
- `FeaturedProducts.ascx`
- displays a few sample products from `Products.xml`

### 3. `Global.asax`
- `Application_Start` stores app start time
- `Session_Start` increments visitor count

### 4. Global Demo Page
- shows app start time
- shows visitor count
- gives a visible way to test the `Global.asax` logic

### 5. Bella Web Service

Possible idea:
- **discount calculator service**

or

- **product recommendation/filter service**

### 6. Bella TryIt Page
- input boxes
- call Bella service
- show output clearly

## Adrian Deliverables

### 1. DLL Library
- hash or encryption/decryption helper for passwords

### 2. Cookie / Session Component

Possible uses:
- save username
- save cart count
- save recent product view

### 3. Adrian Web Service

Possible idea:
- **shipping estimator**

or

- **tax estimator**

or

- **category search helper**

### 4. Adrian TryIt Hook
- visible button or page that proves his DLL and cookie/session work

## Shared Later for Assignment 6

- Member page
- Staff page
- Forms authentication and authorization
- XML account storage
- product management
- final integration
- full deployment

## Suggested File Ownership

### Bella-owned
- `src/MiniStoreWeb/Default.aspx`
- `src/MiniStoreWeb/Default.aspx.cs`
- `src/MiniStoreWeb/Global.asax`
- `src/MiniStoreWeb/Controls/FeaturedProducts.ascx`
- `src/MiniStoreWeb/Controls/FeaturedProducts.ascx.cs`
- `src/MiniStoreWeb/Pages/BellaTryIt.aspx`
- `src/MiniStoreWeb/Pages/BellaTryIt.aspx.cs`
- `src/MiniStoreWeb/Pages/GlobalDemo.aspx`
- `src/MiniStoreWeb/Pages/GlobalDemo.aspx.cs`
- `src/BellaStoreService/`

### Adrian-owned
- `src/AdrianHashLib/`
- `src/AdrianStoreService/`
- cookie/session code inside `MiniStoreWeb`

### Shared later
- `Member.aspx`
- `Staff.aspx`
- auth flow
- XML wiring
- summary table
- deployment packaging

## Initial Product Data

`Products.xml` will contain a small set of fake sample products such as:
- notebook
- pen set
- sticker pack
- mug
- tote bag
- hoodie
- keychain
- bookmark

## Workflow

1. Bella creates the base solution and repo structure.
2. Bella commits the initial skeleton.
3. Adrian clones the repo and creates his branch.
4. Bella works in her branch.
5. Adrian works in his branch.
6. Merge only after code compiles and runs.

## Branch Names

- `main`
- `bella-default-global-usercontrol-service`
- `adrian-dll-cookie-service`

## Rules

- `main` should always compile
- do not commit `.vs`, `bin`, `obj`, `packages`, or user-specific files
- keep component ownership clear
- do not hardcode deployment URLs
- use relative links where possible

## Assignment 5 Target

Bella should have a working:
- `Default.aspx`
- user control
- `Global.asax` demo
- Bella service with a TryIt page

Adrian should have a working:
- DLL
- cookie/session component
- Adrian service with a visible demo path

## Assignment 6 Target

Integrated store app with:
- Default page
- Member page
- Staff page
- Forms auth
- XML storage
- full deployment

  
