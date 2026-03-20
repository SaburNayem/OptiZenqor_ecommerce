import 'package:flutter/material.dart';
import 'package:optizenqor/feature/authentication/auth_choice/auth_choice_screen/auth_choice_screen.dart';
import 'package:optizenqor/feature/authentication/forgot_password/forgot_password_screen/forgot_password_screen.dart';
import 'package:optizenqor/feature/authentication/onboarding/onboarding_screen/onboarding_screen.dart';
import 'package:optizenqor/feature/authentication/reset_password/reset_password_screen/reset_password_screen.dart';
import 'package:optizenqor/feature/authentication/sign_in/sign_in_screen/sign_in_screen.dart';
import 'package:optizenqor/feature/authentication/sign_up/sign_up_screen/sign_up_screen.dart';
import 'package:optizenqor/feature/authentication/splash/splash_screen/splash_screen.dart';
import 'package:optizenqor/feature/authentication/verify_code/verify_code_screen/verify_code_screen.dart';
import 'package:optizenqor/feature/master/categories/category_detail_screen/category_detail_screen.dart';
import 'package:optizenqor/feature/master/categories/categories_screen/categories_screen.dart';
import 'package:optizenqor/feature/master/cart/cart_screen/checkout_screen.dart';
import 'package:optizenqor/feature/master/drawer_page/drawer_page_screen/drawer_page_screen.dart';
import 'package:optizenqor/feature/master/navigation/navigation_screen/navigation_screen.dart';
import 'package:optizenqor/feature/master/offer/offer_screen/offer_screen.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/cart_item_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/category_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_screen/product_details_screen.dart';

class AppRoute {
  AppRoute._();

  static const String splash = '/';
  static const String authChoice = '/auth-choice';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String resetPassword = '/reset-password';
  static const String mainShell = '/main-shell';
  static const String categories = '/categories';
  static const String categoryDetails = '/category-details';
  static const String offer = '/offer';
  static const String drawerPage = '/drawer-page';
  static const String productDetails = '/product-details';
  static const String checkout = '/checkout';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen(), settings);
      case authChoice:
        return _buildRoute(const AuthChoiceScreen(), settings);
      case onboarding:
        return _buildRoute(const OnboardingScreen(), settings);
      case signIn:
        return _buildRoute(const SignInScreen(), settings);
      case signUp:
        return _buildRoute(const SignUpScreen(), settings);
      case forgotPassword:
        return _buildRoute(const ForgotPasswordScreen(), settings);
      case verifyCode:
        return _buildRoute(
          VerifyCodeScreen(account: settings.arguments as String?),
          settings,
        );
      case resetPassword:
        String? account;
        bool fromAccount = false;

        if (settings.arguments is String) {
          account = settings.arguments! as String;
        } else if (settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments! as Map<String, dynamic>;
          account = args['account'] as String?;
          fromAccount = args['fromAccount'] as bool? ?? false;
        }

        return _buildRoute(
          ResetPasswordScreen(account: account, fromAccount: fromAccount),
          settings,
        );
      case mainShell:
        int initialIndex = 0;
        String? initialQuery;

        if (settings.arguments is int) {
          initialIndex = settings.arguments! as int;
        } else if (settings.arguments is Map<String, dynamic>) {
          final Map<String, dynamic> args =
              settings.arguments! as Map<String, dynamic>;
          initialIndex = args['initialIndex'] as int? ?? 0;
          initialQuery = args['searchQuery'] as String?;
        }

        return _buildRoute(
          NavigationScreen(
            initialIndex: initialIndex,
            initialShopQuery: initialQuery,
          ),
          settings,
        );
      case categories:
        return _buildRoute(const CategoriesScreen(), settings);
      case offer:
        return _buildRoute(const OfferScreen(), settings);
      case categoryDetails:
        final CategoryModel category = settings.arguments! as CategoryModel;
        return _buildRoute(
          CategoryDetailScreen(
            title: category.bannerTitle,
            categoryId: category.id,
          ),
          settings,
        );
      case drawerPage:
        final String title = settings.arguments! as String;
        return _buildRoute(DrawerPageScreen(title: title), settings);
      case productDetails:
        final ProductModel product = settings.arguments! as ProductModel;
        return _buildRoute(ProductDetailsScreen(product: product), settings);
      case checkout:
        final List<CartItemModel> items =
            settings.arguments! as List<CartItemModel>;
        return _buildRoute(CheckoutScreen(items: items), settings);
      default:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('Page not found'))),
          settings,
        );
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return MaterialPageRoute<dynamic>(builder: (_) => page, settings: settings);
  }
}
