class ErrorResponse {
  ErrorResponse({
    this.status,
    this.code,
    this.message,
  });

  final String? status;
  final String? code;
  final String? message;

  @override
  String toString() =>
      'ErrorResponse(status: $status, code: $code, message: $message)';
}
