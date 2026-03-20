# OptiZenqor App Documentation

## 1. Overview

`OptiZenqor` is a Flutter mobile application that currently behaves as an e-commerce style shopping app branded in the UI as `Shob Bazaar`.

Although `pubspec.yaml` describes it as a productivity dashboard, the implementation in `lib/` is a shopping application with:

- authentication flows
- home dashboard
- category browsing
- shop and search
- favorite list
- cart and checkout
- product details
- account and settings
- support, help, review, and order history pages

This document describes the app as it is currently implemented in the codebase.

## 2. Tech Stack

- Framework: Flutter
- Language: Dart
- SDK: `^3.10.8`
- Design system: Material 3

### Main Dependencies

- `carousel_slider`: banner/product carousel support
- `circle_nav_bar`: navigation UI support
- `image_picker`: profile image/photo selection
- `local_auth`: biometric-related support
- `url_launcher`: email and phone redirection to device apps

## 3. App Identity

- Package name: `optizenqor`
- App title in code: `Shob Bazaar`
- Root widget: `OptiZenqor`
- Entry point: [`main.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/main.dart)
- App shell: [`app.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/app.dart)

## 4. High-Level Architecture

The app follows a lightweight feature-based Flutter structure:

```text
lib/
  app.dart
  main.dart
  app_route/
  core/
  feature/
    authentication/
    master/
  http_mathod/
```

### Architectural Pattern

Most features follow a simple separation of:

- `screen`: UI rendering and interaction handling
- `controller`: presentation/business logic and screen content setup
- `model`: local data structures

This is not full MVVM or BLoC. It is a controller-driven feature structure with local widget state where needed.

## 4.1 Architecture Diagram

```text
UI Layer (Screens / Widgets)
        |
        v
Controller Layer
        |
        v
Service Layer (Mock Services / Future API Services)
        |
        v
Data Source Layer (Local Storage / Remote API)
```

### Layer Responsibilities

- UI Layer: renders screens, handles user input, and updates views
- Controller Layer: manages feature logic and screen interaction
- Service Layer: handles auth, catalog, and future backend operations
- Data Source Layer: local persistence and remote API communication

## 5. Folder Structure

### Root Application Layer

- [`lib/main.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/main.dart): app startup
- [`lib/app.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/app.dart): `MaterialApp`, theme, routes
- [`lib/app_route/app_route.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/app_route/app_route.dart): named route configuration

### Core Layer

- `core/constant/`: colors and text styles
- `core/widget/`: reusable widgets like buttons, fields, app bars, cards, and bottom navigation
- `core/asset_path/`: image/icon path helpers
- `core/api_endpoint/`: API endpoint placeholder

### Feature Layer

#### `feature/authentication/`

- `splash`
- `auth_choice`
- `sign_in`
- `sign_up`
- `forgot_password`
- `verify_code`
- `reset_password`

#### `feature/master/`

- `home`
- `shop`
- `favorite`
- `cart`
- `categories`
- `offer`
- `product_details`
- `navigation`
- `drawer`
- `drawer_page`
- `account`

### Service Layer

- [`http_mathod/network_service/auth_service.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/http_mathod/network_service/auth_service.dart): mock auth API behavior
- [`http_mathod/network_service/catalog_service.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/http_mathod/network_service/catalog_service.dart): mock product/category data
- `network_service.dart`: generic network placeholder
- `service_model.dart`: shared response model

## 6. Application Flow

### Startup Flow

1. App starts from `main()`
2. `OptiZenqor` loads `MaterialApp`
3. Initial route is `AppRoute.splash`
4. Splash leads users into authentication and then the main shell

### Post-Login Flow

After successful sign-in or sign-up, the app navigates into `mainShell`, which renders the bottom-navigation layout.

## 7. Main Navigation

The bottom navigation is defined in [`navigation_controller.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/navigation/navigation_controller/navigation_controller.dart).

### Main Tabs

1. Home
2. Shop
3. Favorite
4. Cart
5. Account

The main shell is implemented in [`navigation_screen.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/navigation/navigation_screen/navigation_screen.dart) using:

- `PageView`
- a custom bottom navigation widget
- programmatic page switching

## 8. Route Documentation

Defined in [`app_route.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/app_route/app_route.dart).

### Authentication Routes

- `/` -> Splash
- `/auth-choice` -> Authentication selection
- `/sign-in` -> Sign in
- `/sign-up` -> Sign up
- `/forgot-password` -> Forgot password
- `/verify-code` -> Reset code verification
- `/reset-password` -> Reset password

### Main Application Routes

- `/main-shell` -> Bottom navigation shell
- `/categories` -> Categories listing
- `/category-details` -> Category-based products
- `/offer` -> Offers page
- `/drawer-page` -> Drawer detail pages
- `/product-details` -> Single product details
- `/checkout` -> Checkout screen

### Route Arguments

- `verifyCode`: optional account string
- `resetPassword`: string account or map with `account` and `fromAccount`
- `mainShell`: `initialIndex` and optional `searchQuery`
- `categoryDetails`: `CategoryModel`
- `drawerPage`: page title string
- `productDetails`: `ProductModel`
- `checkout`: list of `CartItemModel`

## 9. Feature Documentation

### 9.1 Authentication

Located in `lib/feature/authentication/`.

#### Included Screens

- splash
- auth choice
- sign in
- sign up
- forgot password
- verification code
- reset password

#### Behavior

- Sign in and sign up call mock methods in `AuthService`
- Forgot password sends a mock code
- Verify code expects `123456`
- Reset password supports two entry cases:
  - account recovery flow after code verification
  - direct reset from account settings using `fromAccount: true`

#### Notes

- Backend integration is mocked
- No token persistence or secure session storage is currently implemented

### 9.2 Home

Located in `lib/feature/master/home/`.

#### Responsibilities

- shows banners
- displays featured and popular products
- supports search input and suggestions
- can redirect search into the Shop tab through `mainShell`
- opens the end drawer

#### Data Source

- `HomeController`
- `CatalogService`

### 9.3 Shop

Located in `lib/feature/master/shop/`.

#### Responsibilities

- product browsing
- search-driven filtering
- entry from Home search flow

### 9.4 Categories

Located in `lib/feature/master/categories/`.

#### Responsibilities

- category listing
- category detail pages
- product filtering by category id

#### Data Source

- `CatalogService.getCategories()`
- `CatalogService.getProductsByCategory(categoryId)`

### 9.5 Product Details

Located in `lib/feature/master/product_details/`.

#### Responsibilities

- render product details
- represent product/cart/category models
- allow product navigation from lists across the app

### 9.6 Favorite

Located in `lib/feature/master/favorite/`.

#### Responsibilities

- display favorite products
- manage favorite view state at UI level

### 9.7 Cart and Checkout

Located in `lib/feature/master/cart/`.

#### Responsibilities

- cart viewing
- line item handling
- checkout screen rendering

### 9.8 Account

Located in `lib/feature/master/account/`.

#### Responsibilities

- personal details
- edit profile
- settings
- payment method
- delivery address
- my order
- pickup point

#### Current State

The account feature contains a large amount of logic inside [`account_screen.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/account/account_screen/account_screen.dart). It now includes dedicated sub-screens for several settings-related actions, but the file is still monolithic and would benefit from being split into smaller feature folders.

### 9.9 Drawer and Drawer Pages

Located in:

- `feature/master/drawer/`
- `feature/master/drawer_page/`

#### Drawer Items

Configured by [`drawer_controller.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/drawer/drawer_controller/drawer_controller.dart):

- Order History
- Support
- Review
- Help
- About Us
- Logout

#### Support Behavior

Support email and phone actions use `url_launcher` to open:

- device email app via `mailto:`
- device phone dialer via `tel:`

## 10. Data Models

### Authentication Models

- sign-in model
- sign-up model
- forgot-password model
- verify-code model
- reset-password model
- auth-choice model
- splash model

### Commerce Models

- `ProductModel`
- `CategoryModel`
- `CartItemModel`
- cart and account local models
- drawer page local models

### Shared Models

- `ServiceModel<T>` for service responses

## 11. Service Layer Documentation

### AuthService

File: [`auth_service.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/http_mathod/network_service/auth_service.dart)

#### Methods

- `signIn(email, password)`
- `signUp(name, email, password)`
- `requestPasswordReset(account)`
- `verifyResetCode(code)`
- `resetPassword(password)`

#### Current Behavior

- all methods are mocked
- all requests simulate delay with `Future.delayed`
- reset code is hardcoded to `123456`
- no real HTTP API is connected

### CatalogService

File: [`catalog_service.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/http_mathod/network_service/catalog_service.dart)

#### Responsibilities

- provide category list
- provide product list
- provide featured products
- provide category-filtered products

#### Current Behavior

- uses local in-memory mock data
- product and category content is hardcoded
- no pagination, remote fetch, or caching layer

## 11.1 Planned API Contract

The app is currently mock-based, but the following API design is recommended for backend readiness.

### Auth

- `POST /auth/login`
- `POST /auth/register`
- `POST /auth/forgot-password`
- `POST /auth/verify-code`
- `POST /auth/reset-password`
- `POST /auth/logout`

### User Profile

- `GET /user/profile`
- `PUT /user/profile`
- `PUT /user/settings`

### Products

- `GET /products`
- `GET /products/:id`
- `GET /categories`
- `GET /categories/:id/products`
- `GET /products/search?q=...`

### Favorites

- `GET /favorites`
- `POST /favorites`
- `DELETE /favorites/:productId`

### Cart

- `GET /cart`
- `POST /cart`
- `PUT /cart/:itemId`
- `DELETE /cart/:itemId`

### Orders

- `GET /orders`
- `GET /orders/:id`
- `POST /orders`

### Support

- `POST /support/message`
- `GET /support/tickets`

## 11.2 Example Data Flow

### Add to Cart Flow

1. user taps `Add to Cart`
2. product data is passed from UI to controller
3. controller validates and updates cart state
4. UI rebuilds with updated cart info
5. future version syncs cart with local storage or backend

### Reset Password Flow

1. user starts account reset or forgot-password flow
2. input is validated in UI/controller
3. service verifies code or accepts new password
4. reset password state is updated
5. UI navigates according to the entry path

## 12. Theme and UI System

### Theme Source

- [`app.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/app.dart)

### Styling Files

- [`app_color.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/core/constant/app_color.dart)
- [`text_style.dart`](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/core/constant/text_style.dart)

### Shared Widgets

- custom app bar
- reusable button
- reusable text field
- card widget
- custom bottom navigation

## 12.1 Error Handling Strategy

Current error handling is basic and mostly UI-level.

### Current Pattern

- form validation for invalid input
- snackbars for success/failure messages
- route fallback for unknown pages

### Recommended Production Pattern

- network failure -> retryable error UI
- validation failure -> inline field-level error text
- API failure -> mapped error model and consistent feedback
- timeout -> retry option with graceful fallback
- empty data -> dedicated empty-state components

## 12.2 Security Considerations

- use `flutter_secure_storage` for auth tokens
- do not store passwords locally
- require HTTPS for production API traffic
- validate and sanitize user input before submission
- protect sensitive account actions with authenticated session checks

## 12.3 Performance Considerations

- prefer `const` widgets where possible
- reduce unnecessary rebuilds
- move shared app state out of isolated widget trees
- add pagination for larger product lists in future versions
- optimize remote image loading and scrolling lists

## 12.4 Environment Setup

Recommended environments:

- development
- staging
- production

Suggested environment variables:

- `API_BASE_URL`
- `APP_ENV`
- `ENABLE_LOGGING`
- `SUPPORT_EMAIL`
- `SUPPORT_PHONE`

## 13. State Management Approach

The app currently uses:

- `StatefulWidget` local state
- simple controllers for screen data
- no global state management library like Provider, Bloc, or GetX

### Implication

This keeps the app simple, but larger features may become harder to maintain as the codebase grows.

## 13.1 Future State Management Plan

Recommended direction: `GetX`

### Why GetX

- simple reactive state management with low boilerplate
- built-in support for dependency injection and navigation
- suitable for cross-screen shared state in this app
- easier migration path from the current controller-based structure

### Planned Global States

- authentication state
- cart state
- favorites/wishlist state
- user profile state
- settings and preferences state

### Migration Direction

1. add `get` package
2. convert shared feature controllers into GetX controllers
3. centralize auth, cart, favorites, and profile state
4. register services/controllers through GetX dependency management

## 14. Current Strengths

- clear feature-based folder grouping
- reusable route system
- consistent theme setup
- mock service layer separated from UI
- easy to run and demo without backend dependency
- account settings and support actions have been improved with working navigation and device integrations

## 15. Current Limitations

### Functional Limitations

- authentication is mock-only
- catalog is mock-only
- no database or API integration
- no persistent login/session storage
- no local persistence for many settings
- many screens still use static/demo data
- no centralized global state
- no formal shared error-state pattern

### Structural Limitations

- some large files contain multiple screens in one file, especially account and drawer page features
- folder naming includes `http_mathod`, which appears to be a typo for `http_method`
- app branding and package description do not fully match the implemented shopping use case
- controllers often create services directly, which makes testing and replacement harder

### UX Limitations

- some pages are placeholders or detail stubs
- some flows are not yet connected to real backend actions
- not all settings are persisted after restart
- loading, empty, and error states are not consistent across all features

## 16. Recommended Refactor Direction

For long-term maintainability, each major feature should move toward its own folder with internal structure like:

```text
feature_name/
  feature_name_screen/
    feature_name_screen.dart
  feature_name_controller/
    feature_name_controller.dart
  feature_name_model/
    feature_name_model.dart
```

For larger features, add:

```text
feature_name/
  widget/
  service/
  state/
```

### Priority Refactor Targets

1. split `account_screen.dart`
2. split `drawer_page_screen.dart`
3. unify naming conventions
4. move mock services behind repository/service abstractions
5. add persistent state for profile/settings/cart
6. adopt GetX for shared state and dependency management
7. add local persistence for auth, cart, settings, and favorites
8. prepare the service layer for real API integration

## 16.1 Improvement Roadmap

### Phase 1: Quick Wins

- rename `http_mathod` to `network` or `data`
- split large account and drawer feature files
- add shared loading, empty, and error-state widgets
- add local persistence for login, cart, and settings

### Phase 2: State Management Upgrade

- introduce `GetX`
- create shared controllers for auth, cart, favorites, and profile
- replace isolated widget-only state where cross-screen sync is needed
- register dependencies using GetX injection

### Phase 3: Backend Readiness

- introduce an API client such as `dio`
- define request/response DTOs
- replace mock services with API-backed implementations
- add secure token handling

### Phase 4: Scaling

- pagination
- optimized search
- caching
- analytics and notifications

## 17. How to Run

### Requirements

- Flutter SDK compatible with Dart `^3.10.8`
- Android Studio, VS Code, or Xcode/Android toolchain

### Commands

```bash
flutter pub get
flutter run
```

### Useful Verification

```bash
flutter analyze
flutter test
```

## 18. Suggested Next Documentation Files

To make the project easier to maintain, consider adding:

- `docs/ROUTE_MAP.md`
- `docs/FEATURES.md`
- `docs/ARCHITECTURE.md`
- `docs/API_INTEGRATION_PLAN.md`
- `docs/REFACTOR_PLAN.md`

## 19. Summary

This app is currently a Flutter shopping application with mock authentication, mock catalog data, bottom-tab navigation, product browsing, cart flow, account/settings management, and support/help drawer pages.

The project already has a useful feature-based foundation. The biggest next improvements are:

- splitting large feature files into dedicated feature folders
- replacing mock services with real backend integration
- persisting user/account/settings/cart data
- aligning project naming, branding, and structure
