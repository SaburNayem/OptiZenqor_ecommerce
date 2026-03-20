# OptiZenqor Target Feature Architecture

## 1. Purpose

This document defines the target refactored project structure for the app.

This is not the current monolithic structure.

This is the structure the app should follow after refactor:

- every feature in a separate folder
- every feature has its own `screen`, `controller`, and `model`
- large features can also have `binding`, `widget`, and `service`

This document should be used as the architecture rule for future development.

## 2. Core Rule

Every feature must be isolated.

Required structure:

```text
feature_name/
  feature_name_screen/
    feature_name_screen.dart
  feature_name_controller/
    feature_name_controller.dart
  feature_name_model/
    feature_name_model.dart
```

Optional structure for larger features:

```text
feature_name/
  feature_name_screen/
  feature_name_controller/
  feature_name_model/
  feature_name_binding/
  feature_name_widget/
  feature_name_service/
```

## 3. Full Target Project Structure

```text
lib/
  main.dart
  app.dart
  app_route/
    app_route.dart

  core/
    constant/
      app_color.dart
      text_style.dart
    widget/
      bottom_nav_bar.dart
      button_widget.dart
      card_widget.dart
      custom_appbar.dart
      text_field_widget.dart
    utils/
    theme/

  data/
    service/
      auth_service.dart
      catalog_service.dart
      profile_service.dart
      order_service.dart
    repository/
      auth_repository.dart
      catalog_repository.dart
      cart_repository.dart
      profile_repository.dart
    model/
      service_model.dart

  feature/
    authentication/
      splash/
        splash_screen/
          splash_screen.dart
        splash_controller/
          splash_controller.dart
        splash_model/
          splash_model.dart

      auth_choice/
        auth_choice_screen/
          auth_choice_screen.dart
        auth_choice_controller/
          auth_choice_controller.dart
        auth_choice_model/
          auth_choice_model.dart

      sign_in/
        sign_in_screen/
          sign_in_screen.dart
        sign_in_controller/
          sign_in_controller.dart
        sign_in_model/
          sign_in_model.dart

      sign_up/
        sign_up_screen/
          sign_up_screen.dart
        sign_up_controller/
          sign_up_controller.dart
        sign_up_model/
          sign_up_model.dart

      forgot_password/
        forgot_password_screen/
          forgot_password_screen.dart
        forgot_password_controller/
          forgot_password_controller.dart
        forgot_password_model/
          forgot_password_model.dart

      verify_code/
        verify_code_screen/
          verify_code_screen.dart
        verify_code_controller/
          verify_code_controller.dart
        verify_code_model/
          verify_code_model.dart

      reset_password/
        reset_password_screen/
          reset_password_screen.dart
        reset_password_controller/
          reset_password_controller.dart
        reset_password_model/
          reset_password_model.dart

    master/
      navigation/
        navigation_screen/
          navigation_screen.dart
        navigation_controller/
          navigation_controller.dart
        navigation_model/
          navigation_item_model.dart

      home/
        home_screen/
          home_screen.dart
        home_controller/
          home_controller.dart
        home_model/
          home_model.dart
        home_widget/

      shop/
        shop_screen/
          shop_screen.dart
        shop_controller/
          shop_controller.dart
        shop_model/
          shop_model.dart
        shop_widget/

      categories/
        categories_screen/
          categories_screen.dart
        categories_controller/
          categories_controller.dart
        categories_model/
          categories_model.dart

      category_detail/
        category_detail_screen/
          category_detail_screen.dart
        category_detail_controller/
          category_detail_controller.dart
        category_detail_model/
          category_detail_model.dart

      product_details/
        product_details_screen/
          product_details_screen.dart
        product_details_controller/
          product_details_controller.dart
        product_details_model/
          product_model.dart
          cart_item_model.dart
          category_model.dart
        product_details_widget/

      favorite/
        favorite_screen/
          favorite_screen.dart
        favorite_controller/
          favorite_controller.dart
        favorite_model/
          favorite_model.dart

      cart/
        cart_screen/
          cart_screen.dart
        cart_controller/
          cart_controller.dart
        cart_model/
          cart_model.dart

      checkout/
        checkout_screen/
          checkout_screen.dart
        checkout_controller/
          checkout_controller.dart
        checkout_model/
          checkout_model.dart

      offer/
        offer_screen/
          offer_screen.dart
        offer_controller/
          offer_controller.dart
        offer_model/
          offer_model.dart

      drawer/
        drawer_screen/
          drawer_screen.dart
        drawer_controller/
          drawer_controller.dart
        drawer_model/
          drawer_model.dart

      drawer_page/
        order_history/
          order_history_screen/
            order_history_screen.dart
          order_history_controller/
            order_history_controller.dart
          order_history_model/
            order_history_model.dart

        support/
          support_screen/
            support_screen.dart
          support_controller/
            support_controller.dart
          support_model/
            support_model.dart

        review/
          review_screen/
            review_screen.dart
          review_controller/
            review_controller.dart
          review_model/
            review_model.dart

        help/
          help_screen/
            help_screen.dart
          help_controller/
            help_controller.dart
          help_model/
            help_model.dart

        about_us/
          about_us_screen/
            about_us_screen.dart
          about_us_controller/
            about_us_controller.dart
          about_us_model/
            about_us_model.dart

      account/
        account_screen/
          account_screen.dart
        account_controller/
          account_controller.dart
        account_model/
          account_model.dart

        personal_details/
          personal_details_screen/
            personal_details_screen.dart
          personal_details_controller/
            personal_details_controller.dart
          personal_details_model/
            personal_details_model.dart

        edit_profile/
          edit_profile_screen/
            edit_profile_screen.dart
          edit_profile_controller/
            edit_profile_controller.dart
          edit_profile_model/
            edit_profile_model.dart

        settings/
          settings_screen/
            settings_screen.dart
          settings_controller/
            settings_controller.dart
          settings_model/
            settings_model.dart

        payment_method/
          payment_method_screen/
            payment_method_screen.dart
          payment_method_controller/
            payment_method_controller.dart
          payment_method_model/
            payment_method_model.dart

        delivery_address/
          delivery_address_screen/
            delivery_address_screen.dart
          delivery_address_controller/
            delivery_address_controller.dart
          delivery_address_model/
            delivery_address_model.dart

        my_order/
          my_order_screen/
            my_order_screen.dart
          my_order_controller/
            my_order_controller.dart
          my_order_model/
            my_order_model.dart

        pickup_point/
          pickup_point_screen/
            pickup_point_screen.dart
          pickup_point_controller/
            pickup_point_controller.dart
          pickup_point_model/
            pickup_point_model.dart
```

## 4. Feature-by-Feature Rule

Every feature must follow the same logic:

- `screen`: UI only
- `controller`: logic only
- `model`: data only

### 4.1 Screen Folder

Example:

```text
settings_screen/
  settings_screen.dart
```

Responsibilities:

- render widgets
- collect user input
- call controller methods
- navigate
- listen to reactive state

Do not put:

- API code
- heavy business logic
- storage logic

### 4.2 Controller Folder

Example:

```text
settings_controller/
  settings_controller.dart
```

Responsibilities:

- screen logic
- state changes
- validation
- calling repository/service
- exposing observables if using GetX

Do not put:

- big widget trees
- direct UI layout code

### 4.3 Model Folder

Example:

```text
settings_model/
  settings_model.dart
```

Responsibilities:

- data classes
- feature content models
- request/response models if feature-specific

## 5. How Each Current Feature Should Be Split

### 5.1 Authentication

Each auth flow becomes a separate feature folder:

- `splash`
- `auth_choice`
- `sign_in`
- `sign_up`
- `forgot_password`
- `verify_code`
- `reset_password`

Each of these must independently contain:

- screen
- controller
- model

### 5.2 Home

`home/` should contain:

- home screen
- home controller
- home model
- optional `home_widget/` for banners, sections, chips, or product strips

### 5.3 Shop

`shop/` should contain:

- shop screen
- shop controller
- shop model
- optional shop widgets for search, filter panel, sort actions

### 5.4 Categories

Do not keep category and category detail mixed forever.

Use:

- `categories/`
- `category_detail/`

because they are different responsibilities.

### 5.5 Product Details

Keep `product_details/` separate because it has its own:

- UI
- quantity logic
- review logic
- favorite logic
- checkout entry logic

### 5.6 Cart and Checkout

These should be split into:

- `cart/`
- `checkout/`

because checkout is a separate flow and may grow much larger later.

### 5.7 Account

Do not keep everything inside one account file.

Use:

- `account/` for main account dashboard
- `personal_details/`
- `edit_profile/`
- `settings/`
- `payment_method/`
- `delivery_address/`
- `my_order/`
- `pickup_point/`

Each of those must have its own screen, controller, and model folder.

### 5.8 Drawer Pages

Do not keep support, review, help, about, and order history in one file.

Use:

- `order_history/`
- `support/`
- `review/`
- `help/`
- `about_us/`

Each becomes its own feature module.

## 6. GetX Structure Rule

If you use GetX, each feature can also include:

```text
feature_name/
  feature_name_binding/
    feature_name_binding.dart
```

Purpose:

- register controllers
- register repositories
- register services

Recommended structure with GetX:

```text
feature_name/
  feature_name_screen/
  feature_name_controller/
  feature_name_model/
  feature_name_binding/
  feature_name_widget/
```

## 7. Naming Rules

Use consistent naming everywhere.

### Folder Naming

- lowercase
- underscore separated
- descriptive

Examples:

- `personal_details`
- `edit_profile`
- `payment_method`

### File Naming

Always match folder purpose.

Examples:

- `personal_details_screen.dart`
- `personal_details_controller.dart`
- `personal_details_model.dart`

Bad practice:

- putting multiple unrelated screens inside one file
- generic names like `screen.dart`
- mixing feature logic into another feature file

## 8. Development Rule Going Forward

When creating any new feature, follow this checklist:

1. create a new feature folder
2. create `screen` folder and file
3. create `controller` folder and file
4. create `model` folder and file
5. add route entry if it is navigable
6. add binding if using GetX
7. move reusable parts into feature widgets if needed

Example:

```text
wishlist/
  wishlist_screen/
    wishlist_screen.dart
  wishlist_controller/
    wishlist_controller.dart
  wishlist_model/
    wishlist_model.dart
  wishlist_binding/
    wishlist_binding.dart
```

## 9. Refactor Priority for This App

To convert the current project into this target structure, refactor in this order:

1. rename `http_mathod`
2. split `account_screen.dart`
3. split `drawer_page_screen.dart`
4. split `checkout` from `cart`
5. separate `category_detail` from `categories`
6. add GetX controllers and bindings
7. add repositories
8. add persistence layer

## 10. Final Rule

From now on:

- one feature = one folder
- one feature = one screen folder
- one feature = one controller folder
- one feature = one model folder

Do not keep multiple large features inside one file again.

This document should be treated as the target architecture standard for the project.
