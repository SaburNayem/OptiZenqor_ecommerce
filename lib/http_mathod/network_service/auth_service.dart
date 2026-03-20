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
}
