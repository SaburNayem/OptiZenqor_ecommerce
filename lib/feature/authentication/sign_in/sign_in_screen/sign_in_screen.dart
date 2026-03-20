import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/button_widget.dart';
import 'package:optizenqor/core/widget/text_field_widget.dart';
import 'package:optizenqor/feature/authentication/sign_in/sign_in_controller/sign_in_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignInController _controller = SignInController();
  bool _isLoading = false;
  bool _isBiometricLoading = false;
  bool _canUseBiometrics = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricsAvailability();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadBiometricsAvailability() async {
    final bool canUseBiometrics = await _controller.canCheckBiometrics();
    if (!mounted) {
      return;
    }
    setState(() {
      _canUseBiometrics = canUseBiometrics;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await _controller.signIn(
      email: _emailController.text.trim(),
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
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.mainShell,
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<void> _authenticateWithFingerprint() async {
    setState(() {
      _isBiometricLoading = true;
    });

    final result = await _controller.authenticateWithBiometrics();

    if (!mounted) {
      return;
    }

    setState(() {
      _isBiometricLoading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(result.message)));

    if (result.success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.mainShell,
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _controller.content;

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
                Text(content.subtitle, style: AppTextStyle.body),
                const SizedBox(height: 28),
                AppTextField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'example@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[^@]+@[^@]+\.[^@]+',
                    ).hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.forgotPassword);
                    },
                    child: const Text('Forget Password'),
                  ),
                ),
                const SizedBox(height: 8),
                AppButton(
                  title: 'Log In',
                  onPressed: _submit,
                  isLoading: _isLoading,
                ),
                if (_canUseBiometrics) ...<Widget>[
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _isBiometricLoading
                        ? null
                        : _authenticateWithFingerprint,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    icon: _isBiometricLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.fingerprint_rounded),
                    label: const Text('Use device fingerprint'),
                  ),
                ],
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.signUp);
                  },
                  child: const Text('Need an account? Create one'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
