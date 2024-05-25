import 'package:dio/dio.dart';
import 'package:e_commerce/core/utils/error/error_response.dart';

class CommonException {
  const CommonException();

  static ErrorResponse setError(error) {
    if (error is Exception) {
      if (error.runtimeType == DioException) {
        final dioError = error as DioException;
        final code = dioError.response?.statusCode.toString() ?? '9999';

        return ErrorResponse(
          status: 'network error',
          code: code,
          message: '인터넷 연결을 확인해주세요.',
        );
      } else {
        const code = '8888';
        return ErrorResponse(
          status: 'unExpected error',
          code: code,
          message: '서비스에 오류가 발생했습니다.',
        );
      }
    } else {
      const code = '7777';
      return ErrorResponse(
        status: 'unKnown error',
        code: code,
        message: '서비스에 오류가 발생했습니다.',
      );
    }
  }
}
