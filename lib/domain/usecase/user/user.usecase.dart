import 'package:e_commerce/domain/repository/user.repository.dart';
import 'package:e_commerce/domain/usecase/base/usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserUsecase {
  UserUsecase(this._userRepository);

  final UserRepository _userRepository;

  Future<T> execute<T>({required Useecase usecase}) async {
    return await usecase.call(_userRepository);
  }
}
