import 'package:flutter/material.dart';
import 'package:optizenqor/feature/authentication/auth_choice/auth_choice_screen/auth_choice_screen.dart';
import 'package:optizenqor/feature/authentication/sign_in/sign_in_screen/sign_in_screen.dart';
import 'package:optizenqor/feature/authentication/sign_up/sign_up_screen/sign_up_screen.dart';
import 'package:optizenqor/feature/authentication/splash/splash_screen/splash_screen.dart';
import 'package:optizenqor/feature/master/navigation/navigation_screen/navigation_screen.dart';
import 'package:optizenqor/feature/master/product_details/product_details_model/product_model.dart';
import 'package:optizenqor/feature/master/product_details/product_details_screen/product_details_screen.dart';

class AppRoute {
  AppRoute._();

  static const String splash = '/';
  static const String authChoice = '/auth-choice';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String mainShell = '/main-shell';
  static const String productDetails = '/product-details';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen(), settings);
      case authChoice:
        return _buildRoute(const AuthChoiceScreen(), settings);
      case signIn:
        return _buildRoute(const SignInScreen(), settings);
      case signUp:
        return _buildRoute(const SignUpScreen(), settings);
      case mainShell:
        final int initialIndex = settings.arguments is int
            ? settings.arguments! as int
            : 0;
        return _buildRoute(
          NavigationScreen(initialIndex: initialIndex),
          settings,
        );
      case productDetails:
        final ProductModel product = settings.arguments! as ProductModel;
        return _buildRoute(ProductDetailsScreen(product: product), settings);
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
