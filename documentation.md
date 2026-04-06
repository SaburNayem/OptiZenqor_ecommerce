# Optizenqor Store Backend Documentation

## 1. Purpose

This document explains the current Flutter application from a backend point of view so a backend/API can be built to support it.

It covers:

- app modules and user flows
- current frontend data contracts already present in code
- route-level behavior
- backend entities that should exist
- recommended REST API design
- request and response examples
- notes on what is currently hardcoded in the frontend

This project is currently a frontend-first e-commerce app. A large portion of the business data is still mocked or hardcoded in Flutter, so some backend requirements below are direct observations from the codebase and some are implementation recommendations inferred from the UI.

## 2. App Overview

The app is a mobile e-commerce application branded as `Optizenqor Store`.

Main user areas:

- authentication
- home dashboard
- product browsing
- categories
- product details
- favorites
- cart
- checkout
- account
- settings
- order tracking/history
- support/live chat

The main bottom navigation has 5 tabs:

1. Home
2. Shop
3. Favorite
4. Cart
5. Account

## 3. Current Navigation and Route Map

Defined in [app_route.dart](/f:/OptiZenqor_ecommerce/lib/app_route/app_route.dart).

| Route | Path | Screen | Arguments |
|---|---|---|---|
| Splash | `/` | SplashScreen | none |
| Auth Choice | `/auth-choice` | AuthChoiceScreen | none |
| Onboarding | `/onboarding` | OnboardingScreen | none |
| Sign In | `/sign-in` | SignInScreen | none |
| Sign Up | `/sign-up` | SignUpScreen | none |
| Forgot Password | `/forgot-password` | ForgotPasswordScreen | none |
| Verify Code | `/verify-code` | VerifyCodeScreen | `String? account` |
| Reset Password | `/reset-password` | ResetPasswordScreen | `String` or `{ account, fromAccount }` |
| Main Shell | `/main-shell` | NavigationScreen | `int` or `{ initialIndex, searchQuery }` |
| Categories | `/categories` | CategoriesScreen | none |
| Category Details | `/category-details` | CategoryDetailScreen | `CategoryModel` |
| Offer | `/offer` | OfferScreen | none |
| Drawer Page | `/drawer-page` | DrawerPageScreen | `String title` |
| Product Details | `/product-details` | ProductDetailsScreen | `ProductModel` |
| Checkout | `/checkout` | CheckoutScreen | `List<CartItemModel>` |

## 4. Main Business Domains

The frontend implies these backend domains:

- users
- authentication
- sessions
- biometrics/device login support
- categories
- products
- product reviews
- favorites / wishlist
- cart
- checkout
- orders
- shipping addresses
- payment methods
- account settings
- notifications
- support tickets / live chat
- search history

## 5. Existing Frontend Data Contracts

These are the most important models already used in Flutter.

### 5.1 Common Service Response

Defined in [service_model.dart](/f:/OptiZenqor_ecommerce/lib/http_mathod/service_model/service_model.dart).

```dart
class ServiceModel<T> {
  final bool success;
  final int statusCode;
  final String message;
  final T? data;
}
```

Recommended backend envelope:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Request completed",
  "data": {}
}
```

You can keep this exact shape to minimize frontend changes.

### 5.2 Product

Defined in [product_model.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/product_details/product_details_model/product_model.dart).

```json
{
  "id": "p4",
  "name": "Face Cleanser",
  "categoryId": "beauty_personal_care",
  "categoryName": "Beauty & Personal Care",
  "price": 15.0,
  "rating": 4.5,
  "imageUrl": "https://...",
  "description": "..."
}
```

### 5.3 Category

Defined in [category_model.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/product_details/product_details_model/category_model.dart).

```json
{
  "id": "beauty_personal_care",
  "name": "Beauty & Personal Care",
  "icon": "spa",
  "bannerTitle": "Beauty & Personal Care"
}
```

### 5.4 Cart Item

Defined in [cart_item_model.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/product_details/product_details_model/cart_item_model.dart).

Current frontend shape:

```json
{
  "product": { "...": "ProductModel" },
  "quantity": 1
}
```

Recommended backend shape:

```json
{
  "id": "cart_item_1",
  "productId": "p4",
  "quantity": 1,
  "unitPrice": 15.0,
  "product": { "...": "ProductModel" }
}
```

### 5.5 Account Profile

Inferred from [account_shared.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/account_shared/account_shared.dart) and [personal_details_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/personal_details/personal_details_screen/personal_details_screen.dart).

```json
{
  "name": "Optizenqor Store",
  "email": "support@yourapp.com",
  "phone": "+880 1700 000000",
  "memberSince": "March 2025",
  "imageUrl": "https://i.pravatar.cc/200?img=12"
}
```

### 5.6 Review and Reply

Used in [product_details_state.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/product_details/product_details_controller/product_details_state.dart).

Review:

```json
{
  "id": "review_1",
  "author": "Ariana",
  "rating": 5.0,
  "review": "The quality feels premium...",
  "timeAgo": "2 days ago",
  "replies": [
    {
      "author": "Shop Support",
      "message": "Thanks for the lovely feedback."
    }
  ]
}
```

Recommended backend should return real timestamps too:

```json
{
  "id": "review_1",
  "userId": "u_1",
  "authorName": "Ariana",
  "rating": 5,
  "review": "The quality feels premium...",
  "createdAt": "2026-04-01T12:00:00Z",
  "replies": [
    {
      "id": "reply_1",
      "authorType": "support",
      "authorName": "Shop Support",
      "message": "Thanks for the lovely feedback.",
      "createdAt": "2026-04-01T13:00:00Z"
    }
  ]
}
```

### 5.7 Orders

There are two order-related UIs:

- My Order
- Order History

Current frontend fields include:

- order id
- product
- status
- date
- amount
- action label

Recommended order shape:

```json
{
  "id": "ord_123456",
  "displayOrderId": "#123456",
  "userId": "u_1",
  "status": "delivered",
  "statusLabel": "Delivered",
  "createdAt": "2026-03-08T10:00:00Z",
  "currency": "USD",
  "subtotal": 15.0,
  "deliveryFee": 5.0,
  "total": 20.0,
  "items": [
    {
      "productId": "p4",
      "productName": "Face Cleanser",
      "productImageUrl": "https://...",
      "quantity": 1,
      "unitPrice": 15.0,
      "lineTotal": 15.0
    }
  ],
  "shippingAddress": {
    "label": "Home",
    "fullName": "User Name",
    "phone": "+8801700000000",
    "addressLine": "House 12, Road 5, Mirpur 1, Dhaka",
    "city": "Dhaka",
    "country": "Bangladesh"
  }
}
```

### 5.8 Shipping Address

Inferred from [delivery_address_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/delivery_address/delivery_address_screen/delivery_address_screen.dart).

Fields used by UI:

- label
- address
- note

Recommended backend shape:

```json
{
  "id": "addr_1",
  "label": "Home",
  "recipientName": "User Name",
  "phone": "+8801700000000",
  "addressLine1": "House 12, Road 5",
  "addressLine2": "Mirpur 1",
  "city": "Dhaka",
  "postalCode": "1216",
  "country": "Bangladesh",
  "note": "Primary delivery address",
  "latitude": 23.8103,
  "longitude": 90.4125,
  "isDefault": true
}
```

### 5.9 Account Settings

Inferred from [settings_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/settings/settings_screen/settings_screen.dart).

The frontend currently uses these settings:

- pushNotifications: `bool`
- emailUpdates: `bool`
- smsAlerts: `bool`
- privateProfile: `bool`
- biometricLogin: `bool`
- savePaymentInformation: `bool`
- appLanguage: `String`
- productTranslation: `String`
- currency: `String`
- deliveryPreference: `String`

Recommended backend payload:

```json
{
  "pushNotifications": true,
  "emailUpdates": true,
  "smsAlerts": false,
  "privateProfile": false,
  "biometricLogin": true,
  "savePaymentInformation": true,
  "appLanguage": "English (US)",
  "productTranslation": "English (US)",
  "currency": "USD",
  "deliveryPreference": "Home delivery prioritized"
}
```

## 6. Authentication Flows

Current placeholder auth service is in [auth_service.dart](/f:/OptiZenqor_ecommerce/lib/http_mathod/network_service/auth_service.dart).

### 6.1 Sign Up

Frontend fields:

- full name
- email
- password

Validation:

- name required
- email required and valid format
- password minimum 6 chars

Recommended endpoint:

`POST /auth/sign-up`

Request:

```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "secret123"
}
```

Response:

```json
{
  "success": true,
  "statusCode": 201,
  "message": "Account created successfully",
  "data": {
    "user": {
      "id": "u_1",
      "name": "John Doe",
      "email": "john@example.com"
    },
    "token": "jwt_or_access_token",
    "refreshToken": "refresh_token"
  }
}
```

### 6.2 Sign In

Frontend fields:

- email
- password

Validation:

- valid email
- password minimum 6 chars

Recommended endpoint:

`POST /auth/sign-in`

Request:

```json
{
  "email": "john@example.com",
  "password": "secret123"
}
```

Response:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Signed in successfully",
  "data": {
    "user": {
      "id": "u_1",
      "name": "John Doe",
      "email": "john@example.com"
    },
    "token": "access_token",
    "refreshToken": "refresh_token"
  }
}
```

### 6.3 Biometric Login

The sign-in screen supports device biometrics through Flutter local auth.

Backend implication:

- the backend does not authenticate fingerprint directly
- backend should support persistent sessions / refresh token / device-bound token model
- after local biometric success, app can unlock a stored refresh token or session token

Recommended backend support:

- refresh tokens
- session management
- device session list
- revoke device session endpoint

### 6.4 Forgot Password

Frontend field:

- email or phone

Recommended endpoint:

`POST /auth/forgot-password`

Request:

```json
{
  "account": "john@example.com"
}
```

Response:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Verification code sent successfully",
  "data": {
    "resetRequestId": "reset_1",
    "channel": "email"
  }
}
```

### 6.5 Verify Reset Code

Frontend field:

- 6 digit code

Recommended endpoint:

`POST /auth/verify-reset-code`

Request:

```json
{
  "resetRequestId": "reset_1",
  "code": "123456"
}
```

Response:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Code verified successfully",
  "data": {
    "resetToken": "temporary_reset_token"
  }
}
```

### 6.6 Reset Password

Two frontend contexts exist:

- password reset after forgot-password
- password change from account settings

Fields:

- new password
- confirm password
- current password only when changing from account settings

Recommended endpoints:

- `POST /auth/reset-password`
- `POST /account/change-password`

## 7. Product Catalog

The catalog is currently mocked in [catalog_service.dart](/f:/OptiZenqor_ecommerce/lib/http_mathod/network_service/catalog_service.dart).

### 7.1 Categories Used by UI

Current categories:

- Beauty & Personal Care
- Books & Stationary
- Electronics & Gadget
- Fashion & Clothing
- Groceries & Food
- Health & Wellness
- Home & Living
- Sports & Outdoor
- Toy & Babies Product

### 7.2 Product Fields Used by UI

The UI depends on:

- `id`
- `name`
- `categoryId`
- `categoryName`
- `price`
- `rating`
- `imageUrl`
- `description`

Recommended extensions for backend:

- stock quantity
- currency
- sku
- slug
- isFeatured
- discount / originalPrice
- gallery images
- brand
- attributes / variants
- tags
- reviewCount
- status

Recommended product schema:

```json
{
  "id": "p4",
  "name": "Face Cleanser",
  "slug": "face-cleanser",
  "categoryId": "beauty_personal_care",
  "categoryName": "Beauty & Personal Care",
  "price": 15.0,
  "currency": "USD",
  "rating": 4.5,
  "reviewCount": 42,
  "imageUrl": "https://...",
  "images": ["https://...", "https://..."],
  "description": "Category product reused across multiple category pages in the repo.",
  "stock": 50,
  "isFeatured": true,
  "status": "active"
}
```

### 7.3 Recommended Product Endpoints

- `GET /categories`
- `GET /categories/:id`
- `GET /products`
- `GET /products/:id`
- `GET /products?categoryId=...`
- `GET /products?search=...`
- `GET /products?sort=price_low_to_high`
- `GET /products?minPrice=10&maxPrice=50&minRating=4`
- `GET /products/featured`
- `GET /products/trending`
- `GET /products/new-arrivals`
- `GET /products/recommended`

## 8. Search, Filter, and Sort Requirements

The UI supports:

- keyword search
- category browsing
- price range filtering
- minimum rating filtering
- sorting by:
  - default
  - price low to high
  - price high to low
  - rating
  - name

This is used in:

- Home search
- Shop screen
- Category detail screen

Recommended API:

`GET /products?search=laptop&categoryId=electronics_gadget&minPrice=10&maxPrice=500&minRating=4&sort=rating&page=1&limit=20`

Recommended response:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Products fetched successfully",
  "data": {
    "items": [],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 200,
      "hasNext": true
    }
  }
}
```

## 9. Home Screen Requirements

The home screen expects multiple product collections:

- top banner products
- featured products
- popular products
- new arrived products
- best for you products

Recommended endpoint option:

`GET /home`

Response:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Home data fetched successfully",
  "data": {
    "banners": [],
    "featuredProducts": [],
    "popularProducts": [],
    "newArrivedProducts": [],
    "bestForYouProducts": [],
    "categories": []
  }
}
```

## 10. Favorites / Wishlist

The app has a Favorites tab where products can be removed from favorites.

Current frontend behavior:

- displays a list of favorite products
- tap product opens details
- remove favorite from list

Recommended endpoints:

- `GET /favorites`
- `POST /favorites`
- `DELETE /favorites/:productId`

Add favorite request:

```json
{
  "productId": "p4"
}
```

Favorites response:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Favorites fetched successfully",
  "data": {
    "items": [
      {
        "productId": "p4",
        "product": { "...": "ProductModel" }
      }
    ]
  }
}
```

## 11. Cart

The cart screen currently displays:

- product image
- product name
- quantity
- product price
- total amount

Recommended endpoints:

- `GET /cart`
- `POST /cart/items`
- `PATCH /cart/items/:itemId`
- `DELETE /cart/items/:itemId`
- `DELETE /cart`

Add to cart:

```json
{
  "productId": "p4",
  "quantity": 2
}
```

Get cart response:

```json
{
  "success": true,
  "statusCode": 200,
  "message": "Cart fetched successfully",
  "data": {
    "items": [
      {
        "id": "ci_1",
        "productId": "p4",
        "quantity": 2,
        "unitPrice": 15.0,
        "lineTotal": 30.0,
        "product": { "...": "ProductModel" }
      }
    ],
    "subtotal": 30.0,
    "currency": "USD"
  }
}
```

## 12. Checkout

The checkout screen currently uses:

- delivery address
- order items
- payment summary
- place order

Current frontend checkout data is passed in-memory from cart/product details.

Recommended checkout flow:

1. fetch current cart
2. fetch selected/default address
3. calculate totals server-side
4. create order
5. initiate payment if needed
6. return order confirmation

Recommended endpoints:

- `GET /checkout/summary`
- `POST /orders`
- `POST /payments/intent`

Create order request:

```json
{
  "addressId": "addr_1",
  "paymentMethodId": "pm_1",
  "items": [
    {
      "productId": "p4",
      "quantity": 2
    }
  ]
}
```

Create order response:

```json
{
  "success": true,
  "statusCode": 201,
  "message": "Order placed successfully",
  "data": {
    "orderId": "ord_1",
    "displayOrderId": "#123456",
    "status": "processing",
    "subtotal": 30.0,
    "deliveryFee": 5.0,
    "total": 35.0
  }
}
```

## 13. Orders

The app has two order areas:

- `My Order`: operational status buckets
- `Order History`: grouped by order state

### 13.1 Order Statuses Currently Used

From UI:

- To Pay
- To Ship
- To Receive
- To Review
- To Return
- Cancellation
- Processing
- Delivered
- Cancelled

Recommended backend internal statuses:

- `pending_payment`
- `paid`
- `processing`
- `packed`
- `shipped`
- `out_for_delivery`
- `delivered`
- `review_pending`
- `return_requested`
- `returned`
- `cancelled`
- `refund_pending`
- `refunded`

The backend can map these internal statuses to UI-friendly labels.

### 13.2 Order Endpoints

- `GET /orders`
- `GET /orders/:id`
- `GET /orders?status=pending_payment`
- `POST /orders/:id/cancel`
- `POST /orders/:id/return-request`
- `POST /orders/:id/confirm-delivery`

## 14. Product Reviews

Product details screen supports:

- review list
- average rating
- user adds review
- user replies to a review

Recommended endpoints:

- `GET /products/:id/reviews`
- `POST /products/:id/reviews`
- `POST /reviews/:id/replies`

Create review:

```json
{
  "rating": 5,
  "review": "Very good product"
}
```

Create reply:

```json
{
  "message": "Thanks for the feedback"
}
```

Recommended review response:

```json
{
  "id": "review_1",
  "productId": "p4",
  "userId": "u_1",
  "authorName": "John Doe",
  "rating": 5,
  "review": "Very good product",
  "createdAt": "2026-04-06T10:00:00Z",
  "replies": []
}
```

## 15. Account Module

The Account area currently includes:

- personal details
- payment method
- my order
- delivery address
- order history
- settings
- pickup points

### 15.1 Account Summary

The account landing screen expects:

- user name
- user email
- avatar image
- list of account actions

Recommended endpoint:

- `GET /account/profile`

### 15.2 Personal Details

Fields shown and editable:

- full name
- email
- phone
- member since
- profile image

Recommended endpoints:

- `GET /account/profile`
- `PATCH /account/profile`
- `POST /account/profile-image`

### 15.3 Delivery Addresses

The UI supports:

- saved addresses list
- selecting an address
- editing address fields
- map-based address selection concept

Recommended endpoints:

- `GET /account/addresses`
- `POST /account/addresses`
- `PATCH /account/addresses/:id`
- `DELETE /account/addresses/:id`
- `POST /account/addresses/:id/set-default`

### 15.4 Payment Methods

The UI implies:

- saved cards
- default card
- billing info

Recommended endpoints:

- `GET /account/payment-methods`
- `POST /account/payment-methods`
- `PATCH /account/payment-methods/:id`
- `DELETE /account/payment-methods/:id`
- `POST /account/payment-methods/:id/set-default`

For card storage, use a payment processor tokenization flow, not raw card storage in your own backend unless fully PCI compliant.

### 15.5 Pickup Points

The account flow contains pickup-point related UI copy.

Recommended entity:

```json
{
  "id": "pickup_1",
  "name": "Mirpur Hub",
  "address": "Road 10, Mirpur 1, Dhaka",
  "note": "Open daily from 9 AM - 9 PM"
}
```

Recommended endpoint:

- `GET /pickup-points`

## 16. Settings Module

The settings screen is rich and backend-worthy.

Recommended grouped endpoints:

- `GET /account/settings`
- `PATCH /account/settings`
- `GET /account/devices`
- `DELETE /account/devices/:id`
- `GET /account/search-history`
- `DELETE /account/search-history`
- `GET /app/meta`
- `GET /content/privacy-policy`
- `GET /content/terms`
- `GET /content/return-policy`

### 16.1 Search History

The settings screen exposes "Clear search history".

Recommended shape:

```json
{
  "items": [
    { "id": "sh_1", "query": "Laptop", "createdAt": "2026-04-05T10:00:00Z" },
    { "id": "sh_2", "query": "Headphones", "createdAt": "2026-04-05T12:00:00Z" }
  ]
}
```

### 16.2 Device Sessions

The settings screen implies "Manage devices".

Recommended shape:

```json
{
  "items": [
    {
      "id": "session_1",
      "deviceName": "Samsung S23",
      "platform": "android",
      "location": "Dhaka, Bangladesh",
      "lastActiveAt": "2026-04-06T08:00:00Z",
      "current": true
    }
  ]
}
```

## 17. Notifications

The home screen contains a notifications UI with items like:

- order shipped
- flash sale
- payment received
- review reminder

Recommended endpoints:

- `GET /notifications`
- `PATCH /notifications/:id/read`
- `DELETE /notifications/:id`

Notification shape:

```json
{
  "id": "notif_1",
  "type": "order_shipped",
  "title": "Order shipped",
  "message": "Your Face Cleanser order is on the way.",
  "createdAt": "2026-04-06T09:00:00Z",
  "isRead": false,
  "deepLink": {
    "route": "/orders/ord_1"
  }
}
```

## 18. Support and Live Chat

The support screen currently includes:

- email contact
- phone contact
- live chat

Current hardcoded values:

- email: `support@yourapp.com`
- phone: `+1234567890`

### 18.1 Recommended Support Endpoints

- `GET /support/contact`
- `GET /support/faqs`
- `POST /support/tickets`
- `GET /support/tickets`
- `GET /support/tickets/:id/messages`
- `POST /support/tickets/:id/messages`

Contact response:

```json
{
  "email": "support@optizenqorstore.com",
  "phone": "+8801700000000",
  "chatAvailable": true,
  "chatHours": "24/7"
}
```

### 18.2 Live Chat Model

The current UI uses:

- sender
- message

Recommended backend message shape:

```json
{
  "id": "msg_1",
  "conversationId": "conv_1",
  "senderType": "user",
  "senderId": "u_1",
  "senderName": "John Doe",
  "message": "I need help with my recent order.",
  "createdAt": "2026-04-06T11:00:00Z"
}
```

Recommended support ticket/conversation shape:

```json
{
  "id": "conv_1",
  "subject": "Order help",
  "status": "open",
  "orderId": "ord_1",
  "messages": []
}
```

## 19. Recommended Database Entities

At minimum, the backend should consider these tables/collections:

- users
- user_sessions
- password_reset_requests
- categories
- products
- product_images
- product_reviews
- review_replies
- favorites
- carts
- cart_items
- orders
- order_items
- addresses
- payment_methods
- account_settings
- notifications
- support_tickets
- support_messages
- pickup_points
- search_history

## 20. Recommended Minimal REST API List

### Auth

- `POST /auth/sign-up`
- `POST /auth/sign-in`
- `POST /auth/refresh-token`
- `POST /auth/forgot-password`
- `POST /auth/verify-reset-code`
- `POST /auth/reset-password`
- `POST /auth/logout`

### Account

- `GET /account/profile`
- `PATCH /account/profile`
- `POST /account/profile-image`
- `POST /account/change-password`
- `GET /account/settings`
- `PATCH /account/settings`
- `GET /account/devices`
- `DELETE /account/devices/:id`

### Addresses

- `GET /account/addresses`
- `POST /account/addresses`
- `PATCH /account/addresses/:id`
- `DELETE /account/addresses/:id`
- `POST /account/addresses/:id/set-default`

### Payment

- `GET /account/payment-methods`
- `POST /account/payment-methods`
- `DELETE /account/payment-methods/:id`
- `POST /account/payment-methods/:id/set-default`
- `POST /payments/intent`

### Catalog

- `GET /home`
- `GET /categories`
- `GET /categories/:id`
- `GET /products`
- `GET /products/:id`
- `GET /products/:id/reviews`
- `POST /products/:id/reviews`
- `POST /reviews/:id/replies`

### Favorites

- `GET /favorites`
- `POST /favorites`
- `DELETE /favorites/:productId`

### Cart and Checkout

- `GET /cart`
- `POST /cart/items`
- `PATCH /cart/items/:itemId`
- `DELETE /cart/items/:itemId`
- `GET /checkout/summary`
- `POST /orders`

### Orders

- `GET /orders`
- `GET /orders/:id`
- `POST /orders/:id/cancel`
- `POST /orders/:id/return-request`

### Support

- `GET /support/contact`
- `GET /support/faqs`
- `POST /support/tickets`
- `GET /support/tickets`
- `GET /support/tickets/:id/messages`
- `POST /support/tickets/:id/messages`

### Utilities

- `GET /notifications`
- `PATCH /notifications/:id/read`
- `DELETE /notifications/:id`
- `GET /pickup-points`
- `GET /account/search-history`
- `DELETE /account/search-history`
- `GET /content/privacy-policy`
- `GET /content/terms`
- `GET /content/return-policy`

## 21. Gaps Between Current Frontend and Real Backend

The following are currently hardcoded in Flutter and should be replaced with backend data:

- product catalog
- categories
- favorites list
- cart contents
- checkout address
- order totals
- orders and order statuses
- payment methods
- account profile
- account settings
- search history
- support email and phone
- live chat messages
- notifications
- policy pages

Also note:

- some screens still pass full model objects through navigation instead of IDs
- backend-driven architecture would be cleaner if routes primarily use IDs and screens fetch fresh server data
- payment flow is currently only UI-level and not integrated with a payment gateway

## 22. Backend Implementation Recommendations

### 22.1 Keep Response Envelope Consistent

Use the same `ServiceModel` shape across all endpoints:

- `success`
- `statusCode`
- `message`
- `data`

### 22.2 Prefer Stable IDs

Use backend IDs for:

- users
- orders
- addresses
- reviews
- favorites
- cart items

### 22.3 Return Nested Data Selectively

For performance:

- list APIs can return lightweight product summaries
- detail APIs can return full objects
- orders should include item summaries
- cart should include nested product summary

### 22.4 Support Pagination

Especially for:

- products
- reviews
- orders
- notifications
- support messages

### 22.5 Add Auth Guards

Protected endpoints should require authorization:

- favorites
- cart
- checkout
- orders
- account profile
- settings
- support chat

### 22.6 Keep Currency and Locale Server-Aware

The settings screen already exposes:

- language
- product translation
- currency

So backend should be ready for:

- localized text
- currency formatting
- translated product content

## 23. Suggested First Backend Milestone

If you want the fastest useful backend for this frontend, build in this order:

1. Auth
2. Categories
3. Products with search/filter/sort
4. Favorites
5. Cart
6. Checkout + Orders
7. Profile + Addresses
8. Settings
9. Reviews
10. Notifications
11. Support chat

## 24. Files Most Relevant for Backend Integration

Core files:

- [app_route.dart](/f:/OptiZenqor_ecommerce/lib/app_route/app_route.dart)
- [api_endpoint.dart](/f:/OptiZenqor_ecommerce/lib/core/api_endpoint/api_endpoint.dart)
- [network_service.dart](/f:/OptiZenqor_ecommerce/lib/http_mathod/network_service/network_service.dart)
- [service_model.dart](/f:/OptiZenqor_ecommerce/lib/http_mathod/service_model/service_model.dart)

Auth:

- [sign_in_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/authentication/sign_in/sign_in_screen/sign_in_screen.dart)
- [sign_up_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/authentication/sign_up/sign_up_screen/sign_up_screen.dart)
- [forgot_password_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/authentication/forgot_password/forgot_password_screen/forgot_password_screen.dart)
- [verify_code_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/authentication/verify_code/verify_code_screen/verify_code_screen.dart)
- [reset_password_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/authentication/reset_password/reset_password_screen/reset_password_screen.dart)

Catalog:

- [catalog_service.dart](/f:/OptiZenqor_ecommerce/lib/http_mathod/network_service/catalog_service.dart)
- [product_model.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/product_details/product_details_model/product_model.dart)
- [category_model.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/product_details/product_details_model/category_model.dart)
- [shop_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/shop/shop_screen/shop_screen.dart)
- [category_detail_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/categories/category_detail_screen/category_detail_screen.dart)

Commerce:

- [cart_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/cart/cart_screen/cart_screen.dart)
- [checkout_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/cart/cart_screen/checkout_screen.dart)
- [product_details_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/product_details/product_details_screen/product_details_screen.dart)
- [product_details_state.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/product_details/product_details_controller/product_details_state.dart)

Account:

- [account_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/account_screen/account_screen.dart)
- [personal_details_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/personal_details/personal_details_screen/personal_details_screen.dart)
- [delivery_address_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/delivery_address/delivery_address_screen/delivery_address_screen.dart)
- [my_order_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/my_order/my_order_screen/my_order_screen.dart)
- [settings_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/settings/settings_screen/settings_screen.dart)
- [account_shared.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/account/account_shared/account_shared.dart)

Support:

- [support_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/drawer_page/support/support_screen/support_screen.dart)
- [order_history_screen.dart](/f:/OptiZenqor_ecommerce/lib/feature/master/drawer_page/order_history/order_history_screen/order_history_screen.dart)

## 25. Final Note

This documentation is based on the current Flutter frontend as it exists today in the repository. Some backend structures above are direct frontend requirements, and some are recommended designs to make the app production-ready.

If you want, the next useful step is for me to generate:

- a backend ER diagram in markdown
- a full OpenAPI spec
- a PostgreSQL schema
- a Laravel API route + controller plan
- a Node/Express + MongoDB API plan
