class ErrorResponse {
  const ErrorResponse({
    this.status = 'SUCCESS',
    this.code = '0000',
    this.message = '',
  });

  final String? status;
  final String? code;
  final String? message;

  @override
  String toString() =>
      'ErrorResponse(status: $status, code: $code, message: $message)';
}
