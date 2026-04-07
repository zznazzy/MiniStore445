
# MiniStore445 Contribution Plan

## Team

* Bella Rayner
* Adrian Simon

## Project Overview

MiniStore445 is a lightweight ASP.NET Web Forms application that simulates a small online store.

Assignment 5 focuses on:

* public-facing functionality
* component implementation
* service integration

Assignment 6 builds on this with:

* authentication
* protected pages
* full system integration

---

## Responsibilities

### Bella

* Core web app structure and UI
* Featured products pipeline (XML → UI)
* Global state handling (`Global.asax`)
* Bella web service + TryIt page
* Navigation + baseline UX

### Adrian

* Supporting backend components
* Security/utilities (DLL)
* Session/cookie behavior
* Adrian web service + demo surface
* Integration + extension work

---

## Project Structure

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

---

## Current State (Post–Bella A5)

The application currently includes:

* functional landing page (`Default.aspx`)
* product display via XML-backed user control
* product images + basic styling
* search and category filtering
* working Global.asax demo page
* Bella service + TryIt page
* navigation across all pages
* placeholder Member/Staff pages
* components summary page

This is considered the **baseline build**.

---

## Adrian Scope (Assignment 5)

Adrian’s work should introduce:

### DLL (required)

* hashing or encryption/decryption helper
* intended for later use in authentication

### Session / Cookie Logic

* lightweight state usage inside `MiniStoreWeb`
* examples:

  * cart count
  * remembered user
  * recent product tracking

### Web Service

* independent service with clear functionality
  (shipping, tax, filtering, etc.)

### Demo Surface

* visible way to interact with the above
  (page, button, or integration point)

---

## Optional Enhancements (Adrian-owned)

If time allows, Adrian can extend the app with:

* basic cart system (session-based)
* additional UI polish
* improved layout or styling consistency
* WebStrar deployment setup
* small UX improvements that don’t break structure

---

## Ownership

### Bella-owned

* `MiniStoreWeb/Default.aspx`
* `Global.asax`
* `FeaturedProducts` control
* Bella service + TryIt
* base UI + navigation

### Adrian-owned

* `AdrianHashLib/`
* `AdrianStoreService/`
* session/cookie logic
* any cart implementation

### Shared (Assignment 6)

* authentication flow
* Member/Staff functionality
* XML account handling
* deployment packaging
* final integration

---

## Workflow

* work in separate branches
* keep `main` stable and buildable
* merge only when features are working
* avoid overlapping edits unless coordinated

Suggested branches:

* `bella-core`
* `adrian-services`

---

## Constraints

* no hardcoded deployment URLs
* use relative paths
* avoid breaking navigation
* keep project structure intact

---

## Assignment 5 Target

A working system where:

* core pages load without errors
* Bella’s components are complete and testable
* Adrian’s components are independently functional
* all demo paths are visible and usable

---

## Assignment 6 Direction

Next phase will introduce:

* authentication (Forms Auth)
* role separation (Member vs Staff)
* protected routes
* persistent data via XML
* full system integration
