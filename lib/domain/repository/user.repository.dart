import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/domain/repository/repository.dart';

abstract class UserRepository extends Repository {
  Future<ResponseWrapper<String>> getCustomToken({
    required String userId,
    String? email,
  });
}
