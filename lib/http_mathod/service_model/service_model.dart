class ServiceModel<T> {
  const ServiceModel({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  final bool success;
  final int statusCode;
  final String message;
  final T? data;
}
