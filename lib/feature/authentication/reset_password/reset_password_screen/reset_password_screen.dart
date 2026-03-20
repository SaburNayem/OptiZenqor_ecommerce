import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/button_widget.dart';
import 'package:optizenqor/core/widget/text_field_widget.dart';
import 'package:optizenqor/feature/authentication/reset_password/reset_password_controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    this.account,
    this.fromAccount = false,
    super.key,
  });

  final String? account;
  final bool fromAccount;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ResetPasswordController _controller = ResetPasswordController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await _controller.resetPassword(
      password: _passwordController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result.message)));

    if (result.success) {
      if (widget.fromAccount) {
        Navigator.pop(context, true);
        return;
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.signIn,
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _controller.content;
    final String subtitle = widget.fromAccount
        ? 'Update your current account password below.'
        : content.subtitle;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(content.title, style: AppTextStyle.heading),
                const SizedBox(height: 8),
                Text(subtitle, style: AppTextStyle.body),
                if (widget.account != null) ...<Widget>[
                  const SizedBox(height: 8),
                  Text(widget.account!, style: AppTextStyle.label),
                ],
                const SizedBox(height: 28),
                if (widget.fromAccount) ...<Widget>[
                  AppTextField(
                    controller: _currentPasswordController,
                    label: 'Current password',
                    hintText: 'Enter current password',
                    obscureText: true,
                    prefixIcon: Icons.lock_clock_outlined,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
                AppTextField(
                  controller: _passwordController,
                  label: 'New password',
                  hintText: 'Enter new password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm password',
                  hintText: 'Re-enter password',
                  obscureText: true,
                  prefixIcon: Icons.lock_reset_rounded,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AppButton(
                  title: content.buttonText,
                  onPressed: _submit,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
