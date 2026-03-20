import 'package:flutter/material.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/core/constant/text_style.dart';
import 'package:optizenqor/core/widget/button_widget.dart';
import 'package:optizenqor/feature/authentication/verify_code/verify_code_controller/verify_code_controller.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({this.account, super.key});

  final String? account;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  final VerifyCodeController _controller = VerifyCodeController();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_codeController.text.trim().length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 6 digit code')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await _controller.verifyCode(
      code: _codeController.text.trim(),
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
      Navigator.pushNamed(
        context,
        AppRoute.resetPassword,
        arguments: widget.account,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(content.title, style: AppTextStyle.heading),
              const SizedBox(height: 8),
              Text(content.subtitle, style: AppTextStyle.body),
              if (widget.account != null) ...<Widget>[
                const SizedBox(height: 8),
                Text(widget.account!, style: AppTextStyle.label),
              ],
              const SizedBox(height: 28),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 8,
                ),
                decoration: const InputDecoration(
                  labelText: 'Verification code',
                  hintText: '123456',
                  counterText: '',
                ),
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
    );
  }
}
