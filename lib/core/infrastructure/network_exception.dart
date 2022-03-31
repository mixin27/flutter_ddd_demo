class NetworkException implements Exception {
  final int? errorCode;

  NetworkException(this.errorCode);
}
