import 'package:optizenqor/feature/authentication/sign_up/sign_up_model/sign_up_model.dart';
import 'package:optizenqor/http_mathod/network_service/auth_service.dart';
import 'package:optizenqor/http_mathod/service_model/service_model.dart';

class SignUpController {
  SignUpController({AuthService? authService})
    : _authService = authService ?? const AuthService();

  final AuthService _authService;

  SignUpModel get content => const SignUpModel(
    title: 'Create your account',
    subtitle:
        'Set up your OmniZara profile and start browsing curated products.',
  );

  Future<ServiceModel<Map<String, dynamic>>> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return _authService.signUp(name: name, email: email, password: password);
  }
}
