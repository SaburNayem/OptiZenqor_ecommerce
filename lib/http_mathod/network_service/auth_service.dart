import 'package:optizenqor/core/api_endpoint/api_endpoint.dart';
import 'package:optizenqor/http_mathod/network_service/network_service.dart';
import 'package:optizenqor/http_mathod/service_model/service_model.dart';

class AuthService {
  AuthService({NetworkService? networkService})
    : _networkService = networkService ?? NetworkService();

  final NetworkService _networkService;

  Future<ServiceModel<Map<String, dynamic>>> signIn({
    required String email,
    required String password,
  }) async {
    final ServiceModel<dynamic> result = await _networkService.post(
      ApiEndpoint.signIn,
      body: <String, dynamic>{'email': email, 'password': password},
    );

    return _mapPayload(result);
  }

  Future<ServiceModel<Map<String, dynamic>>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final ServiceModel<dynamic> result = await _networkService.post(
      ApiEndpoint.signUp,
      body: <String, dynamic>{
        'fullName': name,
        'email': email,
        'phone': '+8801700000000',
        'password': password,
      },
    );

    return _mapPayload(result);
  }

  Future<ServiceModel<Map<String, dynamic>>> requestPasswordReset({
    required String account,
  }) async {
    final ServiceModel<dynamic> result = await _networkService.post(
      ApiEndpoint.forgotPassword,
      body: <String, dynamic>{'email': account},
    );

    return _mapPayload(result);
  }

  Future<ServiceModel<Map<String, dynamic>>> verifyResetCode({
    required String email,
    required String code,
  }) async {
    final ServiceModel<dynamic> result = await _networkService.post(
      ApiEndpoint.verifyResetCode,
      body: <String, dynamic>{'email': email, 'code': code},
    );

    return _mapPayload(result);
  }

  Future<ServiceModel<Map<String, dynamic>>> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    final ServiceModel<dynamic> result = await _networkService.post(
      ApiEndpoint.resetPassword,
      body: <String, dynamic>{
        'email': email,
        'code': code,
        'newPassword': password,
      },
    );

    return _mapPayload(result);
  }

  ServiceModel<Map<String, dynamic>> _mapPayload(ServiceModel<dynamic> result) {
    final dynamic payload = result.data;
    final Map<String, dynamic> data = payload is Map<String, dynamic>
        ? (payload['data'] is Map<String, dynamic>
              ? Map<String, dynamic>.from(payload['data'] as Map<String, dynamic>)
              : Map<String, dynamic>.from(payload))
        : <String, dynamic>{};

    final String message = payload is Map<String, dynamic> && payload['message'] is String
        ? payload['message'] as String
        : result.message;

    return ServiceModel<Map<String, dynamic>>(
      success: result.success,
      statusCode: result.statusCode,
      message: message,
      data: data,
    );
  }
}
