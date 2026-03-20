import 'package:optizenqor/feature/authentication/verify_code/verify_code_model/verify_code_model.dart';
import 'package:optizenqor/http_mathod/network_service/auth_service.dart';
import 'package:optizenqor/http_mathod/service_model/service_model.dart';

class VerifyCodeController {
  VerifyCodeController({AuthService? authService})
    : _authService = authService ?? const AuthService();

  final AuthService _authService;

  VerifyCodeModel get content => const VerifyCodeModel(
    title: 'Get Code',
    subtitle: 'Enter the 6 digit verification code sent to your account.',
    buttonText: 'Continue',
  );

  Future<ServiceModel<Map<String, dynamic>>> verifyCode({
    required String code,
  }) {
    return _authService.verifyResetCode(code: code);
  }
}
