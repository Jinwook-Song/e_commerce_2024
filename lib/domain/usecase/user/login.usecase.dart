import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/repository/user.repository.dart';
import 'package:e_commerce/domain/usecase/base/remote.usecase.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginUsecase extends RemoteUsecase<UserRepository> {
  @override
  Future<Result<User>> call(UserRepository repository) async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        if (error is KakaoAuthException &&
            (error.message?.contains('Cancelled') ?? false)) {
          return Result.failure(
            ErrorResponse(
              message: error.message,
            ),
          );
        }

        await _loginWithKakaoAccount();
      }
    } else {
      await _loginWithKakaoAccount();
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

  Future<void> _loginWithKakaoAccount() async {
    try {
      await UserApi.instance.loginWithKakaoAccount();
    } catch (error) {
      if (error is PlatformException && error.code == 'CANCELLED') {
        return;
      }
      logging(error, logType: LogType.error);
      throw CommonException.setError(error);
    }
  }
}
