import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:optizenqor/feature/authentication/sign_in/sign_in_model/sign_in_model.dart';
import 'package:optizenqor/http_mathod/network_service/auth_service.dart';
import 'package:optizenqor/http_mathod/service_model/service_model.dart';

class SignInController {
  SignInController({
    AuthService? authService,
    LocalAuthentication? localAuthentication,
  }) : _authService = authService ?? const AuthService(),
       _localAuthentication = localAuthentication ?? LocalAuthentication();

  final AuthService _authService;
  final LocalAuthentication _localAuthentication;

  SignInModel get content => const SignInModel(
    title: 'Welcome To SignIn Screen',
    subtitle: 'Enter your email and password to continue.',
  );

  Future<ServiceModel<Map<String, dynamic>>> signIn({
    required String email,
    required String password,
  }) {
    return _authService.signIn(email: email, password: password);
  }

  Future<bool> canCheckBiometrics() async {
    try {
      final bool isDeviceSupported = await _localAuthentication
          .isDeviceSupported();
      final bool canCheckBiometrics = await _localAuthentication
          .canCheckBiometrics;
      return isDeviceSupported && canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  Future<ServiceModel<Map<String, dynamic>>> authenticateWithBiometrics() async {
    try {
      final bool didAuthenticate = await _localAuthentication.authenticate(
        localizedReason: 'Use your fingerprint to sign in to OptiZenqor.',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (!didAuthenticate) {
        return ServiceModel<Map<String, dynamic>>(
          success: false,
          statusCode: 401,
          message: 'Fingerprint authentication was cancelled.',
          data: const <String, dynamic>{},
        );
      }

      return ServiceModel<Map<String, dynamic>>(
        success: true,
        statusCode: 200,
        message: 'Fingerprint authentication successful.',
        data: const <String, dynamic>{},
      );
    } on PlatformException catch (error) {
      return ServiceModel<Map<String, dynamic>>(
        success: false,
        statusCode: 500,
        message: error.message ?? 'Biometric authentication is unavailable.',
        data: const <String, dynamic>{},
      );
    }
  }
}
