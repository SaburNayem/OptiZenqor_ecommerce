import 'dart:convert';
import 'dart:io';

import 'package:optizenqor/core/api_endpoint/api_endpoint.dart';
import 'package:optizenqor/http_mathod/service_model/service_model.dart';

class NetworkService {
  NetworkService({HttpClient? client, this.baseUrl = ApiEndpoint.baseUrl})
    : _client = client ?? HttpClient();

  final HttpClient _client;
  final String baseUrl;

  Future<ServiceModel<dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) {
    return _request(method: 'GET', endpoint: endpoint, headers: headers);
  }

  Future<ServiceModel<dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _request(
      method: 'POST',
      endpoint: endpoint,
      body: body,
      headers: headers,
    );
  }

  Future<ServiceModel<dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _request(
      method: 'PUT',
      endpoint: endpoint,
      body: body,
      headers: headers,
    );
  }

  Future<ServiceModel<dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _request(
      method: 'PATCH',
      endpoint: endpoint,
      body: body,
      headers: headers,
    );
  }

  Future<ServiceModel<dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _request(
      method: 'DELETE',
      endpoint: endpoint,
      body: body,
      headers: headers,
    );
  }

  Future<ServiceModel<dynamic>> _request({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final Uri uri = Uri.parse('$baseUrl$endpoint');
      final HttpClientRequest request = await _client.openUrl(method, uri);
      final Map<String, String> requestHeaders = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
      };
      requestHeaders.forEach(request.headers.set);

      if (body != null) {
        request.write(jsonEncode(body));
      }

      final HttpClientResponse response = await request.close();
      final String raw = await response.transform(utf8.decoder).join();
      final dynamic data = raw.isEmpty ? null : jsonDecode(raw);

      return ServiceModel<dynamic>(
        success: response.statusCode >= 200 && response.statusCode < 300,
        statusCode: response.statusCode,
        message: data is Map<String, dynamic> && data['message'] is String
            ? data['message'] as String
            : 'Request completed',
        data: data,
      );
    } on SocketException {
      return const ServiceModel<dynamic>(
        success: false,
        statusCode: 0,
        message: 'No internet connection',
      );
    } catch (error) {
      return ServiceModel<dynamic>(
        success: false,
        statusCode: 0,
        message: error.toString(),
      );
    }
  }
}
