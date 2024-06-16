import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/repository/user.repository.dart';
import 'package:e_commerce/domain/usecase/base/remote.usecase.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginWithTokenUsecase extends RemoteUsecase<UserRepository> {
  @override
  Future<User?> call(UserRepository repository) async {
    // 토큰 유효성 확인 및 갱신
    if (await AuthApi.instance.hasToken()) {
      try {
        // refresh token을 이용하여 access token 갱신
        await UserApi.instance.accessTokenInfo();
      } catch (error) {
        logging(error, logType: LogType.error);
        throw CommonException.setError(error);
      }
    } else {
      return null;
    }

    return await UserApi.instance.me();
  }
}
