import 'package:optizenqor/feature/master/account/account_model/account_model.dart';
import 'package:flutter/material.dart';

class AccountController {
  const AccountController();

  AccountModel get data => const AccountModel(
    name: 'Shob Bazaar',
    email: 'support@yourapp.com',
    actions: <AccountActionModel>[
      AccountActionModel(
        title: 'Personal Details',
        subtitle: 'View and update your profile information.',
        icon: Icons.badge_outlined,
      ),
      AccountActionModel(
        title: 'Settings',
        subtitle: 'Manage notifications, privacy and app preferences.',
        icon: Icons.settings_outlined,
      ),
      AccountActionModel(
        title: 'Payment Method',
        subtitle: 'Review saved cards and payment options.',
        icon: Icons.credit_card_outlined,
      ),
      AccountActionModel(
        title: 'Delivery Address',
        subtitle: 'See your home, office and saved delivery spots.',
        icon: Icons.location_on_outlined,
      ),
      AccountActionModel(
        title: 'My Order',
        subtitle: 'Track active orders and review previous purchases.',
        icon: Icons.receipt_long_outlined,
      ),
      AccountActionModel(
        title: 'Pickup Point',
        subtitle: 'Choose where you want to collect your packages.',
        icon: Icons.store_mall_directory_outlined,
      ),
      AccountActionModel(
        title: 'Follower',
        subtitle: 'See stores and collections you are following.',
        icon: Icons.people_outline,
      ),
      AccountActionModel(
        title: 'Voucher',
        subtitle: 'Browse saved coupons and available offers.',
        icon: Icons.confirmation_number_outlined,
      ),
      AccountActionModel(
        title: 'Wishlist',
        subtitle: 'Open products you saved for later.',
        icon: Icons.favorite_border_rounded,
      ),
    ],
  );
}
