import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/button_widget.dart';
import 'package:optizenqor/feature/authentication/onboarding/onboarding_controller/onboarding_controller.dart';
import 'package:optizenqor/feature/authentication/onboarding/onboarding_model/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final OnboardingController _controller = const OnboardingController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentIndex == _controller.pages.length - 1) {
      Navigator.pushReplacementNamed(context, AppRoute.authChoice);
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, AppRoute.authChoice);
  }

  @override
  Widget build(BuildContext context) {
    final List<OnboardingModel> pages = _controller.pages;

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          final OnboardingModel item = pages[index];
          final bool isLast = index == pages.length - 1;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[item.startColor, item.endColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: _skip,
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.16),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.35),
                            width: 2,
                          ),
                        ),
                        child: Icon(item.icon, size: 72, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      item.title,
                      style: AppTextStyle.hero.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      item.subtitle,
                      style: AppTextStyle.body.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: List<Widget>.generate(
                        pages.length,
                        (int dotIndex) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 8),
                          width: _currentIndex == dotIndex ? 28 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _currentIndex == dotIndex
                                ? Colors.white
                                : Colors.white54,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    AppButton(
                      title: isLast ? 'Get Started' : 'Next',
                      onPressed: _goNext,
                    ),
                    if (!isLast) ...<Widget>[
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Shob Bazaar',
                          style: AppTextStyle.label.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
