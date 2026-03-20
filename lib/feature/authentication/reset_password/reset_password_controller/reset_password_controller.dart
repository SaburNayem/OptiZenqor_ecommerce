import 'package:optizenqor/feature/authentication/reset_password/reset_password_model/reset_password_model.dart';
import 'package:optizenqor/http_mathod/network_service/auth_service.dart';
import 'package:optizenqor/http_mathod/service_model/service_model.dart';

class ResetPasswordController {
  ResetPasswordController({AuthService? authService})
    : _authService = authService ?? const AuthService();

  final AuthService _authService;

  ResetPasswordModel get content => const ResetPasswordModel(
    title: 'Reset Password',
    subtitle: 'Enter your new password and confirm it to continue.',
    buttonText: 'Confirm',
  );

  Future<ServiceModel<Map<String, dynamic>>> resetPassword({
    required String password,
  }) {
    return _authService.resetPassword(password: password);
  }
}
