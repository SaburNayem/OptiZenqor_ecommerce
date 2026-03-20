import 'package:optizenqor/feature/authentication/forgot_password/forgot_password_model/forgot_password_model.dart';
import 'package:optizenqor/http_mathod/network_service/auth_service.dart';
import 'package:optizenqor/http_mathod/service_model/service_model.dart';

class ForgotPasswordController {
  ForgotPasswordController({AuthService? authService})
    : _authService = authService ?? const AuthService();

  final AuthService _authService;

  ForgotPasswordModel get content => const ForgotPasswordModel(
    title: 'Forget Password',
    subtitle:
        'Please enter your email or phone number to receive a verification code.',
    buttonText: 'Get Code',
  );

  Future<ServiceModel<Map<String, dynamic>>> sendCode({
    required String account,
  }) {
    return _authService.requestPasswordReset(account: account);
  }
}
