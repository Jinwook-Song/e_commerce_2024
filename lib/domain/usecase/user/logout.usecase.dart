import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/repository/user.repository.dart';
import 'package:e_commerce/domain/usecase/base/remote.usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LogoutUsecase extends RemoteUsecase<UserRepository> {
  @override
  Future<void> call(UserRepository repository) async {
    try {
      await UserApi.instance.logout();
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      logging(error, logType: LogType.error);
      throw CommonException.setError(error);
    }
  }
}
