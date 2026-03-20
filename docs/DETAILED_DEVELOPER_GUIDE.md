# OptiZenqor Detailed Developer Guide

## 1. Purpose of This Guide

This document explains the app in a practical developer-focused way:

- what each part of the app does
- where each feature lives
- how screens, controllers, models, and services work together
- how navigation flows through the app
- how to reuse this project structure to build another Flutter app

This guide is intended to be detailed enough that you can use the same architecture as a template for your next app.

## 2. App Type

The current implementation is a Flutter shopping app.

Main user capabilities:

- open splash and auth entry
- sign in and sign up
- recover or reset password
- browse home/shop/categories
- open product details
- view favorite and cart sections
- go to checkout
- manage account pages and settings
- open support/help/review/order history drawer pages

## 3. Project Entry and Boot Flow

### 3.1 Entry Point

File: [main.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/main.dart)

What it does:

- starts the Flutter app with `runApp`
- loads the root widget `OptiZenqor`

### 3.2 Root App

File: [app.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/app.dart)

What it does:

- creates `MaterialApp`
- sets app title
- applies theme
- sets initial route
- connects the named route generator

Important properties:

- `initialRoute: AppRoute.splash`
- `onGenerateRoute: AppRoute.onGenerateRoute`

### 3.3 Route System

File: [app_route.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/app_route/app_route.dart)

What it does:

- defines all named route constants
- maps each route name to a screen
- passes route arguments into screens

This file is the navigation hub of the app.

## 4. Main Architecture

The app uses a feature-based structure.

Basic relationship:

```text
Screen -> Controller -> Service -> Model/Data
```

### 4.1 Screen

A screen is the UI layer.

Responsibilities:

- show widgets
- collect user input
- call controller methods
- navigate to other pages
- react to local state changes

Examples:

- [sign_in_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/sign_in/sign_in_screen/sign_in_screen.dart)
- [home_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/home/home_screen/home_screen.dart)
- [cart_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/cart/cart_screen/cart_screen.dart)

### 4.2 Controller

A controller prepares screen content and handles logic.

Responsibilities:

- get data from services
- expose content models
- perform actions like sign-in, search, filtering
- keep presentation logic out of widgets when possible

Examples:

- [sign_in_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/sign_in/sign_in_controller/sign_in_controller.dart)
- [home_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/home/home_controller/home_controller.dart)
- [shop_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/shop/shop_controller/shop_controller.dart)

### 4.3 Model

A model defines the shape of data.

Responsibilities:

- represent domain objects
- represent local feature state/content
- transfer data between layers

Examples:

- [product_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/product_details/product_details_model/product_model.dart)
- [category_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/product_details/product_details_model/category_model.dart)
- [cart_item_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/product_details/product_details_model/cart_item_model.dart)
- [service_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/http_mathod/service_model/service_model.dart)

### 4.4 Service

A service provides data or performs operations.

Responsibilities:

- simulate or call API endpoints
- return structured response data
- isolate backend/data logic from UI code

Examples:

- [auth_service.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/http_mathod/network_service/auth_service.dart)
- [catalog_service.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/http_mathod/network_service/catalog_service.dart)

## 5. Folder-by-Folder Explanation

### 5.1 `lib/core/`

Shared code reused across many features.

#### `core/constant/`

- [app_color.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/core/constant/app_color.dart)
- [text_style.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/core/constant/text_style.dart)

Purpose:

- centralize colors
- centralize typography and text styles

Use this folder when:

- a style is used in more than one screen
- you want consistent design across the app

#### `core/widget/`

Reusable widgets:

- [button_widget.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/core/widget/button_widget.dart)
- [text_field_widget.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/core/widget/text_field_widget.dart)
- [custom_appbar.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/core/widget/custom_appbar.dart)
- [card_widget.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/core/widget/card_widget.dart)
- [bottom_nav_bar.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/core/widget/bottom_nav_bar.dart)

Purpose:

- avoid repeating the same UI code
- keep screens smaller
- keep design consistent

### 5.2 `lib/feature/authentication/`

Contains login-related flows.

#### `splash`

Files:

- [splash_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/splash/splash_screen/splash_screen.dart)
- [splash_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/splash/splash_controller/splash_controller.dart)

How it works:

- splash screen loads first
- `initState` calls controller navigation logic after first frame
- controller decides where the app goes next

Use this pattern in another app for:

- logo loading
- token check
- onboarding decision

#### `auth_choice`

Files:

- [auth_choice_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/auth_choice/auth_choice_screen/auth_choice_screen.dart)
- [auth_choice_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/auth_choice/auth_choice_controller/auth_choice_controller.dart)

How it works:

- shows intro/auth landing page
- gives user a choice between login and signup
- uses simple navigation buttons

#### `sign_in`

Files:

- [sign_in_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/sign_in/sign_in_screen/sign_in_screen.dart)
- [sign_in_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/sign_in/sign_in_controller/sign_in_controller.dart)
- [sign_in_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/sign_in/sign_in_model/sign_in_model.dart)

How it works:

- holds form controllers for email and password
- validates inputs
- calls `SignInController.signIn`
- shows snackbar with result
- navigates to main shell on success
- optionally supports biometric login

What to copy for another app:

- form validation pattern
- async loading state pattern
- success/failure response handling

#### `sign_up`

Files:

- [sign_up_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/sign_up/sign_up_screen/sign_up_screen.dart)
- [sign_up_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/sign_up/sign_up_controller/sign_up_controller.dart)
- [sign_up_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/sign_up/sign_up_model/sign_up_model.dart)

How it works:

- collects name, email, password
- validates inputs
- calls service through controller
- navigates into main shell on success

#### `forgot_password`, `verify_code`, `reset_password`

Files:

- [forgot_password_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/forgot_password/forgot_password_screen/forgot_password_screen.dart)
- [verify_code_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/verify_code/verify_code_screen/verify_code_screen.dart)
- [reset_password_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/authentication/reset_password/reset_password_screen/reset_password_screen.dart)

How it works:

- forgot-password asks for email or phone
- verify-code accepts a 6-digit code
- reset-password handles both:
  - forgot-password completion
  - direct reset from account settings

This is a good reusable password recovery pattern for another app.

### 5.3 `lib/feature/master/navigation/`

Controls the bottom navigation shell.

Files:

- [navigation_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/navigation/navigation_screen/navigation_screen.dart)
- [navigation_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/navigation/navigation_controller/navigation_controller.dart)
- [navigation_item_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/navigation/navigation_model/navigation_item_model.dart)

How it works:

- defines tab items
- creates page list
- uses `PageView`
- switches tabs with custom bottom nav

Tabs included:

1. Home
2. Shop
3. Favorite
4. Cart
5. Account

Use this pattern in another app when:

- you need main module switching after login
- each tab is a major feature

### 5.4 `lib/feature/master/home/`

Files:

- [home_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/home/home_screen/home_screen.dart)
- [home_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/home/home_controller/home_controller.dart)
- [home_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/home/home_model/home_model.dart)

How it works:

- loads dashboard data from controller
- shows top banners using `carousel_slider`
- shows product sections like featured and popular
- supports app-bar search expansion
- sends search queries into the shop tab
- opens end drawer

Important reusable ideas:

- top-level dashboard using multiple content sections
- inline search box in app bar
- section-based horizontal lists

### 5.5 `lib/feature/master/shop/`

Files:

- [shop_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/shop/shop_screen/shop_screen.dart)
- [shop_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/shop/shop_controller/shop_controller.dart)
- [shop_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/shop/shop_model/shop_model.dart)

How it works:

- shows products from controller
- accepts optional initial query from navigation arguments
- supports search
- supports sort
- supports price/rating filters
- opens details page on product tap

Reusable pattern:

- search + filter + sort module
- receiving search query from another screen

### 5.6 `lib/feature/master/categories/`

Files:

- [categories_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/categories/categories_screen/categories_screen.dart)
- [category_detail_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/categories/category_detail_screen/category_detail_screen.dart)

How it works:

- category list is built from mock catalog data
- tapping a category opens a category-detail page
- category-detail screen loads category-based products

Use in another app when:

- you need classification-based navigation
- one dataset is filtered into multiple sections

### 5.7 `lib/feature/master/product_details/`

Files:

- [product_details_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/product_details/product_details_screen/product_details_screen.dart)
- [product_details_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/product_details/product_details_controller/product_details_controller.dart)
- [product_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/product_details/product_details_model/product_model.dart)
- [cart_item_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/product_details/product_details_model/cart_item_model.dart)
- [category_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/product_details/product_details_model/category_model.dart)

How it works:

- receives a `ProductModel` by route argument
- displays product image, name, price, rating, description
- allows quantity change
- allows add-to-cart feedback
- allows direct checkout from one product
- supports favorite toggle
- supports review bottom-sheet interaction

Important note:

- cart addition is currently UI feedback only
- full persistent cart state is not implemented yet

### 5.8 `lib/feature/master/favorite/`

Purpose:

- shows favorite section
- currently mostly demo or local UI behavior

If you copy this into another app:

- make favorites a shared global state
- store it locally or sync with backend

### 5.9 `lib/feature/master/cart/`

Files:

- [cart_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/cart/cart_screen/cart_screen.dart)
- [checkout_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/cart/cart_screen/checkout_screen.dart)
- [cart_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/cart/cart_controller/cart_controller.dart)
- [cart_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/cart/cart_model/cart_model.dart)

How cart works:

- controller prepares cart data
- cart screen lists items
- total is calculated by controller
- checkout screen receives cart items via route argument

How to improve in another app:

- use GetX shared cart controller
- save cart in local storage
- sync cart to backend after login

### 5.10 `lib/feature/master/account/`

Main file:

- [account_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/account/account_screen/account_screen.dart)

Supporting files:

- [account_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/account/account_controller/account_controller.dart)
- [account_model.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/account/account_model/account_model.dart)

What this feature currently contains:

- personal details
- edit profile
- settings
- payment method
- delivery address
- my order
- pickup point

How it works:

- main account page shows a list of actions
- each action opens another account-related page or screen
- settings contains several dedicated screens and detail pages
- reset password opens the account-specific reset flow

Important architectural note:

- this file is still too large
- the correct next refactor is to split each account subfeature into its own folder

Suggested target structure:

```text
account/
  personal_details/
  edit_profile/
  settings/
  payment_method/
  delivery_address/
  my_order/
  pickup_point/
```

### 5.11 `lib/feature/master/drawer/` and `drawer_page/`

Files:

- [drawer_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/drawer/drawer_screen/drawer_screen.dart)
- [drawer_controller.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/drawer/drawer_controller/drawer_controller.dart)
- [drawer_page_screen.dart](/Users/bdcalling/Desktop/nayamProjects/OptiZenqor/lib/feature/master/drawer_page/drawer_page_screen/drawer_page_screen.dart)

What it does:

- shows the end drawer from home and related areas
- provides shortcuts to support/help/review/about/order history/logout
- uses one page entry point and changes content based on selected title

Important note:

- this feature is also large and should eventually be split into dedicated folders like:

```text
drawer_page/
  support/
  review/
  help/
  about_us/
  order_history/
```

## 6. How Data Moves in This App

### 6.1 Auth Example

```text
SignInScreen
  -> SignInController
    -> AuthService.signIn()
      -> ServiceModel response
        -> UI snackbar + route navigation
```

### 6.2 Home Search Example

```text
HomeScreen search input
  -> _performSearch()
    -> Navigator.pushReplacementNamed(mainShell, initialIndex: 1, searchQuery)
      -> NavigationScreen
        -> ShopScreen(initialQuery)
          -> ShopController.searchProducts(query)
```

### 6.3 Product Details Example

```text
Product list tap
  -> Navigator.pushNamed(productDetails, arguments: product)
    -> ProductDetailsScreen(product)
      -> quantity change / favorite toggle / checkout / add to cart feedback
```

## 7. Reusable Design Rules You Can Copy to Another App

### Rule 1: Keep common UI in `core/`

Why:

- less duplicate code
- easier theme consistency

Examples:

- buttons
- app bars
- text fields
- cards

### Rule 2: Keep each feature inside `feature/`

Why:

- easier to scale
- easier to find files
- easier to split ownership across developers

### Rule 3: Put logic in controllers, not directly in widgets

Why:

- cleaner screen code
- easier testing
- easier refactor into GetX later

### Rule 4: Put backend or mock logic in services

Why:

- easy to replace mock data with real APIs
- UI stays independent from backend details

### Rule 5: Pass strongly typed route arguments

Examples:

- `ProductModel`
- `CategoryModel`
- `List<CartItemModel>`

Why:

- safer navigation
- less fragile than passing random maps everywhere

## 8. How to Build Another App Using This Structure

Use this project as a blueprint.

### Step 1: Create the app skeleton

Create:

```text
lib/
  main.dart
  app.dart
  app_route/
  core/
  feature/
  data/ or network/
```

### Step 2: Set app theme first

Create:

- `app_color.dart`
- `text_style.dart`
- reusable widgets for button, text field, app bar

Do this first so all screens stay consistent.

### Step 3: Define route constants

Create a route file like:

```text
app_route/app_route.dart
```

Add:

- all route names
- route argument handling
- central route builder

### Step 4: Build authentication module first

Recommended order:

1. splash
2. auth choice
3. sign in
4. sign up
5. forgot password
6. verify code
7. reset password

Why:

- auth defines entry into the rest of the app
- navigation becomes easier after auth is stable

### Step 5: Build main shell with bottom navigation

Create:

- navigation model
- navigation controller
- navigation screen
- bottom nav widget

This becomes the main container for all logged-in features.

### Step 6: Build each feature in this format

For each feature:

```text
feature_name/
  feature_name_screen/
    feature_name_screen.dart
  feature_name_controller/
    feature_name_controller.dart
  feature_name_model/
    feature_name_model.dart
```

For larger features:

```text
feature_name/
  widget/
  service/
  binding/
```

### Step 7: Build local mock services first

Why:

- helps UI development move fast
- backend can be added later

Create services like:

- auth service
- product service
- profile service
- order service

### Step 8: Add GetX when state starts crossing screens

Use GetX for:

- auth state
- cart state
- favorites state
- settings state
- user profile state

Do not overuse local `StatefulWidget` state once multiple screens depend on the same data.

### Step 9: Add storage

Use:

- `shared_preferences` for small key-value persistence
- `hive` for stronger local storage
- `flutter_secure_storage` for tokens

### Step 10: Replace mocks with API gradually

Recommended order:

1. auth
2. product list/details
3. cart
4. favorites
5. profile
6. orders

## 9. If You Want to Create a Different Type of App

This structure is not only for e-commerce.

You can reuse it for:

- food delivery app
- pharmacy app
- booking app
- productivity app
- education app
- service marketplace app

### Example conversion

If you build a food delivery app:

- `product` becomes `food_item`
- `cart` stays `cart`
- `categories` becomes `restaurant_categories`
- `order_history` stays valid
- `support` stays valid
- `profile/settings` stay valid

That is why the feature-based structure is powerful.

## 10. Recommended Professional Refactor of This Project

If this app is going to grow, reorganize it like this:

```text
lib/
  app/
    app.dart
    app_routes.dart
    bindings/
  core/
    constants/
    theme/
    widgets/
    utils/
  data/
    services/
    models/
    repositories/
  feature/
    authentication/
      sign_in/
      sign_up/
      forgot_password/
    home/
    shop/
    product/
    cart/
    favorites/
    account/
      personal_details/
      edit_profile/
      settings/
      payment_method/
      orders/
      address/
  shared/
```

### With GetX

Recommended extra structure:

```text
feature_name/
  controller/
  model/
  screen/
  binding/
  widget/
```

Use bindings to register:

- controllers
- repositories
- services

## 11. Current Gaps You Should Know Before Reusing This As-Is

- many services are still mock implementations
- cart is not yet a real shared state
- favorites are not persisted
- account feature is too large
- drawer page feature is too large
- some flows still use placeholder content
- storage is not yet production-ready

So the structure is reusable, but some modules still need hardening before production.

## 12. Best Next Steps

If you want this app to become a reusable professional template, the next steps should be:

1. rename `http_mathod`
2. split `account_screen.dart` into subfeatures
3. split `drawer_page_screen.dart` into subfeatures
4. add GetX
5. create global controllers for auth/cart/favorites/profile
6. add local persistence
7. add repository layer
8. replace mock services with real API services

## 13. Final Blueprint Summary

To create another app using this instruction, follow this exact pattern:

1. create `main.dart`, `app.dart`, and route file
2. create `core/` for shared theme and widgets
3. create feature folders with `screen`, `controller`, and `model`
4. create services for mock or backend data
5. connect screens through named routes
6. use route arguments to pass models
7. build one main navigation shell after login
8. move shared states to GetX when the app grows
9. add local storage and secure token storage
10. replace mock services with repositories and APIs

This project already gives you a strong starting pattern. With the refactors above, it can become a reusable starter architecture for future Flutter apps.
