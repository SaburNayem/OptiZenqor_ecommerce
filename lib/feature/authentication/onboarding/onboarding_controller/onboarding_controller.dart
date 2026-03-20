import 'package:flutter/material.dart';
import 'package:optizenqor/feature/authentication/onboarding/onboarding_model/onboarding_model.dart';

class OnboardingController {
  const OnboardingController();

  List<OnboardingModel> get pages => const <OnboardingModel>[
    OnboardingModel(
      title: 'Discover Genuine Products',
      subtitle:
          'Browse trusted categories and shop authentic items with confidence.',
      icon: Icons.storefront_rounded,
      startColor: Color(0xFF0F766E),
      endColor: Color(0xFF99F6E4),
    ),
    OnboardingModel(
      title: 'Search, Compare, and Save',
      subtitle:
          'Find products quickly, compare choices, and keep your favorites ready.',
      icon: Icons.shopping_bag_outlined,
      startColor: Color(0xFF1D4ED8),
      endColor: Color(0xFFBFDBFE),
    ),
    OnboardingModel(
      title: 'Fast Checkout and Support',
      subtitle:
          'Order smoothly, manage your account, and reach support whenever needed.',
      icon: Icons.local_shipping_outlined,
      startColor: Color(0xFFF97316),
      endColor: Color(0xFFFFEDD5),
    ),
  ];
}
