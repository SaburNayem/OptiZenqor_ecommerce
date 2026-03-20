import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/button_widget.dart';
import 'package:optizenqor/feature/authentication/auth_choice/auth_choice_controller/auth_choice_controller.dart';

class AuthChoiceScreen extends StatelessWidget {
  const AuthChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const AuthChoiceController controller = AuthChoiceController();
    final content = controller.content;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xFFF8E8D8), Color(0xFFF7F4EF), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 28),
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 28),
                Text(content.title, style: AppTextStyle.hero),
                const SizedBox(height: 12),
                Text(content.subtitle, style: AppTextStyle.body),
                const Spacer(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppColor.border),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Fresh drops every week', style: AppTextStyle.title),
                      SizedBox(height: 8),
                      Text(
                        'Browse curated categories, deals, favorites, and your cart from one main commerce shell.',
                        style: AppTextStyle.body,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  title: 'Log In',
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.signIn);
                  },
                ),
                const SizedBox(height: 12),
                AppButton(
                  title: 'Create Account',
                  isOutlined: true,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.signUp);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
