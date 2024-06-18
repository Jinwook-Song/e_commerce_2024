import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/repository/user.repository.dart';
import 'package:e_commerce/domain/usecase/base/remote.usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginWithTokenUsecase extends RemoteUsecase<UserRepository> {
  @override
  Future<Result<User>> call(UserRepository repository) async {
    // 토큰 유효성 확인 및 갱신
    if (await AuthApi.instance.hasToken()) {
      try {
        await UserApi.instance.accessTokenInfo();
      } catch (error) {
        logging(error, logType: LogType.error);
        throw CommonException.setError(error);
      }
    } else {
      return const Result.failure(
        ErrorResponse(),
      );
    }

    final user = await UserApi.instance.me();
    final result = await repository.getCustomToken(
      userId: user.id.toString(),
      email:
          user.kakaoAccount?.email ?? '${user.id.toString()}@facammarket.com',
    );

    if (result.status.isSuccess) {
      await FirebaseAuth.instance.signInWithCustomToken(result.data ?? '');

      return Result.success(user);
    }

    return Result.failure(
      ErrorResponse(
        status: result.status,
        code: result.code,
        message: result.message,
      ),
    );
  }
}
