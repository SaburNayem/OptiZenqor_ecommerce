import 'package:flutter/material.dart';
import 'package:optizenqor/core/widget/bottom_nav_bar.dart';
import 'package:optizenqor/feature/master/navigation/navigation_controller/navigation_controller.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({this.initialIndex = 0, super.key});

  final int initialIndex;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late int _currentIndex;
  final NavigationController _controller = const NavigationController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final pages = _controller.pages;
    final items = _controller.items;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        items: items,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
