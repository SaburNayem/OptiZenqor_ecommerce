import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle hero = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    color: AppColor.textPrimary,
    height: 1.1,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColor.textPrimary,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColor.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.textSecondary,
    height: 1.5,
  );

  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColor.textSecondary,
    letterSpacing: 0.3,
  );
}
