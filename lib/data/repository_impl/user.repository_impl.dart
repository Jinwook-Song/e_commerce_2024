import 'package:e_commerce/data/data_source/remote/user/user.api.dart';
import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce/data/mapper/common.mapper.dart';
import 'package:e_commerce/domain/repository/user.repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserApi _userApi;

  UserRepositoryImpl(this._userApi);

  @override
  Future<ResponseWrapper<String>> getCustomToken({
    required String userId,
    String? email,
  }) async {
    final response = await _userApi
        .getCustomToken(params: {'userId': userId, 'email': email});

    return response.toModel<String>(response.data ?? '');
  }
}
