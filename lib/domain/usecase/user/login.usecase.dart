import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/repository/user.repository.dart';
import 'package:e_commerce/domain/usecase/base/remote.usecase.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginUsecase extends RemoteUsecase<UserRepository> {
  @override
  Future<User?> call(UserRepository repository) async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        if (error is KakaoAuthException &&
            error.message!.contains('Cancelled')) {
          // 유저가 로그인을 취소한 경우
          return null;
        }
        _loginWithKakaoAccount();
      }
    } else {
      _loginWithKakaoAccount();
    }

    return await UserApi.instance.me();
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
