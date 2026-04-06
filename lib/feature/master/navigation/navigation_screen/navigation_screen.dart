import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optizenqor/core/widget/bottom_nav_bar.dart';
import 'package:optizenqor/feature/master/navigation/navigation_controller/navigation_cubit.dart';
import 'package:optizenqor/feature/master/navigation/navigation_controller/navigation_controller.dart';
import 'package:optizenqor/feature/master/navigation/navigation_controller/navigation_state.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    this.initialIndex = 0,
    this.initialShopQuery,
    super.key,
  });

  final int initialIndex;
  final String? initialShopQuery;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final NavigationController _controller = const NavigationController();
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = _controller.pages(
      initialShopQuery: widget.initialShopQuery,
    );
    final items = _controller.items;

    return BlocProvider<NavigationCubit>(
      create: (_) => NavigationCubit(initialIndex: widget.initialIndex),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (BuildContext context, NavigationState state) {
          return Scaffold(
            extendBody: true,
            body: SafeArea(
              bottom: false,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: pages,
                onPageChanged: (int index) {
                  context.read<NavigationCubit>().selectTab(index);
                },
              ),
            ),
            bottomNavigationBar: AppBottomNavBar(
              currentIndex: state.currentIndex,
              items: items,
              onTap: (int index) {
                context.read<NavigationCubit>().selectTab(index);
                _pageController.jumpToPage(index);
              },
            ),
          );
        },
      ),
    );
  }
}
