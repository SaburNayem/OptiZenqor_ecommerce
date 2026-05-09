class ApiEndpoint {
  ApiEndpoint._();

  static const String baseUrl = String.fromEnvironment(
    'OPTIZENQOR_API_BASE_URL',
    defaultValue: 'http://10.0.2.2:4000',
  );

  static const String signIn = '/auth/login';
  static const String signUp = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyResetCode = '/auth/verify-reset-code';
  static const String resetPassword = '/auth/reset-password';
  static const String products = '/products';
  static const String categories = '/categories';
  static const String cart = '/cart';
  static const String favorite = '/favorites';
}
