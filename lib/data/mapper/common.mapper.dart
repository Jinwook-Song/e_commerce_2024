import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';

extension ResponseWrapperX on ResponseWrapper {
  ResponseWrapper<T> toResponseWrapper<T>() {
    return ResponseWrapper<T>(
      status: status,
      code: code,
      message: message,
      data: data,
    );
  }
}
