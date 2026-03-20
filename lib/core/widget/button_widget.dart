import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.title,
    required this.onPressed,
    this.isOutlined = false,
    this.isLoading = false,
    super.key,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final Widget child = isLoading
        ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2.4),
          )
        : Text(title);

    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          side: const BorderSide(color: AppColor.primary),
          foregroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: child,
      );
    }

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: child,
    );
  }
}
