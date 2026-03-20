import 'package:optizenqor/http_mathod/service_model/service_model.dart';

class AuthService {
  const AuthService();

  Future<ServiceModel<Map<String, dynamic>>> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    return ServiceModel<Map<String, dynamic>>(
      success: true,
      statusCode: 200,
      message: 'Signed in successfully',
      data: <String, dynamic>{'email': email, 'token': 'demo-token'},
    );
  }

  Future<ServiceModel<Map<String, dynamic>>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    return ServiceModel<Map<String, dynamic>>(
      success: true,
      statusCode: 201,
      message: 'Account created successfully',
      data: <String, dynamic>{'name': name, 'email': email},
    );
  }

  Future<ServiceModel<Map<String, dynamic>>> requestPasswordReset({
    required String account,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    return ServiceModel<Map<String, dynamic>>(
      success: true,
      statusCode: 200,
      message: 'Verification code sent successfully',
      data: <String, dynamic>{'account': account, 'code': '123456'},
    );
  }

  Future<ServiceModel<Map<String, dynamic>>> verifyResetCode({
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final bool isValid = code == '123456';

    return ServiceModel<Map<String, dynamic>>(
      success: isValid,
      statusCode: isValid ? 200 : 400,
      message: isValid ? 'Code verified successfully' : 'Invalid code',
      data: <String, dynamic>{'code': code},
    );
  }

  Future<ServiceModel<Map<String, dynamic>>> resetPassword({
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    return ServiceModel<Map<String, dynamic>>(
      success: true,
      statusCode: 200,
      message: 'Password reset successfully',
      data: <String, dynamic>{'password': password},
    );
  }
}
