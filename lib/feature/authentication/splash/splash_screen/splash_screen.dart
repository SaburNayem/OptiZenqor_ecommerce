import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/feature/authentication/splash/splash_controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController _controller = const SplashController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.navigateNext(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = _controller.content;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF111827),
              Color(0xFF2B3445),
              Color(0xFFFFEEE2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      color: AppColor.primary,
                      size: 42,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    content.title,
                    style: AppTextStyle.hero.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    content.subtitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.body.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 28),
                  const CircularProgressIndicator(color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
