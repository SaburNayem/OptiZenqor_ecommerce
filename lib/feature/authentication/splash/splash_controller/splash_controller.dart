import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/feature/authentication/splash/splash_mode/splash_model.dart';

class SplashController {
  const SplashController();

  SplashModel get content => const SplashModel(
    title: 'Optizenqor Store',
    subtitle: 'Buy Smartly Buy Genuine',
  );

  Future<void> navigateNext(BuildContext context) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    if (!context.mounted) {
      return;
    }

    Navigator.pushReplacementNamed(context, AppRoute.onboarding);
  }
}
