import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/feature/master/drawer_page/about_us/about_us_screen/about_us_screen.dart';
import 'package:optizenqor/feature/master/drawer_page/drawer_page_controller/drawer_page_controller.dart';
import 'package:optizenqor/feature/master/drawer_page/help/help_screen/help_screen.dart';
import 'package:optizenqor/feature/master/drawer_page/order_history/order_history_screen/order_history_screen.dart';
import 'package:optizenqor/feature/master/drawer_page/review/review_screen/review_screen.dart';
import 'package:optizenqor/feature/master/drawer_page/support/support_screen/support_screen.dart';

class DrawerPageScreen extends StatelessWidget {
  const DrawerPageScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final data = const DrawerPageController().fromTitle(title);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        backgroundColor: _appBarColor(data.title),
        foregroundColor: Colors.white,
      ),
      body: _bodyFor(data.title),
    );
  }

  Widget _bodyFor(String title) {
    switch (title) {
      case 'Order History':
        return const OrderHistoryBody();
      case 'Support':
        return const SupportBody();
      case 'Review':
        return const ReviewScreen();
      case 'Help':
        return const HelpScreen();
      case 'About Us':
        return const AboutUsScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  Color _appBarColor(String title) {
    if (title == 'Support') {
      return AppColor.primary;
    }
    if (title == 'Help' || title == 'Review' || title == 'Order History') {
      return Colors.blueAccent;
    }
    return Colors.teal;
  }
}
