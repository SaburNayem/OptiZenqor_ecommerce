import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/feature/master/navigation/navigation_model/navigation_item_model.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final List<NavigationItemModel> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0x1AFF6B35),
      destinations: items
          .map(
            (NavigationItemModel item) => NavigationDestination(
              icon: Icon(item.icon, color: AppColor.textSecondary),
              selectedIcon: Icon(item.icon, color: AppColor.accent),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}
