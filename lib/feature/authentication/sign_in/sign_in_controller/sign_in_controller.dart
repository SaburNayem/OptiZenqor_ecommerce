import 'package:optizenqor/feature/authentication/sign_in/sign_in_model/sign_in_model.dart';
import 'package:optizenqor/http_mathod/network_service/auth_service.dart';
import 'package:optizenqor/http_mathod/service_model/service_model.dart';

class SignInController {
  SignInController({AuthService? authService})
    : _authService = authService ?? const AuthService();

  final AuthService _authService;

  SignInModel get content => const SignInModel(
    title: 'Welcome back',
    subtitle: 'Sign in to continue shopping your saved picks and cart.',
  );

  Future<ServiceModel<Map<String, dynamic>>> signIn({
    required String email,
    required String password,
  }) {
    return _authService.signIn(email: email, password: password);
  }
}
