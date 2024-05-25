class ErrorResponse {
  ErrorResponse({
    required this.status,
    required this.code,
    required this.message,
  });

  final String status;
  final String code;
  final String message;

  @override
  String toString() =>
      'ErrorResponse(status: $status, code: $code, message: $message)';
}
