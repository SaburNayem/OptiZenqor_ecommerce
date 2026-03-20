import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';

class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppCustomAppBar({
    required this.title,
    this.actions = const <Widget>[],
    this.leading,
    super.key,
  });

  final String title;
  final List<Widget> actions;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title, style: AppTextStyle.title.copyWith(fontSize: 20)),
      backgroundColor: Colors.white,
      foregroundColor: AppColor.textPrimary,
      surfaceTintColor: Colors.transparent,
      actions: actions,
    );
  }
}
